Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Public Class GraphicCmdLab
    Inherits BaseGraphicCommand

    Private WithEvents m_frmCmdForm As frmGraphicCmdLab
    Private WithEvents m_EVGrphViewMgr As GraphicViewManager
    Private m_bExiting As Boolean


    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView
        End Get
    End Property
    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_bExiting = False
        m_frmCmdForm = New frmGraphicCmdLab
        m_frmCmdForm.Show() 'show as non-modal

        m_EVGrphViewMgr = ClientServiceProvider.GraphicViewMgr
    End Sub

    Public Overrides Sub OnSuspend()
        MyBase.OnSuspend()
        m_frmCmdForm.Hide()
        m_EVGrphViewMgr = Nothing
    End Sub

    Public Overrides Sub OnResume()
        MyBase.OnResume()
        m_frmCmdForm.Show()
        m_EVGrphViewMgr = ClientServiceProvider.GraphicViewMgr
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()

        'ensure Form.Close will be called only once
        If m_bExiting = False Then
            m_bExiting = True
            m_frmCmdForm.Close()
        End If

        m_frmCmdForm = Nothing
        m_EVGrphViewMgr = Nothing
    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseDown(view, e, position)

        'right-click stops the command
        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right And e.Shift = 0 Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)
        MyBase.OnKeyDown(e)

        If e.KeyValue = ConsoleKey.Escape Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        MyBase.OnMouseMove(view, e, position)

        m_frmCmdForm.lblViewX.Text = e.X
        m_frmCmdForm.lblViewY.Text = e.Y

        m_frmCmdForm.lblWorldX.Text = position.X.ToString("F3")
        m_frmCmdForm.lblWorldY.Text = position.Y.ToString("F3")
        m_frmCmdForm.lblWorldZ.Text = position.Z.ToString("F3")

        '3D world Position is available in OnMouseMove
        'method signature. For GraphicViewMgr events, though,
        'you will have to get it like below:
        '
        'Dim oPos as Position
        'oPos = XformScreenToWorld(view, e.X, e.Y)


    End Sub


    Private Sub m_frmCmdForm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles m_frmCmdForm.FormClosed
        'make sure we do not call StopCommand if
        'we are already in StopCommand (m_bFormClosed will be "True")
        If m_bExiting = False Then
            m_bExiting = True
            StopCommand()
        End If
    End Sub

    Private Sub m_EVGrphViewMgr_DblClick(ByRef view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs) Handles m_EVGrphViewMgr.DblClick

        Dim oPos As Position
        oPos = XformScreenToWorld(view, e.X, e.Y)
        WriteStatusBarMsg("DblClick X: " & oPos.X & "     Y: " & oPos.Y & "     Z: " & oPos.Z)

    End Sub


End Class
