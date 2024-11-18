<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPipeRunData
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
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtSysName = New System.Windows.Forms.TextBox
        Me.txtDsgMaxPressure = New System.Windows.Forms.TextBox
        Me.txtDsgMaxTemp = New System.Windows.Forms.TextBox
        Me.btnSetValues = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(13, 33)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(72, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "System Name"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(13, 69)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(87, 26)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Design Maximum" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "Pressure"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(13, 105)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(87, 26)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Design Maximum" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "Temperature"
        '
        'txtSysName
        '
        Me.txtSysName.Location = New System.Drawing.Point(112, 33)
        Me.txtSysName.Name = "txtSysName"
        Me.txtSysName.Size = New System.Drawing.Size(148, 20)
        Me.txtSysName.TabIndex = 3
        '
        'txtDsgMaxPressure
        '
        Me.txtDsgMaxPressure.Location = New System.Drawing.Point(112, 69)
        Me.txtDsgMaxPressure.Name = "txtDsgMaxPressure"
        Me.txtDsgMaxPressure.Size = New System.Drawing.Size(148, 20)
        Me.txtDsgMaxPressure.TabIndex = 4
        '
        'txtDsgMaxTemp
        '
        Me.txtDsgMaxTemp.Location = New System.Drawing.Point(112, 105)
        Me.txtDsgMaxTemp.Name = "txtDsgMaxTemp"
        Me.txtDsgMaxTemp.Size = New System.Drawing.Size(148, 20)
        Me.txtDsgMaxTemp.TabIndex = 5
        '
        'btnSetValues
        '
        Me.btnSetValues.Location = New System.Drawing.Point(185, 155)
        Me.btnSetValues.Name = "btnSetValues"
        Me.btnSetValues.Size = New System.Drawing.Size(75, 23)
        Me.btnSetValues.TabIndex = 6
        Me.btnSetValues.Text = "Set values"
        Me.btnSetValues.UseVisualStyleBackColor = True
        '
        'frmPipeRunData
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(292, 210)
        Me.Controls.Add(Me.btnSetValues)
        Me.Controls.Add(Me.txtDsgMaxTemp)
        Me.Controls.Add(Me.txtDsgMaxPressure)
        Me.Controls.Add(Me.txtSysName)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Name = "frmPipeRunData"
        Me.Text = "Pipe Run Data"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtSysName As System.Windows.Forms.TextBox
    Friend WithEvents txtDsgMaxPressure As System.Windows.Forms.TextBox
    Friend WithEvents txtDsgMaxTemp As System.Windows.Forms.TextBox
    Friend WithEvents btnSetValues As System.Windows.Forms.Button

End Class
