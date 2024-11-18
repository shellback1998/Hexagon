<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmGraphicCmdLab
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
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.lblViewX = New System.Windows.Forms.Label
        Me.lblViewY = New System.Windows.Forms.Label
        Me.lblWorldX = New System.Windows.Forms.Label
        Me.lblWorldY = New System.Windows.Forms.Label
        Me.lblWorldZ = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(16, 28)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(40, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "View X"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(16, 57)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(40, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "View Y"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(16, 107)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(45, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "World X"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(16, 132)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(45, 13)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "World Y"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(16, 156)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(45, 13)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "World Z"
        '
        'lblViewX
        '
        Me.lblViewX.AutoSize = True
        Me.lblViewX.Location = New System.Drawing.Point(123, 28)
        Me.lblViewX.Name = "lblViewX"
        Me.lblViewX.Size = New System.Drawing.Size(47, 13)
        Me.lblViewX.TabIndex = 5
        Me.lblViewX.Text = "lblViewX"
        '
        'lblViewY
        '
        Me.lblViewY.AutoSize = True
        Me.lblViewY.Location = New System.Drawing.Point(123, 57)
        Me.lblViewY.Name = "lblViewY"
        Me.lblViewY.Size = New System.Drawing.Size(47, 13)
        Me.lblViewY.TabIndex = 6
        Me.lblViewY.Text = "lblViewY"
        '
        'lblWorldX
        '
        Me.lblWorldX.AutoSize = True
        Me.lblWorldX.Location = New System.Drawing.Point(123, 107)
        Me.lblWorldX.Name = "lblWorldX"
        Me.lblWorldX.Size = New System.Drawing.Size(52, 13)
        Me.lblWorldX.TabIndex = 7
        Me.lblWorldX.Text = "lblWorldX"
        '
        'lblWorldY
        '
        Me.lblWorldY.AutoSize = True
        Me.lblWorldY.Location = New System.Drawing.Point(123, 132)
        Me.lblWorldY.Name = "lblWorldY"
        Me.lblWorldY.Size = New System.Drawing.Size(52, 13)
        Me.lblWorldY.TabIndex = 8
        Me.lblWorldY.Text = "lblWorldY"
        '
        'lblWorldZ
        '
        Me.lblWorldZ.AutoSize = True
        Me.lblWorldZ.Location = New System.Drawing.Point(123, 156)
        Me.lblWorldZ.Name = "lblWorldZ"
        Me.lblWorldZ.Size = New System.Drawing.Size(52, 13)
        Me.lblWorldZ.TabIndex = 9
        Me.lblWorldZ.Text = "lblWorldZ"
        '
        'frmGraphicCmdLab
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(218, 206)
        Me.Controls.Add(Me.lblWorldZ)
        Me.Controls.Add(Me.lblWorldY)
        Me.Controls.Add(Me.lblWorldX)
        Me.Controls.Add(Me.lblViewY)
        Me.Controls.Add(Me.lblViewX)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmGraphicCmdLab"
        Me.Text = "Mouse Position - 2D/3D"
        Me.TopMost = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents lblViewX As System.Windows.Forms.Label
    Friend WithEvents lblViewY As System.Windows.Forms.Label
    Friend WithEvents lblWorldX As System.Windows.Forms.Label
    Friend WithEvents lblWorldY As System.Windows.Forms.Label
    Friend WithEvents lblWorldZ As System.Windows.Forms.Label
End Class
