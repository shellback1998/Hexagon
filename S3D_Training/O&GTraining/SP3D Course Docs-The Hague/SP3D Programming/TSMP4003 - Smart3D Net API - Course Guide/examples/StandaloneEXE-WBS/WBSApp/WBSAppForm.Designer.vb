<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class WBSAppForm
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.cboPlants = New System.Windows.Forms.ComboBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.cboPGs = New System.Windows.Forms.ComboBox
        Me.tvWBSHier = New System.Windows.Forms.TreeView
        Me.Label3 = New System.Windows.Forms.Label
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.txtWBSProjName = New System.Windows.Forms.TextBox
        Me.btnCreateWBSProject = New System.Windows.Forms.Button
        Me.GroupBox2 = New System.Windows.Forms.GroupBox
        Me.Label6 = New System.Windows.Forms.Label
        Me.cboAssign = New System.Windows.Forms.ComboBox
        Me.chkExclusive = New System.Windows.Forms.CheckBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.txtWBSItemName = New System.Windows.Forms.TextBox
        Me.btnCreateItem = New System.Windows.Forms.Button
        Me.lvInfo = New System.Windows.Forms.ListView
        Me.ColumnHeader1 = New System.Windows.Forms.ColumnHeader
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'cboPlants
        '
        Me.cboPlants.FormattingEnabled = True
        Me.cboPlants.Location = New System.Drawing.Point(58, 12)
        Me.cboPlants.Name = "cboPlants"
        Me.cboPlants.Size = New System.Drawing.Size(222, 24)
        Me.cboPlants.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(40, 17)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Plant"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 48)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(121, 17)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Permission Group"
        '
        'cboPGs
        '
        Me.cboPGs.FormattingEnabled = True
        Me.cboPGs.Location = New System.Drawing.Point(139, 48)
        Me.cboPGs.Name = "cboPGs"
        Me.cboPGs.Size = New System.Drawing.Size(141, 24)
        Me.cboPGs.TabIndex = 3
        '
        'tvWBSHier
        '
        Me.tvWBSHier.HideSelection = False
        Me.tvWBSHier.Location = New System.Drawing.Point(12, 102)
        Me.tvWBSHier.Name = "tvWBSHier"
        Me.tvWBSHier.ShowNodeToolTips = True
        Me.tvWBSHier.Size = New System.Drawing.Size(265, 154)
        Me.tvWBSHier.TabIndex = 4
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(12, 82)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(155, 17)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Current WBS Hierarchy"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.Label4)
        Me.GroupBox1.Controls.Add(Me.txtWBSProjName)
        Me.GroupBox1.Controls.Add(Me.btnCreateWBSProject)
        Me.GroupBox1.Enabled = False
        Me.GroupBox1.Location = New System.Drawing.Point(9, 413)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(268, 67)
        Me.GroupBox1.TabIndex = 10
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "WBS Project"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(6, 24)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(45, 17)
        Me.Label4.TabIndex = 11
        Me.Label4.Text = "Name"
        '
        'txtWBSProjName
        '
        Me.txtWBSProjName.Location = New System.Drawing.Point(58, 21)
        Me.txtWBSProjName.Name = "txtWBSProjName"
        Me.txtWBSProjName.Size = New System.Drawing.Size(100, 22)
        Me.txtWBSProjName.TabIndex = 10
        '
        'btnCreateWBSProject
        '
        Me.btnCreateWBSProject.Enabled = False
        Me.btnCreateWBSProject.Location = New System.Drawing.Point(194, 21)
        Me.btnCreateWBSProject.Name = "btnCreateWBSProject"
        Me.btnCreateWBSProject.Size = New System.Drawing.Size(68, 33)
        Me.btnCreateWBSProject.TabIndex = 9
        Me.btnCreateWBSProject.Text = "Create"
        Me.btnCreateWBSProject.UseVisualStyleBackColor = True
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.Label6)
        Me.GroupBox2.Controls.Add(Me.cboAssign)
        Me.GroupBox2.Controls.Add(Me.chkExclusive)
        Me.GroupBox2.Controls.Add(Me.Label5)
        Me.GroupBox2.Controls.Add(Me.txtWBSItemName)
        Me.GroupBox2.Controls.Add(Me.btnCreateItem)
        Me.GroupBox2.Enabled = False
        Me.GroupBox2.Location = New System.Drawing.Point(9, 486)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(268, 133)
        Me.GroupBox2.TabIndex = 11
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "WBS Item"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(7, 50)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(81, 17)
        Me.Label6.TabIndex = 18
        Me.Label6.Text = "Assignment"
        '
        'cboAssign
        '
        Me.cboAssign.FormattingEnabled = True
        Me.cboAssign.Items.AddRange(New Object() {"System", "Assembly", "Manual"})
        Me.cboAssign.Location = New System.Drawing.Point(94, 50)
        Me.cboAssign.Name = "cboAssign"
        Me.cboAssign.Size = New System.Drawing.Size(154, 24)
        Me.cboAssign.TabIndex = 17
        '
        'chkExclusive
        '
        Me.chkExclusive.AutoSize = True
        Me.chkExclusive.Location = New System.Drawing.Point(174, 23)
        Me.chkExclusive.Name = "chkExclusive"
        Me.chkExclusive.Size = New System.Drawing.Size(88, 21)
        Me.chkExclusive.TabIndex = 16
        Me.chkExclusive.Text = "Exclusive"
        Me.chkExclusive.UseVisualStyleBackColor = True
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(6, 24)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(45, 17)
        Me.Label5.TabIndex = 15
        Me.Label5.Text = "Name"
        '
        'txtWBSItemName
        '
        Me.txtWBSItemName.Location = New System.Drawing.Point(58, 21)
        Me.txtWBSItemName.Name = "txtWBSItemName"
        Me.txtWBSItemName.Size = New System.Drawing.Size(100, 22)
        Me.txtWBSItemName.TabIndex = 14
        '
        'btnCreateItem
        '
        Me.btnCreateItem.Enabled = False
        Me.btnCreateItem.Location = New System.Drawing.Point(94, 80)
        Me.btnCreateItem.Name = "btnCreateItem"
        Me.btnCreateItem.Size = New System.Drawing.Size(68, 33)
        Me.btnCreateItem.TabIndex = 9
        Me.btnCreateItem.Text = "Create"
        Me.btnCreateItem.UseVisualStyleBackColor = True
        '
        'lvInfo
        '
        Me.lvInfo.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.ColumnHeader1})
        Me.lvInfo.FullRowSelect = True
        Me.lvInfo.GridLines = True
        Me.lvInfo.HideSelection = False
        Me.lvInfo.LabelEdit = True
        Me.lvInfo.Location = New System.Drawing.Point(13, 263)
        Me.lvInfo.Margin = New System.Windows.Forms.Padding(4)
        Me.lvInfo.Name = "lvInfo"
        Me.lvInfo.Size = New System.Drawing.Size(264, 143)
        Me.lvInfo.TabIndex = 12
        Me.lvInfo.UseCompatibleStateImageBehavior = False
        Me.lvInfo.View = System.Windows.Forms.View.Details
        '
        'ColumnHeader1
        '
        Me.ColumnHeader1.Text = "Information"
        Me.ColumnHeader1.Width = 130
        '
        'WBSAppForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(291, 633)
        Me.Controls.Add(Me.lvInfo)
        Me.Controls.Add(Me.GroupBox2)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.tvWBSHier)
        Me.Controls.Add(Me.cboPGs)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.cboPlants)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.MaximizeBox = False
        Me.Name = "WBSAppForm"
        Me.Text = "WBS App"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents cboPlants As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents cboPGs As System.Windows.Forms.ComboBox
    Friend WithEvents tvWBSHier As System.Windows.Forms.TreeView
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents btnCreateWBSProject As System.Windows.Forms.Button
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents btnCreateItem As System.Windows.Forms.Button
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents txtWBSProjName As System.Windows.Forms.TextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents txtWBSItemName As System.Windows.Forms.TextBox
    Friend WithEvents chkExclusive As System.Windows.Forms.CheckBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents cboAssign As System.Windows.Forms.ComboBox
    Friend WithEvents lvInfo As System.Windows.Forms.ListView
    Friend WithEvents ColumnHeader1 As System.Windows.Forms.ColumnHeader

End Class
