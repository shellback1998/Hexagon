VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Func"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Implements ILMForeignCalc

Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean
    
    ILMForeignCalc_DoCalculate = ShowXYCoordinates(DataSource, Items, Value, PropertyName)

End Function

Private Function ShowXYCoordinates(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, Value As Variant, PropertyName As String) As Boolean
    
    Dim Item As LMAItem
    Dim objSymbol As LMSymbol
    Dim objEquipment As LMEquipment
    
    'check if the selected Property is "XYCoordinates", then copy value from X, Y coordinates
    'to it
    
    ShowXYCoordinates = False
    For Each Item In Items
        If PropertyName = "XYCoordinates" Then
On Error Resume Next
            Set objEquipment = DataSource.GetEquipment(Item.Id)
On Error GoTo 0
            If Not objEquipment Is Nothing Then
                Set objSymbol = DataSource.GetSymbol(DataSource.GetModelItem(Item.Id).Representations.Nth(1).Id)
                Value = objSymbol.Attributes("XCoordinate").Value & "/" & objSymbol.Attributes("YCoordinate").Value
            End If
        End If
    Next
    ShowXYCoordinates = True
    
'clean up
    Set Item = Nothing
    Set objSymbol = Nothing
    Set objEquipment = Nothing
End Function


Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant)

End Sub

