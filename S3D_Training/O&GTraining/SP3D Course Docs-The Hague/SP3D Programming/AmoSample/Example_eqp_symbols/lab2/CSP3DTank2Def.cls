VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CSP3DTank2Def"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SP3DEqpUSSClassType" ,"CAD"
Attribute VB_Ext_KEY = "SP3DEqpCADTemplateVersion" ,"1.3"
Attribute VB_Ext_KEY = "SP3DV6UpgradeSO" ,"Upgraded by Eqp SO Upgrade Wizard at 7/26/2005-9:30:43 PM"
'******************************************************************************
' Copyright (C) 2005, Intergraph Corporation. All rights reserved.
'
'File
'   CSP3DSimpleSymboDef.cls
'
'Author
'       Ramon Him
'
'Description
'       Defines the behavior of members of an Equipment that make a custom assembly
'       When a symbol is used with the smart occurrence that contain rigid geometry,
'       This class usually, but is not limited to, manages the nozzles of the equipment.
'
'******************************************************************************
Option Explicit

Private Const MODULE = "SP3DTank2Asm:CSP3DTank2Def"

Private Const IID_IJDATTRIBUTES = "{B25FD387-CFEB-11D1-850B-080036DE8E03}"
Private Const IID_IJDGEOMETRY = "{A1732CBF-5136-11D1-9770-080036754203}"

Private m_oEquipCADHelper As IJEquipCADHelper
Private m_oEditErrors As IJEditErrors

' Implement User Symbol Services(USS)
Implements IJDUserSymbolServices
Implements IJEquipUserAttrMgmt

Private Sub Class_Initialize()
    Set m_oEquipCADHelper = New CADServices
    Set m_oEditErrors = New JServerErrors
    
    m_oEquipCADHelper.ProjectName = "SP3DTank2Asm"
    m_oEquipCADHelper.ClassName = "CSP3DTank2Def"
    m_oEquipCADHelper.OccurrenceRootClass = orcEquipment
    
       
    
    'Add your code here for the declaration of the Public Custom Methods used to manage new members
    'Add new member(NozzleN1) to the definition
    
    
       
    
    
End Sub

Private Sub Class_Terminate()
    Set m_oEditErrors = Nothing
    Set m_oEquipCADHelper = Nothing
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Implementation of IJDUserSymbolServices
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function IJDUserSymbolServices_GetDefinitionName(ByVal definitionParameters As Variant) As String

    ' Progid should be unique
    IJDUserSymbolServices_GetDefinitionName = m_oEquipCADHelper.ProjectName & "." & m_oEquipCADHelper.ClassName
    
End Function

Private Function IJDUserSymbolServices_InstanciateDefinition(ByVal CodeBase As String, _
                                                             ByVal defParams As Variant, _
                                                             ByVal pResourceMgr As Object) As Object
    Const METHOD = "IJDUserSymbolServices_InstanciateDefinition"
    On Error GoTo ErrorHandler
    Dim oSymbolDefinition As IJDSymbolDefinition
    
    Set oSymbolDefinition = m_oEquipCADHelper.InstanciateDefinition(CodeBase, defParams, pResourceMgr)
    IJDUserSymbolServices_InitializeSymbolDefinition oSymbolDefinition
    Set IJDUserSymbolServices_InstanciateDefinition = oSymbolDefinition
    Exit Function
ErrorHandler:
    HandleError MODULE, METHOD
End Function

Private Sub IJDUserSymbolServices_InitializeSymbolDefinition(oSymbolDefinition As IMSSymbolEntities.IJDSymbolDefinition)
    Const METHOD = "IJDUserSymbolServices_InitializeSymbolDefinition"
    On Error GoTo ErrorHandler
    
    Dim oPropertyDescriptions As IJDPropertyDescriptions
    Dim oMemberDescriptions As IJDMemberDescriptions
    Dim oMemberDescription As IJDMemberDescription
    Dim oAggregatorDescription As IJDAggregatorDescription
    
    'Set up the aggregator
    Set oAggregatorDescription = oSymbolDefinition
    oAggregatorDescription.AggregatorClsid = m_oEquipCADHelper.OccurrenceRootClassGUID()
    oAggregatorDescription.SetCMConstruct imsCOOKIE_ID_USS_LIB, "CMConstructEquipment"
    oAggregatorDescription.SetCMFinalConstruct imsCOOKIE_ID_USS_LIB, "CMFinalConstructEquipment"
    oAggregatorDescription.SetCMSetInputs imsCOOKIE_ID_USS_LIB, "CMSetInputsEquipment"
    oAggregatorDescription.SetCMRemoveInputs imsCOOKIE_ID_USS_LIB, "CMRemoveInputsEquipment"
    
    'Add property to aggregator
    Set oPropertyDescriptions = oAggregatorDescription
    oPropertyDescriptions.RemoveAll
    oPropertyDescriptions.AddProperty "EquipmentProperties", 1, IID_IJDATTRIBUTES, "CMEvaluateEquipment", imsCOOKIE_ID_USS_LIB
    
    'Remove all the previous member descriptions
    Set oMemberDescriptions = oSymbolDefinition
    oMemberDescriptions.RemoveAll
    
'==========================================================================================================
    'Add your code here for the declaration of the Public Custom Methods used to manage new members
    
    Set oMemberDescription = Nothing
    Set oMemberDescription = oMemberDescriptions.AddMember("NozzleN1", 1, _
    "CMConstructNozzleN1", imsCOOKIE_ID_USS_LIB)
    oMemberDescription.SetCMSetInputs imsCOOKIE_ID_USS_LIB, "CMSetInputsNozzleN1"
    oMemberDescription.SetCMFinalConstruct imsCOOKIE_ID_USS_LIB, "CMFinalConstructNozzleN1"
    oMemberDescription.SetCMConditional imsCOOKIE_ID_USS_LIB, "CMConditionalNozzleN1"
    oMemberDescription.SetCMCount imsCOOKIE_ID_USS_LIB, "CMCountNozzleN1"
    oMemberDescription.SetCMRelease imsCOOKIE_ID_USS_LIB, "CMReleaseNozzleN1"
    
    'Add properties for (NozzleN1)
    Set oPropertyDescriptions = Nothing
    Set oPropertyDescriptions = oMemberDescription
    oPropertyDescriptions.AddProperty "NozzleN1Properties", 1, _
    IID_IJDATTRIBUTES, "CMEvaluateNozzleN1", imsCOOKIE_ID_USS_LIB
    oPropertyDescriptions.AddProperty "NozzleN1GeometryProperties", 2, _
    IID_IJDGEOMETRY, "CMEvaluateGeometryNozzleN1", imsCOOKIE_ID_USS_LIB
 
'==========================================================================================================
' Release Bo

    Set oAggregatorDescription = Nothing
    Set oMemberDescriptions = Nothing
    Set oMemberDescription = Nothing
    Set oPropertyDescriptions = Nothing
     
    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Private Sub IJDUserSymbolServices_InvokeRepresentation(ByVal pSymbolOccurrence As Object, ByVal pRepName As String, ByVal pOutputColl As Object, arrayOfInputs() As Variant)
    
    'This method is not used by the CAD.

End Sub

Private Function IJDUserSymbolServices_EditOccurence(pSymbolOccurrence As Object, ByVal pTransactionMgr As Object) As Boolean
    
    'Obsolete method. Instead you can record your custom command within the definition (see IJDCommandDescription interface)
    IJDUserSymbolServices_EditOccurence = False

End Function


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Implementation of IJEquipUserAttrMgmt
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function IJEquipUserAttrMgmt_OnAttributeChange(ByVal pIJDAttrs As IJDAttributes, ByVal CollAllDisplayedValues As Object, ByVal pAttrToChange As IJEquipAttrDescriptor, ByVal varNewAttrValue As Variant) As String
    Const METHOD = "IJEquipUserAttrMgmt_OnAttributeChange"
    On Error GoTo ErrorHandler
            
' Add code here

    Dim oMemberDescription As IJDMemberDescription
    Set oMemberDescription = m_oEquipCADHelper.GetMemberDescriptionFromChild(pIJDAttrs)
    Select Case oMemberDescription.Name
        Case "NozzleN1"
            Select Case UCase(pAttrToChange.InterfaceName)
                Case "IJDELETABLEMEMBER"
                    If UCase(pAttrToChange.AttrName) = "CANBEDELETED" Then
                        m_oEquipCADHelper.MakeMemberDeletable oMemberDescription, pIJDAttrs, _
                        CBool(varNewAttrValue)
                    End If
                Case Else
'
            End Select
        Case Else
'
    End Select
    
    IJEquipUserAttrMgmt_OnAttributeChange = ""
    
    Exit Function
ErrorHandler:
    IJEquipUserAttrMgmt_OnAttributeChange = "ERROR"
    HandleError MODULE, METHOD
End Function

Private Function IJEquipUserAttrMgmt_OnPreCommit(ByVal pIJDAttrs As IJDAttributes, ByVal CollAllDisplayedValues As Object) As String
    Const METHOD = "IJEquipUserAttrMgmt_OnPreCommit"
    On Error GoTo ErrorHandler
    
' Add code here
        
    IJEquipUserAttrMgmt_OnPreCommit = ""
    Exit Function
ErrorHandler:
    IJEquipUserAttrMgmt_OnPreCommit = "ERROR"
    HandleError MODULE, METHOD
End Function

Private Function IJEquipUserAttrMgmt_OnPreLoad(ByVal pIJDAttrs As IJDAttributes, ByVal CollAllDisplayedValues As Object) As String
    Const METHOD = "IJEquipUserAttrMgmt_OnPreLoad"
    On Error GoTo ErrorHandler
    
    Dim oMemberDescription As IJDMemberDescription
    Set oMemberDescription = m_oEquipCADHelper.GetMemberDescriptionFromChild(pIJDAttrs)
        
    Set oMemberDescription = Nothing
    
    IJEquipUserAttrMgmt_OnPreLoad = ""
    Exit Function
ErrorHandler:
    IJEquipUserAttrMgmt_OnPreLoad = "ERROR"
    HandleError MODULE, METHOD
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Custom Methods of Equipment (Aggregator)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Sub CMConstructEquipment(ByVal pAggregatorDescription As IJDAggregatorDescription)
    Const METHOD = "CMConstructEquipment"
    On Error GoTo ErrorHandler
    
    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMFinalConstructEquipment(ByVal pAggregatorDescription As IJDAggregatorDescription)
    Const METHOD = "CMFinalConstructEquipment"
    On Error GoTo ErrorHandler
    
    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMSetInputsEquipment(ByVal pAggregatorDescription As IJDAggregatorDescription)
    Const METHOD = "CMSetInputsEquipment"
    On Error GoTo ErrorHandler
    
    m_oEquipCADHelper.SetSmartItemAsInputToSymbol pAggregatorDescription
    
    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMRemoveInputsEquipment(ByVal pAggregatorDescription As IJDAggregatorDescription)
    Const METHOD = "CMRemoveInputsEquipment"
    On Error GoTo ErrorHandler

    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMEvaluateEquipment(ByVal oPropertyDescription As IJDPropertyDescription, pObject As Object)
    Const METHOD = "CMEvaluateEquipment"
    On Error GoTo ErrorHandler

    Exit Sub
ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Private Sub HandleError(sModule As String, sMethod As String)
    
    If Not m_oEditErrors Is Nothing Then
        m_oEditErrors.AddFromErr Err, "", sMethod, sModule
    End If
    
    Err.Raise Err.Number, Err.Source & " " & sMethod, Err.Description, _
              Err.HelpFile, Err.HelpContext
End Sub

' Custom Methods for NozzleN1
Public Sub CMConstructNozzleN1(ByVal pMemberDescription As IJDMemberDescription, ByVal pResourceManager As IUnknown, ByRef pObject As Object)

    Const METHOD = "CMConstructNozzleN1"
    On Error GoTo ErrorHandler

'Create Nozzle
    m_oEquipCADHelper.CreateNozzleFromPH pMemberDescription, pResourceManager, pObject, 1
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMFinalConstructNozzleN1(ByVal pMemberDesc As IJDMemberDescription)

    Const METHOD = "CMFinalConstructNozzleN1"
    On Error GoTo ErrorHandler
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMSetInputsNozzleN1(ByVal pMemberDesc As IJDMemberDescription)
    
    Const METHOD = "CMSetInputsNozzleN1"
    On Error GoTo ErrorHandler
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMEvaluateNozzleN1(ByVal oPropertyDescription As IJDPropertyDescription, pObject As Object)
    
    Const METHOD = "CMEvaluateNozzleN1"
    On Error GoTo ErrorHandler
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMEvaluateGeometryNozzleN1(ByVal oPropertyDescription As IJDPropertyDescription, pObject As Object)

    Const METHOD = "CMEvaluateGeometryNozzleN1"
    On Error GoTo ErrorHandler

    'Transform the nozzle so that it behaves like a rigid body inside the equipment
    m_oEquipCADHelper.TransformNozzleWrtPH oPropertyDescription, pObject, 1
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMConditionalNozzleN1(ByVal pMemberDesc As IJDMemberDescription, ByRef IsNeeded As Boolean)

    Const METHOD = "CMConditionalNozzleN1"
    On Error GoTo ErrorHandler
    
    IsNeeded = m_oEquipCADHelper.CheckMemberConditional(pMemberDesc)
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMCountNozzleN1(ByVal pMemberDesc As IJDMemberDescription, ByRef Count As Long)

    Const METHOD = "CMCountNozzleN1"
    On Error GoTo ErrorHandler
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub

Public Sub CMReleaseNozzleN1(ByVal pMemberDesc As IJDMemberDescription)
    
    Const METHOD = "CMReleaseNozzleN1"
    On Error GoTo ErrorHandler
    Exit Sub

ErrorHandler:
    HandleError MODULE, METHOD
End Sub




