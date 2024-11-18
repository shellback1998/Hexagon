<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SelectSetLabForm
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
        Me.btnRemove1stObject = New System.Windows.Forms.Button
        Me.btnRemoveAndReloadAll = New System.Windows.Forms.Button
        Me.btnContainmentCheck = New System.Windows.Forms.Button
        Me.btnClearSelection = New System.Windows.Forms.Button
        Me.chkListenToEvents = New System.Windows.Forms.CheckBox
        Me.chkDelayedUpdate = New System.Windows.Forms.CheckBox
        Me.Button5 = New System.Windows.Forms.Button
        Me.Label1 = New System.Windows.Forms.Label
        Me.IvEvents = New System.Windows.Forms.ListView
        Me.XEvents = New System.Windows.Forms.ColumnHeader
        Me.SuspendLayout()
        '
        'btnRemove1stObject
        '
        Me.btnRemove1stObject.Location = New System.Drawing.Point(13, 13)
        Me.btnRemove1stObject.Name = "btnRemove1stObject"
        Me.btnRemove1stObject.Size = New System.Drawing.Size(126, 23)
        Me.btnRemove1stObject.TabIndex = 0
        Me.btnRemove1stObject.Text = "Remove 1st object"
        Me.btnRemove1stObject.UseVisualStyleBackColor = True
        '
        'btnRemoveAndReloadAll
        '
        Me.btnRemoveAndReloadAll.Location = New System.Drawing.Point(13, 42)
        Me.btnRemoveAndReloadAll.Name = "btnRemoveAndReloadAll"
        Me.btnRemoveAndReloadAll.Size = New System.Drawing.Size(126, 23)
        Me.btnRemoveAndReloadAll.TabIndex = 1
        Me.btnRemoveAndReloadAll.Text = "Remove && Reload"
        Me.btnRemoveAndReloadAll.UseVisualStyleBackColor = True
        '
        'btnContainmentCheck
        '
        Me.btnContainmentCheck.Location = New System.Drawing.Point(13, 71)
        Me.btnContainmentCheck.Name = "btnContainmentCheck"
        Me.btnContainmentCheck.Size = New System.Drawing.Size(126, 23)
        Me.btnContainmentCheck.TabIndex = 2
        Me.btnContainmentCheck.Text = "Containment Check"
        Me.btnContainmentCheck.UseVisualStyleBackColor = True
        '
        'btnClearSelection
        '
        Me.btnClearSelection.Location = New System.Drawing.Point(13, 100)
        Me.btnClearSelection.Name = "btnClearSelection"
        Me.btnClearSelection.Size = New System.Drawing.Size(126, 23)
        Me.btnClearSelection.TabIndex = 3
        Me.btnClearSelection.Text = "Clear Selection"
        Me.btnClearSelection.UseVisualStyleBackColor = True
        '
        'chkListenToEvents
        '
        Me.chkListenToEvents.AutoSize = True
        Me.chkListenToEvents.Location = New System.Drawing.Point(180, 19)
        Me.chkListenToEvents.Name = "chkListenToEvents"
        Me.chkListenToEvents.Size = New System.Drawing.Size(151, 17)
        Me.chkListenToEvents.TabIndex = 4
        Me.chkListenToEvents.Text = "Listen to SelectSet Events"
        Me.chkListenToEvents.UseVisualStyleBackColor = True
        '
        'chkDelayedUpdate
        '
        Me.chkDelayedUpdate.AutoSize = True
        Me.chkDelayedUpdate.Location = New System.Drawing.Point(180, 48)
        Me.chkDelayedUpdate.Name = "chkDelayedUpdate"
        Me.chkDelayedUpdate.Size = New System.Drawing.Size(103, 17)
        Me.chkDelayedUpdate.TabIndex = 5
        Me.chkDelayedUpdate.Text = "Delayed Update"
        Me.chkDelayedUpdate.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(180, 71)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(75, 23)
        Me.Button5.TabIndex = 6
        Me.Button5.Text = "Clear Output"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(13, 149)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(86, 13)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "SelectSetEvents"
        '
        'IvEvents
        '
        Me.IvEvents.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.XEvents})
        Me.IvEvents.Location = New System.Drawing.Point(16, 166)
        Me.IvEvents.Name = "IvEvents"
        Me.IvEvents.Size = New System.Drawing.Size(315, 97)
        Me.IvEvents.TabIndex = 8
        Me.IvEvents.UseCompatibleStateImageBehavior = False
        Me.IvEvents.View = System.Windows.Forms.View.Details
        '
        'XEvents
        '
        Me.XEvents.Text = "Events"
        Me.XEvents.Width = 131
        '
        'SelectSetLabForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(339, 295)
        Me.Controls.Add(Me.IvEvents)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.chkDelayedUpdate)
        Me.Controls.Add(Me.chkListenToEvents)
        Me.Controls.Add(Me.btnClearSelection)
        Me.Controls.Add(Me.btnContainmentCheck)
        Me.Controls.Add(Me.btnRemoveAndReloadAll)
        Me.Controls.Add(Me.btnRemove1stObject)
        Me.Name = "SelectSetLabForm"
        Me.Text = "SelectSetLabForm"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnRemove1stObject As System.Windows.Forms.Button
    Friend WithEvents btnRemoveAndReloadAll As System.Windows.Forms.Button
    Friend WithEvents btnContainmentCheck As System.Windows.Forms.Button
    Friend WithEvents btnClearSelection As System.Windows.Forms.Button
    Friend WithEvents chkListenToEvents As System.Windows.Forms.CheckBox
    Friend WithEvents chkDelayedUpdate As System.Windows.Forms.CheckBox
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents IvEvents As System.Windows.Forms.ListView
    Friend WithEvents XEvents As System.Windows.Forms.ColumnHeader
End Class
