Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class frmEqpModCmd

    Public Event OnFinish()
    Public Event OnNameChanged()
    Public Event OnPositionChanged(ByVal Ps As Position)

    Private m_Pos As New Position

    Public Property Position() As Position
        Get
            Return m_Pos
        End Get

        Set(ByVal value As Position)
            m_Pos = value

            txtX.Text = FormatDistanceValue(m_Pos.X)
            txtY.Text = FormatDistanceValue(m_Pos.Y)
            txtZ.Text = FormatDistanceValue(m_Pos.Z)
        End Set

    End Property

    Public Property EqpName() As String
        Get
            Return txtName.Text
        End Get
        Set(ByVal value As String)
            txtName.Text = value
        End Set
    End Property


    Private Sub frmEqpModCmd_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        txtX.ForeColor = Drawing.Color.Black
        txtY.ForeColor = Drawing.Color.Black
        txtZ.ForeColor = Drawing.Color.Black

    End Sub

    Private Sub btnFinish_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinish.Click
        RaiseEvent OnFinish()
    End Sub

    Private Sub txtName_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtName.KeyDown
        If e.KeyCode = Windows.Forms.Keys.Enter Then
            RaiseEvent OnNameChanged()
        End If
    End Sub

    Private Sub txtName_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtName.LostFocus
        RaiseEvent OnNameChanged()
    End Sub

    'called whenever a coordinate value is changed.
    'It will try to parse the value, and if it fails,
    'it will show the value in RED
    Private Function CheckCoordinate(ByVal sender As Object, ByRef dValue As Double) As Boolean

        Dim oTextBox As Windows.Forms.TextBox = sender
        Dim bResult As Boolean = True

        Try
            dValue = MiddleServiceProvider.UOMMgr.ParseUnit(UnitType.Distance, oTextBox.Text)

        Catch ex As Exception
            bResult = False
            oTextBox.ForeColor = Drawing.Color.Red
        End Try

        Return bResult

    End Function

    Private Sub ComputePosition()
        'only raise event if all 3 coordinates are valid

        If txtX.ForeColor = Drawing.Color.Black AndAlso _
        txtY.ForeColor = Drawing.Color.Black AndAlso _
        txtZ.ForeColor = Drawing.Color.Black Then

            RaiseEvent OnPositionChanged(m_Pos)

        End If
    End Sub

    'handles KeyDown for all coordinate input boxes
    Private Sub txtXYZ_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) _
    Handles txtX.KeyDown, txtY.KeyDown, txtZ.KeyDown

        'first change the color to black since we are entering a value
        Dim oTextBox As Windows.Forms.TextBox = sender

        oTextBox.ForeColor = Drawing.Color.Black

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dValue As Double

            If CheckCoordinate(sender, dValue) Then
                If (sender Is txtX) Then m_Pos.X = dValue
                If (sender Is txtY) Then m_Pos.Y = dValue
                If (sender Is txtZ) Then m_Pos.Z = dValue

                ComputePosition()
            End If
        End If
    End Sub

    
    'handles LostFocus for all coordinate input boxes
    Private Sub txtXYZ_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) _
        Handles txtX.LostFocus, txtY.LostFocus, txtZ.LostFocus

        Dim dValue As Double

        If CheckCoordinate(sender, dValue) Then
            If (sender Is txtX) Then m_Pos.X = dValue
            If (sender Is txtY) Then m_Pos.Y = dValue
            If (sender Is txtZ) Then m_Pos.Z = dValue
            ComputePosition()
        End If
    End Sub


    Private Function FormatDistanceValue(ByVal dValue) As String
        Return MiddleServiceProvider.UOMMgr.FormatUnit(UnitType.Distance, dValue)
    End Function


End Class