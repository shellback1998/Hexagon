<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class GraphicCmdLabFrm
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblViewX = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.lblViewY = New System.Windows.Forms.Label
        Me.lblWorldX = New System.Windows.Forms.Label
        Me.lblWorldY = New System.Windows.Forms.Label
        Me.lblWorldZ = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'lblViewX
        '
        Me.lblViewX.AutoSize = True
        Me.lblViewX.Location = New System.Drawing.Point(90, 20)
        Me.lblViewX.Name = "lblViewX"
        Me.lblViewX.Size = New System.Drawing.Size(39, 13)
        Me.lblViewX.TabIndex = 0
        Me.lblViewX.Text = "Label1"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 20)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(40, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "ViewX:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(12, 47)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(40, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "ViewY:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(12, 89)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(45, 13)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "WorldX:"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(12, 113)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(45, 13)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "WorldY:"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(12, 137)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(45, 13)
        Me.Label6.TabIndex = 5
        Me.Label6.Text = "WorldZ:"
        '
        'lblViewY
        '
        Me.lblViewY.AutoSize = True
        Me.lblViewY.Location = New System.Drawing.Point(90, 47)
        Me.lblViewY.Name = "lblViewY"
        Me.lblViewY.Size = New System.Drawing.Size(39, 13)
        Me.lblViewY.TabIndex = 6
        Me.lblViewY.Text = "Label7"
        '
        'lblWorldX
        '
        Me.lblWorldX.AutoSize = True
        Me.lblWorldX.Location = New System.Drawing.Point(90, 89)
        Me.lblWorldX.Name = "lblWorldX"
        Me.lblWorldX.Size = New System.Drawing.Size(39, 13)
        Me.lblWorldX.TabIndex = 7
        Me.lblWorldX.Text = "Label8"
        '
        'lblWorldY
        '
        Me.lblWorldY.AutoSize = True
        Me.lblWorldY.Location = New System.Drawing.Point(90, 113)
        Me.lblWorldY.Name = "lblWorldY"
        Me.lblWorldY.Size = New System.Drawing.Size(39, 13)
        Me.lblWorldY.TabIndex = 8
        Me.lblWorldY.Text = "Label9"
        '
        'lblWorldZ
        '
        Me.lblWorldZ.AutoSize = True
        Me.lblWorldZ.Location = New System.Drawing.Point(90, 137)
        Me.lblWorldZ.Name = "lblWorldZ"
        Me.lblWorldZ.Size = New System.Drawing.Size(45, 13)
        Me.lblWorldZ.TabIndex = 9
        Me.lblWorldZ.Text = "Label10"
        '
        'GraphicCmdLabFrm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(252, 167)
        Me.Controls.Add(Me.lblWorldZ)
        Me.Controls.Add(Me.lblWorldY)
        Me.Controls.Add(Me.lblWorldX)
        Me.Controls.Add(Me.lblViewY)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.lblViewX)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "GraphicCmdLabFrm"
        Me.Text = "GraphicCmdLabFrm"
        Me.TopMost = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblViewX As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents lblViewY As System.Windows.Forms.Label
    Friend WithEvents lblWorldX As System.Windows.Forms.Label
    Friend WithEvents lblWorldY As System.Windows.Forms.Label
    Friend WithEvents lblWorldZ As System.Windows.Forms.Label
End Class
