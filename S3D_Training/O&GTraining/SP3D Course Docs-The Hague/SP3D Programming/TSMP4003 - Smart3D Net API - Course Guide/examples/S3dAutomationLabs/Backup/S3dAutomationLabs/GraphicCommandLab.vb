Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Imports Ingr.SP3D.Equipment.Middle


Public Class GraphicCommandLab
    Inherits BaseGraphicCommand

    Private WithEvents m_frmCmdForm As GraphicCmdLabFrm

    Private mHighlight As Hiliter
    Private oLine As Line3d

    Private m_oMatrix As Matrix4X4
    Private m_oOrigin As New Position

    Private m_oSmartsketch As SmartSketch3d

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView
        End Get
    End Property

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)


        mHighlight = New Hiliter
        mHighlight.LinePattern = HiliterBase.HiliterLinePattern.Solid '.Dashed 'Solid
        mHighlight.Color = RGB(255, 0, 0)
        mHighlight.Weight = 3

        m_oSmartsketch = New SmartSketch3d

        Dim oSelectset As SelectSet = ClientServiceProvider.SelectSet

        If oSelectset.SelectedObjects.Count > 0 AndAlso _
          TypeOf oSelectset.SelectedObjects.Item(0) Is Equipment Then
            Dim oEqp As Equipment
            oEqp = oSelectset.SelectedObjects.Item(0)

            m_oMatrix = New Matrix4X4(oEqp.Matrix)

            m_oOrigin.Set(m_oMatrix.GetIndexValue(12), _
                          m_oMatrix.GetIndexValue(13), _
                          m_oMatrix.GetIndexValue(14))
            m_oMatrix.Invert()

            If m_oOrigin.Subtract(oEqp.Origin).Length > 0.001 Then
                MsgBox("???")
            End If
            ' m_oOrigin = New Position(oEqp.Origin)

        Else
            m_oMatrix = New Matrix4X4
        End If


        m_frmCmdForm = New GraphicCmdLabFrm
        m_frmCmdForm.Show()
    End Sub
    Public Overrides Sub OnStop()
        m_frmCmdForm.Close()
        m_frmCmdForm = Nothing

        mHighlight.HilitedObjects.Clear()
        mHighlight = Nothing
    End Sub

    Public Overrides Sub OnSuspend()
        m_frmCmdForm.Hide()

        mHighlight.HilitedObjects.Clear()
    End Sub

    Public Overrides Sub OnResume()
        m_frmCmdForm.Show()

        If oLine IsNot Nothing Then
            mHighlight.HilitedObjects.Add(oLine)
        End If


    End Sub

    Protected Overrides Sub OnMouseDown(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)
        If e.Button = GraphicViewManager.GraphicViewEventArgs.MouseButtons.Right _
           And e.Shift = 0 Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnKeyDown(ByVal e As Ingr.SP3D.Common.Client.BaseGraphicCommand.KeyEventArgs)
        If e.KeyValue = ConsoleKey.Escape Then
            StopCommand()
        End If
    End Sub

    Protected Overrides Sub OnMouseMove( _
        ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, _
        ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, _
        ByVal position As Ingr.SP3D.Common.Middle.Position)

        m_frmCmdForm.lblViewX.Text = e.X
        m_frmCmdForm.lblViewY.Text = e.Y

        With m_frmCmdForm
            Dim oLPos As Position
            Dim oVec As Vector
            oLPos = m_oMatrix.Transform(position)
            oVec = position - m_oOrigin

            Dim oSS3dPt As Position = Nothing
            Dim oBo As BusinessObject = Nothing
            m_oSmartsketch.GetPosition(view, e.X, e.Y, SmartSketch3dMouseEvent.Move, oSS3dPt, oBo)

            Dim oIName As INamedItem
            If oBo IsNot Nothing Then
                If TypeOf oBo Is INamedItem Then
                    oIName = oBo
                    m_frmCmdForm.Text = oIName.Name
                End If

            End If
            .lblWorldX.Text = "GX: " & position.X & " SS3dx: " & oSS3dPt.X & " LX: " & oLPos.X & " Vx: " & oVec.X
            .lblWorldY.Text = "GY: " & position.Y & " SS3dy: " & oSS3dPt.Y & " LY: " & oLPos.Y & " Vy: " & oVec.Y
            .lblWorldZ.Text = "GZ: " & position.Z & " SS3dz: " & oSS3dPt.Z & " LZ: " & oLPos.Z & " Vz: " & oVec.Z
        End With

 
        If oLine Is Nothing Then

            oLine = New Line3d(m_oOrigin, position)
        Else
            oLine.EndPoint = position
        End If
        mHighlight.HilitedObjects.Clear()
        mHighlight.HilitedObjects.Add(oLine)

        Dim oPos As New Position
        oPos = XformScreenToWorld(view, e.X, e.Y)
        If oPos.Subtract(position).Length > 0.001 Then
            MsgBox("Invalid transformation view to world")
        End If

    End Sub


    Private Sub m_frmCmdForm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles m_frmCmdForm.FormClosed
        StopCommand()
    End Sub
End Class
