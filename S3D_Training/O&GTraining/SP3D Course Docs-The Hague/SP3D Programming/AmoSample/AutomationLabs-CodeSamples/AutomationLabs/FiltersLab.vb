Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services


Public Class FiltersLab
    Inherits BaseModalCommand

    Private m_ofrmFilterFolder As frmFiltersLab

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_ofrmFilterFolder = New frmFiltersLab
        m_ofrmFilterFolder.ShowDialog()
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_ofrmFilterFolder.Close()
    End Sub

End Class
