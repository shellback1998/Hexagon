'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   FenceLocatorLab.vb
'   ProgID:         SP3DAutomationLabs.FenceLocatorLab
'   Author:         Satya Mahesh
'   Creation Date:  Monday, September 15, 2008
'   Description:    
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Strict Off
Option Explicit On

Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Public Class FenceLocatorLab

    Inherits BaseGraphicCommand

    Private m_oLocatedHiliter As GraphicViewHiliter
    Private m_oGfxViewMgrEV As GraphicViewManager
    Private m_oRectFence As RectangularFence
    Private lastView As GraphicView
    Private m_oLocator As Locator

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return 2
        End Get
    End Property

    Public Overrides ReadOnly Property Modal() As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides ReadOnly Property Suspendable() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_oGfxViewMgrEV = Services.ClientServiceProvider.GraphicViewMgr

        ' Create a Hiliter to locate Located Elements
        m_oLocatedHiliter = New GraphicViewHiliter()
        m_oLocatedHiliter.Color = Services.ColorConstants.RGBYellow
        m_oLocatedHiliter.LinePattern = Services.Hiliter.HiliterLinePattern.Dotted
        m_oLocatedHiliter.Weight = 2

    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_oLocatedHiliter.HilitedObjects.Clear()
        m_oGfxViewMgrEV = Nothing
        m_oRectFence = Nothing
        m_oLocatedHiliter = Nothing
    End Sub

    Public Overrides Sub OnSuspend()
        MyBase.OnSuspend()

    End Sub

    Public Overrides Sub OnResume()
        MyBase.OnResume()

    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)
    
        ' Changing View in between Fence definition drops Fence and ReStarts Fence placement.
        If Not (view.Equals(lastView)) Then
            DropFence() ' drop active fence
            lastView = view ' remember new view
            m_oLocator = view.CreateLocator ' create locator for this view.
        End If

        ' Right Button --> Same as ESC = Restart Active Fence | End Command
        ' Left Button ---> Fence Point(s) - Rect  Fence --> Start/End point
        If (e.Button = Services.GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right) Then ' See above Logic description.
            If Not (m_oRectFence Is Nothing) Then
                DropFence()
                WriteStatusBarMsg("Fence Cancelled, LeftClick = Start, RightClick = End") ' Not supported in V8.00.48.02
                Exit Sub
            End If

            StopCommand()
            Exit Sub
        End If

        ' If fence Doesnt exist, Create it, else Select Elements inside Fence.
        If (m_oRectFence Is Nothing) Then
            m_oRectFence = view.CreateRectangularFence
            m_oRectFence.Color = Services.ColorConstants.RGBBlue
            m_oRectFence.LineStyle = 2
            m_oRectFence.LineWidth = 3
            m_oRectFence.SetInitialPoint(e.X, e.Y)
            OnMouseMove(view, e, position)
        Else
            DropFence()
            m_oRectFence = Nothing
            Exit Sub
        End If

    End Sub


    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)

        If (m_oRectFence Is Nothing) Then Exit Sub ' No Fence? exit

        ' Changing View while Fence definition not allowed by our command.
        If Not (view.Equals(lastView)) Then Exit Sub

        ' If fence exists, move the end point, and locate.
        Dim dLowXY(1) As Long, dHighXY(1) As Long

        m_oRectFence.SetMovingPoint(e.X, e.Y) ' set the new Moving point of the fence.
        m_oRectFence.GetTopLeft(dLowXY(0), dLowXY(1)) ' Get 1st point
        m_oRectFence.GetBottomRight(dHighXY(0), dHighXY(1)) ' Get 2nd point

        ' Locate now. If Ctrl key is down, we use overlapping fence, otherwise non-overlapping fence.
        m_oLocator.Locate(dLowXY(0), dLowXY(1), dHighXY(0), dHighXY(1), e.Control)

        ' Hilite located elements

        m_oLocatedHiliter.HilitedObjects.Clear() ' clear hilited elements, i.e. previous located elements in the hiliter
        m_oLocatedHiliter.HilitedObjects.Add(m_oLocator.LocatedObjects) ' add new located elements to hiliter
        WriteStatusBarMsg("Found " & m_oLocator.LocatedObjects.Count & " element(s) inside Fence, Overlap " & IIf(((e.Shift And ConsoleModifiers.Alt) = ConsoleModifiers.Alt), "ON", "OFF"))

    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)
        MyBase.OnKeyDown(e)

        If (e.KeyValue = ConsoleKey.Escape) Then
            'Escape key to
            '  Cancel current active Fence Placement & start over.
            '  End Command if No fence Placement active.
            If Not (m_oRectFence Is Nothing) Then
                DropFence()
                WriteStatusBarMsg("Fence Cancelled, LeftClick = Start, RightClick = End") ' Not supported in V8.00.48.02
                Exit Sub
            End If

            StopCommand()
            Exit Sub

        End If

        Exit Sub

    End Sub

    Private Sub DropFence()

        'Drop existing fence
        m_oLocatedHiliter.HilitedObjects.Clear()
        If Not (m_oRectFence Is Nothing) Then m_oRectFence.DropFence()
        m_oRectFence = Nothing ' Release
        WriteStatusBarMsg("LeftClick = Start, Esc/RightClick = Restart Fence | End Command") ' Not supported in V8.00.48.02

    End Sub
End Class

