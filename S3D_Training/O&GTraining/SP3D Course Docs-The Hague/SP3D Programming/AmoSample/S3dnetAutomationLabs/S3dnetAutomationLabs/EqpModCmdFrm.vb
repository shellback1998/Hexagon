Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class EqpModCmdFrm
    Private m_UOM As UOMManager
    Private m_oPos As New Position

    Public Event onFinish()
    Public Event onNameChanged()
    Public Event OnPositionChanged(ByVal opos As Position)

    Public Property eqpPosition() As Position
        Get
            Return m_oPos
        End Get
        Set(ByVal value As Position)
            m_oPos.Set(value.X, value.Y, value.Z)
            txtX.Text = FormatDistanceValue(m_oPos.X)
            txtY.Text = FormatDistanceValue(m_oPos.Y)
            txtZ.Text = FormatDistanceValue(m_oPos.Z)

        End Set
    End Property

    Private Function FormatDistanceValue(ByVal dVal As Double) As String
        Return m_UOM.FormatUnit(UnitType.Distance, dVal)

    End Function

    Private Sub btnFinish_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFinish.Click
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

    Private Function checkcoordinate(ByVal sender As Object, Byref dValue As Double) As Boolean
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
            RaiseEvent OnPositionChanged(m_oPos)

        End If
    End Sub

    Private Sub txtX_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtX.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dvalue As Double
            If checkcoordinate(sender, dvalue) Then
                m_oPos.X = dvalue
                ComputePosition()

            End If
        End If
    End Sub



    Private Sub txtX_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtX.LostFocus
        Dim dvalue As Double

        If checkcoordinate(sender, dvalue) Then
            m_oPos.X = dvalue
            ComputePosition()
        End If

    End Sub


    Private Sub txtY_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtY.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dvalue As Double
            If checkcoordinate(sender, dvalue) Then
                m_oPos.Y = dvalue
                ComputePosition()

            End If
        End If
    End Sub



    Private Sub txtY_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtY.LostFocus
        Dim dvalue As Double

        If checkcoordinate(sender, dvalue) Then
            m_oPos.Y = dvalue
            ComputePosition()
        End If

    End Sub

    Private Sub txtZ_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtZ.KeyDown
        Dim oTextbox As System.Windows.Forms.TextBox = sender

        oTextbox.ForeColor = Drawing.Color.Black
        oTextbox.BackColor = Drawing.Color.White

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dvalue As Double
            If checkcoordinate(sender, dvalue) Then
                m_oPos.Z = dvalue
                ComputePosition()

            End If
        End If
    End Sub



    Private Sub txtZ_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtZ.LostFocus
        Dim dvalue As Double

        If checkcoordinate(sender, dvalue) Then
            m_oPos.Z = dvalue
            ComputePosition()
        End If

    End Sub


    ' TODO:copy txtX_KeyDown and txtX_LostFocus for Y and Z

    Private Sub EqpModCmdFrm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        m_UOM = MiddleServiceProvider.UOMMgr
        txtX.ForeColor = Drawing.Color.Black
        txtY.ForeColor = Drawing.Color.Black
        txtZ.ForeColor = Drawing.Color.Black


    End Sub
End Class