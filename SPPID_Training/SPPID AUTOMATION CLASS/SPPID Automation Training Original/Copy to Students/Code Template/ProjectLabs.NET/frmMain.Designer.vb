<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmMain
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
	Public WithEvents cmdExit As System.Windows.Forms.Button
	Public WithEvents Option2 As System.Windows.Forms.RadioButton
	Public WithEvents Option1 As System.Windows.Forms.RadioButton
	Public WithEvents Options As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmMain))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.cmdExit = New System.Windows.Forms.Button
		Me.Options = New System.Windows.Forms.GroupBox
		Me.Option2 = New System.Windows.Forms.RadioButton
		Me.Option1 = New System.Windows.Forms.RadioButton
		Me.Options.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.Text = "Main Form"
		Me.ClientSize = New System.Drawing.Size(610, 352)
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
		Me.Name = "frmMain"
		Me.cmdExit.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdExit.Text = "E&xit"
		Me.cmdExit.Size = New System.Drawing.Size(73, 25)
		Me.cmdExit.Location = New System.Drawing.Point(272, 152)
		Me.cmdExit.TabIndex = 3
		Me.cmdExit.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdExit.BackColor = System.Drawing.SystemColors.Control
		Me.cmdExit.CausesValidation = True
		Me.cmdExit.Enabled = True
		Me.cmdExit.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdExit.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdExit.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdExit.TabStop = True
		Me.cmdExit.Name = "cmdExit"
		Me.Options.Text = "Options"
		Me.Options.Size = New System.Drawing.Size(185, 89)
		Me.Options.Location = New System.Drawing.Point(216, 40)
		Me.Options.TabIndex = 0
		Me.Options.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Options.BackColor = System.Drawing.SystemColors.Control
		Me.Options.Enabled = True
		Me.Options.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Options.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Options.Visible = True
		Me.Options.Name = "Options"
		Me.Option2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.Option2.Text = "Use PIDDatasource"
		Me.Option2.Size = New System.Drawing.Size(145, 17)
		Me.Option2.Location = New System.Drawing.Point(24, 56)
		Me.Option2.TabIndex = 2
		Me.Option2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Option2.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.Option2.BackColor = System.Drawing.SystemColors.Control
		Me.Option2.CausesValidation = True
		Me.Option2.Enabled = True
		Me.Option2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Option2.Cursor = System.Windows.Forms.Cursors.Default
		Me.Option2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Option2.Appearance = System.Windows.Forms.Appearance.Normal
		Me.Option2.TabStop = True
		Me.Option2.Checked = False
		Me.Option2.Visible = True
		Me.Option2.Name = "Option2"
		Me.Option1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.Option1.Text = "Use New LMADatasource"
		Me.Option1.Size = New System.Drawing.Size(145, 25)
		Me.Option1.Location = New System.Drawing.Point(24, 24)
		Me.Option1.TabIndex = 1
		Me.Option1.Checked = True
		Me.Option1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Option1.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.Option1.BackColor = System.Drawing.SystemColors.Control
		Me.Option1.CausesValidation = True
		Me.Option1.Enabled = True
		Me.Option1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Option1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Option1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Option1.Appearance = System.Windows.Forms.Appearance.Normal
		Me.Option1.TabStop = True
		Me.Option1.Visible = True
		Me.Option1.Name = "Option1"
		Me.Controls.Add(cmdExit)
		Me.Controls.Add(Options)
		Me.Options.Controls.Add(Option2)
		Me.Options.Controls.Add(Option1)
		Me.Options.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class