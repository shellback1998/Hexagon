<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmStructCmd2
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
        Me.btmOK = New System.Windows.Forms.Button
        Me.txtX = New System.Windows.Forms.TextBox
        Me.txtY = New System.Windows.Forms.TextBox
        Me.txtZ = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.PictureBox1 = New System.Windows.Forms.PictureBox
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btmOK
        '
        Me.btmOK.Location = New System.Drawing.Point(327, 215)
        Me.btmOK.Name = "btmOK"
        Me.btmOK.Size = New System.Drawing.Size(97, 25)
        Me.btmOK.TabIndex = 0
        Me.btmOK.Text = "OK"
        Me.btmOK.UseVisualStyleBackColor = True
        '
        'txtX
        '
        Me.txtX.Location = New System.Drawing.Point(343, 16)
        Me.txtX.Name = "txtX"
        Me.txtX.Size = New System.Drawing.Size(71, 20)
        Me.txtX.TabIndex = 1
        Me.txtX.Text = "50 m"
        '
        'txtY
        '
        Me.txtY.Location = New System.Drawing.Point(343, 58)
        Me.txtY.Name = "txtY"
        Me.txtY.Size = New System.Drawing.Size(71, 20)
        Me.txtY.TabIndex = 2
        Me.txtY.Text = "50 m"
        '
        'txtZ
        '
        Me.txtZ.Location = New System.Drawing.Point(343, 100)
        Me.txtZ.Name = "txtZ"
        Me.txtZ.Size = New System.Drawing.Size(71, 20)
        Me.txtZ.TabIndex = 3
        Me.txtZ.Text = "0 m"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(324, 19)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(17, 13)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = "X:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(324, 61)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(17, 13)
        Me.Label2.TabIndex = 6
        Me.Label2.Text = "Y:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(324, 103)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(17, 13)
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Z:"
        '
        'PictureBox1
        '
        Me.PictureBox1.Image = Global.AutomationLabs.My.Resources.Resources.Struct
        Me.PictureBox1.InitialImage = Global.AutomationLabs.My.Resources.Resources.Struct
        Me.PictureBox1.Location = New System.Drawing.Point(12, 12)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(306, 246)
        Me.PictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox1.TabIndex = 4
        Me.PictureBox1.TabStop = False
        '
        'frmStructCmd2
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(431, 270)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.PictureBox1)
        Me.Controls.Add(Me.txtZ)
        Me.Controls.Add(Me.txtY)
        Me.Controls.Add(Me.txtX)
        Me.Controls.Add(Me.btmOK)
        Me.Name = "frmStructCmd2"
        Me.Text = "Build Structure"
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btmOK As System.Windows.Forms.Button
    Friend WithEvents txtX As System.Windows.Forms.TextBox
    Friend WithEvents txtY As System.Windows.Forms.TextBox
    Friend WithEvents txtZ As System.Windows.Forms.TextBox
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
End Class
