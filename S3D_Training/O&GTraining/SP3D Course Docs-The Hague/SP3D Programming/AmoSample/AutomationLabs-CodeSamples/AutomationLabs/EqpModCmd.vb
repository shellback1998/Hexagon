
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle
'import this to avoid 'long names' for mouse button
'constants in OnMouseMove and OnMouseDown
Imports Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs



Public Class EqpModCmd
    Inherits BaseGraphicCommand

    Private WithEvents m_RBEqpMod As New RBEqipmentMod
    Private m_oEqp As Equipment
    Private m_oTransactionMgr As ClientTransactionManager

    Private m_ModalState As Boolean = False

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)

        'create and set RB
        'm_RBEqpMod = New RBEquipMod
        Me.RibbonBar = m_RBEqpMod

        'get SelectSet
        Dim oSelectSet As SelectSet = ClientServiceProvider.SelectSet

        'check if we have exactly one equipment in the oSelectSet
        If Not (oSelectSet.SelectedObjects.Count = 1 AndAlso _
                (TypeOf oSelectSet.SelectedObjects.Item(0) Is Equipment)) Then
            GoTo ExitWitMessage
        End If

        'get selected equipment
        m_oEqp = CType(oSelectSet.SelectedObjects.Item(0), Equipment)

        'initialize form properties
        m_RBEqpMod.Position = m_oEqp.Origin
        m_RBEqpMod.EqpName = m_oEqp.Name

        Exit Sub
ExitWitMessage:
        MsgBox("Select One Equipment before running this command.")
        'force system to stop us by making our Modal property = true
        m_ModalState = True
    End Sub

    Public Overrides ReadOnly Property Modal() As Boolean
        Get
            Return m_ModalState
        End Get
    End Property
    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)

        If e.Button = MouseButtons.Left Then
            m_oEqp.Origin = position
            ClientServiceProvider.TransactionMgr.Compute()
            m_RBEqpMod.Position = m_oEqp.Origin
        End If
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)

        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Left Then
            OnMouseMove(view, e, position)
        ElseIf e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right Then
            StopCommand()
        End If
    End Sub


    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)
        MyBase.OnKeyDown(e)

        If e.KeyValue = ConsoleKey.Escape Then
            StopCommand()
        End If

    End Sub
    Public Overrides Sub OnStop()

        ClientServiceProvider.TransactionMgr.Abort()
        'this check is needed, because if no equipment is selected
        'we'll arrive here withough having initialized the form

        Me.RibbonBar = Nothing
        m_RBEqpMod.Dispose()

    End Sub
   

    Private Sub m_RB_OnFinish() Handles m_RBEqpMod.OnFinish
        ClientServiceProvider.TransactionMgr.Commit("Eqp Mod Cmd")
        StopCommand()
    End Sub

    Private Sub m_RB_OnNameChanged() Handles m_RBEqpMod.OnNameChanged
        If m_oEqp.Name <> m_RBEqpMod.EqpName Then
            m_oEqp.SetUserDefinedName(m_RBEqpMod.EqpName)
        End If
    End Sub


    Private Sub m_RB_OnPositionChanged(ByVal oPos As Ingr.SP3D.Common.Middle.Position) Handles m_RBEqpMod.OnPositionChanged

        m_oEqp.Origin = oPos

        'constraints might not allow the equipment to move to this position
        'so we need the following
        ClientServiceProvider.TransactionMgr.Compute()
        m_RBEqpMod.Position = m_oEqp.Origin

    End Sub

   

End Class
