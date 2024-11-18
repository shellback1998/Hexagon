Option Strict Off
Option Explicit On
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Equipment.Middle

'**************************************************************************************
'WARNING - USE THIS ONLY AS A BLUEPRINT FOR FUTURE USE OF CONSTRAINTS
'MATE CONSTRAINT IS NOT YET IMPLEMENTED, SO IT WILL NOT BE CREATED
'**********************************************************************************
Public Class EqpRelationsChange
    Inherits BaseStepCommand

    Private m_oObj As Equipment
    Private m_oSelectSet As SelectSet
    Private m_oTxnMgr As Ingr.SP3D.Common.Client.Services.ClientTransactionManager

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_oTxnMgr = ClientServiceProvider.TransactionMgr
        m_oSelectSet = ClientServiceProvider.SelectSet

        m_oSelectSet.SelectedObjects.Clear()

        StepCount = 3
        SelectHiliterColor = ColorConstants.RGBWhite
        SelectHiliterWeight = 10

        Steps(0).Prompt = "Select one Equipment which should be Mate"
        Steps(0).MaximumSelectable = 1
        Steps(0).LocateBehavior = StepDefinition.LocateBehaviors.QuickPick
        Steps(0).StepFilter.AddInterface("IJEquipment")
        Steps(0).UseStepHiliterForSelection = True
        Steps(0).HiliteSelected = True

        Steps(1).Prompt = "Select Reference On Selected Equipment"
        Steps(1).MaximumSelectable = 1
        Steps(1).LocateBehavior = StepDefinition.LocateBehaviors.QuickPick

        'StepFilter.Criteria = "IJPlane Or IJProjection Or IJCone"
        Steps(1).StepFilter.AddInterface("IJPlane")
        Steps(1).StepFilter.AddLogicalOperator(StepFilter.LogicalOperator.OR)
        Steps(1).StepFilter.AddInterface("IJProjection")
        Steps(1).StepFilter.AddLogicalOperator(StepFilter.LogicalOperator.OR)
        Steps(1).StepFilter.AddInterface("IJCone")

        Steps(1).UseStepHiliterForSelection = True
        Steps(1).HiliteSelected = True

        Steps(2).Prompt = "Select Reference in the Model"
        Steps(2).MaximumSelectable = 1
        Steps(2).LocateBehavior = StepDefinition.LocateBehaviors.QuickPick

        'StepFilter.Criteria = "IJPlane Or IJProjection Or IJCone"
        Steps(2).StepFilter.AddInterface("IJPlane")
        Steps(2).StepFilter.AddLogicalOperator(StepFilter.LogicalOperator.OR)
        Steps(2).StepFilter.AddInterface("IJProjection")
        Steps(2).StepFilter.AddLogicalOperator(StepFilter.LogicalOperator.OR)
        Steps(2).StepFilter.AddInterface("IJCone")
        Steps(2).ExcludedFromLocate.Add(Steps(0).SelectedBusinessObjects)


        Steps(2).UseStepHiliterForSelection = True
        Steps(2).HiliteSelected = True

        Enabled = True
        CurrentStepIndex = 0

    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_oTxnMgr = Nothing
        m_oSelectSet = Nothing
        m_oObj = Nothing

    End Sub

    Protected Overrides Sub OnMouseUp(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseUp(view, e, position)

        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right And CurrentStepIndex = 1 Then
            StopCommand()
        End If

        If Not Steps Is Nothing Then
            If Steps(0).SelectedBusinessObjects.Count = 1 And CurrentStepIndex = 0 Then
                m_oObj = Steps(0).SelectedBusinessObjects.Item(0)
                Steps(1).LocateTarget = Steps(0).SelectedBusinessObjects.Item(0)
                CurrentStepIndex = 1
            ElseIf Steps(1).SelectedBusinessObjects.Count = 1 And CurrentStepIndex = 1 Then
                Steps(2).LocateTarget = Nothing
                CurrentStepIndex = 2
                Steps(2).ExcludedFromLocate.Add(Steps(0).SelectedBusinessObjects)
            ElseIf Steps(2).SelectedBusinessObjects.Count = 1 And CurrentStepIndex = 2 Then
                MateEquipment()
            End If
        End If
    End Sub


    Private Sub MateEquipment()

        Try
            Dim oConstraint As Ingr.SP3D.Equipment.Middle.Constraint
            oConstraint = New Ingr.SP3D.Equipment.Middle.Constraint(m_oObj, Steps(1).SelectedBusinessObjects.Item(0), Steps(2).SelectedBusinessObjects.Item(0), ConstraintType.Mate, 0)
            m_oTxnMgr.Commit("Commit Mate")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class
