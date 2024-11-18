Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle


Public Class SampleModalCmd
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Dim oSelSet As SelectSet = ClientServiceProvider.SelectSet

        If oSelSet.SelectedObjects.Count = 0 Then
            MsgBox("No Objects selected")
        Else
            Dim strSelectedObjectsNames As String = ""

            For Each oObj As BusinessObject In oSelSet.SelectedObjects
                strSelectedObjectsNames += vbCrLf & oObj.ToString
            Next

            MsgBox(strSelectedObjectsNames)
        End If
    End Sub

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveConnection Or EnableUIFlagSettings.NonEmptySelectSet
        End Get
    End Property

End Class
