Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle
Imports System.Collections.ObjectModel

Public Class SmartCmdLab
    Inherits BaseStepCommand

    Private m_activeItemIdx As Integer

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Me.StepCount = 2

        'used only for steps where UseStepHiliterForSelection = False
        Me.SelectHiliterColor = ColorConstants.RGBBlue
        Me.SelectHiliterWeight = 2

        '1st step 
        Me.Steps(0).Prompt = "Select Equipment(s) using a Fence. Press UpArrow when ready to specify positions."
        Me.Steps(0).LocateBehavior = StepDefinition.LocateBehaviors.Fence
        Me.Steps(0).StepFilter = New StepFilter
        Me.Steps(0).StepFilter.AddInterface("IJSmartEquipmentOcc")
        Me.Steps(0).UseStepHiliterForSelection = True
        Me.Steps(0).HiliteSelected = True
        Me.Steps(0).SelectHiliterColor = ColorConstants.RGBWhite
        Me.Steps(0).SelectHiliterWeight = 2

        '2nd step
        Me.Steps(1).Prompt = "Specify Position of Equipment"
        Me.Steps(1).LocateBehavior = StepDefinition.LocateBehaviors.SmartSketch3D
        Me.Steps(1).UseStepHiliterForSelection = False

        Me.Steps(1).SmartSketchOptions.AssistingPositionOn = True
        Me.Steps(1).SmartSketchOptions.CenterPoint = True
        Me.Steps(1).SmartSketchOptions.KeyPoint = True
        Me.Steps(1).SmartSketchOptions.ReferenceAxisAlignment = True 'cannot do horiz/vert separately
        Me.Steps(1).SmartSketchOptions.Intersection = True
        Me.Steps(1).SmartSketchOptions.MidPoint = True
        Me.Steps(1).SmartSketchOptions.OffsetPlane = False
        Me.Steps(1).SmartSketchOptions.Parallel = False
        Me.Steps(1).SmartSketchOptions.Perpendicular = False
        Me.Steps(1).SmartSketchOptions.PointOnCurve = True
        Me.Steps(1).SmartSketchOptions.PointCreator = Nothing


        'set active step to 0
        Me.Enabled = True
        Me.CurrentStepIndex = 0
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        ClientServiceProvider.TransactionMgr.Abort()

    End Sub

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView
        End Get
    End Property

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)
        Try
            If Me.CurrentStepIndex = 1 Then

                ''This will show that the position passed comes from the SmartSketch3D, therefore
                ''it is different than the transformed mouse x,y
                'Dim oPos As Position = XformScreenToWorld(view, e.X, e.Y)

                'If oPos <> position Then
                '    MsgBox("SmartSketch3d position different than transformed mouse coords")
                'End If

                WriteStatusBarMsg("Arrows: UpArrow-Position, Left/RightArrow-EqptChange, DownArrow-Finish")

                If (m_activeItemIdx > 0 And m_activeItemIdx <= Steps(0).SelectedBusinessObjects.Count) Then
                    Dim oEqp As Equipment

                    oEqp = Steps(0).SelectedBusinessObjects(m_activeItemIdx - 1)
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
            Me.StopCommand()
        End If
    End Sub

    Public Overrides Sub OnSuspend()
        MyBase.OnSuspend()
        Me.Enabled = False
    End Sub

    Public Overrides Sub OnResume()
        MyBase.OnResume()
        Me.Enabled = True
    End Sub


    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)

        If Not Steps Is Nothing Then
            If e.KeyValue = System.Windows.Forms.Keys.Left Then      'To move Back for Previous Equipment
                PreviousOrNext(-1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Right Then  ' To move Forward for Next Equipment
                PreviousOrNext(1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Up Then     'Key For setting "Position" Step
                If (Me.CurrentStepIndex = 0) And Not (Me.Steps(0).SelectedBusinessObjects.Count = 0) Then
                    Me.CurrentStepIndex = 1
                    m_activeItemIdx = 1 ' reset to 1
                End If
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Down Then    'For "Finish" Step
                ClientServiceProvider.TransactionMgr.Commit("Step Command Commit")
                Me.StopCommand()
            End If
        End If

    End Sub

    Private Sub PreviousOrNext(ByVal delta As Integer)

        m_activeItemIdx = m_activeItemIdx + delta
        With Me.Steps(0).SelectedBusinessObjects
            ' allow 'parking at '0' and 'n+1' so user can
            ' press left/right arrow keys to go back/forward.
            If (m_activeItemIdx < 0) Then
                m_activeItemIdx = 0
            ElseIf (m_activeItemIdx > .Count + 1) Then
                m_activeItemIdx = .Count + 1
            End If
        End With

    End Sub

End Class
