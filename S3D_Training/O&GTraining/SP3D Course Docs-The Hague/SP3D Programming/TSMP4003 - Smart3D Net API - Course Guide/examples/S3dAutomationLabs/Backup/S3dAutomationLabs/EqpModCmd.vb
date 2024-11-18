


Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Imports Ingr.SP3D.Equipment.Middle

' avoid 'long names' for mouse button
' constants in OnMouseMove and OnMouseDown
Imports Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs


Public Class EqpModCmd
    Inherits BaseGraphicCommand

    Private WithEvents m_frmEqpModForm As EqpModCmdFrm

    Private m_oEqp As Equipment
    Private m_oTransactionMgr As ClientTransactionManager
    Private m_oUOM As UOMManager
    Private m_Modalstate As Boolean


    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)

        m_oUOM = MiddleServiceProvider.UOMMgr

        m_oTransactionMgr = ClientServiceProvider.TransactionMgr

        Dim oSelectset As SelectSet = ClientServiceProvider.SelectSet

        If Not (oSelectset.SelectedObjects.Count = 1 AndAlso _
          TypeOf oSelectset.SelectedObjects.Item(0) Is Equipment) Then
            MsgBox("Select One Equipment before running the command")
            m_Modalstate = True
            Exit Sub
        End If

        m_oEqp = oSelectset.SelectedObjects.Item(0)

        m_frmEqpModForm = New EqpModCmdFrm
        m_frmEqpModForm.Show()

        m_frmEqpModForm.EqpPosition = m_oEqp.Origin
        m_frmEqpModForm.txtName.Text = m_oEqp.Name
    End Sub

    Public Overrides ReadOnly Property Modal() As Boolean
        Get
            Return m_Modalstate
        End Get
    End Property


    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, _
            ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, _
            ByVal position As Ingr.SP3D.Common.Middle.Position)

        If e.Button = MouseButtons.Left Then
            m_oEqp.Origin = position

            m_oTransactionMgr.Compute()

            m_frmEqpModForm.EqpPosition = m_oEqp.Origin

        End If
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)

        If e.Button = MouseButtons.Right Then
            StopCommand()
        ElseIf e.Button = MouseButtons.Left Then
            OnMouseMove(view, e, position)
        End If

    End Sub
    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)

        If e.KeyValue = ConsoleKey.Escape Then
            StopCommand()
        End If
    End Sub


    Private Sub m_frmEqpModForm_onFinish() Handles m_frmEqpModForm.onFinish
        m_oTransactionMgr.Commit("Modify Equipment")
        StopCommand()
    End Sub

    Private Sub m_frmEqpModForm_onNameChanged() Handles m_frmEqpModForm.onNameChanged
        If m_oEqp.Name <> m_frmEqpModForm.txtName.Text Then
            m_oEqp.SetUserDefinedName(m_frmEqpModForm.txtName.Text)

        End If
    End Sub


    Private Sub m_frmEqpModForm_onPositionChanged(ByVal oPos As Ingr.SP3D.Common.Middle.Position) Handles m_frmEqpModForm.onPositionChanged
        m_oEqp.Origin = oPos
        m_oTransactionMgr.Compute()

        m_frmEqpModForm.EqpPosition = m_oEqp.Origin
    End Sub

    Public Overrides Sub OnStop()

        If m_frmEqpModForm IsNot Nothing Then
            m_frmEqpModForm.Close()
        End If

        m_oTransactionMgr.Abort()

    End Sub

    'TODO: overrides also OnSuspend, OnResume

End Class
