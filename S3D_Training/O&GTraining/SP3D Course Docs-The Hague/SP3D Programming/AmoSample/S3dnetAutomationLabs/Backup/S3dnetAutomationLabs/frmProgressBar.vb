Public Class frmProgressBar

    Private Sub frmProgressBar_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



    Private Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        Progressbar.Increment(5)
        Me.Refresh()
    End Sub
End Class