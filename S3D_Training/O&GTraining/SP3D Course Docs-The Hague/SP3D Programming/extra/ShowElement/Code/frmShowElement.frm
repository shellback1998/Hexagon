VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmShowElement 
   Caption         =   "Show Element"
   ClientHeight    =   6315
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12480
   LinkTopic       =   "Form1"
   ScaleHeight     =   6315
   ScaleWidth      =   12480
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdInfo 
      Caption         =   "Info"
      Height          =   372
      Left            =   10680
      TabIndex        =   9
      Top             =   5520
      Width           =   1692
   End
   Begin VB.CommandButton cmdUnknown 
      Caption         =   "Interfaces not yet implemented"
      Height          =   372
      Left            =   7920
      TabIndex        =   8
      Top             =   5520
      Width           =   2655
   End
   Begin VB.ListBox lstSorted2 
      Height          =   255
      Left            =   10560
      Sorted          =   -1  'True
      TabIndex        =   7
      Top             =   4200
      Visible         =   0   'False
      Width           =   972
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search"
      Height          =   372
      Left            =   5040
      TabIndex        =   6
      Top             =   5520
      Width           =   1215
   End
   Begin VB.CommandButton cmdAttrInfo 
      Caption         =   "Show Interface/Codelist Info"
      Height          =   372
      Left            =   2520
      TabIndex        =   5
      Top             =   5520
      Width           =   2415
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   9840
      Top             =   240
      _ExtentX        =   688
      _ExtentY        =   688
      _Version        =   393216
   End
   Begin VB.ListBox lstSorted 
      Height          =   255
      Left            =   10560
      Sorted          =   -1  'True
      TabIndex        =   4
      Top             =   4560
      Visible         =   0   'False
      Width           =   972
   End
   Begin MSComctlLib.TreeView TreeView1 
      Height          =   5412
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   7332
      _ExtentX        =   12938
      _ExtentY        =   9551
      _Version        =   393217
      Style           =   7
      Appearance      =   1
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   5940
      Width           =   12480
      _ExtentX        =   22013
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   21484
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "Expand   *-marked Node"
      Height          =   372
      Left            =   120
      TabIndex        =   1
      Top             =   5520
      Width           =   2292
   End
   Begin VB.CommandButton cmdToFile 
      Caption         =   "Save to File"
      Height          =   372
      Left            =   6360
      TabIndex        =   0
      Top             =   5520
      Width           =   1455
   End
End
Attribute VB_Name = "frmShowElement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Compare Text



Public moMyObject As clsObject

Private mLastSearch As String

Private myFrmShow As frmShowLines
Private m_oLinesHiliter(2)        As IMSHiliteObjs.IJHiliter
    

'
'  setup a new form showing information about an attribute
'
Private Sub cmdAttrInfo_Click()
Dim objNode As Node

    Set objNode = Me.TreeView1.SelectedItem
    Call ExpandAttrInfo(objNode)
End Sub

Private Sub ExpandAttrInfo(objNode As Node)
    Dim o As Object
    Dim oAttCol As IJDAttributesCol
    Dim oIntInfo As IJDInterfaceInfo
    Dim oCol As IJDInfosCol
    Dim oClassInfo As IJDClassInfo
    Dim Form As frmShowElement
    Dim Node1 As Node
    Dim Node2 As Node
    Dim Node3 As Node
    Dim Node4 As Node
    Dim s As String
    Dim oIJDInfosCol As IJDInfosCol
    Dim oObject As Object
    Dim l As Long
    
    
    On Error Resume Next
    Set o = objNode.Tag
    If o Is Nothing Then
        s = objNode.Text
        l = InStr(1, s, "CodeListTableName=")
        If l > 0 Then
            l = l + Len("CodeListTableName=")
            s = Mid(s, l)
            l = InStr(1, s, vbTab)
            s = Left(s, l - 1)
            Call ShowCodeList(s)
        End If
        Me.StatusBar1.Panels(1).Text = "No Information"
        Exit Sub
    End If
    
    
    Set oAttCol = o
    If Err Then
        Me.StatusBar1.Panels(1).Text = "No Attribute Information: " & TypeName(o)
        Exit Sub
    End If
    On Error GoTo Handler
    Set oIntInfo = oAttCol.InterfaceInfo
    Set oCol = oIntInfo.ImplementingClasses()
    
    Set Form = New frmShowElement
    Form.Caption = oIntInfo.Name
    Call Form.DisableCommands
    
    Set Node1 = Form.TreeView1.Nodes.Add(, , , "Interface: " & oIntInfo.Name)
    
    Set oIJDInfosCol = oIntInfo.AttributeCollection
    If Not oIJDInfosCol Is Nothing Then
       Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "AttributeCollection Count= " & oIJDInfosCol.Count)
       For Each oObject In oIJDInfosCol
    
           
           If TypeOf oObject Is IJDAttributeInfo Then
               
               Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , TypeName(oObject) & " " & oObject.Name)
               Call DisplayIJDAttributeInfo(Node3, oObject, Form)
           Else
               Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , TypeName(oObject))
           End If
       Next oObject
    End If
    
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "CategoryID= " & oIntInfo.CategoryID)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Description= " & oIntInfo.Description)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Flag= " & oIntInfo.Flag)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IsFrozen= " & oIntInfo.IsFrozen)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IsHardCoded= " & oIntInfo.IsHardCoded)
 
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , " ImplementingClasses:")
    
   
    For Each oClassInfo In oCol
    
        s = oClassInfo.Name
 
        Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , s)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "ClassType=" & oClassInfo.ClassType)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "Description=" & oClassInfo.Description)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "Namespace=" & oClassInfo.Namespace)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "TableName=" & oClassInfo.TableName)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "UserName=" & oClassInfo.UserName)
        Set Node4 = Form.TreeView1.Nodes.Add(Node3, tvwChild, , "ViewName=" & oClassInfo.ViewName)
        
        
    Next oClassInfo
    Node1.Expanded = True
    Form.Show
    Exit Sub
Handler:
    Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , Err.Description)
    Resume Next
End Sub

Private Sub ShowCodeList(sTableName As String)
    Dim colCl As Collection
    Dim Form As frmShowElement
    Dim Node1 As Node
    Dim Node2 As Node
    Dim Node3 As Node
    Dim v As Variant
    Dim s As String
    
    On Error Resume Next
    Set colCl = mcolCodeLists.Item(sTableName)
    If colCl Is Nothing Then
        Me.StatusBar1.Panels(1).Text = "No Codelist: " & sTableName
        Exit Sub
    End If
    On Error GoTo Handler
    
    Set Form = New frmShowElement
    Form.Caption = "Codelist: " & sTableName
    Call Form.DisableCommands
    
    Set Node1 = Form.TreeView1.Nodes.Add(, , , "Codelist: " & sTableName)
    For Each v In colCl
        s = v
        s = Replace(s, vbTab, "     ")
        Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , s)
    Next
    Node1.Expanded = True
    Form.Show
    Exit Sub
Handler:
    Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , Err.Description)
    Resume Next
End Sub
Private Sub DisplayIJDAttributeInfo(Node1 As Node, oIJDAttributeInfo As IJDAttributeInfo, _
            Form As frmShowElement)
    Dim Node2 As Node
    On Error GoTo Handler
    
    If oIJDAttributeInfo Is Nothing Then Exit Sub
    
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ChildProperty= " & oIJDAttributeInfo.ChildProperty)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "CodeListTableName= " & oIJDAttributeInfo.CodeListTableName)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "CodelistTableNamespace= " & oIJDAttributeInfo.CodelistTableNamespace)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ColumnName= " & oIJDAttributeInfo.ColumnName)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ComplexParentAttributeInfo=...") ' & oIJDAttributeInfo.ComplexParentAttributeInfo)
    If Not oIJDAttributeInfo.ComplexParentAttributeInfo Is Nothing Then
        Debug.Assert False
    End If
    Call DisplayIJDAttributeInfo(Node2, oIJDAttributeInfo.ComplexParentAttributeInfo, Form)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ComplexSiblingAttributes=...")  ' & oIJDAttributeInfo.ComplexSiblingAttributes)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ComplexSiblingSQLAttributes=...") ' & oIJDAttributeInfo.ComplexSiblingSQLAttributes)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ComplexTypeIID=" & oIJDAttributeInfo.ComplexTypeIID)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ComplexTypePropertyDispID=" & oIJDAttributeInfo.ComplexTypePropertyDispID)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Description=" & oIJDAttributeInfo.Description)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Dispid=" & oIJDAttributeInfo.Dispid)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Exposure=" & oIJDAttributeInfo.Exposure)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "InterfaceName=" & oIJDAttributeInfo.InterfaceName)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "InterfaceNamespace=" & oIJDAttributeInfo.InterfaceNamespace)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IsValueRequired=" & oIJDAttributeInfo.IsValueRequired)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Name=" & oIJDAttributeInfo.Name)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "OnPropertyPage=" & oIJDAttributeInfo.OnPropertyPage)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ParentProperty=" & oIJDAttributeInfo.ParentProperty)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "PrimaryUnits=" & oIJDAttributeInfo.PrimaryUnits)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ReadOnly=" & oIJDAttributeInfo.ReadOnly)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SecondaryUnits=" & oIJDAttributeInfo.SecondaryUnits)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "TertiaryUnits=" & oIJDAttributeInfo.TertiaryUnits)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Type=" & oIJDAttributeInfo.Type)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "UnitsType=" & oIJDAttributeInfo.UnitsType)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "UserName=" & oIJDAttributeInfo.UserName)
 
    
    
    
 
    Exit Sub
Handler:
 
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Error: " & Err.Description)
    Debug.Print Err.Description
    Debug.Assert False
    Resume Next
    Resume
End Sub

Private Sub cmdInfo_Click()
    Dim oFrm As frmShowElement
    
    If cmdInfo.Caption = "Info" Then
    
    Set oFrm = New frmShowElement
    oFrm.Caption = "Info"
    Call oFrm.DisableCommands
    oFrm.cmdInfo.Visible = True
    oFrm.cmdInfo.Caption = "Change Properties"
    
        oFrm.TreeView1.Font.Name = "FixedSys"
        Call oFrm.TreeView1.Nodes.Add(, , , "ShowElement.ShowObject " & App.Major & "." & App.Minor & "." & App.Revision)
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "After selecting one or more Sp3d Objects, call this function")
        Call oFrm.TreeView1.Nodes.Add(, , , "and for each object a form will show all available interfaces and their attributes")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "The button:")
        Call oFrm.TreeView1.Nodes.Add(, , , "'Expand *-marked attributes'    - will add information for a referenced object (or collection of objects)")
        Call oFrm.TreeView1.Nodes.Add(, , , "'Show Interface/Codelist info'  - will show information about the interface of the selected line")
        Call oFrm.TreeView1.Nodes.Add(, , , "                                - or all valid codelist entries, if the selected line contains a codelist value")
        Call oFrm.TreeView1.Nodes.Add(, , , "'Search'                        - allows to search in all lines for a given text (including wild-card-characters)")
        Call oFrm.TreeView1.Nodes.Add(, , , "                                  all lines matching the text will be displayed in bold font")
        Call oFrm.TreeView1.Nodes.Add(, , , "'Save to File'                  - allows to save the information in the treeview to a file")
        Call oFrm.TreeView1.Nodes.Add(, , , "'Interfaces not yet implemented'- will show a list of all interface, where no special handling is implemented in the code")
        Call oFrm.TreeView1.Nodes.Add(, , , "                                  For these interfaces the code of the program should be enhanced.")
        Call oFrm.TreeView1.Nodes.Add(, , , "                                  These interfaces will display the text:")
        Call oFrm.TreeView1.Nodes.Add(, , , "                                      'interface specific information not available'")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
'        Call oFrm.TreeView1.Nodes.Add(, , , "")
'        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "Double-Click a line in the treeview will allow to copy (part) of the line")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "Written by:  Gottfried Werner")
        Call oFrm.TreeView1.Nodes.Add(, , , "email:       gottfried.werner@intergraph.com")
        Call oFrm.TreeView1.Nodes.Add(, , , "phone:       (+49)5102 - 914126")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        Call oFrm.TreeView1.Nodes.Add(, , , "")
        
        
    oFrm.Show
    Set oFrm = Nothing
    
    Else ' "Show Properties"
        Dim s As String
        Dim l As Long
        
        s = InputBox("Maximum List", "Maximum Relations in List", glMaxList)
        If s <> "" Then
            On Error Resume Next
            l = -1
            l = s
            If l >= 5 Then
                glMaxList = l
            
                Call HandleSessionParameters(False)
            End If
        End If
    End If
End Sub

'
'  Expand a node, e.g. a node marked with *
'
Private Sub cmdOpen_Click()
Dim objNode As Node

    Set objNode = Me.TreeView1.SelectedItem
    Call ExpandNode(objNode)
    objNode.EnsureVisible
End Sub

Private Sub ExpandNode(objNode As Node)
    Dim o As Object
    Dim iu As IUnknown
    Dim s As String
    
    Me.StatusBar1.Panels(1).Text = ""
    
    If objNode Is Nothing Then
        Exit Sub
    End If

    
    On Error Resume Next
    Set o = Nothing
    Set o = objNode.Tag
    If o Is Nothing Then
        Set iu = objNode.Tag
        Set o = iu
    End If
    If Not o Is Nothing Then
    
        moMyObject.m_oHiliter.Elements.Clear
        moMyObject.m_oHiliter.Elements.Add o
        
        If Not objNode.Child Is Nothing Then
            Me.StatusBar1.Panels(1).Text = "Already expanded."
            Exit Sub
        End If
    
        If TypeOf o Is IJDAttributesCol Then
            Me.StatusBar1.Panels(1).Text = ""
            Call ExpandAttrInfo(objNode)
        End If
        On Error GoTo Handler
        Call moMyObject.AddAttributes(objNode, o)

    Else
        s = objNode.Text
        If StrComp(Left(s, 6), "*Port:", vbTextCompare) = 0 Then
            Call ShowPort(s)
        Else
        
            Me.StatusBar1.Panels(1).Text = "Nothing to expand."
        End If
    End If
    
    Exit Sub
Handler:
    Me.StatusBar1.Panels(1).Text = Err.Description
    Debug.Assert False
    Exit Sub
    Resume
End Sub

Private Sub ShowPort(sText As String)
    Dim lSts As Long
    Dim dArray() As Double
    Dim dFactor As Double
    
    Dim ov1 As New DVector
    Dim ov2 As New DVector
    Dim ovZ As New DVector
    Const refLength As Double = 0.025
    Dim oGeometryFactory    As IngrGeom3D.GeometryFactory
    Dim oLineFactory        As IngrGeom3D.ILines3d
    Dim lLIne As IJLine
    Dim i As Long
    
    dFactor = 0.2
    lSts = getDoubleValues(sText, dArray)
    If lSts = 0 Then
    If UBound(dArray) >= 8 Then
        If Not m_oLinesHiliter(0) Is Nothing Then
            m_oLinesHiliter(0).Elements.Clear
            m_oLinesHiliter(1).Elements.Clear
            m_oLinesHiliter(2).Elements.Clear
        End If
        Set m_oLinesHiliter(0) = New IMSHiliteObjs.Hiliter
        Set m_oLinesHiliter(1) = New IMSHiliteObjs.Hiliter
        Set m_oLinesHiliter(2) = New IMSHiliteObjs.Hiliter
        For i = 0 To 2
    With m_oLinesHiliter(i)
        .Color = vbGreen
        .Weight = 2
        .LinePattern = imsSolid
        .Elements.WaitForUpdate = True
    End With
        Next i
    m_oLinesHiliter(0).Color = vbRed
    m_oLinesHiliter(1).Color = vbGreen
    m_oLinesHiliter(2).Color = vbBlue
        
    Set oGeometryFactory = New GeometryFactory
    Set oLineFactory = oGeometryFactory.Lines3d
        
'        If myFrmShow Is Nothing Then
'            Set myFrmShow = New frmShowLines
'            Load myFrmShow
'        End If
        
        ov1.Set dArray(3), dArray(4), dArray(5)
        ov2.Set dArray(6), dArray(7), dArray(8)
        Set ovZ = ov2.Cross(ov1)
'        Set ov2 = ov2.Cross(ovZ)

        Set lLIne = oLineFactory.CreateBy2Points(Nothing, 0, 0, 0, 0, 0, 0)
        lLIne.SetStartPoint dArray(0), dArray(1), dArray(2)
        lLIne.SetDirection dArray(3), dArray(4), dArray(5)
        lLIne.Length = refLength * 3#
        m_oLinesHiliter(0).Elements.Add lLIne
        
        Set lLIne = oLineFactory.CreateBy2Points(Nothing, 0, 0, 0, 0, 0, 0)
        lLIne.SetStartPoint dArray(0), dArray(1), dArray(2)
        lLIne.SetDirection dArray(6), dArray(7), dArray(8)
        lLIne.Length = refLength
        m_oLinesHiliter(1).Elements.Add lLIne
        
        Set lLIne = oLineFactory.CreateBy2Points(Nothing, 0, 0, 0, 0, 0, 0)
        lLIne.SetStartPoint dArray(0), dArray(1), dArray(2)
        lLIne.SetDirection ovZ.x, ovZ.y, ovZ.z
        lLIne.Length = refLength * 2#
        m_oLinesHiliter(2).Elements.Add lLIne
        
        m_oLinesHiliter(0).Elements.Update
        m_oLinesHiliter(1).Elements.Update
        m_oLinesHiliter(2).Elements.Update
        
        
'       Call myFrmShow.drawLine(dArray(0), dArray(1), dArray(2), _
'                dArray(0) + dArray(3) * dFactor, dArray(1) + dArray(4) * dFactor, dArray(2) + dArray(5) * dFactor, 5, vbRed)
'        Call myFrmShow.drawLine(dArray(0), dArray(1), dArray(2), _
'                dArray(0) + dArray(6) * dFactor, dArray(1) + dArray(7) * dFactor, dArray(2) + dArray(8) * dFactor, 5, vbGreen)
'
'        Call myFrmShow.drawLine(dArray(0), dArray(1), dArray(2), dArray(0) + ovZ.x * dFactor, dArray(1) + ovZ.y * dFactor, dArray(2) + ovZ.z * dFactor, 5, vbGreen)
    
        Me.StatusBar1.Panels(1).Text = sText
    
    End If
    End If

End Sub

Private Sub cmdSearch_Click()
Dim objNode As Node
Dim lResult As Long
Dim sText As String
 
 

    Me.StatusBar1.Panels(1).Text = ""
    Set objNode = Me.TreeView1.Nodes.Item(1)
    If objNode Is Nothing Then
        Me.StatusBar1.Panels(1).Text = "No Start Node."
        Exit Sub
    End If
    sText = InputBox("Enter Text to search for:", App.ProductName, mLastSearch)
    If sText = "" Then
        
        Exit Sub
    End If
    If sText = " special" Then
        Call showUnknownInterfaces
    End If
    mLastSearch = sText
 
    sText = "*" & mLastSearch & "*"
 
    lResult = startSearch(objNode, sText)

    If lResult > 0 Then
        Me.StatusBar1.Panels(1).Text = "'" & sText & "' found " & lResult & " times."
    Else
        Me.StatusBar1.Panels(1).Text = "'" & sText & "' not found."
    End If
    
End Sub

'
'  Search a tree starting at objNode, search all subnodes and next nodes
'  all matching nodes are displayed in bold and made visible
'
Private Function startSearch(objNode As Node, sText As String) As Long
    Dim oNode2 As Node
'    Dim oNode3 As Node
'    Dim b As Boolean
    If objNode.Text Like sText Then
        objNode.Selected = True
        objNode.Checked = True ' What does this?
        objNode.Bold = True
        startSearch = startSearch + 1
    Else
        objNode.Checked = False
        objNode.Bold = False
    End If
    

    Set oNode2 = objNode.Child
    If Not oNode2 Is Nothing Then
        startSearch = startSearch + startSearch(oNode2, sText)
    End If
    Set oNode2 = objNode.Next
    If Not oNode2 Is Nothing Then
        startSearch = startSearch + startSearch(oNode2, sText)
 
    End If

    
    
        
End Function



Private Sub cmdUnknown_Click()
    Dim var As Variant
    Dim s As String
    If cmdUnknown.Caption = "Interfaces not yet implemented" Then
        showUnknownInterfaces
    Else
        For Each var In gcolUnknownInterfaces
            s = s & vbCrLf & "'#function," & var & vbCrLf & _
               "'#property,,comment,Implementation missing" & vbCrLf & "'#endfunction" & vbCrLf
        Next var
        Call Clipboard.Clear
        Call Clipboard.SetText(s)
        Me.StatusBar1.Panels(1).Text = "Clipboard contains code for functions"
    End If
End Sub

Private Sub Form_Load()
    Dim s As String
    s = "ShowObject " & App.Major & "." & App.Minor & "." & App.Revision
    Me.Caption = s
    Me.StatusBar1.Panels(1).Text = s
    
 
    
End Sub

'
'  frmShowElement.frm
'
' Show all attributes of a SP3d object in a treeview
'


Private Sub Form_Resize()
    On Error Resume Next
    Me.TreeView1.Width = Me.Width - 2 * Me.TreeView1.Left - 100
    Me.TreeView1.Height = Me.Height - Me.TreeView1.Top - Me.StatusBar1.Height - 700 - Me.cmdToFile.Height
    
    Me.cmdToFile.Top = Me.TreeView1.Top + Me.TreeView1.Height + 100 ' Me.Height - Me.cmdToFile.Height - Me.StatusBar1.Height - 500
    Me.cmdOpen.Top = Me.cmdToFile.Top
    Me.cmdAttrInfo.Top = Me.cmdToFile.Top
    Me.cmdSearch.Top = Me.cmdToFile.Top
    Me.cmdUnknown.Top = Me.cmdToFile.Top
    Me.cmdInfo.Top = Me.cmdToFile.Top
    
End Sub

Private Sub cmdToFile_Click()
    Dim lErr As Long
    
    CommonDialog1.CancelError = False
    CommonDialog1.Filter = "txt Files(*.txt)|*.txt|ALl Files|*.*"
    CommonDialog1.CancelError = True
    On Error Resume Next
    CommonDialog1.ShowOpen
    lErr = Err.Number
 
    If lErr = 0 Then
        Call ToFile(CommonDialog1.FileName)
    End If
  
End Sub
Private Function ToFile(oPath As String) As Long
    Dim of As Long
    Dim Node1 As MSComctlLib.Node
    
    On Error GoTo Handler
    
    of = FreeFile
    Open oPath For Output As #of
    
    Set Node1 = Me.TreeView1.Nodes.Item(1)
    
'    For Each Node1 In TreeView1.Nodes
        Call WriteNode(Node1, of, "")
'    Next
    Close of
    Me.StatusBar1.Panels(1).Text = "Saved to file: " & oPath
    Exit Function
Handler:
    Debug.Assert False
    On Error Resume Next
    Close of
    
End Function
Private Function WriteNode(Node1 As MSComctlLib.Node, of As Long, sHead As String) As Long
    Dim Node2 As Node
    Print #of, sHead & Node1.Text
    Set Node2 = Node1.Child
    While Not Node2 Is Nothing
        Call WriteNode(Node2, of, sHead & "...")
        Set Node2 = Node2.Next
    Wend
End Function


Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
  
        Set m_oLinesHiliter(0) = Nothing
        Set m_oLinesHiliter(1) = Nothing
        Set m_oLinesHiliter(2) = Nothing
    If Not myFrmShow Is Nothing Then
        Unload myFrmShow
        Set myFrmShow = Nothing
    End If
End Sub

Private Sub StatusBar1_DblClick()
    Dim f As New frmMessages
    f.ShowFile gsLogFilePath
 
End Sub

 

'------------------------------------------------------------------------------------------------------------------------

 
 

'
' When double clicking an tree view entry,
' put the value into the clipboard
' and start edit mode, so the user may put part of the string into clipboard
'
Private Sub TreeView1_DblClick()
Dim objNode As Node
Dim strText As String
Dim lngP As Long

    Set objNode = Me.TreeView1.SelectedItem
    strText = objNode.Text
    If Len(strText) >= 0 Then
        Clipboard.Clear
        lngP = InStrRev(strText, "=")
        If lngP > 0 Then
            strText = Mid(strText, lngP + 1)
            Call Clipboard.SetText(Mid(strText, lngP + 1))
        Else
            Call Clipboard.SetText(strText)
        End If
         Me.StatusBar1.Panels(1).Text = "Clipboard=" & strText
    End If
     
    Set TreeView1.SelectedItem = objNode
    TreeView1.StartLabelEdit
End Sub

Private Sub TreeView1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim objNode As Node
    
    If Button = vbRightButton Then
        Set objNode = Me.TreeView1.SelectedItem
        Call ExpandNode(objNode)
    End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
 
    If KeyCode = vbKeyF2 Then
        showUnknownInterfaces
    End If
End Sub

Public Sub DisableCommands()
    Me.cmdOpen.Visible = False
    Me.cmdAttrInfo.Visible = False
    Me.cmdUnknown.Visible = False
    Me.cmdInfo.Visible = False
    
End Sub
