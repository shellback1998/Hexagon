VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SlopeRiseRunAngle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'*************************************************************************
'Copyright © 1998, Intergraph Corporation. All rights reserved.
'
'File
'     SyncSlopeRiseRunAngle.Cls
'
'Author
'     Raghu Veeramreddy
'
'Abstract
'     Implements ILMForeignCalc class.
'
'Description
'     Validates and calculates SyncSlopeRiseRunAngle.
'     THis function Depends on Slope, SlopeRise and SlopeRun Properties
'
'Modifications:
'Date:          Changes:
'24/09/03        Created
'*************************************************************************

Option Explicit

Implements ILMForeignCalc

'do not change the values for these constants
Const CONST_PipeRunItemName As String = "PipeRun"
Const CONST_SlopeAngleAttributeName As String = "Slope"
Const CONST_SlopeRiseAttributeName As String = "SlopeRise"
Const CONST_SlopeRunAttributeName As String = "SlopeRun"

Private Function ILMForeignCalc_DoCalculate(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateProperty(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant) As Boolean
        Dim objLMAItem As LMAItem
        For Each objLMAItem In Items
            If objLMAItem.ItemType = CONST_PipeRunItemName Then
                ILMForeignCalc_DoValidateProperty = SyncSlopeRiseAndRun(Datasource.GetPipeRun(objLMAItem.Id), strPropertyName, CStr(varValue & ""))
            End If
        Next
End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant)

    Dim objLMAItem As LMAItem
    For Each objLMAItem In Items
        If objLMAItem.ItemType = CONST_PipeRunItemName Then
            Call SyncSlopeRiseAndRun(Datasource.GetPipeRun(objLMAItem.Id), strPropertyName, CStr(varValue & ""))
        End If
    Next
End Sub

Private Function UpdateItemTag(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   varValue As Variant, strPropertyName As String) As Boolean

End Function

Private Function SyncSlopeRiseAndRun(objLMPipeRun As LMPipeRun, strPropertyName As String, strvalue As String) As Boolean

    Dim dblRunValue As Double
    Dim dblRiseValue As Double
    Dim dblAngleValue As Double

    Dim dbllocalValue As Double
    
    dblAngleValue = 0
    dblRiseValue = 0
    dblRunValue = 0
    On Error GoTo ErrorHandler
    Select Case strPropertyName
        Case CONST_SlopeAngleAttributeName
            If strvalue <> "" Then
                If CheckIfValuesAreValid(objLMPipeRun, strPropertyName, strvalue, dblAngleValue, dblRiseValue, dblRunValue) = True Then
                    If dblRunValue > 0 And dblAngleValue > 0 Then
                        'Calculate Rise
                        dbllocalValue = Tan(dblAngleValue) * dblRunValue
                        objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    ElseIf dblRiseValue > 0 And dblAngleValue > 0 Then
                        'calculate Run
                        dbllocalValue = dblRiseValue / Tan(dblAngleValue)
                        objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    Else
                        SyncSlopeRiseAndRun = True
                    End If
                Else
                    SyncSlopeRiseAndRun = True
                End If
            Else
                objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value = Null
                objLMPipeRun.Commit True
                SyncSlopeRiseAndRun = True
            End If
        Case CONST_SlopeRiseAttributeName
            If strvalue <> "" Then
                If CheckIfValuesAreValid(objLMPipeRun, strPropertyName, strvalue, dblAngleValue, dblRiseValue, dblRunValue) = True Then
                    If dblRunValue > 0 And dblRiseValue > 0 Then
                        'Calculate Angle
                        dbllocalValue = Atn(dblRiseValue / dblRunValue)
                        objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    ElseIf dblAngleValue > 0 And dblRiseValue > 0 Then
                        'calculate Run
                        dbllocalValue = dblRiseValue / Tan(dblAngleValue)
                        objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    Else
                        objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = strvalue
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    End If
                Else
                    SyncSlopeRiseAndRun = True
                End If
            Else
                objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = Null
                objLMPipeRun.Commit True
                SyncSlopeRiseAndRun = True
            End If
        Case CONST_SlopeRunAttributeName
            If strvalue <> "" Then
                If CheckIfValuesAreValid(objLMPipeRun, strPropertyName, strvalue, dblAngleValue, dblRiseValue, dblRunValue) = True Then
                    If dblRiseValue > 0 And dblRunValue > 0 Then
                        'Calculate Angle
                        dbllocalValue = Atn(dblRiseValue / dblRunValue)
                        objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    ElseIf dblAngleValue > 0 And dblAngleValue > 0 Then
                        'calculate Rise
                        dbllocalValue = dblRunValue * Tan(dblAngleValue)
                        objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value = strvalue
                        objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.FormatUnit(dbllocalValue)
                        objLMPipeRun.Commit True
                        SyncSlopeRiseAndRun = True
                    Else
                        SyncSlopeRiseAndRun = True
                    End If
                Else
                    SyncSlopeRiseAndRun = True
                End If
            Else
                objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value = Null
                objLMPipeRun.Commit True
                SyncSlopeRiseAndRun = True
            End If
    End Select
    Exit Function
ErrorHandler:
    SyncSlopeRiseAndRun = False
    LogError "Error in SyncSlopeRiseAndRun"
End Function

'THis Function Checks if the Keyed in values and the Existing Values are Valid Values on the item
'For The Slope, SlopeRise and SlopeRun
Private Function CheckIfValuesAreValid(ByVal objLMPipeRun As LMPipeRun, ByVal strPropertyName As String, ByVal strvalue As String, ByRef dblSlopeAngle As Double, ByRef dblSlopeRise As Double, ByRef dblSlopeRun As Double) As Boolean
    Dim strVariant As Variant
    On Error GoTo ErrorHandler
    CheckIfValuesAreValid = True
    Select Case strPropertyName
        Case CONST_SlopeAngleAttributeName
            strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(strvalue)
            If IsNull(strVariant) Then
                CheckIfValuesAreValid = False
                Exit Function 'Because the Keyedin Value itself is wrong
            Else
                dblSlopeAngle = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(strvalue)
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function 'Exiting Function because the Value Exists and it is a wrong Value
                Else
                    dblSlopeRun = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value)
                    Exit Function 'Exiting Function because the Value we are calculating Rise
                End If
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function 'Because the Keyedin Value itself is wrong
                Else
                    dblSlopeRise = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value)
                End If
            Else
                CheckIfValuesAreValid = False
                Exit Function
            End If
        Case CONST_SlopeRiseAttributeName
            strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(strvalue)
            If IsNull(strVariant) Then
                CheckIfValuesAreValid = False
                Exit Function 'Because the Keyedin Value itself is wrong
            Else
                dblSlopeRise = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(strvalue)
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function 'Exiting Function because the Value Exists and it is a wrong Value
                Else
                    dblSlopeRun = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).Value)
                    Exit Function
                End If
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item("Slope").Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function
                Else
                    dblSlopeAngle = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value)
                End If
            Else
                CheckIfValuesAreValid = False
                Exit Function
            End If
        Case CONST_SlopeRunAttributeName
            strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(strvalue)
            If IsNull(strVariant) Then
                CheckIfValuesAreValid = False
                Exit Function 'Because the Keyedin Value itself is wrong
            Else
                dblSlopeRun = objLMPipeRun.Attributes.Item(CONST_SlopeRunAttributeName).ISPAttribute.Format.Parse(strvalue)
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function 'Exiting Function because the Value Exists and it is a wrong Value
                Else
                    dblSlopeRise = objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeRiseAttributeName).Value)
                    Exit Function
                End If
            End If
            If Not IsNull(objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value) Then
                strVariant = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value)
                If IsNull(strVariant) Then
                    CheckIfValuesAreValid = False
                    Exit Function 'Exiting Function because the Value Exists and it is a wrong Value
                Else
                    dblSlopeAngle = objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).ISPAttribute.Format.Parse(objLMPipeRun.Attributes.Item(CONST_SlopeAngleAttributeName).Value)
                End If
            Else
                CheckIfValuesAreValid = False
                Exit Function
            End If
    End Select
    Exit Function
ErrorHandler:
    CheckIfValuesAreValid = False
    LogError "Error In CheckIfValuesAreValid"
End Function

