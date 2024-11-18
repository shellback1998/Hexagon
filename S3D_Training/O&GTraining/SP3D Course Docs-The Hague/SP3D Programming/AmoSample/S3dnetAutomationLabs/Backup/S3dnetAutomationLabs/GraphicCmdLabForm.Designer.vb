<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class GraphicCmdLabForm
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
        Me.Label1 = New System.Windows.Forms.Label
        Me.lblViewX = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.lblViewY = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.lblWorldX = New System.Windows.Forms.Label
        Me.lblWorldY = New System.Windows.Forms.Label
        Me.Label8 = New System.Windows.Forms.Label
        Me.lblWorldZ = New System.Windows.Forms.Label
        Me.Label10 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(30, 24)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(37, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "ViewX"
        '
        'lblViewX
        '
        Me.lblViewX.AutoSize = True
        Me.lblViewX.Location = New System.Drawing.Point(143, 24)
        Me.lblViewX.Name = "lblViewX"
        Me.lblViewX.Size = New System.Drawing.Size(39, 13)
        Me.lblViewX.TabIndex = 1
        Me.lblViewX.Text = "Label2"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(30, 54)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(37, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "ViewY"
        '
        'lblViewY
        '
        Me.lblViewY.AutoSize = True
        Me.lblViewY.Location = New System.Drawing.Point(143, 54)
        Me.lblViewY.Name = "lblViewY"
        Me.lblViewY.Size = New System.Drawing.Size(39, 13)
        Me.lblViewY.TabIndex = 3
        Me.lblViewY.Text = "Label4"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(30, 83)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(42, 13)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "WorldX"
        '
        'lblWorldX
        '
        Me.lblWorldX.AutoSize = True
        Me.lblWorldX.Location = New System.Drawing.Point(143, 83)
        Me.lblWorldX.Name = "lblWorldX"
        Me.lblWorldX.Size = New System.Drawing.Size(39, 13)
        Me.lblWorldX.TabIndex = 5
        Me.lblWorldX.Text = "Label6"
        '
        'lblWorldY
        '
        Me.lblWorldY.AutoSize = True
        Me.lblWorldY.Location = New System.Drawing.Point(143, 108)
        Me.lblWorldY.Name = "lblWorldY"
        Me.lblWorldY.Size = New System.Drawing.Size(39, 13)
        Me.lblWorldY.TabIndex = 7
        Me.lblWorldY.Text = "Label7"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(30, 108)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(42, 13)
        Me.Label8.TabIndex = 6
        Me.Label8.Text = "WorldY"
        '
        'lblWorldZ
        '
        Me.lblWorldZ.AutoSize = True
        Me.lblWorldZ.Location = New System.Drawing.Point(143, 134)
        Me.lblWorldZ.Name = "lblWorldZ"
        Me.lblWorldZ.Size = New System.Drawing.Size(39, 13)
        Me.lblWorldZ.TabIndex = 9
        Me.lblWorldZ.Text = "Label9"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(30, 134)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(42, 13)
        Me.Label10.TabIndex = 8
        Me.Label10.Text = "WorldZ"
        '
        'GraphicCmdLabForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(566, 197)
        Me.Controls.Add(Me.lblWorldZ)
        Me.Controls.Add(Me.Label10)
        Me.Controls.Add(Me.lblWorldY)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.lblWorldX)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.lblViewY)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.lblViewX)
        Me.Controls.Add(Me.Label1)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "GraphicCmdLabForm"
        Me.Text = "GraphicCmdLabForm"
        Me.TopMost = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents lblViewX As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents lblViewY As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents lblWorldX As System.Windows.Forms.Label
    Friend WithEvents lblWorldY As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents lblWorldZ As System.Windows.Forms.Label
    Friend WithEvents Label10 As System.Windows.Forms.Label
End Class
