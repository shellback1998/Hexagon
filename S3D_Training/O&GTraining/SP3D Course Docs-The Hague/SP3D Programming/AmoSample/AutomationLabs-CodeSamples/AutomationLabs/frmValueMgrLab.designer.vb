<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmValueMgrLab
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
        Me.optStringType = New System.Windows.Forms.RadioButton
        Me.optBooleanType = New System.Windows.Forms.RadioButton
        Me.optDoubleType = New System.Windows.Forms.RadioButton
        Me.txtKeyName = New System.Windows.Forms.TextBox
        Me.txtValue = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.btnAddValue = New System.Windows.Forms.Button
        Me.btnGetValue = New System.Windows.Forms.Button
        Me.optIntegerType = New System.Windows.Forms.RadioButton
        Me.btnRemoveKey = New System.Windows.Forms.Button
        Me.btnIsKeyValid = New System.Windows.Forms.Button
        Me.btnReplaceKey = New System.Windows.Forms.Button
        Me.btnNoOfKeys = New System.Windows.Forms.Button
        Me.btnListOfKeys = New System.Windows.Forms.Button
        Me.lvKeyDetails = New System.Windows.Forms.ListView
        Me.KeyName = New System.Windows.Forms.ColumnHeader
        Me.btnCancel = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'optStringType
        '
        Me.optStringType.AutoSize = True
        Me.optStringType.Checked = True
        Me.optStringType.Location = New System.Drawing.Point(26, 52)
        Me.optStringType.Name = "optStringType"
        Me.optStringType.Size = New System.Drawing.Size(52, 17)
        Me.optStringType.TabIndex = 0
        Me.optStringType.TabStop = True
        Me.optStringType.Text = "String"
        Me.optStringType.UseVisualStyleBackColor = True
        '
        'optBooleanType
        '
        Me.optBooleanType.AutoSize = True
        Me.optBooleanType.Location = New System.Drawing.Point(26, 120)
        Me.optBooleanType.Name = "optBooleanType"
        Me.optBooleanType.Size = New System.Drawing.Size(64, 17)
        Me.optBooleanType.TabIndex = 2
        Me.optBooleanType.Text = "Boolean"
        Me.optBooleanType.UseVisualStyleBackColor = True
        '
        'optDoubleType
        '
        Me.optDoubleType.AutoSize = True
        Me.optDoubleType.Location = New System.Drawing.Point(26, 152)
        Me.optDoubleType.Name = "optDoubleType"
        Me.optDoubleType.Size = New System.Drawing.Size(59, 17)
        Me.optDoubleType.TabIndex = 3
        Me.optDoubleType.Text = "Double"
        Me.optDoubleType.UseVisualStyleBackColor = True
        '
        'txtKeyName
        '
        Me.txtKeyName.Location = New System.Drawing.Point(69, 218)
        Me.txtKeyName.Name = "txtKeyName"
        Me.txtKeyName.Size = New System.Drawing.Size(180, 20)
        Me.txtKeyName.TabIndex = 4
        '
        'txtValue
        '
        Me.txtValue.Location = New System.Drawing.Point(69, 257)
        Me.txtValue.Name = "txtValue"
        Me.txtValue.Size = New System.Drawing.Size(180, 20)
        Me.txtValue.TabIndex = 5
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(10, 224)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(53, 13)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "KeyName"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 264)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(34, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Value"
        '
        'btnAddValue
        '
        Me.btnAddValue.Location = New System.Drawing.Point(286, 213)
        Me.btnAddValue.Name = "btnAddValue"
        Me.btnAddValue.Size = New System.Drawing.Size(103, 25)
        Me.btnAddValue.TabIndex = 8
        Me.btnAddValue.Text = "Add Value"
        Me.btnAddValue.UseVisualStyleBackColor = True
        '
        'btnGetValue
        '
        Me.btnGetValue.Location = New System.Drawing.Point(286, 253)
        Me.btnGetValue.Name = "btnGetValue"
        Me.btnGetValue.Size = New System.Drawing.Size(103, 24)
        Me.btnGetValue.TabIndex = 9
        Me.btnGetValue.Text = "Get value"
        Me.btnGetValue.UseVisualStyleBackColor = True
        '
        'optIntegerType
        '
        Me.optIntegerType.AutoSize = True
        Me.optIntegerType.Location = New System.Drawing.Point(26, 84)
        Me.optIntegerType.Name = "optIntegerType"
        Me.optIntegerType.Size = New System.Drawing.Size(58, 17)
        Me.optIntegerType.TabIndex = 10
        Me.optIntegerType.TabStop = True
        Me.optIntegerType.Text = "Integer"
        Me.optIntegerType.UseVisualStyleBackColor = True
        '
        'btnRemoveKey
        '
        Me.btnRemoveKey.Location = New System.Drawing.Point(436, 213)
        Me.btnRemoveKey.Name = "btnRemoveKey"
        Me.btnRemoveKey.Size = New System.Drawing.Size(102, 24)
        Me.btnRemoveKey.TabIndex = 11
        Me.btnRemoveKey.Text = "Remove Key"
        Me.btnRemoveKey.UseVisualStyleBackColor = True
        '
        'btnIsKeyValid
        '
        Me.btnIsKeyValid.Location = New System.Drawing.Point(436, 253)
        Me.btnIsKeyValid.Name = "btnIsKeyValid"
        Me.btnIsKeyValid.Size = New System.Drawing.Size(104, 26)
        Me.btnIsKeyValid.TabIndex = 12
        Me.btnIsKeyValid.Text = "Is This Key Valid?"
        Me.btnIsKeyValid.UseVisualStyleBackColor = True
        '
        'btnReplaceKey
        '
        Me.btnReplaceKey.Location = New System.Drawing.Point(286, 298)
        Me.btnReplaceKey.Name = "btnReplaceKey"
        Me.btnReplaceKey.Size = New System.Drawing.Size(111, 26)
        Me.btnReplaceKey.TabIndex = 13
        Me.btnReplaceKey.Text = "Replace Key value"
        Me.btnReplaceKey.UseVisualStyleBackColor = True
        '
        'btnNoOfKeys
        '
        Me.btnNoOfKeys.Location = New System.Drawing.Point(437, 298)
        Me.btnNoOfKeys.Name = "btnNoOfKeys"
        Me.btnNoOfKeys.Size = New System.Drawing.Size(101, 24)
        Me.btnNoOfKeys.TabIndex = 14
        Me.btnNoOfKeys.Text = "No of keys"
        Me.btnNoOfKeys.UseVisualStyleBackColor = True
        '
        'btnListOfKeys
        '
        Me.btnListOfKeys.Location = New System.Drawing.Point(206, 12)
        Me.btnListOfKeys.Name = "btnListOfKeys"
        Me.btnListOfKeys.Size = New System.Drawing.Size(116, 25)
        Me.btnListOfKeys.TabIndex = 15
        Me.btnListOfKeys.Text = "List Of KeyNames"
        Me.btnListOfKeys.UseVisualStyleBackColor = True
        '
        'lvKeyDetails
        '
        Me.lvKeyDetails.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.KeyName})
        Me.lvKeyDetails.GridLines = True
        Me.lvKeyDetails.Location = New System.Drawing.Point(206, 52)
        Me.lvKeyDetails.Name = "lvKeyDetails"
        Me.lvKeyDetails.Size = New System.Drawing.Size(217, 135)
        Me.lvKeyDetails.TabIndex = 16
        Me.lvKeyDetails.UseCompatibleStateImageBehavior = False
        Me.lvKeyDetails.View = System.Windows.Forms.View.Details
        '
        'KeyName
        '
        Me.KeyName.Text = "Key Names"
        Me.KeyName.Width = 215
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(145, 298)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(104, 23)
        Me.btnCancel.TabIndex = 17
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'frmValueMgrLab
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(552, 344)
        Me.ControlBox = False
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.lvKeyDetails)
        Me.Controls.Add(Me.btnListOfKeys)
        Me.Controls.Add(Me.btnNoOfKeys)
        Me.Controls.Add(Me.btnReplaceKey)
        Me.Controls.Add(Me.btnIsKeyValid)
        Me.Controls.Add(Me.btnRemoveKey)
        Me.Controls.Add(Me.optIntegerType)
        Me.Controls.Add(Me.btnGetValue)
        Me.Controls.Add(Me.btnAddValue)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtValue)
        Me.Controls.Add(Me.txtKeyName)
        Me.Controls.Add(Me.optDoubleType)
        Me.Controls.Add(Me.optBooleanType)
        Me.Controls.Add(Me.optStringType)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmValueMgrLab"
        Me.Text = "Value Manager"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents optStringType As System.Windows.Forms.RadioButton
    Friend WithEvents optBooleanType As System.Windows.Forms.RadioButton
    Friend WithEvents optDoubleType As System.Windows.Forms.RadioButton
    Friend WithEvents txtKeyName As System.Windows.Forms.TextBox
    Friend WithEvents txtValue As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents btnAddValue As System.Windows.Forms.Button
    Friend WithEvents btnGetValue As System.Windows.Forms.Button
    Friend WithEvents optIntegerType As System.Windows.Forms.RadioButton
    Friend WithEvents btnRemoveKey As System.Windows.Forms.Button
    Friend WithEvents btnIsKeyValid As System.Windows.Forms.Button
    Friend WithEvents btnReplaceKey As System.Windows.Forms.Button
    Friend WithEvents btnNoOfKeys As System.Windows.Forms.Button
    Friend WithEvents btnListOfKeys As System.Windows.Forms.Button
    Friend WithEvents lvKeyDetails As System.Windows.Forms.ListView
    Friend WithEvents KeyName As System.Windows.Forms.ColumnHeader
    Friend WithEvents btnCancel As System.Windows.Forms.Button

End Class
