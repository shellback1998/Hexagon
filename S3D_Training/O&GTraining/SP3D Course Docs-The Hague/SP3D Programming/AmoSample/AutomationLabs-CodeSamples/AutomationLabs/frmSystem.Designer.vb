<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmSystem
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
        Me.btnCreateSystem = New System.Windows.Forms.Button
        Me.btnChangeSys = New System.Windows.Forms.Button
        Me.optEqpSys = New System.Windows.Forms.RadioButton
        Me.optAreaSys = New System.Windows.Forms.RadioButton
        Me.optConduitSys = New System.Windows.Forms.RadioButton
        Me.optDuctingSys = New System.Windows.Forms.RadioButton
        Me.optElecSys = New System.Windows.Forms.RadioButton
        Me.optPipingSys = New System.Windows.Forms.RadioButton
        Me.optPipeLineSys = New System.Windows.Forms.RadioButton
        Me.optStructSys = New System.Windows.Forms.RadioButton
        Me.optUnitSystem = New System.Windows.Forms.RadioButton
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.optGenericSys = New System.Windows.Forms.RadioButton
        Me.btnAddRemoveAllowableSpecs = New System.Windows.Forms.Button
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnCreateSystem
        '
        Me.btnCreateSystem.Location = New System.Drawing.Point(6, 19)
        Me.btnCreateSystem.Name = "btnCreateSystem"
        Me.btnCreateSystem.Size = New System.Drawing.Size(116, 24)
        Me.btnCreateSystem.TabIndex = 2
        Me.btnCreateSystem.Text = "Create New System"
        Me.btnCreateSystem.UseVisualStyleBackColor = True
        '
        'btnChangeSys
        '
        Me.btnChangeSys.Location = New System.Drawing.Point(163, 31)
        Me.btnChangeSys.Name = "btnChangeSys"
        Me.btnChangeSys.Size = New System.Drawing.Size(116, 38)
        Me.btnChangeSys.TabIndex = 3
        Me.btnChangeSys.Text = "Change Eqp System Hierarchy"
        Me.btnChangeSys.UseVisualStyleBackColor = True
        '
        'optEqpSys
        '
        Me.optEqpSys.AutoSize = True
        Me.optEqpSys.Location = New System.Drawing.Point(6, 146)
        Me.optEqpSys.Name = "optEqpSys"
        Me.optEqpSys.Size = New System.Drawing.Size(109, 17)
        Me.optEqpSys.TabIndex = 8
        Me.optEqpSys.Text = "EquipmentSystem"
        Me.optEqpSys.UseVisualStyleBackColor = True
        '
        'optAreaSys
        '
        Me.optAreaSys.AutoSize = True
        Me.optAreaSys.Checked = True
        Me.optAreaSys.Location = New System.Drawing.Point(6, 52)
        Me.optAreaSys.Name = "optAreaSys"
        Me.optAreaSys.Size = New System.Drawing.Size(81, 17)
        Me.optAreaSys.TabIndex = 4
        Me.optAreaSys.TabStop = True
        Me.optAreaSys.Text = "AreaSystem"
        Me.optAreaSys.UseVisualStyleBackColor = True
        '
        'optConduitSys
        '
        Me.optConduitSys.AutoSize = True
        Me.optConduitSys.Location = New System.Drawing.Point(6, 75)
        Me.optConduitSys.Name = "optConduitSys"
        Me.optConduitSys.Size = New System.Drawing.Size(95, 17)
        Me.optConduitSys.TabIndex = 5
        Me.optConduitSys.Text = "ConduitSystem"
        Me.optConduitSys.UseVisualStyleBackColor = True
        '
        'optDuctingSys
        '
        Me.optDuctingSys.AutoSize = True
        Me.optDuctingSys.Location = New System.Drawing.Point(6, 100)
        Me.optDuctingSys.Name = "optDuctingSys"
        Me.optDuctingSys.Size = New System.Drawing.Size(96, 17)
        Me.optDuctingSys.TabIndex = 6
        Me.optDuctingSys.Text = "DuctingSystem"
        Me.optDuctingSys.UseVisualStyleBackColor = True
        '
        'optElecSys
        '
        Me.optElecSys.AutoSize = True
        Me.optElecSys.Location = New System.Drawing.Point(6, 123)
        Me.optElecSys.Name = "optElecSys"
        Me.optElecSys.Size = New System.Drawing.Size(102, 17)
        Me.optElecSys.TabIndex = 7
        Me.optElecSys.Text = "ElectricalSystem"
        Me.optElecSys.UseVisualStyleBackColor = True
        '
        'optPipingSys
        '
        Me.optPipingSys.AutoSize = True
        Me.optPipingSys.Location = New System.Drawing.Point(6, 169)
        Me.optPipingSys.Name = "optPipingSys"
        Me.optPipingSys.Size = New System.Drawing.Size(88, 17)
        Me.optPipingSys.TabIndex = 9
        Me.optPipingSys.Text = "PipingSystem"
        Me.optPipingSys.UseVisualStyleBackColor = True
        '
        'optPipeLineSys
        '
        Me.optPipeLineSys.AutoSize = True
        Me.optPipeLineSys.Location = New System.Drawing.Point(6, 192)
        Me.optPipeLineSys.Name = "optPipeLineSys"
        Me.optPipeLineSys.Size = New System.Drawing.Size(100, 17)
        Me.optPipeLineSys.TabIndex = 10
        Me.optPipeLineSys.TabStop = True
        Me.optPipeLineSys.Text = "PipeLineSystem"
        Me.optPipeLineSys.UseVisualStyleBackColor = True
        '
        'optStructSys
        '
        Me.optStructSys.AutoSize = True
        Me.optStructSys.Location = New System.Drawing.Point(6, 215)
        Me.optStructSys.Name = "optStructSys"
        Me.optStructSys.Size = New System.Drawing.Size(104, 17)
        Me.optStructSys.TabIndex = 11
        Me.optStructSys.TabStop = True
        Me.optStructSys.Text = "StructuralSystem"
        Me.optStructSys.UseVisualStyleBackColor = True
        '
        'optUnitSystem
        '
        Me.optUnitSystem.AutoSize = True
        Me.optUnitSystem.Location = New System.Drawing.Point(6, 238)
        Me.optUnitSystem.Name = "optUnitSystem"
        Me.optUnitSystem.Size = New System.Drawing.Size(78, 17)
        Me.optUnitSystem.TabIndex = 12
        Me.optUnitSystem.TabStop = True
        Me.optUnitSystem.Text = "UnitSystem"
        Me.optUnitSystem.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.optAreaSys)
        Me.GroupBox1.Controls.Add(Me.optConduitSys)
        Me.GroupBox1.Controls.Add(Me.btnCreateSystem)
        Me.GroupBox1.Controls.Add(Me.optGenericSys)
        Me.GroupBox1.Controls.Add(Me.optDuctingSys)
        Me.GroupBox1.Controls.Add(Me.optElecSys)
        Me.GroupBox1.Controls.Add(Me.optPipingSys)
        Me.GroupBox1.Controls.Add(Me.optPipeLineSys)
        Me.GroupBox1.Controls.Add(Me.optStructSys)
        Me.GroupBox1.Controls.Add(Me.optUnitSystem)
        Me.GroupBox1.Controls.Add(Me.optEqpSys)
        Me.GroupBox1.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(130, 298)
        Me.GroupBox1.TabIndex = 13
        Me.GroupBox1.TabStop = False
        '
        'optGenericSys
        '
        Me.optGenericSys.AutoSize = True
        Me.optGenericSys.Location = New System.Drawing.Point(6, 261)
        Me.optGenericSys.Name = "optGenericSys"
        Me.optGenericSys.Size = New System.Drawing.Size(96, 17)
        Me.optGenericSys.TabIndex = 13
        Me.optGenericSys.TabStop = True
        Me.optGenericSys.Text = "GenericSystem"
        Me.optGenericSys.UseVisualStyleBackColor = True
        '
        'btnAddRemoveAllowableSpecs
        '
        Me.btnAddRemoveAllowableSpecs.Location = New System.Drawing.Point(148, 112)
        Me.btnAddRemoveAllowableSpecs.Name = "btnAddRemoveAllowableSpecs"
        Me.btnAddRemoveAllowableSpecs.Size = New System.Drawing.Size(163, 40)
        Me.btnAddRemoveAllowableSpecs.TabIndex = 14
        Me.btnAddRemoveAllowableSpecs.Text = "Add_Remove_Replace_Reset Allowable Specs"
        Me.btnAddRemoveAllowableSpecs.UseVisualStyleBackColor = True
        '
        'frmSystem
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(323, 323)
        Me.Controls.Add(Me.btnAddRemoveAllowableSpecs)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.btnChangeSys)
        Me.Name = "frmSystem"
        Me.Text = "frmSystem"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents btnCreateSystem As System.Windows.Forms.Button
    Friend WithEvents btnChangeSys As System.Windows.Forms.Button
    Friend WithEvents optEqpSys As System.Windows.Forms.RadioButton
    Friend WithEvents optAreaSys As System.Windows.Forms.RadioButton
    Friend WithEvents optConduitSys As System.Windows.Forms.RadioButton
    Friend WithEvents optDuctingSys As System.Windows.Forms.RadioButton
    Friend WithEvents optElecSys As System.Windows.Forms.RadioButton
    Friend WithEvents optPipingSys As System.Windows.Forms.RadioButton
    Friend WithEvents optPipeLineSys As System.Windows.Forms.RadioButton
    Friend WithEvents optStructSys As System.Windows.Forms.RadioButton
    Friend WithEvents optUnitSystem As System.Windows.Forms.RadioButton
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents optGenericSys As System.Windows.Forms.RadioButton
    Friend WithEvents btnAddRemoveAllowableSpecs As System.Windows.Forms.Button
End Class
