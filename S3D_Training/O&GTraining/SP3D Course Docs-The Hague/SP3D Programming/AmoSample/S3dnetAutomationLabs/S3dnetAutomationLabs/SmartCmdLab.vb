Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Equipment.Middle
Imports System.Collections.ObjectModel

Public Class SmartCmdLab
    Inherits BaseStepCommand

    Private m_activeItemIdx As Integer


    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView
        End Get
    End Property

    Public Overrides Sub OnStop()
        ClientServiceProvider.TransactionMgr.Abort()
    End Sub

    Public Overrides Sub OnSuspend()
        Enabled = False
    End Sub

    Public Overrides Sub OnResume()
        Enabled = True
    End Sub

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        StepCount = 2

        SelectHiliterColor = ColorConstants.RGBBlue
        SelectHiliterWeight = 2

        Steps(0).Prompt = "Select Equipment(s) using a fence. Press UpArrow when ready to specify positions."
        Steps(0).LocateBehavior = StepDefinition.LocateBehaviors.Fence
        Steps(0).StepFilter = New StepFilter
        Steps(0).StepFilter.AddInterface("IJSmartEquipment")
        Steps(0).UseStepHiliterForSelection = True
        Steps(0).HiliteSelected = True
        Steps(0).SelectHiliterColor = ColorConstants.RGBWhite
        Steps(0).SelectHiliterWeight = 2

        Steps(1).Prompt = "Specify Eqp Position: Left/Right Arrow = Prev/next Eqp"
        Steps(1).LocateBehavior = StepDefinition.LocateBehaviors.SmartSketch3D
        Steps(1).UseStepHiliterForSelection = False
        Steps(1).SmartSketchOptions.EvaluateCenterpointOn = True
        Steps(1).SmartSketchOptions.CenterPoint = True
        Steps(1).SmartSketchOptions.ReferenceAxisAlignment = True
        Steps(1).SmartSketchOptions.Intersection = True
        Steps(1).SmartSketchOptions.MidPoint = True
        Steps(1).SmartSketchOptions.PointOnCurve = True
        Steps(1).SmartSketchOptions.PointCreator = Nothing

        ClientServiceProvider.TransactionMgr.Abort()
        Enabled = True
        CurrentStepIndex = 0

    End Sub

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        Try
            If Not Steps Is Nothing And CurrentStepIndex = 1 Then
                WriteStatusBarMsg("Arrows: UpArrow-Position, Left/RightArrow-EqptChange, DownArrow-Finish")

                If (m_activeItemIdx > 0 And m_activeItemIdx <= Steps(0).SelectedBusinessObjects.Count) Then
                    Dim oEqp As Equipment = Steps(0).SelectedBusinessObjects(m_activeItemIdx - 1)

                    oEqp.Origin = position
                    ClientServiceProvider.TransactionMgr.Compute()

                End If
            End If
        Catch ex As Exception
            MsgBox("" & ex.Message, , "ErrorMouseMove")
        End Try
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)

        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Left And CurrentStepIndex = 1 Then
            PreviousOrNext(1)
        ElseIf e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)

        If Not Steps Is Nothing Then
            If e.KeyValue = System.Windows.Forms.Keys.Left Then
                PreviousOrNext(-1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Right Then
                PreviousOrNext(1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Up Then
                If (CurrentStepIndex = 0) And Not (Steps(0).SelectedBusinessObjects.Count = 0) Then
                    CurrentStepIndex = 1
                    m_activeItemIdx = 1
                End If
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Down Then
                onfinish()
            End If
        End If
    End Sub

    Private Sub onfinish()
        ClientServiceProvider.TransactionMgr.Commit("Step Command Commit")
        StopCommand()
    End Sub

    Private Sub PreviousOrNext(ByVal delta As Integer)

        m_activeItemIdx = m_activeItemIdx + delta
        With Steps(0).SelectedBusinessObjects
            If (m_activeItemIdx < 0) Then
                m_activeItemIdx = 0
            ElseIf (m_activeItemIdx > .Count + 1) Then
                m_activeItemIdx = .Count + 1
            End If
        End With

    End Sub

End Class
