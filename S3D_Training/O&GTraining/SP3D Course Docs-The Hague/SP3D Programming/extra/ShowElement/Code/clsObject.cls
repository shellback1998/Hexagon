VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Const MODULE = "clsObject::"
'
' clsObject
'
' show information about any SP3D object
'
' This class implements a method  "ShowObject", with one Object as parameter,
' which should be an SP3d Object.
' The method will open a form with a treeview and show all interfaces, attributes and relations
' of this object.
' For specific interfaces, it will also show the names of other available methods etc.
' and - if possible and useful - call these methods and show the result.
' These "specific interfaces" are stored by key=name in a collection.
' Inside the collection a class-reference is stored, which can display the specific information.
'
' 1.0.0.  24.10.2007 G. Werner    Created
' 1.0.1.  16.07.2007 G. Werner    updated
'         24.10.2007 G. Werner    added codelist values
' 1.0.5   30.10.2008 G. Werner    add relations
' 1.0.7   16.04.2009 G. Werner    add ShowGuid
'

' The form containing the treeview
Public mForm As frmShowElement

' A collection remembering all GUIDs, which are already shown in the treeview,
' avoiding to show the same guid several times and going into an endless loop.
'   - not used any more, because the subnodes are only opened on user request,
'     a recursion is no problem. The user may find duplicates by using the
'     search function
'Public mcolPrinted As Collection

' A collection of Interface names, which needs special treatment
' For a given interface, the corresponding class is returned
' and by calling cls.output<InterfaceName>
' special information is added to the treeview
Private mcolKnownInterfaces As Collection   ' key=Interface name, object=clsXXX


Public m_oHiliter As IJHiliter ' Used to display selected objects

'================= start of code from Repository browser ==================================================

    Public Enum testObjectForAttributesReturnValues
        HAS_NO_ATTRIBUTES = 0
        HAS_GOOD_ATTRIBUTES = 1
        ERROR_INVALID_OBJECT = -1
        ERROR_NO_ATTRIBUTEHELPER = -2
        ERROR_BAD_INTERFACE = -3
    End Enum

    Public Enum TestObjectForRelationErrors
        RETURNS_CORRECT_RELATION_COUNT = 1
        RETURNS_BAD_RELATION_COUNT = -1
        RETURNS_NO_ASSOC = -2
    End Enum
    
'================= end of code from Repository browser ==================================================
    
    
    
Public Function ShowObject(o As Object, Optional MainNode As MSComctlLib.Node = Nothing, _
    Optional bModal As Boolean = False) As Long
    Const METHOD = "ShowObject"
    Dim Node1 As MSComctlLib.Node
    
    On Error GoTo Handler
    
    If MainNode Is Nothing Then
        Set Node1 = mForm.TreeView1.Nodes.Add(, , , "Typename=" & TypeName(o) & " " & getName(o, ">", "<") & " " & getGuid(o))
    Else
        Set Node1 = mForm.TreeView1.Nodes.Add(MainNode, tvwChild, , "Typename=" & TypeName(o) & " " & getName(o, ">", "<") & " " & getGuid(o))
    End If
    
        ' Show all interfaces and attributes
        Call AddAttributes(Node1, o)


CleanUp:
        On Error Resume Next
        Node1.Expanded = True
    
        If bModal Then
            mForm.Show vbModal
        Else
            mForm.Show
            
'            Debug.Print TypeName(o)
'            Call frmTree.ShowInfo(o)
        End If
        
        Exit Function
Handler:
        MsgBox Err.Description & " (in " & MODULE & METHOD & ")", vbOKOnly
        GoTo CleanUp
        Resume
End Function

'
'   Add the generally known information about an object to the treeview
'
'   There is special handling for some sorts of collections and other
'   often used sp3d classes.
'   The typical sp3d object has the interface IJDAttributes
'
Public Sub AddAttributes(Node0 As MSComctlLib.Node, o As Object)

    Dim Node3 As MSComctlLib.Node
    Dim Node4 As MSComctlLib.Node
    
    Dim occAttrib As IJDAttributes
    Dim nCount As Long
    Dim vIID As Variant
    Dim oAttCol As IJDAttributesCol
    Dim oIntInfo As IJDInterfaceInfo
 
'    Dim oAtt As IJDAttribute
'    Dim s As String
'    Dim oWhatToDo As Object
    Dim o2 As Object
    
    Dim sIntName As String
    Dim i As Long
    Dim p() As String
    Dim bImplemented As Boolean
    Dim bHasAttributes As Boolean
    Dim v As Variant
    Dim oIJDObjectCollection As IJDObjectCollection
    
    Dim oTrader As Trader
    Dim oWorkingSet As IJDWorkingSet
    Dim sInterfaceNames() As String
    Dim colIntNames As Collection
    
    Dim x As Double
    Dim y As Double
    Dim z As Double
    
    On Error GoTo Handler
    bImplemented = False
    
    If o Is Nothing Then
        Exit Sub
    End If
    
    bHasAttributes = False
    
    ' First check for collection of objects:
    If TypeOf o Is IJDObjectCollection Then
        bImplemented = True
 
        Set oIJDObjectCollection = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , TypeName(o) & " count=" & o.Count)
        For Each v In oIJDObjectCollection
            If VarType(v) = vbDataObject Then
                If oTrader Is Nothing Then
                    Set oTrader = New Trader
                    Set oWorkingSet = oTrader.Service(TKWorkingSet, "")
                End If
                Set o2 = oWorkingSet.ActiveConnection.GetObject(v)
            Else
                Set o2 = v
            End If
            Set Node4 = mForm.TreeView1.Nodes.Add(Node3, tvwChild, , TypeName(o2))
            Call AddAttributes(Node3, o2)
            Set o2 = Nothing
        Next v
 
    End If
    If TypeOf o Is IJDCollection Then
        bImplemented = True
 
        Dim oIJDCollection As IJDCollection
        Dim var As Variant
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , TypeName(o) & " count=" & o.Size)
        ' This code is not yet tested..
        Set oIJDCollection = o
        If oIJDCollection.Size > 0 Then
           For i = 1 To oIJDCollection.Size
               Set var = oIJDCollection.Item(i)
               Set o2 = var
               Set Node4 = mForm.TreeView1.Nodes.Add(Node3, tvwChild, , TypeName(o2))
               Call AddAttributes(Node3, o2)
    
           Next
        End If
    End If
    
    If TypeOf o Is IJDTargetObjectCol Then
        bImplemented = True
        Dim oIJDTargetObjectCol As IJDTargetObjectCol
        Set oIJDTargetObjectCol = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , TypeName(o) & " count=" & oIJDTargetObjectCol.Count)
        For i = 1 To oIJDTargetObjectCol.Count
            Set o2 = oIJDTargetObjectCol.Item(i)
            Set Node4 = mForm.TreeView1.Nodes.Add(Node3, tvwChild, , "*Item(" & i & ")= Typename=" & TypeName(o2) & " " & getGuid(o2))
            Set Node4.Tag = o2
        Next i
    End If
    If TypeOf o Is ISPSSlabBoundaries Then
        bImplemented = True
        Dim oCol As ISPSSlabBoundaries
        Set oCol = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , TypeName(o) & " count=" & oCol.Count)
        For i = 1 To oCol.Count
            Set o2 = oCol.Item(i)
            Set Node4 = mForm.TreeView1.Nodes.Add(Node3, tvwChild, , "*Item(" & i & ")= Typename=" & TypeName(o2) & " " & getGuid(o2))
            Set Node4.Tag = o2
        Next i
    End If
    
    
    ' check for the standard sp3d object having IJDAttributes interface
    If TypeOf o Is IJDAttributes Then
        
        Set occAttrib = o
        
        '
        '  Get all interfaces and sort by name
        '
        On Error Resume Next
        nCount = occAttrib.Count
        If Err Then
            'this is not a correct IJDAttributes object
            GoTo ContWithNext
        End If
        On Error GoTo Handler
        
        bImplemented = True
        
        Set colIntNames = New Collection
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all " & nCount & " Interfaces of " & getName(o, ">", "<") & " " & getGuid(o))
        
        For Each vIID In occAttrib
            Set oAttCol = occAttrib.CollectionOfAttributes(vIID)
            Set oIntInfo = oAttCol.InterfaceInfo
            sIntName = oIntInfo.Name
            colIntNames.Add sIntName & vbTab & vIID, sIntName
        Next vIID
        '
        '   add Interfaces, which have no attributes, but relations
        '
        Call addRelationInterfaces(o, colIntNames)
        
        
        '
        '   sort the interface names alphabetically
        '
        Call mForm.lstSorted.Clear
        For Each v In colIntNames
            Call mForm.lstSorted.AddItem(v)
        Next v
        
        '
        '  output interfaces in sorted order (sort by name)
        '
        If mForm.lstSorted.ListCount > 0 Then
            
            ReDim sInterfaceNames(mForm.lstSorted.ListCount - 1)
            For i = 0 To mForm.lstSorted.ListCount - 1
                sInterfaceNames(i) = mForm.lstSorted.List(i)
            Next i
            For i = 0 To UBound(sInterfaceNames)
                p = Split(sInterfaceNames(i), vbTab)
                Debug.Print p(0)
                Call AddSpecificInterface(Node3, o, p(1), p(0))
            Next i

        End If
        bHasAttributes = True
        

    End If
ContWithNext:
    
    ' check for special objects, like a vector:
    If TypeOf o Is IJDVector Then
        bImplemented = True
        Dim oVector As IJDVector
        Set oVector = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Vector= " & Vector(oVector.x, oVector.y, oVector.z))
    End If
    If TypeOf o Is IJDPosition Then
        bImplemented = True
        Dim oIJDPosition As IJDPosition
        Set oIJDPosition = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Position= " & Vector(oIJDPosition.x, oIJDPosition.y, oIJDPosition.z))
    End If
    If TypeOf o Is IJNameRuleAE Then
        bImplemented = True
        Dim oIJnameRuleAE As IJNameRuleAE
        Set oIJnameRuleAE = o
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "IJNameRuleAE: Frozen= " & oIJnameRuleAE.Frozen & ", NamingParentsString=" & oIJnameRuleAE.NamingParentsString)
    End If
    
    
    If TypeOf o Is IJPlane Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJPlane " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJPlane")
    End If
    If TypeOf o Is IJComplexString Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJComplexString " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJComplexString")
    End If
    If TypeOf o Is IJLine And Not bHasAttributes Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJLine " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJLine")
    End If
    If TypeOf o Is IJArc And Not bHasAttributes Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJArc " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJArc")
    End If
    
    
    If TypeOf o Is IJHgrPntOnRteFeat Then
        bImplemented = True
        Dim oIJHgrPntOnRteFeat As IJHgrPntOnRteFeat
        Set oIJHgrPntOnRteFeat = o
        
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "IsAbsolute= " & oIJHgrPntOnRteFeat.IsAbsolute)
    End If
    
    If TypeOf o Is IJPort And Not bImplemented Then
        bImplemented = True
 
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJPort:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJPort")
    End If
    If TypeOf o Is IJRteInTrunkRouteLeg And Not bImplemented Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJPort:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJRteInTrunkRouteLeg")
    End If

    If TypeOf o Is IJPoint And Not bImplemented Then
        bImplemented = True
        Dim oIJPoint As IJPoint
        Set oIJPoint = o
        Call oIJPoint.GetPoint(x, y, z)
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Point: " & Vector(x, y, z))
        
    End If
    
    If TypeOf o Is IJDSketch3d And Not bImplemented Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJDSketch3d:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJDSketch3d")
    End If
    
    If TypeOf o Is IJToDoRecord Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJToDoRecord:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJToDoRecord")
    End If
    If TypeOf o Is IJSemanticErrorInfo Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJSemanticErrorInfo:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJSemanticErrorInfo")
    End If
    If TypeOf o Is IJSpaceAssociationAE Then
        bImplemented = True
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "Listing of all Interfaces of IJSpaceAssociationAE:" & getName(o, ">", "<") & " " & getGuid(o))
        Call AddInterfaceSpecificOutput(Node3, o, "IJSpaceAssociationAE")
    End If
    
 
    If Not bImplemented Then
        Set Node3 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , "No Expansion implemented for: " & TypeName(o))
    End If
    Node3.Expanded = True
    Node3.Selected = True
   
    Set oTrader = Nothing
    Set oWorkingSet = Nothing
    Exit Sub
Handler:
    Call EnterErrorInTree(Err.Description, mForm, Node0, Node3)
    Debug.Assert False
    Resume Next
    Resume
End Sub


'
'  output information about one interface
'
'  (a) output all attributes (from interface IJDAttributes)
'  (b) look for special handling
'
Public Sub AddSpecificInterface(Node0 As MSComctlLib.Node, o As Object, ByVal sIntUID As String, ByVal sIntName As String)
    Dim oAttCol As IJDAttributesCol
    Dim oIntInfo As IJDInterfaceInfo
    Dim s As String
    Dim Node1 As MSComctlLib.Node
    Dim Node2 As MSComctlLib.Node
    Dim occAttrib As IJDAttributes
    Dim oAtt As IJDAttribute
    Dim oWhatToDo As Object
    
'    Debug.Assert sIntName <> "IJPartOcc"
 
'    Dim oCol As IJDInfosCol
'    Dim o2 As Object
    Dim i As Long
    Dim sCodeListName As String
    
    On Error GoTo Handler
        Set occAttrib = o
    
        Set oAttCol = Nothing
        On Error Resume Next
        Set oAttCol = occAttrib.CollectionOfAttributes(sIntUID)
        On Error GoTo Handler
        If oAttCol Is Nothing Then
            Set Node1 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , sIntName)
            GoTo Relations
        End If
        Set oIntInfo = oAttCol.InterfaceInfo
 
        sIntName = oIntInfo.Name
        s = oIntInfo.Name & AddIfNotEmpty(oIntInfo.Description, " (Description=")
        s = s & AddIfNotEmpty(oIntInfo.UserName, " (UserName=")
        s = s & AddIfNotEmpty(oIntInfo.TableName, " (TableName=")
        s = s & AddIfNotEmpty(oIntInfo.Namespace, " (Namespace=")
        
        Set Node1 = mForm.TreeView1.Nodes.Add(Node0, tvwChild, , s)
        Set Node1.Tag = oAttCol
        s = ""
        mForm.lstSorted2.Clear
        For Each oAtt In oAttCol
            s = oAtt.AttributeInfo.Name
            sCodeListName = ""
            If Len(oAtt.AttributeInfo.CodeListTableName) > 0 Then
                sCodeListName = oAtt.AttributeInfo.CodeListTableName
                s = s & vbTab & " CodeListTableName=" & sCodeListName
            End If
            If Len(oAtt.AttributeInfo.Description) > 0 Then
                s = s & vbTab & " Description=" & oAtt.AttributeInfo.Description
            End If
            On Error Resume Next
            Err.Clear
            s = s & vbTab & " value= " & oAtt.Value
            If Err Then
                s = s & " (" & Err.Description & ") "
                s = s & VarType(oAtt.Value)
            End If
            If sCodeListName <> "" Then
                s = s & " " & getCodeListEntry(sCodeListName, oAtt.Value)
            End If
             mForm.lstSorted2.AddItem s
            'Set Node2 = mForm.TreeView1.Nodes.Add(Node1, tvwChild, , s)
            s = ""
            
        Next oAtt
        For i = 0 To mForm.lstSorted2.ListCount - 1
            Set Node2 = mForm.TreeView1.Nodes.Add(Node1, tvwChild, , mForm.lstSorted2.List(i))
        Next i
        Set Node2 = Nothing
        
Relations:
        ' Check for Relations
        Call checkForRelations(Node1, o, sIntName)
        
        
        ' check if sIntName is known, then special processing
        Set oWhatToDo = Nothing
        On Error Resume Next
        Set oWhatToDo = mcolKnownInterfaces.Item(sIntName)
        
        If Not oWhatToDo Is Nothing Then
            On Error GoTo Handler
            s = sIntName
            'Call oWhatToDo.Display(mForm, Node1, o, sIntName)
'            call oWhatToDo.("output" & sIntname)(node2,o)
            On Error Resume Next
            Err.Clear
            Call CallByName(oWhatToDo, "output" & sIntName, VbMethod, mForm, Node1, o)
            If Err Then
                Debug.Assert False
                Call EnterErrorInTree("output" & sIntName & ": routine not found.", mForm, Node0, Node1, Node2)
            End If
        Else
            gcolUnknownInterfaces.Add sIntName, sIntName
            On Error GoTo Handler
            
            'If Node1.Children > 0 Then
                Set Node2 = mForm.TreeView1.Nodes.Add(Node1, tvwChild, , "- interface specific information not available -")
            'End If
        End If
        
        Exit Sub
Handler:
    Call EnterErrorInTree(s & " (" & Err.Description & ")", mForm, Node0, Node1, Node2)
    Resume Next
    Resume
End Sub

Private Sub addRelationInterfaces(o As Object, colIntNames As Collection)
    Dim oObjectWrapper As New ObjectWrapper
    Dim oWrapper As IJDObjectWrapper
    Dim oWrappedCol As IJDWrappedRelationCol
    Dim relCol As IJDRelationshipCol
    Dim metaData As IJDAccessMetaData
    Dim sInterface As String
    Dim sIID As String
    Dim relType As Variant
    Dim colName As String
    Dim originName As String
    Dim var As Variant
    
    
    Set oWrappedCol = oObjectWrapper
    Set oWrapper = oObjectWrapper
    oWrapper.Init o
    
    Set metaData = oWrapper
    For Each relCol In oWrappedCol
        relType = relCol.Type
        colName = relCol.Infos(var)
        originName = metaData.OriginCollectionName(relType)
        
        If StrComp(colName, originName) = 0 Then
            sInterface = metaData.OriginInterfaceName(relType)
            sIID = metaData.OriginInterfaceIID(relType)
        Else
            sInterface = metaData.DestinationInterfaceName(relType)
            sIID = metaData.DestinationInterfaceIID(relType)
        End If
        On Error Resume Next
        colIntNames.Add sInterface & vbTab & sIID, sInterface
        If Err Then
        Else
            Debug.Print "Adding: " & sInterface
        End If
    Next relCol
End Sub
Private Sub checkForRelations(Node0 As MSComctlLib.Node, o As Object, sInterfaceName As String)
    ' Code from Repository browser
    Dim oObjectWrapper As New ObjectWrapper
    Dim oWrapper As IJDObjectWrapper
    Dim oWrappedCol As IJDWrappedRelationCol
    Dim metaData As IJDAccessMetaData
    Dim relCol As IJDRelationshipCol
    
    Dim relationshipName As String
    Dim relType As Variant
    Dim colName As String
    Dim var As Variant
    Dim subRelCount As Long
    Dim j As Long
    Dim oCh As Node
    Dim endObj As IUnknown
    Dim Child1 As Node
    Dim Child2 As Node
    Dim Child3 As Node
    Dim Child4 As Node
'    Dim Child5 As Node
    Dim originName As String
    Dim interface1 As String
    Dim interface2 As String
    Dim rolename1 As String
    Dim rolename2 As String
    Dim s As String
    Dim lCount As Long
    
 
    Dim oRelationInfo As RelationInfo
    Dim sRelUsername As String
    
    On Error GoTo Handler
    
    Set oCh = Node0
    Set oWrappedCol = oObjectWrapper
    Set oWrapper = oObjectWrapper
    oWrapper.Init o
    Set metaData = oWrapper
    
    For Each relCol In oWrappedCol
        relType = relCol.Type
        colName = relCol.Infos(var)
        originName = metaData.OriginCollectionName(relType)
        relationshipName = metaData.RelationshipTypeName(relType)
        
        Set oRelationInfo = relCol
        sRelUsername = oRelationInfo.UserName
       
'        Debug.Assert relationshipName <> "madeFrom"
        
        If StrComp(colName, originName) = 0 Then
            s = metaData.OriginInterfaceName(relType)
            interface1 = s & " (Origin)"
            interface2 = metaData.DestinationInterfaceName(relType) & " (Destination)"
            rolename1 = metaData.OriginCollectionName(relType) & " (Origin)"
            rolename2 = metaData.DestinationCollectionName(relType) & " (Destination)"
           
        Else
            s = metaData.DestinationInterfaceName(relType)
            interface1 = s & " (Destination)"
            interface2 = metaData.OriginInterfaceName(relType) & " (Origin)"
            rolename1 = metaData.DestinationCollectionName(relType) & " (Destination)"
            rolename2 = metaData.OriginCollectionName(relType) & " (Origin)"
            
         End If
            
        
        If sInterfaceName <> s Then
                GoTo Skip
        End If
        
  

        lCount = 0
        subRelCount = relCol.Count
        For j = 1 To subRelCount
 
                lCount = lCount + 1
                If lCount > glMaxList Then
                    Set Child1 = mForm.TreeView1.Nodes.Add(oCh, tvwChild, , "...more relations suppressed")
                    GoTo Skip
                End If
        
                
                Set Child1 = mForm.TreeView1.Nodes.Add(oCh, tvwChild, , "Relation: " & relationshipName & " (Username=" & sRelUsername & ")")
                Set Child2 = mForm.TreeView1.Nodes.Add(Child1, tvwChild, , "Role Destination: " & rolename1)
                
                Set Child3 = mForm.TreeView1.Nodes.Add(Child1, tvwChild, , "Role Origin:  " & rolename2)

                Set Child4 = mForm.TreeView1.Nodes.Add(Child3, tvwChild, , "*Interface Origin: " & interface2 & " " & IdentityOfObject(endObj))
                                                  
                
                Set endObj = relCol.Item(j).Target
                 
                Set Child4.Tag = endObj
                
        
     
        Next j
Skip:
    Next relCol
    Exit Sub
Handler:
    Call EnterErrorInTree(s & " (" & Err.Description & ")", mForm, Node0)
    Resume Next
    Resume
End Sub

'================= start of code from Repository browser ==================================================

Private Function IdentityOfObject(ByVal someObj As IUnknown) As String
    On Error GoTo ErrorHandler
    IdentityOfObject = vbNullString
    
    Dim oObjectWrapper As New ObjectWrapper
    Dim oWrapper As IJDObjectWrapper
    Dim objectStr As String
    Dim position As Integer
    Dim i As Integer
    Dim searchStr As String
    Dim testStr As String
    Dim finalStr As String
    searchStr = "."
    
    Set oWrapper = oObjectWrapper
    oWrapper.Init someObj
      
    objectStr = oWrapper.TypeName
    If objectStr = vbNullString Then
       IdentityOfObject = "No ID"
    Else
        position = InStr(objectStr, searchStr)
        For i = (position + 1) To Len(objectStr)
            testStr = Mid(objectStr, i, 1)
            If testStr <> "." Then
                finalStr = finalStr & testStr
            Else
                Exit For
            End If
        Next i
        IdentityOfObject = finalStr
    End If
    Dim testAttribs As Integer
    Dim warningString As String
    
    Select Case RelationCountError(someObj)
    Case RETURNS_BAD_RELATION_COUNT
        warningString = ": " & "This object returns a zero count of relations"
        IdentityOfObject = finalStr & warningString
    Case RETURNS_NO_ASSOC
        'warningString = ": " & "This object has errors in relations"
        IdentityOfObject = finalStr '& warningString
    Case RETURNS_CORRECT_RELATION_COUNT
    Case Else
        warningString = ": " & "This object has unidentified error in relations"
        IdentityOfObject = finalStr & warningString
    End Select
        
    testAttribs = TestObjectForAttributes(someObj)
    If testAttribs = ERROR_BAD_INTERFACE Then
        warningString = ": " & "Undefined interface in AttributeHelper"
        IdentityOfObject = finalStr & warningString
    End If
    
    Set oWrapper = Nothing
    Set oObjectWrapper = Nothing
    Exit Function
ErrorHandler:
    'MsgBox "Error in IdentityOfObject"
    
    warningString = ": " & ""
    IdentityOfObject = finalStr & warningString
    
    Set oWrapper = Nothing
    Set oObjectWrapper = Nothing
Exit Function

End Function

Private Function RelationCountError(ByVal someObj As IUnknown) As TestObjectForRelationErrors

    
    On Error GoTo ErrorHandler
    
    Dim oObjectWrapper As New ObjectWrapper
    Dim oWrapper As IJDObjectWrapper
           
    Dim oWrappedCol As IJDWrappedRelationCol
    Set oWrappedCol = oObjectWrapper
    Set oWrapper = oObjectWrapper
        
    oWrapper.Init someObj
    Dim j As Long
    Dim relCol As IJDRelationshipCol
    
    Dim subRelCount As Long
    
    Dim errorFlag As Boolean
    errorFlag = False
    
    
    For Each relCol In oWrappedCol
        
              
        subRelCount = 0
        If relCol Is Nothing Then
            MsgBox "relCol is nothing"
        End If
        
        subRelCount = relCol.Count
              
        If subRelCount <= 0 Then
           errorFlag = True
        End If
    Next relCol
    
    If errorFlag = True Then
        RelationCountError = RETURNS_BAD_RELATION_COUNT
    Else
        RelationCountError = RETURNS_CORRECT_RELATION_COUNT
    End If
    Exit Function
    
ErrorHandler:
    RelationCountError = RETURNS_NO_ASSOC
    
            
End Function

Private Function TestObjectForAttributes(ByVal someObj As IUnknown) As testObjectForAttributesReturnValues
    Dim ah As IJDAttributes
    Dim numInterfaces As Integer
    numInterfaces = 0
    
    On Error GoTo NoAttributeHelper
    Set ah = someObj
    Debug.Assert Not ah Is Nothing
    
    Dim interfaceID As Variant
    On Error GoTo BadInterface
    For Each interfaceID In ah
        numInterfaces = numInterfaces + 1
    Next interfaceID
    
    If numInterfaces > 1 Then
        TestObjectForAttributes = HAS_GOOD_ATTRIBUTES 'object has attributes, properly defined
        GoTo CleanUp
    End If
    
NoAttributeHelper:
        TestObjectForAttributes = HAS_NO_ATTRIBUTES  'object does not aggregate the attribute helper
        GoTo CleanUp
BadInterface:
        TestObjectForAttributes = ERROR_BAD_INTERFACE 'object has an undefined interface
        
CleanUp:
        Set ah = Nothing
        Set interfaceID = Nothing
   
        
        
End Function

'================= end of code from Repository browser ==================================================


Public Sub AddInterfaceSpecificOutput(Node1 As MSComctlLib.Node, o As Object, sIntName As String)
    Dim oWhatToDo As Object
    Dim s As String
    Dim Node2 As MSComctlLib.Node
    On Error GoTo Handler
    
        ' check if sIntName is known, then special processing
        Set oWhatToDo = Nothing
        On Error Resume Next
        Set oWhatToDo = mcolKnownInterfaces.Item(sIntName)
        
        If Not oWhatToDo Is Nothing Then
            On Error GoTo Handler
            s = sIntName
            'Call oWhatToDo.Display(mForm, Node1, o, sIntName)
'            call oWhatToDo.("output" & sIntname)(node2,o)
            On Error Resume Next
            Err.Clear
            Call CallByName(oWhatToDo, "output" & sIntName, VbMethod, mForm, Node1, o)
            If Err Then
                Debug.Assert False
                Call EnterErrorInTree("output" & sIntName & ": routine not found.", mForm, Node1)
            End If
        Else
            gcolUnknownInterfaces.Add sIntName, sIntName
            On Error GoTo Handler
            
            Set Node2 = mForm.TreeView1.Nodes.Add(Node1, tvwChild, , "- interface specific information not available -")
        End If
        
        Exit Sub
Handler:
    Call EnterErrorInTree(s & " (" & Err.Description & ")", mForm, Node1, Node2)
    Resume Next
End Sub

Private Sub Class_Initialize()
    Dim o As Object
    Set mForm = New frmShowElement
 
    Set mForm.moMyObject = Me
'    Set mcolPrinted = New Collection
    Set mcolKnownInterfaces = New Collection
    
    ' set up collection of those interfaces, where we have special code to execute
    ' the object should have the methods:
    '    Publish
    '    output<InterfaceName>
    '

        On Error Resume Next
        Set o = Nothing
        Set o = CreateObject("User.Show")
        If Not o Is Nothing Then
            Call o.Publish(mcolKnownInterfaces)
        End If
        

        Set o = New clsShow
'        Set o.mcolPrinted = mcolPrinted
        Call o.Publish(mcolKnownInterfaces)
        
        Set o = New clsEmpty
'        Set o.mcolPrinted = mcolPrinted
        Call o.Publish(mcolKnownInterfaces)
        
    Dim oTrader As New Trader
    Dim oGraphicViews As IJDGraphicViews
    
    Set oGraphicViews = oTrader.Service(TKGraphicViewMgr, "")
    Set m_oHiliter = oGraphicViews.CreateHiliter
    Set oGraphicViews = Nothing
        
        
 
End Sub

Private Sub Class_Terminate()
    Set mcolKnownInterfaces = Nothing
    Set m_oHiliter = Nothing
End Sub



