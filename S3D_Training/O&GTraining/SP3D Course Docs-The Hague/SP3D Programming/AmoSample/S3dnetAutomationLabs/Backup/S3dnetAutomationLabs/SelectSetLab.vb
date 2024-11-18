Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class SelectSetLab
    Inherits BaseModalCommand

    Private m_Form As SelectSetLabForm

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        'Initialize our form
        m_Form = New SelectSetLabForm

        'Show our form
        m_Form.ShowDialog()

    End Sub


    Public Overrides ReadOnly Property Modal() As Boolean
        Get
            Return True
        End Get
    End Property
End Class
