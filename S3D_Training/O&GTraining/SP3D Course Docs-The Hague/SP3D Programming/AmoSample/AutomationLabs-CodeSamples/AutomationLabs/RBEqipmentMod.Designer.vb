<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class RBEqipmentMod
    Inherits Ingr.SP3D.Common.Client.BaseRibbonBarControl 'System.Windows.Forms.UserControl

    'UserControl overrides dispose to clean up the component list.
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
        Me.btnFinish = New System.Windows.Forms.Button
        Me.txtName = New System.Windows.Forms.TextBox
        Me.txtX = New System.Windows.Forms.TextBox
        Me.txtY = New System.Windows.Forms.TextBox
        Me.txtZ = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'btnFinish
        '
        Me.btnFinish.Location = New System.Drawing.Point(564, 12)
        Me.btnFinish.Name = "btnFinish"
        Me.btnFinish.Size = New System.Drawing.Size(69, 27)
        Me.btnFinish.TabIndex = 0
        Me.btnFinish.Text = "Finish"
        Me.btnFinish.UseVisualStyleBackColor = True
        '
        'txtName
        '
        Me.txtName.Location = New System.Drawing.Point(54, 16)
        Me.txtName.Name = "txtName"
        Me.txtName.Size = New System.Drawing.Size(195, 20)
        Me.txtName.TabIndex = 1
        '
        'txtX
        '
        Me.txtX.Location = New System.Drawing.Point(289, 17)
        Me.txtX.Name = "txtX"
        Me.txtX.Size = New System.Drawing.Size(60, 20)
        Me.txtX.TabIndex = 2
        '
        'txtY
        '
        Me.txtY.Location = New System.Drawing.Point(388, 17)
        Me.txtY.Name = "txtY"
        Me.txtY.Size = New System.Drawing.Size(60, 20)
        Me.txtY.TabIndex = 3
        '
        'txtZ
        '
        Me.txtZ.Location = New System.Drawing.Point(487, 16)
        Me.txtZ.Name = "txtZ"
        Me.txtZ.Size = New System.Drawing.Size(60, 20)
        Me.txtZ.TabIndex = 4
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(10, 20)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(38, 13)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = "Name:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(266, 20)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(17, 13)
        Me.Label2.TabIndex = 6
        Me.Label2.Text = "X:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(365, 19)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(17, 13)
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Y:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(464, 20)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(17, 13)
        Me.Label4.TabIndex = 8
        Me.Label4.Text = "Z:"
        '
        'RBEqipmentMod
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtZ)
        Me.Controls.Add(Me.txtY)
        Me.Controls.Add(Me.txtX)
        Me.Controls.Add(Me.txtName)
        Me.Controls.Add(Me.btnFinish)
        Me.Name = "RBEqipmentMod"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnFinish As System.Windows.Forms.Button
    Friend WithEvents txtName As System.Windows.Forms.TextBox
    Friend WithEvents txtX As System.Windows.Forms.TextBox
    Friend WithEvents txtY As System.Windows.Forms.TextBox
    Friend WithEvents txtZ As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label

End Class
