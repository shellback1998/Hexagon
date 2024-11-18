VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ImportItems"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public Function Add(strItemTypeName As String, strSymbolFile As String, objImportItemAtts As ImportItemAtts) As ImportItem
    
    Dim objNewObject As New ImportItem
    
    On Error GoTo ErrHandler
    
    objNewObject.ItemTypeName = strItemTypeName
    objNewObject.ItemSymbolFile = strSymbolFile
    Set objNewObject.ImportItemAtts = objImportItemAtts
    mCol.Add objNewObject
    Set Add = objNewObject
    Exit Function
    
ErrHandler:
    Set Add = Nothing
End Function

Public Property Get Item(vntIndexKey As Variant) As ImportItem
Attribute Item.VB_UserMemId = 0
    'used when referencing an element in the collection
    'vntIndexKey contains either the Index or Key to the collection,
    'this is why it is declared as a Variant
    'Syntax: Set foo = x.Item(xyz) or Set foo = x.Item(5)
    On Error Resume Next
    If mCol(vntIndexKey) Is Nothing Then
        Set Item = Nothing
    Else
       Set Item = mCol(vntIndexKey)
    End If
End Property

Public Property Get Count() As Long
    'used when retrieving the number of elements in the
    'collection. Syntax: Debug.Print x.Count
    Count = mCol.Count
End Property

Public Sub Remove(vntIndexKey As Variant)
    'used when removing an element from the collection
    'vntIndexKey contains either the Index or Key, which is why
    'it is declared as a Variant
    'Syntax: x.Remove(xyz)

    On Error Resume Next
    mCol.Remove vntIndexKey
End Sub

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    Set NewEnum = mCol.[_NewEnum]
End Property

Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set mCol = New Collection
End Sub

Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
End Sub



