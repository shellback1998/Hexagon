VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Validate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*************************************************************************
'Copyright © 1998, Intergraph Corporation. All rights reserved.
'
'File
'     Validate.Cls
'
'Author
'     Sai Chitta
'
'Abstract
'     Implements ILMForeignCalc.
'
'Description
'     Calculates and validates unit name and item tag property values.
'
'Modifications:
'Date:          Changes:
'5/10/00        Added standard doc header; removed obsolete code -- dmw
'7/10/00        Added error handling -- dmw
'**************************************************************************

Option Explicit

Implements ILMForeignCalc

Const CONST_strItemTagValidationProgID As String = "ItemTag.ItemTagFunc"
Const CONST_strUnitValidationProgID As String = "ValidateUnit.Unit"
Const CONST_strItemTagAttrName As String = "ItemTag"
Const CONST_strTagSequenceNoAttrName As String = "TagSequenceNo"
Const CONST_strLoopTagSuffixAttrName As String = "LoopTagSuffix"
Const CONST_strNozzleItemType As String = "Nozzle"
Const CONST_NozzlePlantItemIndex As Integer = 21
Const CONST_PlantItemTypeAttributeName As String = "PlantItemType"
Const CONST_EFDesignBasisValidation = "EFDesignBasisValidation.EFDesignBasis"
Const CONST_PlantGroupAttributeName As String = "SP_PlantGroupID"
Private Function ILMForeignCalc_DoCalculate(Datasource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, varValue As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(Datasource As Llama.LMADataSource, _
   Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean
   
    Dim objValidateUnit As Object
    Dim objLMAItems As LMAItems
    Dim objLMAItem As LMAItem
    Dim objLMAAttr As LMAAttribute
    Dim objLMALoopTagSuffixAttr As LMAAttribute
    Dim objLMForeignCalc As ILMForeignCalc
    Dim strPropName As String
    Dim strPropValue As String
    
    On Error GoTo ErrorHandler
    
    ILMForeignCalc_DoValidateItem = True
 
    Select Case Context
        
        Case LMAValidateCreate
            'performance optimizations
            If Items.Count = 1 Then
                Set objLMAItem = Items.Nth(1)
                objLMAItem.Attributes.BuildAttributesOnDemand = True
                Set objLMAAttr = Items.Nth(1).Attributes(CONST_PlantGroupAttributeName)
                If objLMAAttr Is Nothing Then
                    GoTo Cleanup
                End If
            End If
            
            'Assigns a Unit Name to which the Drawing belongs
            Set objValidateUnit = CreateObject(CONST_strUnitValidationProgID)
            If Not objValidateUnit Is Nothing Then
                objValidateUnit.UpdateUnitNumber Datasource, Items, Context
            End If
        
        Case LMAValidateCopy
            'performance optimizations
            If Items.Count = 1 Then
                Set objLMAItem = Items.Nth(1)
                objLMAItem.Attributes.BuildAttributesOnDemand = True
                Set objLMAAttr = Items.Nth(1).Attributes(CONST_PlantGroupAttributeName)
                If objLMAAttr Is Nothing Then
                    GoTo Cleanup
                End If
            End If
            
            'Assigns a Unit Name to which the Drawing belongs
            Set objValidateUnit = CreateObject(CONST_strUnitValidationProgID)
            If Not objValidateUnit Is Nothing Then
                objValidateUnit.UpdateUnitNumber Datasource, Items, Context
            End If
            strPropName = CONST_strItemTagAttrName
            'populates an unique Itemtag
            For Each objLMAItem In Items
                strPropValue = ""
                Set objLMAAttr = Nothing
                Set objLMAAttr = objLMAItem.Attributes(CONST_strItemTagAttrName)

                If Not objLMAAttr Is Nothing And Not IsNull(objLMAAttr) Then
                    'Maintain the same itemtag if the property is a editable.
                    If objLMAAttr.ISPAttribute.Attribution.ReadOnly = True Then
                        strPropValue = ""
                    Else
                        If Not IsNull(objLMAAttr.Value) Then
                            strPropValue = objLMAAttr.Value
                        End If
                    End If

                    Set objLMAAttr = objLMAItem.Attributes(CONST_strTagSequenceNoAttrName)

                    Set objLMALoopTagSuffixAttr = objLMAItem.Attributes( _
                                                            CONST_strLoopTagSuffixAttrName)

                    If Not objLMAAttr Is Nothing And Not IsNull(objLMAAttr) Then
                        If objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index <> CONST_NozzlePlantItemIndex And _
                            objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index <> 41 Then
                            objLMAAttr.Value = ""
                        End If
                        ' set the "LoopTagSuffix" Attribute if present to ""
'                        If Not objLMALoopTagSuffixAttr Is Nothing And _
'                           Not IsNull(objLMALoopTagSuffixAttr) Then
'                               objLMALoopTagSuffixAttr.Value = ""
'                        End If
                    End If
                    'Fire ItemTag property validation to generate appropriate ItemTag.
                    Set objLMForeignCalc = CreateObject(CONST_strItemTagValidationProgID)
                    If Not objLMForeignCalc Is Nothing Then
                        'Special handling for Nozzle Item Validation
                        If objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index = CONST_NozzlePlantItemIndex Or _
                            objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index = 41 Then
                                objLMForeignCalc.DoValidatePropertyNoUI Datasource, Items, strPropName, strPropValue
                        Else
                            ILMForeignCalc_DoValidateItem = objLMForeignCalc.DoValidateProperty(Datasource, Items, strPropName, strPropValue)
                        End If
                    End If
                End If
            Next
            
            'We no longer need this since we are setting it in the objmgr
            'Fire EFDesignBasis validation to clear the SP_DesignBasisUID value
''''            Set objLMForeignCalc = Nothing
''''            Set objLMForeignCalc = CreateObject(CONST_EFDesignBasisValidation)
''''            If Not objLMForeignCalc Is Nothing Then
''''                ILMForeignCalc_DoValidateItem = objLMForeignCalc.DoValidateItem(Datasource, Items, Context)
''''            End If
            
        Case LMAValidateFiltered
            strPropName = CONST_strItemTagAttrName
            Set objLMForeignCalc = CreateObject(CONST_strItemTagValidationProgID)
            If Not objLMForeignCalc Is Nothing Then
                For Each objLMAItem In Items
                    Set objLMAItems = New LMAItems
                    objLMAItems.Add objLMAItem
                    If objLMAItem.ItemType = CONST_strNozzleItemType Then
                        Set objLMAAttr = objLMAItem.Attributes.Item(CONST_strItemTagAttrName)
                        If Not objLMAAttr Is Nothing Then
                            If Not IsNull(objLMAAttr.Value) Then strPropValue = objLMAAttr.Value
                        End If
                    End If
                    ILMForeignCalc_DoValidateItem = objLMForeignCalc.DoValidateProperty(Datasource, objLMAItems, strPropName, strPropValue)
                    Set objLMAItems = Nothing
                Next
            End If
        
        Case LMAValidateNoUI
            strPropName = CONST_strItemTagAttrName
            Set objLMForeignCalc = CreateObject(CONST_strItemTagValidationProgID)
            If Not objLMForeignCalc Is Nothing Then
                For Each objLMAItem In Items
                    Set objLMAItems = New LMAItems
                    objLMAItems.Add objLMAItem
                    objLMForeignCalc.DoValidatePropertyNoUI Datasource, objLMAItems, strPropName, strPropValue
                    Set objLMAItems = Nothing
                Next
            End If
            
    End Select
    
Cleanup:
    If Err.Number <> 0 Then
        Err.Clear
    End If
    Set objLMAItem = Nothing
    Set objValidateUnit = Nothing
    Set objLMAAttr = Nothing
    Set objLMALoopTagSuffixAttr = Nothing
    Set objLMForeignCalc = Nothing
    
    Exit Function
    
ErrorHandler:
    LogError "PlantItemValidation - Validate::ILMForeignCalc_DoValidateItem --> " & Err.Description
    Resume Cleanup
    
End Function

Private Function ILMForeignCalc_DoValidateProperty(Datasource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, varValue As Variant) As Boolean

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(Datasource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, varValue As Variant)

End Sub


