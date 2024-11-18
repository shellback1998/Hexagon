<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class Form1
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents txtMessage As System.Windows.Forms.TextBox
	Public WithEvents cmdDoIt As System.Windows.Forms.Button
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtMessage = New System.Windows.Forms.TextBox
        Me.cmdDoIt = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'txtMessage
        '
        Me.txtMessage.AcceptsReturn = True
        Me.txtMessage.BackColor = System.Drawing.SystemColors.Window
        Me.txtMessage.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMessage.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMessage.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMessage.Location = New System.Drawing.Point(8, 40)
        Me.txtMessage.MaxLength = 0
        Me.txtMessage.Multiline = True
        Me.txtMessage.Name = "txtMessage"
        Me.txtMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMessage.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtMessage.Size = New System.Drawing.Size(569, 233)
        Me.txtMessage.TabIndex = 1
        '
        'cmdDoIt
        '
        Me.cmdDoIt.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDoIt.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDoIt.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDoIt.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDoIt.Location = New System.Drawing.Point(261, 8)
        Me.cmdDoIt.Name = "cmdDoIt"
        Me.cmdDoIt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDoIt.Size = New System.Drawing.Size(65, 25)
        Me.cmdDoIt.TabIndex = 0
        Me.cmdDoIt.Text = "Do It"
        Me.cmdDoIt.UseVisualStyleBackColor = False
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(585, 283)
        Me.Controls.Add(Me.txtMessage)
        Me.Controls.Add(Me.cmdDoIt)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(3, 29)
        Me.Name = "Form1"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "Schema Component Chapter 5 -- Lab1"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class