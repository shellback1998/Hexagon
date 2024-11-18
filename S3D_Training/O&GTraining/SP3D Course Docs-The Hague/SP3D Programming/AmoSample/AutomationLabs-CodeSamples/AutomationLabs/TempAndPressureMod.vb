
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class TempAndPressureMod
    Inherits BaseModalCommand

    Private m_frmCmdForm As frmTempAndPressureMod

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        'get select set and make sure we have exactly 1  Pipe run
        Dim oSelSet As SelectSet = ClientServiceProvider.SelectSet

        If oSelSet.SelectedObjects.Count = 1 AndAlso oSelSet.SelectedObjects.Item(0).SupportsInterface("IJRtePipeRun") Then
            m_frmCmdForm = New frmTempAndPressureMod
            m_frmCmdForm.ShowDialog()
        Else
            MsgBox("Please select a single pipe run before running the command")
        End If
    End Sub

End Class
