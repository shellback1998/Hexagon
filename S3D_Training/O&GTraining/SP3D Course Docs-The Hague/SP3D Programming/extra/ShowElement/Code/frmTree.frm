VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmTree 
   Caption         =   "Simple Object Browser"
   ClientHeight    =   4335
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6150
   LinkTopic       =   "Form1"
   ScaleHeight     =   4335
   ScaleWidth      =   6150
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdRun 
      Caption         =   "Run"
      Enabled         =   0   'False
      Height          =   270
      Left            =   4080
      TabIndex        =   2
      Top             =   4080
      Width           =   1215
   End
   Begin MSComctlLib.StatusBar statBar 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   1
      Top             =   4035
      Width           =   6150
      _ExtentX        =   10848
      _ExtentY        =   529
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   2
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   3528
            MinWidth        =   3528
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   3528
            MinWidth        =   3528
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView treeList 
      Height          =   3975
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   7011
      _Version        =   393217
      Indentation     =   530
      LineStyle       =   1
      Style           =   6
      Appearance      =   1
   End
End
Attribute VB_Name = "frmTree"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'http://gpwiki.org/index.php/VB:Building_a_Better_Scripting_Language_by_Using_Dynamic_Classes
'***    This project demonstrates building a simple object browser for use in a custom scripting language.
'***    It has been tested in VB 6.0, but will likely run under earlier versions such as 5.0. The code makes
'***    use of the TypeLib Information library.
'***
'***    How to use:
'***    When you run the program, it will automatically fill the TreeView control with info on all members of
'***    the clsTest class. Click on any member name to see the return type in the status bar. When clicking on
'***    a variable, the current value stored in the variable will also be displayed. When clicking on a function
'***    or subroutine, the Run button will be enabled. Clicking this will execute the selected sub or function.
'***    Value display and the Run button only work on the top-level class, and not on member classes. Experiment
'***    with the program by adding your own methods and properties to the test classes.
'***
'***    This code is free. Do as you will with it.
'***
'***    -Metal
'***    www.sphere7studios.com
'***


Dim ClassNames() As String
Private mobjClass As Object  ' clsTest

Public Sub ShowInfo(o As Object)
    
    
    Set mobjClass = o
    BuildClassTree mobjClass
    Me.Show
End Sub


Private Sub cmdRun_Click()
    
    Dim n As Long
    Dim i As Long
    Dim ClassInfo As InterfaceInfo
    Dim ClassMember As MemberInfo
    Dim alParams() As Variant
    Dim hr As Variant
    
    
    'grab class info
    Set ClassInfo = tli.InterfaceInfoFromObject(mobjClass)
    Set ClassMember = ClassInfo.GetMember(ClassNames(treeList.SelectedItem.Index))
    
    'here we get the number of parameters that the function requires
    n = ClassMember.Parameters.Count - 1
    
    'if the function has parameters, we will loop through them and prompt for each one.
    If n >= 0 Then
        ReDim alParams(n)
        
        'when using InvokeHookArray, parameters are passed in reverse order, so we set up the For loop accordingly.
        For i = n To 0 Step -1
            alParams(i) = InputBox("Enter a value for parameter " & ClassMember.Parameters((n - i) + 1).Name, ClassMember.Name & " parameters")
        Next i
        
        'InvokeHookArray is extremely useful when you don't know how many parameters you need to pass until runtime.
        hr = InvokeHookArray(mobjClass, ClassMember.MemberId, INVOKE_FUNC, alParams)
    Else
        'InvokeHook let's us call without any parameters more simply than InvokeHookArray.
        hr = InvokeHook(mobjClass, ClassMember.MemberId, INVOKE_FUNC)
    End If
    
End Sub

Private Sub Form_Load()
        
    'in order to grab info from a class, the object has to be running. you must use the New
    'keyword to make an object running. whether you do it in the Dim statement or a Set statement
    'is up to you.
'    Set mobjClass = New clsTest
'    BuildClassTree mobjClass
    
End Sub

Sub BuildClassTree(objClass As Object)
    
    Dim ClassInfo As InterfaceInfo
    Dim oTypeInfo As TypeInfo
    
    ' Class does not support Automation or does not support expected interface
    Set oTypeInfo = tli.ClassInfoFromObject(objClass)
    
    Debug.Print oTypeInfo.AttributeMask
    Debug.Assert False
    
    
    
    Set ClassInfo = tli.InterfaceInfoFromObject(objClass)
    'this is our function to add nodes to the TreeView control
    '-1 tells it that this is the top level class, therefore there is no parent node
    AddClassNodes ClassInfo.Members, ClassInfo.Name, -1
    
End Sub

Sub AddClassNodes(ClassMembers As Members, strClassName, lngParent As Long)
    
    Dim strKey As String
    Dim newNode As Node
    Dim FilteredMembers As SearchResults
    Dim ClassMember As MemberInfo
    Dim i As Long
    
    
    'this builds the heading nodes
    If lngParent >= 0 Then
        treeList.Nodes.Add lngParent, tvwChild, "Functions" & CStr(lngParent), "Functions"
        treeList.Nodes.Add lngParent, tvwChild, "Objects" & CStr(lngParent), "Objects"
        treeList.Nodes.Add lngParent, tvwChild, "Variables" & CStr(lngParent), "Variables"
    Else
        treeList.Nodes.Add , , "Functions" & CStr(lngParent), "Functions"
        treeList.Nodes.Add , , "Objects" & CStr(lngParent), "Objects"
        treeList.Nodes.Add , , "Variables" & CStr(lngParent), "Variables"
    End If
    
    'if there is no parent, this is the first loop - initialize the ClassNames array
    If lngParent = -1 Then
        ReDim Preserve ClassNames(-1 To 0)
        ClassNames(-1) = strClassName
    End If
    
    'we need the filtered members in order to eliminate COM functions that VB will add in automatically
    'once we compile the exe.
    Set FilteredMembers = ClassMembers.GetFilteredMembers
    
    For i = 1 To FilteredMembers.Count
        
        'InvokeKinds stores the type of member this is. We'll check for particular flags to determine
        'if it falls into the category of function/sub, variable property, or object property.
        If FilteredMembers(i).InvokeKinds And INVOKE_FUNC Then
            strKey = "Functions" & CStr(lngParent)
        ElseIf FilteredMembers(i).InvokeKinds And INVOKE_PROPERTYPUT Then
            strKey = "Variables" & CStr(lngParent)
        ElseIf FilteredMembers(i).InvokeKinds And INVOKE_PROPERTYPUTREF Then
            strKey = "Objects" & CStr(lngParent)
        Else
            'catch-all
            GoTo NextMember
        End If
        
        'this is our function to get the unfiltered version of this member
        Set ClassMember = GetMemberByID(ClassMembers, FilteredMembers(i).MemberId)
        
        'add the member to the tree
        Set newNode = treeList.Nodes.Add(strKey, tvwChild, , ClassMember.Name)
        
        If strKey = "Objects" & CStr(lngParent) Then
            'here we compare the type of the object property with the type of its parent
            'if they match, don't build a subtree for this one, or it will infinitely loop within itself.
            'instead, bold the node to signal a self-reference.
            If ClassNames(lngParent) = ClassMember.ReturnType.TypeInfo.Name Then
                newNode.Bold = True
            Else
            
                'while the top-level class has to be running, we can grab info on all child classes (properties
                'that are objects) whether they are running or not, by using the ReturnType.TypeInfo property.
                AddClassNodes ClassMember.ReturnType.TypeInfo.Members, ClassMember.ReturnType.TypeInfo.Name, newNode.Index
                
                'store the name of the class that this object property is defined as
                'this is used for comparison above
                If newNode.Index > UBound(ClassNames) Then ReDim Preserve ClassNames(-1 To newNode.Index)
                ClassNames(newNode.Index) = ClassMember.ReturnType.TypeInfo.Name
            End If
            
            'we'll use the Tag property of the Nodes to store the return types of the properties and functions.
            'we use Mid to take the underscore off the front of custom class names
            newNode.Tag = Mid(ClassMember.ReturnType.TypeInfo.Name, 2)
        Else
            'store the name of the member for later retrieval
            If newNode.Index > UBound(ClassNames) Then ReDim Preserve ClassNames(-1 To newNode.Index)
            ClassNames(newNode.Index) = ClassMember.Name
            
            'store return type
            newNode.Tag = TypeName(ClassMember.ReturnType.TypedVariant)
        End If
        
NextMember:
    Next i
    
End Sub

Function GetMemberByID(objMembers As Members, memID As Long) As MemberInfo
    
    Dim i As Long
    
    
    'this function gets the unfiltered version of a member. this is necessary because the GetFilteredMembers
    'property, while extremely useful for its ability to quickly eliminate unneeded COM functions, also
    'eliminates some useful information, such as the ReturnType and Parameters properties. This function
    'simply takes the unfiltered members collection, and the MemberID of the filtered member, then loops
    'through and locates its unfiltered equivalent.
    For i = 1 To objMembers.Count
        If objMembers(i).MemberId = memID Then
            Set GetMemberByID = objMembers(i)
            Exit For
        End If
    Next i
    
End Function

Private Sub Form_Resize()
    
    treeList.Width = Me.ScaleWidth
    treeList.Height = Me.ScaleHeight - statBar.Height
    cmdRun.Top = Me.ScaleHeight - cmdRun.Height
    
End Sub

Private Sub treeList_NodeClick(ByVal Node As MSComctlLib.Node)
    
    statBar.Panels(1).Text = "Type: " & Node.Tag
    
    If Not Node.Parent Is Nothing Then
    
        If Node.Parent.Text = "Functions" And Node.Parent.Parent Is Nothing Then
            cmdRun.Enabled = True
        Else
            cmdRun.Enabled = False
        End If
        
        If Node.Parent.Text = "Variables" And Node.Parent.Parent Is Nothing Then
            'here we use InvokeHook with INVOKE_PROPERTYGET to grab the value currently stored in the property.
            statBar.Panels(2).Text = "Value: " & CStr(InvokeHook(mobjClass, ClassNames(Node.Index), INVOKE_PROPERTYGET))
        Else
            statBar.Panels(2).Text = ""
        End If
        
    End If
    
End Sub
