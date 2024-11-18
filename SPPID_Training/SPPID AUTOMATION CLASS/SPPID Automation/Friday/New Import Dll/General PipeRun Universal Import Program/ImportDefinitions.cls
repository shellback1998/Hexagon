VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportDefinitions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public Function Add(objImportDefinition As ImportDefinition) As ImportDefinition
    
    On Error GoTo ErrHandler
    
    mCol.Add objImportDefinition, objImportDefinition.Attr
    Set Add = objImportDefinition

    Exit Function
    
ErrHandler:
    Set Add = Nothing
    If Err.Number = 457 Then 'key already associated
 '       Stop
        'it is OK
        UpdateStatus "      Key already associated. Attribute Name = " & objImportDefinition.Attr & ". It is an expected error."
    Else
        UpdateStatus LoadResString(120) & Err.Description
    End If
End Function

Public Property Get Item(vntIndexKey As Variant) As ImportDefinition
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



Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set mCol = New Collection
End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
End Sub


