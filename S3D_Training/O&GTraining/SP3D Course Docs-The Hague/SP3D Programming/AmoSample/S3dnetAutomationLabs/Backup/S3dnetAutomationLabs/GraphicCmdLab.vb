Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle



Public Class GraphicCmdLab
    Inherits BaseGraphicCommand

    Private WithEvents m_frmCmdForm As GraphicCmdLabForm

    Private mHighLight As Hiliter
    Private oline As Line3d

    'Private m_frmCmdForm As GraphicCmdLabForm
    Private m_oMtx As Matrix4X4
    Private m_oOrigin As New Position
    Private m_oSmartSketch As SmartSketch3d


    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView

        End Get
    End Property

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        m_frmCmdForm = New GraphicCmdLabForm
        m_oSmartSketch = New SmartSketch3d

        mHighLight = New Hiliter
        mHighLight.LinePattern = HiliterBase.HiliterLinePattern.Dashed
        mHighLight.Color = RGB(255, 0, 0)
        mHighLight.Weight = 2

        Dim oSelectSet As SelectSet = ClientServiceProvider.SelectSet
        If oSelectSet.SelectedObjects.Count > 0 AndAlso _
        TypeOf oSelectSet.SelectedObjects.Item(0) Is Equipment Then
            Dim oEqp As Equipment
            oEqp = oSelectSet.SelectedObjects.Item(0)

            m_oMtx = New Matrix4X4(oEqp.Matrix)
            m_oOrigin.Set(m_oMtx.GetIndexValue(12), _
                          m_oMtx.GetIndexValue(13), _
                          m_oMtx.GetIndexValue(14))
            m_oMtx.Invert()
        Else
            m_oMtx = New Matrix4X4
        End If

        m_frmCmdForm.Show()

    End Sub

    Public Overrides Sub Onstop()
        m_frmCmdForm.Close()
        m_frmCmdForm = Nothing

        mHighLight = Nothing

    End Sub

    Public Overrides Sub OnSuspend()
        m_frmCmdForm.Hide()

        mHighLight.HilitedObjects.Clear()
    End Sub

    Public Overrides Sub Onresume()
        m_frmCmdForm.Show()

        If oline IsNot Nothing Then
            mHighLight.HilitedObjects.Add(oline)
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

    Protected Overrides Sub OnMouseMove(ByVal view As Ingr.SP3D.Common.Client.Services.GraphicView, ByVal e As Ingr.SP3D.Common.Client.Services.GraphicViewManager.GraphicViewEventArgs, ByVal position As Ingr.SP3D.Common.Middle.Position)

        Dim oLPos As Position
        Dim oVec As Vector
        Dim oSS3DPt As Position = Nothing, oBo As BusinessObject = Nothing

        m_frmCmdForm.lblViewX.Text = e.X
        m_frmCmdForm.lblViewY.Text = e.Y
        m_oSmartSketch.GetPosition(view, e.X, e.Y, SmartSketch3dMouseEvent.Move, oSS3DPt, oBo)

        Dim oIName As INamedItem
        If oBo IsNot Nothing Then
            If TypeOf oBo Is INamedItem Then
                oIName = oBo
                m_frmCmdForm.Text = oIName.Name
            End If
        End If


        'm_frmCmdForm.lblWorldX.Text = position.X
        'm_frmCmdForm.lblWorldY.Text = position.Y
        'm_frmCmdForm.lblWorldZ.Text = position.Z

        With m_frmCmdForm

            oLPos = m_oMtx.Transform(position)
            oVec = position - m_oOrigin

            .lblWorldX.Text = "Gx:" & position.X & " oSS3DcX:" & oSS3DPt.X & " Lx:" & oLPos.X & " Vx:" & oVec.X
            .lblWorldY.Text = "Gy:" & position.Y & " oSS3DcY:" & oSS3DPt.Y & " Ly:" & oLPos.Y & " Vy:" & oVec.Y
            .lblWorldZ.Text = "Gz:" & position.Z & " oSS3DcZ:" & oSS3DPt.Z & " Lz:" & oLPos.Z & " Vz:" & oVec.Z

        End With

        If oline Is Nothing Then
            'oline = New Line3d(New Position(0, 0, 0), position)
            oline = New Line3d(m_oOrigin, position)
        Else
            oline.EndPoint = position
        End If
        mHighLight.HilitedObjects.Clear()
        mHighLight.HilitedObjects.Add(oline)

        Dim oPos As New Position
        oPos = XformScreenToWorld(view, e.X, e.Y)
        If oPos.Subtract(position).Length > 0.001 Then
            MsgBox("Invalid transformation view to world")
        End If

    End Sub

    Private Sub m_frmCmdForm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles m_frmCmdForm.FormClosed
        mHighLight.HilitedObjects.Clear()
        StopCommand()
    End Sub
End Class
