Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services


Public Class SampleModalCmd
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Dim oSelectSet As SelectSet = ClientServiceProvider.SelectSet
        If (oSelectSet.SelectedObjects.Count = 0) Then
            MsgBox("No Objects Selected")
        Else
            Dim strSelectedObjectNames As String = ""
            For Each oObj As BusinessObject In oSelectSet.SelectedObjects
                strSelectedObjectNames += vbCrLf & oObj.ToString
            Next
            MsgBox(strSelectedObjectNames, , "Selected Object Names")
        End If
    End Sub

    'Public Overrides ReadOnly Property Modal() As Boolean
    '    Get
    '        Return False
    '    End Get
    'End Property

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveConnection + EnableUIFlagSettings.NonEmptySelectSet
        End Get
    End Property
End Class
