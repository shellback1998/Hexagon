<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class Ex5F
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
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Ex5F))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.txtMessage = New System.Windows.Forms.TextBox
		Me.cmdDoIt = New System.Windows.Forms.Button
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.Text = "Schema Component Example 5"
		Me.ClientSize = New System.Drawing.Size(585, 283)
		Me.Location = New System.Drawing.Point(3, 29)
		Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "Ex5F"
		Me.txtMessage.AutoSize = False
		Me.txtMessage.Size = New System.Drawing.Size(569, 233)
		Me.txtMessage.Location = New System.Drawing.Point(8, 40)
		Me.txtMessage.MultiLine = True
		Me.txtMessage.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.txtMessage.TabIndex = 1
		Me.txtMessage.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtMessage.AcceptsReturn = True
		Me.txtMessage.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtMessage.BackColor = System.Drawing.SystemColors.Window
		Me.txtMessage.CausesValidation = True
		Me.txtMessage.Enabled = True
		Me.txtMessage.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtMessage.HideSelection = True
		Me.txtMessage.ReadOnly = False
		Me.txtMessage.Maxlength = 0
		Me.txtMessage.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtMessage.TabStop = True
		Me.txtMessage.Visible = True
		Me.txtMessage.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtMessage.Name = "txtMessage"
		Me.cmdDoIt.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdDoIt.Text = "Do It"
		Me.cmdDoIt.Size = New System.Drawing.Size(65, 25)
		Me.cmdDoIt.Location = New System.Drawing.Point(261, 8)
		Me.cmdDoIt.TabIndex = 0
		Me.cmdDoIt.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdDoIt.BackColor = System.Drawing.SystemColors.Control
		Me.cmdDoIt.CausesValidation = True
		Me.cmdDoIt.Enabled = True
		Me.cmdDoIt.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdDoIt.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdDoIt.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdDoIt.TabStop = True
		Me.cmdDoIt.Name = "cmdDoIt"
		Me.Controls.Add(txtMessage)
		Me.Controls.Add(cmdDoIt)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class