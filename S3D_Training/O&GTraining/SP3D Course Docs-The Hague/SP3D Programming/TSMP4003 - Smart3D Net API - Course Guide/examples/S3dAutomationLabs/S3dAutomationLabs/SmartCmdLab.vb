
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Equipment.Middle
Imports System.Collections.ObjectModel


Public Class SmartCmdLab
    Inherits BaseStepCommand

    Private m_activeItemIdx As Integer


    Private m_oMoveIndicator As Line3d
    Private m_oMoveHiliter As Hiliter
    Private m_sCommitString As String

    Public Overrides Sub OnSuspend()
        Enabled = False
    End Sub
    Public Overrides Sub OnResume()
        Enabled = True
    End Sub

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveConnection

        End Get
    End Property

    Public Overrides Sub OnStop()
        ClientServiceProvider.TransactionMgr.Abort()

    End Sub

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)

        StepCount = 2

        SelectHiliterColor = ColorConstants.RGBBlue
        SelectHiliterWeight = 2

        '1st step
        Steps(0).Prompt = "Select Equipment(s) using a Fence. Press UpArrow when ready to specify positions."
        Steps(0).LocateBehavior = StepDefinition.LocateBehaviors.Fence
        Steps(0).StepFilter = New StepFilter
        Steps(0).StepFilter.AddInterface("IJSmartEquipment")
        Steps(0).UseStepHiliterForSelection = True
        Steps(0).HiliteSelected = True
        Steps(0).HiliteCumulativeSelection = True
        Steps(0).SelectHiliterColor = ColorConstants.RGBWhite
        Steps(0).SelectHiliterWeight = 2

        '2nd step
        Steps(1).Prompt = "Specify Position of Equipment, left/right arrow to toggle equipments."
        Steps(1).LocateBehavior = StepDefinition.LocateBehaviors.SmartSketch3D
        Steps(1).UseStepHiliterForSelection = False
        'Steps(1).SmartSketchOptions.AssistingPosition = True

        Steps(1).SmartSketchOptions.CenterPoint = True
        Steps(1).SmartSketchOptions.Offset = False
        Steps(1).SmartSketchOptions.Parallel = False


        m_oMoveHiliter = New Hiliter
        m_oMoveHiliter.Color = ColorConstants.RGBYellow
        m_oMoveHiliter.Weight = 3
        m_oMoveHiliter.LinePattern = HiliterBase.HiliterLinePattern.Solid

        m_sCommitString = "Reposition Multiple Equipments"

        Enabled = True
        CurrentStepIndex = 0

    End Sub

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)

        Try
            If Not Steps Is Nothing And CurrentStepIndex = 1 Then
                If m_activeItemIdx >= 0 And m_activeItemIdx < Steps(0).SelectedBusinessObjects.Count Then
                    Dim oEqp As Equipment = Steps(0).SelectedBusinessObjects.Item(m_activeItemIdx)

                    If m_oMoveIndicator Is Nothing Then
                        m_oMoveIndicator = New Line3d(oEqp.Origin, oEqp.Origin)
                    End If

                    oEqp.Origin = position
                    ClientServiceProvider.TransactionMgr.Compute()

 
                    m_oMoveIndicator.EndPoint = position
                    m_oMoveHiliter.HilitedObjects.Clear()
                    m_oMoveHiliter.HilitedObjects.Add(m_oMoveIndicator)

                End If
            End If
        Catch ex As Exception
            MsgBox(ex.Message, , "ErrorMouseMove")
        End Try
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)

        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Left And _
            CurrentStepIndex = 1 Then
            ClientServiceProvider.TransactionMgr.Compute()

            ClientServiceProvider.TransactionMgr.Commit(m_sCommitString)
            m_sCommitString = ""

            PreviousOrNext(-1)
        ElseIf e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)

        If Not Steps Is Nothing Then
            If e.KeyValue = System.Windows.Forms.Keys.Left Then
                ClientServiceProvider.TransactionMgr.Abort()

                PreviousOrNext(-1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Right Then
                ClientServiceProvider.TransactionMgr.Abort()
                PreviousOrNext(1)
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Up Then
                If CurrentStepIndex = 0 And Not (Steps(0).SelectedBusinessObjects.Count = 0) Then
                    CurrentStepIndex = 1
                    m_activeItemIdx = 0
                End If
            ElseIf e.KeyValue = System.Windows.Forms.Keys.Down Then
                onFinish()
            End If
        End If
    End Sub

    Private Sub onFinish()
        ClientServiceProvider.TransactionMgr.Commit("Step Command Commit")
        StopCommand()
    End Sub

    Private Sub PreviousOrNext(ByVal delta As Integer)
        m_activeItemIdx = m_activeItemIdx + delta
        With Steps(0).SelectedBusinessObjects
            If m_activeItemIdx < 0 Then
                m_activeItemIdx = 0
            ElseIf m_activeItemIdx > .Count Then
                m_activeItemIdx = .Count

            End If
            If m_activeItemIdx > 0 And m_activeItemIdx < .Count Then
                Dim oEQP As Equipment = .Item(m_activeItemIdx)
                Dim oPoint As New Position(oEQP.Origin)

                SmartSketch.AssistingPosition = oPoint

                If m_oMoveIndicator Is Nothing Then
                    m_oMoveIndicator = New Line3d(oPoint, oPoint)
                End If

                m_oMoveIndicator.StartPoint = oPoint

            End If


        End With
    End Sub

End Class
