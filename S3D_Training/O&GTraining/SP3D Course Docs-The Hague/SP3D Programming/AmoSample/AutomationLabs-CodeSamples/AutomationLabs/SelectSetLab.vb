Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Public Class SelectSetLab
    Inherits BaseModalCommand

    Private m_Form As frmSelectSetLab

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)


        'initialize form
        m_Form = New frmSelectSetLab

        'show as Modal form
        m_Form.ShowDialog()


    End Sub

End Class
