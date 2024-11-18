Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Public Class StructCmd2
    Inherits BaseModalCommand

    Private m_form As frmStructCmd2

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        m_form = New frmStructCmd2
        m_form.ShowDialog()

    End Sub

End Class
