Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Public Class TempAndPressureMod
    Inherits BaseModalCommand

    Private m_frmCmdForm As frmTempAndPressureMod

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim oSelSet As SelectSet = ClientServiceProvider.SelectSet
        If oSelSet.SelectedObjects.Count <> 1 Then
            MsgBox("You need to select a single Pipe Run before running the command.")
        ElseIf (oSelSet.SelectedObjects.Item(0).SupportsInterface("IJRtePipeRun")) Then
            m_frmCmdForm = New frmTempAndPressureMod
            m_frmCmdForm.ShowDialog()
        Else
            MsgBox("You need to select a single Pipe Run before running the command.")
        End If
    End Sub
End Class
