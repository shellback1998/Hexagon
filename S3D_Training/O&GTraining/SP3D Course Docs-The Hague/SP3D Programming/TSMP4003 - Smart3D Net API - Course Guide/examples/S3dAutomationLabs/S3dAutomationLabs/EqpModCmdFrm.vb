
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Middle

Public Class EqpModCmdFrm

    Private m_UOM As UOMManager
    Private m_oPos As New Position

    Public Event onFinish()
    Public Event onNameChanged()
    Public Event onPositionChanged(ByVal oPos As Position)

    Public Property EqpPosition() As Position
        Get
            Return m_oPos
        End Get
        Set(ByVal value As Position)
            m_oPos.Set(value.X, value.Y, value.Z)

            txtX.Text = formatDistanceValue(m_oPos.X)
            txtY.Text = formatDistanceValue(m_oPos.Y)
            txtZ.Text = formatDistanceValue(m_oPos.Z)

        End Set
    End Property

    Private Function formatDistanceValue(ByVal dVal As Double) As String
        Return m_UOM.FormatUnit(UnitType.Distance, dVal)
    End Function


    Private Sub btnFinish_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinish.Click
        RaiseEvent onFinish()
    End Sub


    Private Sub txtName_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtName.KeyDown
        If e.KeyCode = Windows.Forms.Keys.Enter Then
            RaiseEvent onNameChanged()
        End If
    End Sub


    Private Sub txtName_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtName.LostFocus
        RaiseEvent onNameChanged()
    End Sub

    Private Function CheckCoordinate(ByVal sender As Object, ByRef dValue As Double) As Boolean
        Dim oText As System.Windows.Forms.TextBox = sender
        Dim bResult As Boolean = True

        Try
            dValue = m_UOM.ParseUnit(UnitType.Distance, oText.Text)

        Catch ex As Exception
            bResult = False
            oText.ForeColor = Drawing.Color.Red
            oText.BackColor = Drawing.Color.LightPink
        End Try

        Return bResult
    End Function

    Private Sub ComputePosition()
        If txtX.ForeColor = Drawing.Color.Black _
           And txtY.ForeColor = Drawing.Color.Black _
           And txtZ.ForeColor = Drawing.Color.Black Then

            RaiseEvent onPositionChanged(m_oPos)
        End If

    End Sub



    Private Sub txtX_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtX.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dValue As Double
            If CheckCoordinate(sender, dValue) Then
                m_oPos.X = dValue
                ComputePosition()
            End If
        End If
    End Sub



    Private Sub txtX_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtX.LostFocus
        Dim dvalue As Double

        If CheckCoordinate(sender, dvalue) Then
            m_oPos.X = dvalue
            ComputePosition()
        End If
    End Sub



    ' TODO: copy txtX_LostFocus and txtX_KeyDown for y and z

    Private Sub txty_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtY.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dValue As Double
            If CheckCoordinate(sender, dValue) Then
                m_oPos.Y = dValue
                ComputePosition()
            End If
        End If
    End Sub



    Private Sub txty_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtY.LostFocus
        Dim dvalue As Double

        If CheckCoordinate(sender, dvalue) Then
            m_oPos.Y = dvalue
            ComputePosition()
        End If
    End Sub


    Private Sub txtz_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtZ.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dValue As Double
            If CheckCoordinate(sender, dValue) Then
                m_oPos.Z = dValue
                ComputePosition()
            End If
        End If
    End Sub



    Private Sub txtz_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtZ.LostFocus
        Dim dvalue As Double

        If CheckCoordinate(sender, dvalue) Then
            m_oPos.Z = dvalue
            ComputePosition()
        End If
    End Sub


    Private Sub EqpModCmdFrm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        m_UOM = MiddleServiceProvider.UOMMgr

        txtX.ForeColor = Drawing.Color.Black
        txtY.ForeColor = Drawing.Color.Black
        txtZ.ForeColor = Drawing.Color.Black

    End Sub
End Class