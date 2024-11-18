Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Equipment.Middle

Public Class LocalCoordSystemPositionCmd
    Inherits BaseGraphicCommand

    Private m_frmCmdForm As frmGraphicCmdLab
    Private m_oOrigin As New Position
    Private m_Mtx As Matrix4X4


    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)


        With ClientServiceProvider.SelectSet.SelectedObjects

            If (.Count > 0) AndAlso (TypeOf .Item(0) Is Equipment) Then
                'get equipment
                Dim oEqp As Equipment = .Item(0)
                'create a new matrix and make it equal to the Eqp's matrix
                m_Mtx = New Matrix4X4(oEqp.Matrix)
                m_oOrigin = oEqp.Origin
                m_Mtx.Invert()

            Else
                'no equipment. Create a new matrix (Identity by default)
                m_Mtx = New Matrix4X4
            End If
        End With

        m_frmCmdForm = New frmGraphicCmdLab
        m_frmCmdForm.Show()

    End Sub

    Public Overrides Sub OnSuspend()
        MyBase.OnSuspend()
        m_frmCmdForm.Hide()
    End Sub

    Public Overrides Sub OnResume()
        MyBase.OnResume()
        m_frmCmdForm.Show()
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_frmCmdForm.Close()
        m_frmCmdForm = Nothing
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)

        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right And e.Shift = 0 Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)
        MyBase.OnKeyDown(e)

        If e.KeyValue = ConsoleKey.Escape And e.Shift = False Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)

        m_frmCmdForm.lblViewX.Text = e.X
        m_frmCmdForm.lblViewY.Text = e.Y

        Dim oLPos As Position = m_Mtx.Transform(position) 'transform from Global to Local coordinates
        Dim oVec As Vector = (position - m_oOrigin) 'get vector from Origin to position

        m_frmCmdForm.lblWorldX.Text = "Gx: " & position.X.ToString("F3") & " Lx: " & oLPos.X.ToString("F3") & " Vx: " & oVec.X.ToString("F3")
        m_frmCmdForm.lblWorldY.Text = "Gy: " & position.Y.ToString("F3") & " Ly: " & oLPos.Y.ToString("F3") & " Vy: " & oVec.Y.ToString("F3")
        m_frmCmdForm.lblWorldZ.Text = "Gz: " & position.Z.ToString("F3") & " Lz: " & oLPos.Z.ToString("F3") & " Vz: " & oVec.Z.ToString("F3")

    End Sub

End Class
