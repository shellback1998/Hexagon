Imports Ingr.SP3D.Common.Client

Public Class PlaceEqpAndPiping
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim myForm As New PlaceEqpAndPipingForm
        myForm.ShowDialog()
    End Sub

End Class
