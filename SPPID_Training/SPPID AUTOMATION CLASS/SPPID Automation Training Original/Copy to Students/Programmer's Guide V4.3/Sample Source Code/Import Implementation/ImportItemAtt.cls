VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ImportItemAtt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarName As String
Private mvarValue As Variant
Private mvarUnits As String

Public Property Let Name(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Name = "Fred"
    mvarName = vData
End Property

Public Property Get Name() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Name
    Name = mvarName
End Property

Public Property Let Value(ByVal vData As Variant)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Value = 5
    mvarValue = vData
End Property

Public Property Set Value(ByVal vData As Object)
'used when assigning an Object to the property, on the left side of a Set statement.
'Syntax: Set x.Value = Form1
    Set mvarValue = vData
End Property

Public Property Get Value() As Variant
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Value
    If IsObject(mvarValue) Then
        Set Value = mvarValue
    Else
        Value = mvarValue
    End If
End Property

Public Property Let Units(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Name = "Fred"
    mvarUnits = vData
End Property

Public Property Get Units() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Name
    Units = mvarUnits
End Property

