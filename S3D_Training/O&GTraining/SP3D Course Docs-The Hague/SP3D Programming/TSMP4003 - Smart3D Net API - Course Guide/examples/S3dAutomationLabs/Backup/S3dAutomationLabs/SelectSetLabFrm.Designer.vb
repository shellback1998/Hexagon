<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SelectSetLabFrm
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
        Me.Button1 = New System.Windows.Forms.Button
        Me.Button2 = New System.Windows.Forms.Button
        Me.Button3 = New System.Windows.Forms.Button
        Me.Button4 = New System.Windows.Forms.Button
        Me.Button5 = New System.Windows.Forms.Button
        Me.CheckBox1 = New System.Windows.Forms.CheckBox
        Me.CheckBox2 = New System.Windows.Forms.CheckBox
        Me.lvEvents = New System.Windows.Forms.ListView
        Me.MyEvents = New System.Windows.Forms.ColumnHeader
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(12, 12)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(132, 21)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Remove 1st Object"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(12, 39)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(132, 21)
        Me.Button2.TabIndex = 1
        Me.Button2.Text = "Remove &&  Reload"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(12, 66)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(132, 21)
        Me.Button3.TabIndex = 2
        Me.Button3.Text = "Containment Check"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(12, 93)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(132, 21)
        Me.Button4.TabIndex = 3
        Me.Button4.Text = "Clear Selection"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(178, 93)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(102, 21)
        Me.Button5.TabIndex = 4
        Me.Button5.Text = "ClearOutput"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(178, 16)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(151, 17)
        Me.CheckBox1.TabIndex = 5
        Me.CheckBox1.Text = "Listen to SelectSet Events"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'CheckBox2
        '
        Me.CheckBox2.AutoSize = True
        Me.CheckBox2.Location = New System.Drawing.Point(178, 43)
        Me.CheckBox2.Name = "CheckBox2"
        Me.CheckBox2.Size = New System.Drawing.Size(108, 17)
        Me.CheckBox2.TabIndex = 6
        Me.CheckBox2.Text = "Delayed Updates"
        Me.CheckBox2.UseVisualStyleBackColor = True
        '
        'lvEvents
        '
        Me.lvEvents.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.MyEvents})
        Me.lvEvents.Location = New System.Drawing.Point(12, 132)
        Me.lvEvents.Name = "lvEvents"
        Me.lvEvents.Size = New System.Drawing.Size(262, 114)
        Me.lvEvents.TabIndex = 7
        Me.lvEvents.UseCompatibleStateImageBehavior = False
        Me.lvEvents.View = System.Windows.Forms.View.Details
        '
        'MyEvents
        '
        Me.MyEvents.Text = "Select Set Events"
        Me.MyEvents.Width = 259
        '
        'SelectSetLabFrm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(292, 266)
        Me.Controls.Add(Me.lvEvents)
        Me.Controls.Add(Me.CheckBox2)
        Me.Controls.Add(Me.CheckBox1)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Name = "SelectSetLabFrm"
        Me.Text = "SelectSetLabFrm"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents CheckBox2 As System.Windows.Forms.CheckBox
    Friend WithEvents lvEvents As System.Windows.Forms.ListView
    Friend WithEvents MyEvents As System.Windows.Forms.ColumnHeader
End Class
