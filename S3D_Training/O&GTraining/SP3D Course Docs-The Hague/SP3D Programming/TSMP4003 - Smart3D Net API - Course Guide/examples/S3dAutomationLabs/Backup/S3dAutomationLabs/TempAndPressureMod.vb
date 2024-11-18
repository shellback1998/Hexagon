Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle



Public Class TempAndPressureMod
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim oTempAndPressureModForm As TempAndPressuerModFrm

        Dim oSelect As SelectSet = ClientServiceProvider.SelectSet

        If oSelect.SelectedObjects.Count <> 1 Then
            MsgBox("You need to select a single Piperun before running the command.")

        ElseIf oSelect.SelectedObjects.Item(0).SupportsInterface("IJRtePipeRun") Then
            oTempAndPressureModForm = New TempAndPressuerModFrm
            oTempAndPressureModForm.ShowDialog()
        Else
            MsgBox("You need to select a single Piperun before running the command.")
        End If

    End Sub
End Class
