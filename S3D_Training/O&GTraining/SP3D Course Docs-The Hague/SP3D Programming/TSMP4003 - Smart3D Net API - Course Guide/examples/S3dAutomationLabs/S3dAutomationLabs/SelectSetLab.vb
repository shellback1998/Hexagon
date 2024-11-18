
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class SelectSetLab
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim frm As SelectSetLabFrm

        frm = New SelectSetLabFrm

        frm.ShowDialog()

    End Sub
End Class
