<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmAttributesLab
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
        Me.cmdGet = New System.Windows.Forms.Button
        Me.txtInterface = New System.Windows.Forms.TextBox
        Me.txtAttribute = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.cmdSet = New System.Windows.Forms.Button
        Me.cmdCompute = New System.Windows.Forms.Button
        Me.cmdCommit = New System.Windows.Forms.Button
        Me.cmdAbort = New System.Windows.Forms.Button
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtValue = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'cmdGet
        '
        Me.cmdGet.Location = New System.Drawing.Point(89, 99)
        Me.cmdGet.Name = "cmdGet"
        Me.cmdGet.Size = New System.Drawing.Size(62, 23)
        Me.cmdGet.TabIndex = 2
        Me.cmdGet.Text = "Get"
        Me.cmdGet.UseVisualStyleBackColor = True
        '
        'txtInterface
        '
        Me.txtInterface.Location = New System.Drawing.Point(86, 24)
        Me.txtInterface.Name = "txtInterface"
        Me.txtInterface.Size = New System.Drawing.Size(150, 20)
        Me.txtInterface.TabIndex = 0
        '
        'txtAttribute
        '
        Me.txtAttribute.Location = New System.Drawing.Point(89, 62)
        Me.txtAttribute.Name = "txtAttribute"
        Me.txtAttribute.Size = New System.Drawing.Size(146, 20)
        Me.txtAttribute.TabIndex = 1
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(8, 31)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(49, 13)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "Interface"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 71)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(46, 13)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "Attribute"
        '
        'cmdSet
        '
        Me.cmdSet.Enabled = False
        Me.cmdSet.Location = New System.Drawing.Point(92, 171)
        Me.cmdSet.Name = "cmdSet"
        Me.cmdSet.Size = New System.Drawing.Size(58, 24)
        Me.cmdSet.TabIndex = 3
        Me.cmdSet.Text = "Set"
        Me.cmdSet.UseVisualStyleBackColor = True
        '
        'cmdCompute
        '
        Me.cmdCompute.Location = New System.Drawing.Point(39, 220)
        Me.cmdCompute.Name = "cmdCompute"
        Me.cmdCompute.Size = New System.Drawing.Size(66, 22)
        Me.cmdCompute.TabIndex = 4
        Me.cmdCompute.Text = "Compute"
        Me.cmdCompute.UseVisualStyleBackColor = True
        '
        'cmdCommit
        '
        Me.cmdCommit.Location = New System.Drawing.Point(120, 220)
        Me.cmdCommit.Name = "cmdCommit"
        Me.cmdCommit.Size = New System.Drawing.Size(66, 22)
        Me.cmdCommit.TabIndex = 5
        Me.cmdCommit.Text = "Commit"
        Me.cmdCommit.UseVisualStyleBackColor = True
        '
        'cmdAbort
        '
        Me.cmdAbort.Location = New System.Drawing.Point(205, 220)
        Me.cmdAbort.Name = "cmdAbort"
        Me.cmdAbort.Size = New System.Drawing.Size(63, 22)
        Me.cmdAbort.TabIndex = 6
        Me.cmdAbort.Text = "Abort"
        Me.cmdAbort.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(17, 138)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(33, 13)
        Me.Label3.TabIndex = 9
        Me.Label3.Text = "value"
        '
        'txtValue
        '
        Me.txtValue.Location = New System.Drawing.Point(89, 135)
        Me.txtValue.Name = "txtValue"
        Me.txtValue.Size = New System.Drawing.Size(147, 20)
        Me.txtValue.TabIndex = 7
        '
        'frmAttributesLab
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(292, 266)
        Me.ControlBox = False
        Me.Controls.Add(Me.txtValue)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.cmdAbort)
        Me.Controls.Add(Me.cmdCommit)
        Me.Controls.Add(Me.cmdCompute)
        Me.Controls.Add(Me.cmdSet)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtAttribute)
        Me.Controls.Add(Me.txtInterface)
        Me.Controls.Add(Me.cmdGet)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmAttributesLab"
        Me.Text = "Attributes Lab"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents cmdGet As System.Windows.Forms.Button
    Friend WithEvents txtInterface As System.Windows.Forms.TextBox
    Friend WithEvents txtAttribute As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents cmdSet As System.Windows.Forms.Button
    Friend WithEvents cmdCompute As System.Windows.Forms.Button
    Friend WithEvents cmdCommit As System.Windows.Forms.Button
    Friend WithEvents cmdAbort As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtValue As System.Windows.Forms.TextBox
End Class
