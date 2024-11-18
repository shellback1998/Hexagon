'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   PlaceLineLabV1.vb
'   ProgID:         SP3DNetAutomationLabs.PlaceLineLabV1
'   Author:         SivaKumar Kotha
'   Creation Date:  Monday, Oct 06, 2008
'   Description:
'       Places Line3D and adds to the Hiliter
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
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Route
Imports System.Collections.ObjectModel
'This example demonstrates creating LineStrings in Active Connection. 
'After a workspace refresh, Orphan objects like these will not be easily 
'reachable using a filter. Also, such orphan graphic objects are not easily selectable.
'Therefore, the command calls Abort on stop to not persist those lines

Public Class PlaceLineLab
    Inherits BaseGraphicCommand

    Private m_oLine As Line3d
    Private m_oActiveConn As SP3DConnection
    Private m_oTxnMgr As ClientTransactionManager
    Private m_oHiliter As GraphicViewHiliter
    Private m_CmdStopped As Boolean

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_oActiveConn = ClientServiceProvider.WorkingSet.ActiveConnection
        m_oTxnMgr = ClientServiceProvider.TransactionMgr

        Dim oGVMgr As GraphicViewManager
        oGVMgr = ClientServiceProvider.GraphicViewMgr
        m_oHiliter = New GraphicViewHiliter
        m_oHiliter.Color = ColorConstants.RGBWhite
        m_oHiliter.LinePattern = Hiliter.HiliterLinePattern.DashDotDot
        m_oHiliter.Weight = 4



        WriteStatusBarMsg("Left Click = Start LineString, Right Click / ESC = Quit")


    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_oTxnMgr.Abort()
        m_oHiliter.HilitedObjects.Clear()
        WriteStatusBarMsg("")
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)

        If e.KeyValue = System.ConsoleKey.Escape Then
            StopCommand()
        End If
    End Sub
    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)
        Try
            If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Left And e.Shift = 0 Then


                If m_oLine Is Nothing Then

                    m_oLine = New Line3d(m_oActiveConn, position, position) ' It is failing here if we dont persist the Line Object
                    'm_oLine = New Line3d(position, position)
                    m_oTxnMgr.Compute()
                    m_oHiliter.HilitedObjects.Add(m_oLine)
                    WriteStatusBarMsg("Left Click = Next End Point, Middle Click = End LineString, Right Click / ESC = Quit")
                Else
                    m_oLine = Nothing
                    WriteStatusBarMsg("Left Click = Start New Linestring, Right Click / ESC = Quit")

                End If

            ElseIf e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right And e.Shift = 0 Then
                StopCommand()
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)

        Try
            If Not m_oLine Is Nothing Then

                m_oLine.EndPoint = position

                m_oTxnMgr.Compute()
                m_oHiliter.HilitedObjects.Remove(m_oLine)     ' It is failing here if we dont persist the Line Object
                m_oHiliter.HilitedObjects.Add(m_oLine)
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class

