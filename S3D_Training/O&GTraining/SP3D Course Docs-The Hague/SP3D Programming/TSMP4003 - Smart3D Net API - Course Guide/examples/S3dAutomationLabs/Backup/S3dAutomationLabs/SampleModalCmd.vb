Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services


Public Class SampleModalCmd
    Inherits BaseModalCommand

    Dim WithEvents oselectset As SelectSet

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)


        oselectset = ClientServiceProvider.SelectSet

        If oselectset.SelectedObjects.Count = 0 Then
            MsgBox("No objects selected")
        Else
            Dim strNames As String = ""
            For Each oObj As BusinessObject In oselectset.SelectedObjects
                strNames += vbCrLf & oObj.ToString() & " (" & oObj.ObjectID & ")"

            Next
            MsgBox(strNames, MsgBoxStyle.OkOnly, "Selected Objects")
        End If
        oselectset = Nothing



    End Sub

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.NonEmptySelectSet + _
                   EnableUIFlagSettings.ActiveConnection

        End Get
    End Property

    Public Overrides ReadOnly Property Modal() As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides ReadOnly Property Suspendable() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Overrides Sub OnSuspend()
        WriteStatusBarMsg("Command suspended")
    End Sub

    Public Overrides Sub OnResume()
        WriteStatusBarMsg("Command resumed")
    End Sub


    Public Overrides Sub OnStop()
        WriteStatusBarMsg("Command stopped.")
    End Sub

    Private Sub oselectset_Added(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles oselectset.Added

    End Sub

    Private Sub oselectset_Removed(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles oselectset.Removed

    End Sub
End Class
