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

Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, Context As ENUM_LMAValidateContext) As Boolean
    
    Dim PlantItemValidate As ILMForeignCalc
    
    Dim ds As LMADataSource
    Set ds = New LMADataSource
    Set ds = Nothing
    
    'Call PlantItemValidation.Validate
    Set PlantItemValidate = CreateObject("PlantItemValidation.Validate")
    If Not PlantItemValidate Is Nothing Then
        ILMForeignCalc_DoValidateItem = PlantItemValidate.DoValidateItem(DataSource, Items, Context)
    End If
    
    'call function to place actuator
    ILMForeignCalc_DoValidateItem = CopySystemCode(DataSource, Items, Context)

End Function

Private Function CopySystemCode(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, Context As ENUM_LMAValidateContext) As Boolean
    Dim objLMAItem As LMAItem
    Dim objDrawing As LMDrawing
    Dim objModelItem As LMModelItem
    
    If Context = LMAValidateCreate Then
        For Each objLMAItem In Items
            Set objModelItem = DataSource.GetModelItem(objLMAItem.Id)
            Set objDrawing = objModelItem.Representations.Nth(1).DrawingObject
            objLMAItem.Attributes("SystemCode").Value = objDrawing.Attributes("SystemCode").Value
            objLMAItem.Commit
        Next
    End If
End Function


Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant)

End Sub
