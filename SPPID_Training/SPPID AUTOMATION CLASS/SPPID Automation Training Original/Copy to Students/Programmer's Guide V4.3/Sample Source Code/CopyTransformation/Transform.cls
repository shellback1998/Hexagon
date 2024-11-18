VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Transform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*************************************************************************
'Copyright © 1998, Intergraph Corporation. All rights reserved.
'
'File
'     TransFormation.Cls
'
'Author
'     Raghu Veeramreddy
'
'Abstract
'     Implements ILMForeignCalc.
'
'Description
'     Calculates and validates Transformation Program During Copy and Paste
'
'Modifications:
'Date:          Changes:
' 9-9-2004 pr   TR-58936 process data not getting cleared when other options
'               are selected.  Set BuildAttributesOnDemand to False for this
'               option.
'**************************************************************************

Option Explicit

Implements ILMForeignCalc
Implements ITransformUI
Const CONST_strItemTagValidationProgID As String = "ItemTag.ItemTagFunc"
Const CONST_strItemTagAttrName As String = "ItemTag"
Const CONST_strTagSequenceNoAttrName As String = "TagSequenceNo"
Const CONST_strLoopTagSuffixAttrName As String = "LoopTagSuffix"
Const CONST_strNozzleItemType As String = "Nozzle"
Const CONST_NozzlePlantItemIndex As Integer = 21
Const CONST_PlantItemTypeAttributeName As String = "PlantItemType"
Const CONST_PipingMaterialsClass As String = "PipingMaterialsClass"
Const Const_ProcessCategory As String = "Process"
Const Const_OPCItemName As String = "OPC"
Const Const_OPCTagAttributeName As String = "OPCTag"
Const Const_InstrumentItemName As String = "Instrument"
Const Const_spdisplayatt As Integer = 0
Private m_bGenerateNewSequenceNumbers As Boolean
Private m_bAddStringTotheBegining As Boolean
Private m_strAddstring As String
Private m_bClearPipingMaterialClassification As Boolean
Private m_bClearProcessData As Boolean

Private m_bKeepExisting As Boolean
Private Sub Class_Initialize()
    'default value for Generate new seq no in UI is checked.
    m_bGenerateNewSequenceNumbers = True
End Sub
















Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean
   
    Dim objLMAItems As LMAItems
    Dim objLMAItem As LMAItem
    Dim objLMAAttr As LMAAttribute
    Dim strPropName As String
    Dim strPropValue As String
    Dim bGenerateNewSequenceNumbers As Boolean
    Dim bAddStringTotheBegining As Boolean
    Dim strAddstring As String
    Dim bClearPipingMaterialClassification As Boolean
    Dim bClearProcessData As Boolean
    Dim strItemTypeName As String
    Dim objLMPipiingComp As LMPipingComp
    
    On Error GoTo ErrorHandler
    
    ILMForeignCalc_DoValidateItem = True
    
    For Each objLMAItem In Items
        If m_bGenerateNewSequenceNumbers = True Or m_bAddStringTotheBegining = True Then
            objLMAItem.Attributes.BuildAttributesOnDemand = True
            strItemTypeName = objLMAItem.ItemType
            If strItemTypeName = Const_OPCItemName Then
                Set objLMAAttr = objLMAItem.Attributes.Item(Const_OPCTagAttributeName)
            Else
                Set objLMAAttr = objLMAItem.Attributes.Item(CONST_strTagSequenceNoAttrName)
            End If
            
            If Not objLMAAttr Is Nothing Then
                If m_bGenerateNewSequenceNumbers = True Then
                    If Not IsNull(objLMAAttr.Value) Then
                        If Not IsNull(objLMAAttr.ISPAttribute.Attribution.ValidationProgID) Then
                            'Nulling out the TagSequence Numbers So the the Validation Will refill the Sequence numbers
                            If objLMAItem.ItemType <> Const_InstrumentItemName Then
                                objLMAAttr.Value = Null
                            End If
                        End If
                    End If
                ElseIf m_bAddStringTotheBegining = True Then
                    If Not IsNull(objLMAAttr.Value) Then
                        'Setting the Sequence Numbers with the prefix defined
                        objLMAAttr.Value = m_strAddstring & objLMAAttr.Value
                    End If
                End If
            End If
            Set objLMAAttr = Nothing
        End If
        
        If m_bClearPipingMaterialClassification = True Then
            objLMAItem.Attributes.BuildAttributesOnDemand = True
            Set objLMAAttr = objLMAItem.Attributes.Item(CONST_PipingMaterialsClass)
            If Not objLMAAttr Is Nothing Then
                If Not IsNull(objLMAAttr.Value) Then
                    'Clearing Out the Piping Material Class
                    objLMAAttr.Value = Null
                End If
            End If
        End If
        Set objLMAAttr = Nothing
        If m_bClearProcessData = True Then
            'pr 9-9-4 TR58936 Process data not getting cleared when other options are selected
            objLMAItem.Attributes.BuildAttributesOnDemand = False
            For Each objLMAAttr In objLMAItem.Attributes
                'Clearing Out all the Process Data
                If objLMAAttr.ISPAttribute.Attribution.Category = Const_ProcessCategory Then
                    'dont clear internal or nondisplayable values
                    If objLMAAttr.ISPAttribute.Attribution.Displayable = Const_spdisplayatt Then
                        If Not IsNull(objLMAAttr.Value) Then
                            objLMAAttr.Value = Null
                        End If
                    End If
                End If
            Next
        End If
    Next
        
Cleanup:
    If Err.Number <> 0 Then
        Err.Clear
    End If
    Set objLMAItem = Nothing
    Set objLMAAttr = Nothing
    
    Exit Function
    
ErrorHandler:
    LogError "TransFormationValidation - Validate::ILMForeignCalc_DoValidateItem --> " & Err.Description
    Resume Cleanup
End Function

Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, varValue As Variant) As Boolean

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, varValue As Variant)

End Sub

Private Sub ITransformUI_DoUI()
    'Show he Form
    Form1.Show vbModal
    
    'get the Form Values
    If Form1.Option1.Value = True Then
        m_bGenerateNewSequenceNumbers = True
    Else
        m_bGenerateNewSequenceNumbers = False
    End If
    If Form1.Option2.Value = True Then
        m_bAddStringTotheBegining = True
    Else
        m_bAddStringTotheBegining = False
    End If
    m_strAddstring = Form1.Text1.Text
    If Form1.Option3.Value = True Then
        m_bKeepExisting = True
    Else
        m_bKeepExisting = False
    End If
    If Form1.Check3.Value = 1 Then
        m_bClearPipingMaterialClassification = True
    Else
        m_bClearPipingMaterialClassification = False
    End If
    
    If Form1.Check4.Value = 1 Then
        m_bClearProcessData = True
    Else
        m_bClearProcessData = False
    End If
    Unload Form1
End Sub

Private Function ITransformUI_SupportsUI() As Boolean
    ITransformUI_SupportsUI = True
End Function
