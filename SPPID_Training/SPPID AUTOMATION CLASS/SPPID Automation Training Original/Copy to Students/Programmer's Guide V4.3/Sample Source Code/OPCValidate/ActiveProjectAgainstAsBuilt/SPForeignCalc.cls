VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SPForeignCalc"
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
'     SPForeignCalc.cls
'
'Author
'     Sai Chitta
'
'Abstract
'     Implements ILMForeignCalc
'
'Description
'     Validates and calculates OPC item tag values.
'
'Modifications:
'Date:      Changes:
'5/12/00    Added standard document header; removed obsolete code/comments -- dmw.
'7/10/00    Standardized error handling. -- dmw
'**************************************************************************

Option Explicit

Implements ILMForeignCalc

Private Const CONST_strOPCItemType As String = "OPC"                ' I18N OK
Private Const CONST_strItemTag As String = "OPCTag"                 ' I18N OK
Private Const CONST_strOPCItemTag As String = "OPCItemTag"          ' I18N OK
Private Const CONST_strName As String = "Name"                      ' I18N OK
Private Const CONST_strOptionSettings As String = "OptionSettings"  ' I18N OK
Private Const CONST_strSP_ID As String = "SP_ID"
Private Const CONST_strSP_pairedWithID As String = "SP_pairedWithID"

'Validation resource strings
Private m_strViolationOfUniqueItemTag As String
Private m_strDupTagInPlant As String
Private m_strDupTagInPlantOrProjects As String
Private m_strItemTagMsgCaption As String
Private m_strDuplicateItemTagError As String
Private m_strDuplicateErrorMsgCaption As String

Const CONST_lngViolationOfUniqueItemTag As Long = 2000
Const CONST_lngItemTagMsgCaption As Long = 2001
Const CONST_lngDuplicateItemTagError As Long = 2002
Const CONST_lngDuplicateErrorMsgCaption As Long = 2003
Const CONST_DoNotBelongToTheSameWorkshareSiteCaption As Long = 2005
Const CONST_ApplicationCaption As Long = 2004
Const CONST_WorkShareSiteID As String = "SP_WSSiteID"
Const CONST_lngOPCTagExistsInPlant As Long = 2006
Const CONST_lngOPCTagExistsInPlantOrProjects As Long = 2007

Private Enum eDuplicateTagCheckScope
    ActivePlant = 0                                 'this is the original check
    ActiveProjAgainstAsBuilt = 1                    'this means the local project and asbuilt
    ActiveProjAgainstAsBuiltAndProjs = 2            'this means asbuilt and all its projects
End Enum
Private m_DuplicateTagCheckScope As eDuplicateTagCheckScope

Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, valValue As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean
   
    ILMForeignCalc_DoValidateItem = SetOPCItemTag(DataSource, Items, Context)
    
End Function

Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, valValue As Variant) As Boolean
   
    ILMForeignCalc_DoValidateProperty = ValidateOPCItemTag(DataSource, Items, strPropertyName, valValue)
    
End Function

Private Function ValidateOPCItemTag(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, strPropertyName As String, valValue As Variant) As Boolean
    Dim colDupOpcTagIDs As Collection
    Dim objLMAItems As LMAItems
    Dim objLMAItem As LMAItem
    Dim objLMOPC As LMOPC
    Dim objPairedLMOPC As LMOPC
    Dim objLMAFilter As LMAFilter
    Dim objLMACriterion As LMACriterion
    Dim bDoValidation As Boolean
    Dim lStatus As Long
    Dim strOpcID As String
    Dim strOpcPairedWithID As String
    On Error GoTo ErrorHandler
    
    bDoValidation = True
    
    'm_DuplicateTagCheckScope = ActivePlant
    m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt
    'm_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs
    
    'If the workshare type is a satellite then only active plant checking is supported
    If DataSource.IsSatellite = True Then
        m_DuplicateTagCheckScope = ActivePlant
    End If
    
    m_strViolationOfUniqueItemTag = LoadResString(CONST_lngViolationOfUniqueItemTag)
    m_strItemTagMsgCaption = LoadResString(CONST_lngItemTagMsgCaption)
    m_strDuplicateItemTagError = LoadResString(CONST_lngDuplicateItemTagError)
    m_strDuplicateErrorMsgCaption = LoadResString(CONST_lngDuplicateErrorMsgCaption)
    m_strDupTagInPlant = LoadResString(CONST_lngOPCTagExistsInPlant)
    m_strDupTagInPlantOrProjects = LoadResString(CONST_lngOPCTagExistsInPlantOrProjects)
    
    ValidateOPCItemTag = True
    
    'If ItemTag value is set to its value itself then don't do any validations
    With Items
        If .Count = 1 Then
            If .Nth(1).Attributes(CONST_strItemTag).Value = valValue Then
                GoTo CleanUp
            End If
        ElseIf .Count > 1 Then
            If Len(valValue) > 0 Then
                'Item Tag cannot be same for more than one OPC.
                ValidateOPCItemTag = False
                MsgBox m_strDuplicateItemTagError, vbCritical, m_strDuplicateErrorMsgCaption
                GoTo CleanUp
            End If
        End If
    End With
    
    strOpcID = Items.Nth(1).Id
    strOpcPairedWithID = Items.Nth(1).Attributes(CONST_strSP_pairedWithID)
        
    If Len(valValue) > 0 Then
        'If Item Tag is set to some value then check for Uniqueness.
         If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
             lStatus = DataSource.GetDupOpcTagIDs("Global", strOpcID, strOpcPairedWithID, CStr(valValue), colDupOpcTagIDs)
             If colDupOpcTagIDs.Count > 0 Then
                 ValidateOPCItemTag = False
                 MsgBox m_strDupTagInPlantOrProjects, vbCritical, m_strItemTagMsgCaption
                 GoTo CleanUp
             End If
         Else
            Set objLMAFilter = New LMAFilter
            Set objLMACriterion = New LMACriterion
            
            With objLMACriterion
                .SourceAttributeName = strPropertyName
                .ValueAttribute = valValue
                .Operator = "="     ' I18N OK
            End With
                
            With objLMAFilter
                .ItemType = CONST_strOPCItemType
                .Criteria.Add objLMACriterion
            End With
            
            'Gets all OPCs where value of ItemTag is equal to Value
            Set objLMAItems = DataSource.Collect(CONST_strOPCItemType, , , objLMAFilter)
            
            With objLMAItems
                'If found an OPC with this Item Tag value then
                'prompt user with the message and return Validation Failure.
                If .Count > 0 Then
                    If Items.Count = 1 Then
                        If .Nth(1).Id <> Items.Nth(1).Id Then
                            ValidateOPCItemTag = False
                            MsgBox m_strViolationOfUniqueItemTag, vbCritical, m_strItemTagMsgCaption
                            GoTo CleanUp
                        End If
                    End If
                End If
            End With
            
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                lStatus = DataSource.GetDupOpcTagIDs("AsBuilt", strOpcID, strOpcPairedWithID, CStr(valValue), colDupOpcTagIDs)
                If colDupOpcTagIDs.Count > 0 Then
                     ValidateOPCItemTag = False
                     MsgBox m_strDupTagInPlant, vbCritical, m_strItemTagMsgCaption
                     GoTo CleanUp
                 End If
            End If
        End If
    End If
    
    'If no OPCs found with the Item Tag = Value or Item Tag is not set
    'then change the Item Tag of OPC pair to the new Value.
    'We need to Check if both the OPCS belong to the same workshare site.
    bDoValidation = True
    For Each objLMAItem In Items
        Set objLMOPC = DataSource.GetOPC(objLMAItem.Id)
        Set objPairedLMOPC = objLMOPC.pairedWithOPCObject
        If objLMOPC.Attributes.Item(CONST_WorkShareSiteID).Value & "" = DataSource.IPile.ActiveWorkShareSiteID & "" Then
            If objPairedLMOPC.Attributes.Item(CONST_WorkShareSiteID).Value & "" = DataSource.IPile.ActiveWorkShareSiteID & "" Then
                bDoValidation = True
            Else
                bDoValidation = False
            End If
        End If
    Next
    If bDoValidation = True Then
        For Each objLMAItem In Items
            Set objLMOPC = DataSource.GetOPC(objLMAItem.Id)
            
            With objLMOPC
    '            .pairedWithOPCObject.OPCTag = valValue
            
                .OPCTag = valValue
                .Commit
                
                Set objPairedLMOPC = .pairedWithOPCObject
                objPairedLMOPC.OPCTag = valValue        ' Fix for TR# PB37234 -SM (August 20, 2002)
                objPairedLMOPC.Commit
            
    '            Set objLMOPC = Nothing
                Set objPairedLMOPC = Nothing
            End With
        Next
    Else
        ValidateOPCItemTag = False
        MsgBox LoadResString(CONST_DoNotBelongToTheSameWorkshareSiteCaption), vbCritical, LoadResString(CONST_ApplicationCaption)
        GoTo CleanUp
    End If
CleanUp:
    Set objLMOPC = Nothing
    Set objPairedLMOPC = Nothing
    Set objLMAItem = Nothing
    Set objLMAItems = Nothing
    Set objLMAFilter = Nothing
    Set objLMACriterion = Nothing
    Set colDupOpcTagIDs = Nothing

    Exit Function
   
ErrorHandler:

    LogError "OPCValidate - SPForeignCalc::ValidateOPCItemTag --> " & Err.Description   ' I18N OK
    
    If Err Then
        ValidateOPCItemTag = False
        Err.Clear
    End If

End Function

Private Function SetOPCItemTag(DataSource As Llama.LMADataSource, _
   Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

    Dim objLMAItem As LMAItem
    Dim objLMAItems As LMAItems
    Dim objLMOPC As LMOPC
    Dim objPairedLMOPC As LMOPC
    Dim objLMOptionSettings As LMOptionSettings
    Dim objLMOptionSetting As LMOptionSetting
    Dim objLMAFilter As LMAFilter
    Dim objLMACriterion As LMACriterion
    Dim bFoundNextTag As Boolean
    Dim bCommitFailed As Boolean
    Dim varTagSeqNo As Variant
    Dim varPrevUpdCount As Variant
    Dim bGenerateTag As Boolean
    
    On Error GoTo ErrorHandler
    
    Set objLMOptionSettings = New LMOptionSettings
    
    For Each objLMAItem In Items
        objLMAItem.Attributes.BuildAttributesOnDemand = True
        
        bGenerateTag = False
        If Context = LMAValidateCopy Then
            'itemtag validation gets called for both opc and it's mate during copy and assembly placement.
            'so set the same opctag on both while processing one of these 2 opcs.
            'logic used here is to compare the SPIDs of both opcs
            'and only perform itemtag generation when processing the OPC with lesser SPID.
            Set objLMOPC = DataSource.GetOPC(objLMAItem.Id)
            Set objPairedLMOPC = objLMOPC.pairedWithOPCObject
            If objLMOPC.Id < objPairedLMOPC.Id Then
                bGenerateTag = True
            End If
            
        ElseIf Context = LMAValidateCreate And IsNull(objLMAItem.Attributes(CONST_strItemTag).Value) Then
            bGenerateTag = True
            Set objLMOPC = DataSource.GetOPC(objLMAItem.Id)
            Set objPairedLMOPC = objLMOPC.pairedWithOPCObject
        End If
        
        If bGenerateTag Then
            objLMOPC.Attributes.BuildAttributesOnDemand = True
            objPairedLMOPC.Attributes.BuildAttributesOnDemand = True
            
            Do
                'Get the ItemTag number from OptionSetting Table through LAMA automation.
                Set objLMAFilter = New LMAFilter
                Set objLMACriterion = New LMACriterion
                
                With objLMACriterion
                    .SourceAttributeName = CONST_strName   'Name
                    .ValueAttribute = CONST_strOPCItemTag  'OPCItemTag
                    .Operator = "=" ' I18N OK
                End With
                    
                With objLMAFilter
                    .ItemType = CONST_strOptionSettings
                    .Criteria.Add objLMACriterion
                End With
            
                With objLMOptionSettings
                
                    .Collect DataSource, , , objLMAFilter
                
                    Set objLMOptionSetting = .Nth(1)
                    
                    With objLMOptionSetting
                        varTagSeqNo = .Value
                        'varPrevUpdCount is set to present UpdateCount
                        varPrevUpdCount = .UpdateCount
                    End With
                    
                End With
                
                'If TagSeqNo from OptionManager is a numeric value then
                If CLng(varTagSeqNo) Then
                    Do
                        Set objLMAFilter = Nothing
                        Set objLMACriterion = Nothing
                        
                        'Check whether any of the OPCs has the same Item Tag as TagSeqNo.
                        Set objLMAFilter = New LMAFilter
                        Set objLMACriterion = New LMACriterion
                        
                        With objLMACriterion
                            .SourceAttributeName = CONST_strItemTag 'ItemTag
                            .ValueAttribute = varTagSeqNo
                            .Operator = "=" ' I18N OK
                        End With
                            
                        With objLMAFilter
                            .ItemType = CONST_strOPCItemType   'OPC
                            .Criteria.Add objLMACriterion
                        End With
                    
                        Set objLMAItems = DataSource.Collect(CONST_strOPCItemType, , , objLMAFilter)
                        
                        'If one of the OPCs has the Item Tag as TagSeqNo, then increment
                        'the TagSeqNo by 1 and then repeat the search for OPCs with same
                        'Item Tag as that of next TagSeqNo.
                        If objLMAItems.Count > 0 Then
                            bFoundNextTag = False
                            varTagSeqNo = varTagSeqNo + 1
                        'If no OPC has the Item Tag same as that of TagSeqNo , then assign
                        'this TagSeqNo to the Newly Created OPC and it's mate.
                        Else
                            bFoundNextTag = True
                        End If
                        
                    Loop While (bFoundNextTag = False)
                    
                    'Increment the TagSeqNo as the Next available TagSeqNo.
                    With objLMOptionSetting
                        .Value = CLng(varTagSeqNo) + 1
                        .Commit
                    End With
                    'If the UpdateCount is same before and after commit then
                    'it means commit has failed.
                    If varPrevUpdCount = objLMOptionSetting.UpdateCount Then
                        bCommitFailed = True
                    Else
                        bCommitFailed = False
                    End If
                End If
            Loop While (bCommitFailed = True) 'Do till commit succeeds.
            
            'Set the same Item Tag to both the Items
            With objLMOPC
                .OPCTag = varTagSeqNo
                .Commit
            End With
            
            With objPairedLMOPC
                .OPCTag = varTagSeqNo
                .Commit
            End With
            
        End If
    Next
    
    SetOPCItemTag = True
    
CleanUp:
    Set objLMOptionSetting = Nothing
    Set objLMACriterion = Nothing
    Set objLMAFilter = Nothing
    Set objLMOPC = Nothing
    Set objPairedLMOPC = Nothing
    Set objLMOptionSetting = Nothing
    Set objLMOptionSettings = Nothing
    
    Exit Function
        
ErrorHandler:
    If Err Then
        LogError "OPCValidate - SPForeignCalc::SetOPCItemTag --> " & Err.Description    ' I18N OK
        Err.Clear
    End If
    
End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant)

End Sub
