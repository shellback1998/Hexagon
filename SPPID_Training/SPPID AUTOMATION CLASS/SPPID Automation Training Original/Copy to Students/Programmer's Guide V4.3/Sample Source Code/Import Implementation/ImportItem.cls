VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ImportItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarImportItemAtts As ImportItemAtts
Private mvarItemTypeName As String
Private mvarItemSymbolFile As String

Public Property Set ImportItemAtts(ByVal objImportItemAtts As ImportItemAtts)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Name = "Fred"
    Set mvarImportItemAtts = objImportItemAtts
End Property

Public Property Get ImportItemAtts() As ImportItemAtts
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Name
    Set ImportItemAtts = mvarImportItemAtts
End Property

Public Property Let ItemTypeName(ByVal strItemTypeName As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Name = "Fred"
    mvarItemTypeName = strItemTypeName
End Property

Public Property Get ItemTypeName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Name
    ItemTypeName = mvarItemTypeName
End Property

Public Property Let ItemSymbolFile(ByVal strItemSymbolFile As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Name = "Fred"
    mvarItemSymbolFile = strItemSymbolFile
End Property

Public Property Get ItemSymbolFile() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Name
    ItemSymbolFile = mvarItemSymbolFile
End Property

