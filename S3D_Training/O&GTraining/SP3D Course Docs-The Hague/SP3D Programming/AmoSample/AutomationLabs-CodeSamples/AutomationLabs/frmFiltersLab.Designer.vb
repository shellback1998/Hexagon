<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmFiltersLab
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
        Me.btnFilterFolder = New System.Windows.Forms.Button
        Me.btnCompoundFilter = New System.Windows.Forms.Button
        Me.lvObjs = New System.Windows.Forms.ListView
        Me.OutPut = New System.Windows.Forms.ColumnHeader
        Me.btnHierarchyFilter = New System.Windows.Forms.Button
        Me.btnPropertiesFilter = New System.Windows.Forms.Button
        Me.btnPersistantFilter = New System.Windows.Forms.Button
        Me.btnSQLFilter = New System.Windows.Forms.Button
        Me.btnCancel = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'btnFilterFolder
        '
        Me.btnFilterFolder.Location = New System.Drawing.Point(38, 23)
        Me.btnFilterFolder.Name = "btnFilterFolder"
        Me.btnFilterFolder.Size = New System.Drawing.Size(104, 31)
        Me.btnFilterFolder.TabIndex = 0
        Me.btnFilterFolder.Text = "Create FilterFolder"
        Me.btnFilterFolder.UseVisualStyleBackColor = True
        '
        'btnCompoundFilter
        '
        Me.btnCompoundFilter.Location = New System.Drawing.Point(38, 92)
        Me.btnCompoundFilter.Name = "btnCompoundFilter"
        Me.btnCompoundFilter.Size = New System.Drawing.Size(104, 28)
        Me.btnCompoundFilter.TabIndex = 1
        Me.btnCompoundFilter.Text = "Compound Filter"
        Me.btnCompoundFilter.UseVisualStyleBackColor = True
        '
        'lvObjs
        '
        Me.lvObjs.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.OutPut})
        Me.lvObjs.GridLines = True
        Me.lvObjs.Location = New System.Drawing.Point(38, 160)
        Me.lvObjs.Name = "lvObjs"
        Me.lvObjs.Size = New System.Drawing.Size(373, 170)
        Me.lvObjs.TabIndex = 2
        Me.lvObjs.UseCompatibleStateImageBehavior = False
        Me.lvObjs.View = System.Windows.Forms.View.Details
        '
        'OutPut
        '
        Me.OutPut.Text = "OutPut"
        Me.OutPut.Width = 177
        '
        'btnHierarchyFilter
        '
        Me.btnHierarchyFilter.Location = New System.Drawing.Point(175, 92)
        Me.btnHierarchyFilter.Name = "btnHierarchyFilter"
        Me.btnHierarchyFilter.Size = New System.Drawing.Size(104, 28)
        Me.btnHierarchyFilter.TabIndex = 3
        Me.btnHierarchyFilter.Text = "Hierarchy Filter"
        Me.btnHierarchyFilter.UseVisualStyleBackColor = True
        '
        'btnPropertiesFilter
        '
        Me.btnPropertiesFilter.Location = New System.Drawing.Point(307, 92)
        Me.btnPropertiesFilter.Name = "btnPropertiesFilter"
        Me.btnPropertiesFilter.Size = New System.Drawing.Size(104, 28)
        Me.btnPropertiesFilter.TabIndex = 4
        Me.btnPropertiesFilter.Text = "Properties Filter"
        Me.btnPropertiesFilter.UseVisualStyleBackColor = True
        '
        'btnPersistantFilter
        '
        Me.btnPersistantFilter.Location = New System.Drawing.Point(175, 23)
        Me.btnPersistantFilter.Name = "btnPersistantFilter"
        Me.btnPersistantFilter.Size = New System.Drawing.Size(113, 42)
        Me.btnPersistantFilter.TabIndex = 5
        Me.btnPersistantFilter.Text = "Create Persistant Filter"
        Me.btnPersistantFilter.UseVisualStyleBackColor = True
        '
        'btnSQLFilter
        '
        Me.btnSQLFilter.Location = New System.Drawing.Point(307, 23)
        Me.btnSQLFilter.Name = "btnSQLFilter"
        Me.btnSQLFilter.Size = New System.Drawing.Size(104, 31)
        Me.btnSQLFilter.TabIndex = 6
        Me.btnSQLFilter.Text = "SQL Filter"
        Me.btnSQLFilter.UseVisualStyleBackColor = True
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(333, 336)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(78, 25)
        Me.btnCancel.TabIndex = 7
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'frmFiltersLab
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(430, 368)
        Me.ControlBox = False
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnSQLFilter)
        Me.Controls.Add(Me.btnPersistantFilter)
        Me.Controls.Add(Me.btnPropertiesFilter)
        Me.Controls.Add(Me.btnHierarchyFilter)
        Me.Controls.Add(Me.lvObjs)
        Me.Controls.Add(Me.btnCompoundFilter)
        Me.Controls.Add(Me.btnFilterFolder)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmFiltersLab"
        Me.Text = "Filters Lab"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents btnFilterFolder As System.Windows.Forms.Button
    Friend WithEvents btnCompoundFilter As System.Windows.Forms.Button
    Friend WithEvents lvObjs As System.Windows.Forms.ListView
    Friend WithEvents OutPut As System.Windows.Forms.ColumnHeader
    Friend WithEvents btnHierarchyFilter As System.Windows.Forms.Button
    Friend WithEvents btnPropertiesFilter As System.Windows.Forms.Button
    Friend WithEvents btnPersistantFilter As System.Windows.Forms.Button
    Friend WithEvents btnSQLFilter As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
End Class
