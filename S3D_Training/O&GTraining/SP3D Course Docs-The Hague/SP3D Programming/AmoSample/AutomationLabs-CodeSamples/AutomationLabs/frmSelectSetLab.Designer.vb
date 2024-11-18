<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmSelectSetLab
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
        Me.btnRemove1 = New System.Windows.Forms.Button
        Me.btnRemAndReload = New System.Windows.Forms.Button
        Me.btnContainmentChk = New System.Windows.Forms.Button
        Me.btnClear = New System.Windows.Forms.Button
        Me.btnClearOut = New System.Windows.Forms.Button
        Me.chkEvents = New System.Windows.Forms.CheckBox
        Me.chkDelay = New System.Windows.Forms.CheckBox
        Me.lvEvents = New System.Windows.Forms.ListView
        Me.ColumnHeader1 = New System.Windows.Forms.ColumnHeader
        Me.SuspendLayout()
        '
        'btnRemove1
        '
        Me.btnRemove1.Location = New System.Drawing.Point(34, 21)
        Me.btnRemove1.Name = "btnRemove1"
        Me.btnRemove1.Size = New System.Drawing.Size(181, 34)
        Me.btnRemove1.TabIndex = 0
        Me.btnRemove1.Text = "Remove 1st Object1"
        Me.btnRemove1.UseVisualStyleBackColor = True
        '
        'btnRemAndReload
        '
        Me.btnRemAndReload.Location = New System.Drawing.Point(34, 81)
        Me.btnRemAndReload.Name = "btnRemAndReload"
        Me.btnRemAndReload.Size = New System.Drawing.Size(181, 34)
        Me.btnRemAndReload.TabIndex = 1
        Me.btnRemAndReload.Text = "Remove And Reload All"
        Me.btnRemAndReload.UseVisualStyleBackColor = True
        '
        'btnContainmentChk
        '
        Me.btnContainmentChk.Location = New System.Drawing.Point(34, 143)
        Me.btnContainmentChk.Name = "btnContainmentChk"
        Me.btnContainmentChk.Size = New System.Drawing.Size(181, 34)
        Me.btnContainmentChk.TabIndex = 2
        Me.btnContainmentChk.Text = "Containment Check"
        Me.btnContainmentChk.UseVisualStyleBackColor = True
        '
        'btnClear
        '
        Me.btnClear.Location = New System.Drawing.Point(34, 204)
        Me.btnClear.Name = "btnClear"
        Me.btnClear.Size = New System.Drawing.Size(181, 34)
        Me.btnClear.TabIndex = 3
        Me.btnClear.Text = "Clear Selection"
        Me.btnClear.UseVisualStyleBackColor = True
        '
        'btnClearOut
        '
        Me.btnClearOut.Location = New System.Drawing.Point(289, 143)
        Me.btnClearOut.Name = "btnClearOut"
        Me.btnClearOut.Size = New System.Drawing.Size(181, 34)
        Me.btnClearOut.TabIndex = 4
        Me.btnClearOut.Text = "Clear Output"
        Me.btnClearOut.UseVisualStyleBackColor = True
        '
        'chkEvents
        '
        Me.chkEvents.AutoSize = True
        Me.chkEvents.Location = New System.Drawing.Point(289, 33)
        Me.chkEvents.Name = "chkEvents"
        Me.chkEvents.Size = New System.Drawing.Size(154, 17)
        Me.chkEvents.TabIndex = 5
        Me.chkEvents.Text = "Listen to Select Set Events"
        Me.chkEvents.UseVisualStyleBackColor = True
        '
        'chkDelay
        '
        Me.chkDelay.AutoSize = True
        Me.chkDelay.Location = New System.Drawing.Point(289, 81)
        Me.chkDelay.Name = "chkDelay"
        Me.chkDelay.Size = New System.Drawing.Size(103, 17)
        Me.chkDelay.TabIndex = 6
        Me.chkDelay.Text = "Delayed Update"
        Me.chkDelay.UseVisualStyleBackColor = True
        '
        'lvEvents
        '
        Me.lvEvents.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.ColumnHeader1})
        Me.lvEvents.Location = New System.Drawing.Point(70, 268)
        Me.lvEvents.Name = "lvEvents"
        Me.lvEvents.Size = New System.Drawing.Size(413, 189)
        Me.lvEvents.TabIndex = 7
        Me.lvEvents.UseCompatibleStateImageBehavior = False
        Me.lvEvents.View = System.Windows.Forms.View.Details
        '
        'ColumnHeader1
        '
        Me.ColumnHeader1.Text = "Events"
        Me.ColumnHeader1.Width = 469
        '
        'frmSelectSetLab
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(529, 471)
        Me.Controls.Add(Me.lvEvents)
        Me.Controls.Add(Me.chkDelay)
        Me.Controls.Add(Me.chkEvents)
        Me.Controls.Add(Me.btnClearOut)
        Me.Controls.Add(Me.btnClear)
        Me.Controls.Add(Me.btnContainmentChk)
        Me.Controls.Add(Me.btnRemAndReload)
        Me.Controls.Add(Me.btnRemove1)
        Me.Name = "frmSelectSetLab"
        Me.Text = "frmSelectSetLab"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnRemove1 As System.Windows.Forms.Button
    Friend WithEvents btnRemAndReload As System.Windows.Forms.Button
    Friend WithEvents btnContainmentChk As System.Windows.Forms.Button
    Friend WithEvents btnClear As System.Windows.Forms.Button
    Friend WithEvents btnClearOut As System.Windows.Forms.Button
    Friend WithEvents chkEvents As System.Windows.Forms.CheckBox
    Friend WithEvents chkDelay As System.Windows.Forms.CheckBox
    Friend WithEvents lvEvents As System.Windows.Forms.ListView
    Friend WithEvents ColumnHeader1 As System.Windows.Forms.ColumnHeader
End Class
