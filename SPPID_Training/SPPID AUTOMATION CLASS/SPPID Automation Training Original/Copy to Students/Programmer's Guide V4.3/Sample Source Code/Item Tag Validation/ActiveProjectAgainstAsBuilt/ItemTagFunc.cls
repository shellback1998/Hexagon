VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ItemTagFunc"
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
'     ItemTagFunc.Cls
'
'Author
'     Raghu Veeramreddy
'
'Abstract
'     Implements ILMForeignCalc class.
'
'Description
'     Validates and calculates item tags.
'
'Modifications:
'Date:          Changes:
'5/10/00        Added standard document header; removed obsolete code -- dmw.
'6/26/00        Added error handling -- dmw
'*************************************************************************

Option Explicit

'do not change the values for these constants
Const CONST_EquipmentPlantItemIndex As Integer = 16
Const CONST_InstrumentPlantItemIndex As Integer = 5
Const CONST_InstrumentPlantItemIndex1 As Integer = 41
Const CONST_NozzlePlantItemIndex As Integer = 21
Const CONST_PipeRunPlantItemIndex As Integer = 4
Const CONST_InstrLoopPlantItemIndex As Integer = 46
Const CONST_EquipmentCompItemIndex As Integer = 6
Const CONST_PipingCompItemIndex As Integer = 35
Const CONST_FalseIndex As Integer = 1
Const CONST_TrueIndex As Integer = 2
Const CONST_EquipmentItemName As String = "Equipment"                                   'I18_OK
Const CONST_InstrumentItemName As String = "Instrument"                                 'I18_OK
Const CONST_NozzleItemName As String = "Nozzle"                                         'I18_OK
Const CONST_PipeRunItemName As String = "PipeRun"                                       'I18_OK
Const CONST_InstrLoopItemName As String = "InstrLoop"                                   'I18_OK
Const CONST_PlantItemTypeAttributeName As String = "PlantItemType"                      'I18_OK
Const CONST_ItemTagAttributeName As String = "ItemTag"                                  'I18_OK
Const CONST_TagSequenceNoAttributeName As String = "TagSequenceNo"                      'I18_OK
Const CONST_TagSuffixAttributeName As String = "TagSuffix"                              'I18_OK
Const CONST_TagPrefixAttributeName As String = "TagPrefix"                              'I18_OK
Const CONST_MeasuredVariableCodeAttributeName As String = "MeasuredVariableCode"        'I18_OK
Const CONST_InstrumentTypeModifierAttributeName As String = "InstrumentTypeModifier"    'I18_OK
Const CONST_LoopTagSuffixAttributeName As String = "LoopTagSuffix"                      'I18_OK
Const CONST_OptionSettingAttributeName As String = "OptionSetting"                      'I18_OK
Const CONST_NameAttributeName As String = "Name"                                        'I18_OK
Const CONST_EquipNextSeqNoAttributeName As String = "EquipNextSeqNo"                    'I18_OK
Const CONST_PipeRunNextSeqNoAttributeName As String = "PipeRunNextSeqNo"                'I18_OK
Const CONST_InstrLoopNextSeqNoAttributeName As String = "InstrLoopNextSeqNo"            'I18_OK
Const CONST_OperFluidCodeAttributeName As String = "OperFluidCode"                      'I18_OK
Const CONST_PartofPlantItem_SP_IDAttributeName As String = "PartofPlantItem.SP_ID"      'I18_OK
Const CONST_ClassAttributeName = "Class"                                                'I18_OK
Const CONST_LoopFunctionAttributeName = "LoopFunction"                                  'I18_OK
Const CONST_SP_EquipmentIDAttributeName = "SP_EquipmentID"                              'I18_OK
Const CONST_ItemStatus As String = "ItemStatus"
Const Const_ItemStatusValue As String = "1"
Const Const_SignalRunItemName As String = "SignalRun"
Const CONST_PartOfIDAttributeName = "SP_PartOfID"
Const CONST_IsBulkItemAttributeName = "IsBulkItem"
Const CONST_SP_IDAttributeName = "SP_ID"

Private m_isUIEnabled As Boolean
Private m_lngID As String
Private m_NozzleSeqNo As Long
Private m_PrevNozzleEqID As String
Private m_objLMNozzles As LMNozzles
Private m_DuplicateTagCheckScope As eDuplicateTagCheckScope

Private Enum eDuplicateTagCheckScope
    ActivePlant = 0                                 'this is the original check
    ActiveProjAgainstAsBuilt = 1                    'this means the local project and asbuilt
    ActiveProjAgainstAsBuiltAndProjs = 2            'this means asbuilt and all its projects
End Enum

Implements ILMForeignCalc

'
Private Function GetChildNozzles(objLMPlantItem As LMPlantItem) As LMAItems
    Dim objChildPlantItem As LMPlantItem
    Dim objChildPlantItems As LMPlantItems
    Dim objLMNozzle As LMNozzle
    
    Set objChildPlantItems = objLMPlantItem.ChildPlantItemPlantItems
    
    For Each objChildPlantItem In objChildPlantItems
        objChildPlantItem.Attributes.BuildAttributesOnDemand = True
        
        If (objChildPlantItem.ItemTypeName = CONST_NozzleItemName) Then
            
            Set objLMNozzle = objChildPlantItem.Datasource.GetNozzle(CStr(objChildPlantItem.Id))
            m_objLMNozzles.Add objLMNozzle.AsLMAItem
        Else
            Call GetChildNozzles(objChildPlantItem)
        End If
    Next
    
    Set objChildPlantItem = Nothing
    Set objChildPlantItems = Nothing
    Set objLMNozzle = Nothing
End Function

Private Sub Class_Initialize()
    Set m_objLMNozzles = Nothing
    'Default checks only the active plant
    m_DuplicateTagCheckScope = ActivePlant
End Sub

Private Sub Class_Terminate()
    Set m_objLMNozzles = Nothing
End Sub


Private Function ILMForeignCalc_DoCalculate(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateProperty(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant) As Boolean
   
        m_isUIEnabled = True
        ILMForeignCalc_DoValidateProperty = UpdateItemTag(Datasource, Items, varValue, strPropertyName)

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   strPropertyName As String, varValue As Variant)

    m_isUIEnabled = False
    UpdateItemTag Datasource, Items, varValue, strPropertyName

End Sub

Private Function UpdateItemTag(Datasource As Llama.LMADataSource, Items As Llama.LMAItems, _
   varValue As Variant, strPropertyName As String) As Boolean

    Dim objLMAItem As LMAItem
    Dim BNotAnyCase As Boolean
    
    On Error GoTo ErrorHandler
    
    'm_DuplicateTagCheckScope = ActivePlant
     m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt
    'm_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs
    
    'If the workshare type is a satellite then only active plant checking is supported
    If Datasource.IsSatellite = True Then
        m_DuplicateTagCheckScope = ActivePlant
    End If
    
    BNotAnyCase = True
    For Each objLMAItem In Items
        objLMAItem.Attributes.BuildAttributesOnDemand = True
        
        Select Case objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index

            Case CONST_PipeRunPlantItemIndex ' 4
                'Update the PipeRun ItemTag
                UpdateItemTag = UpdatePipeRunTag(Datasource, Datasource.GetPipeRun(objLMAItem.Id), _
                   varValue, strPropertyName)
            Case CONST_InstrumentPlantItemIndex, CONST_InstrumentPlantItemIndex1
                'Update the Instrument ItemTag
                objLMAItem.Attributes.BuildAttributesOnDemand = True
                If objLMAItem.Attributes.Item("ItemTypeName").value = "Instrument" Then
                    UpdateItemTag = UpdateInstrTag(Datasource, Datasource.GetInstrument(objLMAItem.Id), _
                    varValue, strPropertyName)
                ElseIf objLMAItem.Attributes.Item("ItemTypeName").value = "SignalRun" Then
                    UpdateItemTag = UpdateSignalRunTag(Datasource, Datasource.GetSignalRun(objLMAItem.Id), _
                    varValue, strPropertyName)
                End If
            Case CONST_EquipmentPlantItemIndex
                'Update the Equipment ItemTag
                If objLMAItem.Attributes(CONST_ClassAttributeName).Index = CONST_EquipmentCompItemIndex Then
                    UpdateItemTag = True
                    BNotAnyCase = False
                Else
                    UpdateItemTag = UpdateEquipTag(Datasource, Datasource.GetEquipment(objLMAItem.Id), _
                       varValue, strPropertyName)
                End If
            Case CONST_NozzlePlantItemIndex
                'Updates the Nozzle ItemTag
                UpdateItemTag = UpdateNozzleTag(Datasource, Datasource.GetNozzle(objLMAItem.Id), varValue, _
                   strPropertyName)
                  BNotAnyCase = True
            Case CONST_InstrLoopPlantItemIndex
                If objLMAItem.Attributes("PlantItemGroupType").Index = 6 Then
                    UpdateItemTag = UpdateLoopTag(Datasource, Datasource.GetInstrLoop(objLMAItem.Id), _
                       varValue, strPropertyName)
                Else
                    UpdateItemTag = True
                End If
            Case CONST_PipingCompItemIndex
                'Update the PipingComponent ItemTag
                UpdateItemTag = True
                BNotAnyCase = False
            Case Else
                UpdateItemTag = True
        End Select
        
        'safety -- do not remove
        If BNotAnyCase = True Then
            If strPropertyName = CONST_TagSequenceNoAttributeName And Items.Count < 2 Then
        
                If Not IsNull(objLMAItem.Attributes(CONST_TagSequenceNoAttributeName).value) And _
                objLMAItem.Attributes(CONST_PlantItemTypeAttributeName).Index <> CONST_EquipmentCompItemIndex Then
              
                    varValue = objLMAItem.Attributes(CONST_TagSequenceNoAttributeName).value
                
                End If
            
            End If
        End If
    Next
    
        'This is something We have to look into
        If BNotAnyCase = True Then
            If Items.Count > 1 And strPropertyName <> CONST_OperFluidCodeAttributeName Then
                UpdateItemTag = False
                Exit Function
            ElseIf Items.Count > 1 And strPropertyName = CONST_OperFluidCodeAttributeName Then
                UpdateItemTag = True
            ElseIf Items.Count = 1 Then
                UpdateItemTag = UpdateItemTag
            End If
        Else
            UpdateItemTag = True
        End If
    
    Exit Function

ErrorHandler:
    
    LogError "ItemTag - ItemTagFunc::UpdateItemTag --> " & Err.Description
    If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
        LogError "ItemTag - ItemTagFunc::UpdateItemTag --> Duplicate Tag Scope: Active Project Against AsBuilt"
    ElseIf m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
        LogError "ItemTag - ItemTagFunc::UpdateItemTag --> Duplicate Tag Scope: Active Project Against AsBuilt and its projects"
    Else
        LogError "ItemTag - ItemTagFunc::UpdateItemTag --> Duplicate Tag Scope: Active Project or Plant"
    End If
    
End Function

Private Function UpdateInstrTag(Datasource As LMADataSource, Item As Llama.LMInstrument, _
   varValue As Variant, strPropertyName As String) As Boolean
        
    Dim bUniqueStatus As Boolean
    Dim colTagValues As Collection
    Dim objFilter As LMAFilter
    Dim strDupMessage As String
    Dim strItemTag As String
    Dim strLocTagSeqNo As String
    Dim intResponse As Integer
    
    On Error Resume Next
    
    Item.Attributes.BuildAttributesOnDemand = True
    strDupMessage = ""
    
    'Use the collections unique index feature to avoid a bunch of if statements to
    'determine what property was passed in
    Set colTagValues = New Collection
    
    With colTagValues
    
        .Add Trim$(VariantToString(varValue)), strPropertyName

        Select Case strPropertyName

            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.MeasuredVariableCode)), CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.InstrumentTypeModifier)), CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName

            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.MeasuredVariableCode)), CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.InstrumentTypeModifier)), CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName

            Case CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.InstrumentTypeModifier)), CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName

            Case CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.MeasuredVariableCode)), CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.InstrumentTypeModifier)), CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName

            Case CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.MeasuredVariableCode)), CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName

            Case Else
                .Add Trim$(VariantToString(Item.MeasuredVariableCode)), CONST_MeasuredVariableCodeAttributeName
                .Add Trim$(VariantToString(Item.LoopTagSuffix)), CONST_LoopTagSuffixAttributeName
                .Add Trim$(VariantToString(Item.InstrumentTypeModifier)), CONST_InstrumentTypeModifierAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
        End Select
    
    End With
    
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    
    'strItemTag = colTagValues(CONST_MeasuredVariableCodeAttributeName) & _
       colTagValues(CONST_InstrumentTypeModifierAttributeName) & "-" & _
       strLocTagSeqNo & colTagValues(CONST_LoopTagSuffixAttributeName) & _
       colTagValues(CONST_TagSuffixAttributeName)
    
    strItemTag = BuildInstrumentTag(colTagValues(CONST_MeasuredVariableCodeAttributeName), _
                                    colTagValues(CONST_InstrumentTypeModifierAttributeName), _
                                    strLocTagSeqNo, colTagValues(CONST_LoopTagSuffixAttributeName), _
                                    colTagValues(CONST_TagSuffixAttributeName))
       
    UpdateInstrTag = True
    bUniqueStatus = True
    strDupMessage = LoadResString(5002)
    
    If Len(strLocTagSeqNo) > 0 And m_isUIEnabled = True Then
        'Forming a filter
        If (m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs) Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Instrument " & LoadResString(5011)  'AsBuilt plant or its projects
            'Get a filter to use for the V_GlobalTagList view  (this is not a table)
              If Item.IsBulkItemIndex = CONST_TrueIndex Then
                   Set objFilter = GetFilter(CONST_InstrumentItemName, CONST_ItemTagAttributeName, _
                      strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex1, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
              Else
                   Set objFilter = GetFilter(CONST_InstrumentItemName, CONST_ItemTagAttributeName, _
                      strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex1)
              End If
               
            'CheckForGlobalUnique
            bUniqueStatus = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
        Else
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Instrument " & LoadResString(5010) 'Active Project
            Else
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Instrument " & LoadResString(5007) 'Active Plant
            End If
            Set objFilter = GetFilter(CONST_InstrumentItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
        
            'Checking if the itemtag is unique in this project
            bUniqueStatus = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
            If bUniqueStatus = True Then
                If (m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt) Then
                    strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Instrument " & LoadResString(5008) 'AsBuilt Plant
                    Set objFilter = Nothing
                    If Item.IsBulkItemIndex = CONST_TrueIndex Then
                        Set objFilter = GetFilter(CONST_InstrumentItemName, CONST_ItemTagAttributeName, _
                              strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex1, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                    Else
                       Set objFilter = GetFilter(CONST_InstrumentItemName, CONST_ItemTagAttributeName, _
                              strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex1)
                    End If
                    'CheckForAsBuiltUnique
                     bUniqueStatus = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                End If
            End If
        End If
    End If
    
    If bUniqueStatus = False Then
        If Item.Id <> m_lngID Then
            m_lngID = Item.Id
            intResponse = MsgBox(strDupMessage, vbOKOnly + vbExclamation, LoadResString(5001))
        End If
                
        UpdateInstrTag = False
    End If

    'Update the values
    With Item
        
        If Len(strLocTagSeqNo) > 0 Or strPropertyName = CONST_TagSequenceNoAttributeName Then
            .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
        End If
        
        If strLocTagSeqNo = "" Then
            '.ItemTag = ""
            .ItemTag = Null
        Else
            If Len(colTagValues(CONST_MeasuredVariableCodeAttributeName)) > 0 Then
                .MeasuredVariableCode = colTagValues(CONST_MeasuredVariableCodeAttributeName)
            End If
            
            If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                .TagSuffix = colTagValues(CONST_TagSuffixAttributeName)
            End If
            
            If Len(colTagValues(CONST_LoopTagSuffixAttributeName)) > 0 Then
                .LoopTagSuffix = colTagValues(CONST_LoopTagSuffixAttributeName)
            End If
            
            If Len(colTagValues(CONST_InstrumentTypeModifierAttributeName)) > 0 Then
                .InstrumentTypeModifier = colTagValues(CONST_InstrumentTypeModifierAttributeName)
            End If
            
            If Len(strItemTag) > 0 Then
                .ItemTag = strItemTag
            End If
            
        End If
        
        If strLocTagSeqNo = "" Then
        
            If strPropertyName = CONST_InstrumentTypeModifierAttributeName Then
                If Len(colTagValues(CONST_InstrumentTypeModifierAttributeName)) > 0 Then
                    .InstrumentTypeModifier = colTagValues(CONST_InstrumentTypeModifierAttributeName)
                End If
            ElseIf strPropertyName = CONST_MeasuredVariableCodeAttributeName Then
                If Len(colTagValues(CONST_InstrumentTypeModifierAttributeName)) > 0 Then
                    .InstrumentTypeModifier = colTagValues(CONST_InstrumentTypeModifierAttributeName)
                End If
                If Len(colTagValues(CONST_MeasuredVariableCodeAttributeName)) > 0 Then
                    .Attributes.Item(CONST_MeasuredVariableCodeAttributeName).value = colTagValues(CONST_MeasuredVariableCodeAttributeName)
                End If
            End If
            If strPropertyName = CONST_TagSuffixAttributeName Then
                If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                    .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues(CONST_TagSuffixAttributeName)
                End If
            End If
        End If
        
        If Not IsNull(varValue) Then
            'trim off any spaces in the input value
            varValue = Trim$(varValue)
        End If
            
        .Commit
    
    End With
    
    Err.Clear

End Function

Private Function UpdatePipeRunTag(Datasource As LMADataSource, Item As Llama.LMPipeRun, _
   varValue As Variant, strPropertyName As String) As Boolean
   
    Dim colTagValues As Collection
    Dim objPlantGroups As LMPlantGroups
    Dim objPlantGroup As LMPlantGroup
    Dim objUnit As LMUnit
    Dim objFilter As LMAFilter
    Dim objPipeRun As LMPipeRun
    
    Dim strItemTag As String
    Dim strLocTagSeqNo As String
    Dim strDupMessage As String
    Dim strUnitName As String
    Dim intResponse As Integer
    Dim blnUnique As Boolean
    Dim bUniqueStatus As Boolean
    
    On Error GoTo ErrorHandler
    
    strUnitName = ""
    strDupMessage = ""
    
    Item.Attributes.BuildAttributesOnDemand = True
    
    'Get the UnitCode Value
    Set objPipeRun = Datasource.GetPipeRun(Item.Id)
    objPipeRun.Attributes.BuildAttributesOnDemand = True
    
    On Error Resume Next
    Set objPlantGroup = objPipeRun.PlantGroupObject
    On Error GoTo ErrorHandler
    If Not objPlantGroup Is Nothing Then
        objPlantGroup.Attributes.BuildAttributesOnDemand = True
        
        If objPlantGroup.PlantGroupTypeIndex = 65 Then
            Set objUnit = Datasource.GetUnit(objPlantGroup.Id)
            objUnit.Attributes.BuildAttributesOnDemand = True
            'Unit code may not be set if the Units are created by retrieving from EF
            If Not IsNull(objUnit.UnitCode) Then
                strUnitName = objUnit.UnitCode
            End If
        End If
    End If
    
    'Use the collections unique index feature to avoid a bunch of if statements to
    'determine what property was passed in
    Set colTagValues = New Collection
    
    With colTagValues
    
        .Add Trim$(VariantToString(varValue)), strPropertyName
        
        Select Case strPropertyName
        
            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.OperFluidCode)), CONST_OperFluidCodeAttributeName
                
            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.OperFluidCode)), CONST_OperFluidCodeAttributeName
                
            Case CONST_OperFluidCodeAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                
            Case Else
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.OperFluidCode)), CONST_OperFluidCodeAttributeName
            
        End Select
        
    End With
    
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    
    If Len(strLocTagSeqNo) = 0 And strPropertyName <> CONST_TagSequenceNoAttributeName Then
        'Get the next tagseqno from Options Manager
        strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, CONST_NameAttributeName, _
           CONST_PipeRunNextSeqNoAttributeName)
    End If
    
'    strItemTag = strUnitName & strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
'    If Len(colTagValues(CONST_OperFluidCodeAttributeName)) > 0 Then
'        strItemTag = strItemTag & "-" & colTagValues(CONST_OperFluidCodeAttributeName)
'    End If
    
    strItemTag = BuildPipeRunTag(strUnitName, strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName), colTagValues(CONST_OperFluidCodeAttributeName))
    
    UpdatePipeRunTag = True
    
    If Len(strLocTagSeqNo) > 0 Then
        Set objFilter = Nothing
        strDupMessage = LoadResString(5000)
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Pipe Run " & LoadResString(5011)
            If Item.IsBulkItemIndex = CONST_TrueIndex Then
                Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                      strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
            Else
                Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                      strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex)
            End If
            bUniqueStatus = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
        Else
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
               'strDupMessage = "Duplicate Tag " & strItemTag & " found in active project."
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Pipe Run " & LoadResString(5010)
            Else
               'strDupMessage = "Duplicate Tag " & strItemTag & " found in active plant."
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Pipe Run " & LoadResString(5007)
            End If
            
            'Check Active Plant first
            Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                      strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
            bUniqueStatus = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
            
            If bUniqueStatus = True Then
                'strDupMessage = "Duplicate Tag " & strItemTag & " found in AsBuilt plant."
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Pipe Run " & LoadResString(5008)
                If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                    Set objFilter = Nothing
                    If Item.IsBulkItemIndex = CONST_TrueIndex Then
                        Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                             strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                    Else
                        Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                             strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex)
                    End If
                    bUniqueStatus = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                End If
            End If
        End If
        
        If bUniqueStatus = False Then
            If m_isUIEnabled Then
                intResponse = MsgBox(strDupMessage & " " & LoadResString(5009), vbYesNo + vbSystemModal + _
                   vbExclamation, LoadResString(5001))
            Else
                intResponse = vbNo
            End If
            
            If intResponse = vbNo Then
            
                UpdatePipeRunTag = True
                
                With Item
                    If Len(strLocTagSeqNo) > 0 Then
                        .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
                    End If
                    
                    If Len(colTagValues.Item(CONST_TagSuffixAttributeName)) > 0 Then
                        .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues.Item(CONST_TagSuffixAttributeName)
                    End If
                    If Len(strItemTag) > 0 Then
                        .ItemTag = strItemTag
                    End If
                    .Commit
                End With
                
                Exit Function
                
            ElseIf intResponse = vbYes Then
            
                blnUnique = False
                
                Do While blnUnique = False
                
                    'Get the next tagseqno from Options Manager
                    strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, _
                       CONST_NameAttributeName, CONST_PipeRunNextSeqNoAttributeName)
                       
                    'strItemTag = strUnitName & strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
                    'If Len(colTagValues(CONST_OperFluidCodeAttributeName)) > 0 Then
                    '    strItemTag = strItemTag & "-" & colTagValues(CONST_OperFluidCodeAttributeName)
                    'End If
                    
                    strItemTag = BuildPipeRunTag(strUnitName, strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName), colTagValues(CONST_OperFluidCodeAttributeName))
                    
                    Set objFilter = Nothing
                    If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
                        strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Pipe Run " & LoadResString(5011)
                        If Item.IsBulkItemIndex = CONST_TrueIndex Then
                            'if the piperun is bulk its okay to have a duplicate on another bulk
                            'but not on a not-bulk.
                            Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                            strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                        Else
                            Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                            strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex)
                        End If
                        blnUnique = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                    Else
                        Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                            strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
                        blnUnique = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
                        
                        If blnUnique = True Then
                            'Its unique in the project - check in the Asbuilt
                            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                                Set objFilter = Nothing
                                If Item.IsBulkItemIndex = CONST_TrueIndex Then
                                    Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                                    strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                                Else
                                    Set objFilter = GetFilter(CONST_PipeRunItemName, CONST_ItemTagAttributeName, _
                                                    strItemTag, CONST_PlantItemTypeAttributeName, CONST_PipeRunPlantItemIndex)
                                End If
                                blnUnique = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                            End If
                        End If
                    End If
               Loop
               
           Else
                UpdatePipeRunTag = False
           End If
           
        End If
        
    End If
    
    'Update the item values
    If UpdatePipeRunTag Then
    
        With Item
            
            If Len(strLocTagSeqNo) > 0 Then
                .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
            End If
            
            If strLocTagSeqNo = "" Then
                If Len(colTagValues(CONST_OperFluidCodeAttributeName)) = "" Then
                    '.ItemTag = ""
                    .ItemTag = Null
                Else
                    If Len(colTagValues.Item(CONST_TagSuffixAttributeName)) > 0 Then
                        .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues.Item(CONST_TagSuffixAttributeName)
                    End If
                    If Len(strItemTag) > 0 Then
                        .ItemTag = strItemTag
                    End If
                End If
                
                .ItemTag = Null
            Else
                If Len(colTagValues.Item(CONST_TagSuffixAttributeName)) > 0 Then
                    .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues.Item(CONST_TagSuffixAttributeName)
                End If
                If Len(strItemTag) > 0 Then
                    .ItemTag = strItemTag
                End If
            End If
            
            If Not IsNull(varValue) Then
                'trim off any spaces in the input value
                varValue = Trim$(varValue)
            End If
            
            .Commit
            
        End With
        
    End If
    
    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::UpdatePipeRunTag --> " & Err.Description
    Set objPipeRun = Nothing
    Set objPlantGroups = Nothing
    Set objUnit = Nothing
    Set colTagValues = Nothing
    Set objFilter = Nothing
        
End Function

Private Function UpdateEquipTag(Datasource As LMADataSource, Item As Llama.LMEquipment, _
   varValue As Variant, strPropertyName As String) As Boolean
   
    Dim colTagValues As Collection
    Dim objFilter As LMAFilter
    Dim strDupMessage As String
    Dim strItemTag As String
    Dim strLocTagSeqNo As String
    Dim intResponse As Integer
    Dim blnUnique As Boolean
    Dim bUniqueStatus As Boolean
    
    On Error GoTo ErrorHandler
    
    Item.Attributes.BuildAttributesOnDemand = True
    strDupMessage = ""
    
    'Use the collections unique index feature to avoid a bunch of if statements
    'to determine what property was passed in
    Set colTagValues = New Collection
    
    With colTagValues
        'Trim off any white spaces in the properties that make up the tag.
        .Add Trim$(VariantToString(varValue)), strPropertyName
        
        Select Case strPropertyName
        
            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.TagPrefix)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                
            Case CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                
            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagPrefix)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                
            Case CONST_ItemTagAttributeName
                .Add Trim$(VariantToString(Item.TagPrefix)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
        End Select
        
    End With
    
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    
    If Len(strLocTagSeqNo) < 1 And strPropertyName <> CONST_TagSequenceNoAttributeName Then
    
        'Get the next tagseqno from Options Manager
        strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, _
           CONST_NameAttributeName, CONST_EquipNextSeqNoAttributeName)
           
        'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & "-" & _
           strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
        strItemTag = BuildEquipmentTag(colTagValues(CONST_TagPrefixAttributeName), strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
                
        bUniqueStatus = CheckForEquipUnique(Datasource, Item, strItemTag, strDupMessage)
        
        'Check for uniqueness of the ItemTag
        If bUniqueStatus = False Then
            blnUnique = False
            
            Do While blnUnique = False
            
                'Get the next tagseqno from Options Manager
                strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, CONST_NameAttributeName, _
                   CONST_EquipNextSeqNoAttributeName)
                   
                'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & "-" & _
                   strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
                strItemTag = BuildEquipmentTag(colTagValues(CONST_TagPrefixAttributeName), strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
                
                blnUnique = CheckForEquipUnique(Datasource, Item, strItemTag, strDupMessage)
            Loop
         End If
    End If
    
    'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & "-" & _
       strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
    strItemTag = BuildEquipmentTag(colTagValues(CONST_TagPrefixAttributeName), strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
    
    UpdateEquipTag = True
    
    If Len(strLocTagSeqNo) > 0 Then
        'Check for uniqueness
         bUniqueStatus = CheckForEquipUnique(Datasource, Item, strItemTag, strDupMessage)
         
         If bUniqueStatus = False Then
        
            If m_isUIEnabled Then
                 intResponse = MsgBox(strDupMessage & " " & LoadResString(5009), vbYesNo + vbSystemModal + _
                    vbExclamation, LoadResString(5001))
            Else
                intResponse = vbYes
            End If
            
            If intResponse = vbYes Then
                blnUnique = False
                
                Do While blnUnique = False
                
                    'Get the next Available tag sequence number from Options Manager
                    strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, CONST_NameAttributeName, _
                       CONST_EquipNextSeqNoAttributeName)
                       
                    'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & "-" & _
                       strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
                    strItemTag = BuildEquipmentTag(colTagValues(CONST_TagPrefixAttributeName), strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
                    
                    blnUnique = CheckForEquipUnique(Datasource, Item, strItemTag, strDupMessage)
                Loop
            Else
                varValue = Item.Attributes.Item(strPropertyName).value
                UpdateEquipTag = False
            End If
            
        End If
        
    End If
    
    'Update the values
    If UpdateEquipTag Then
        
        With Item
            If Len(strLocTagSeqNo) > 0 Then
                .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
            End If
            
            If strLocTagSeqNo = "" Then
                .ItemTag = Null
            Else
                If Len(colTagValues(CONST_TagPrefixAttributeName)) > 0 Then
                    .TagPrefix = colTagValues(CONST_TagPrefixAttributeName)
                End If
                If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                    .TagSuffix = colTagValues(CONST_TagSuffixAttributeName)
                End If
                
                If Len(strItemTag) > 0 Then
                    .ItemTag = strItemTag
                End If
            End If
            
            If Not IsNull(varValue) Then
                'trim off any spaces in the input value
                varValue = Trim$(varValue)
            End If
            .Commit
            
        End With
        
    End If
    
    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::UpdateEquipTag --> " & Err.Description
    Set colTagValues = Nothing
    Set objFilter = Nothing

End Function

Private Function CheckForEquipUnique(Datasource As LMADataSource, Item As Llama.LMEquipment, _
                                           strItemTag As String, strMessage As String) As Boolean
    Dim bUniqueStatus As Boolean
    Dim objFilter As LMAFilter
    Dim strDupMessage As String
  
On Error GoTo ErrorHandler
    CheckForEquipUnique = False
    bUniqueStatus = False
    strMessage = ""
    strDupMessage = ""
    
    If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
        strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Equipment " & LoadResString(5011) 'AsBuiltPlant or its projects
        If Item.PartOfPlantItemID > 0 Then
            If Item.IsBulkItemIndex = CONST_TrueIndex Then
                Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                       strItemTag, CONST_PartofPlantItem_SP_IDAttributeName, Item.PartOfPlantItemID, _
                       CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
            Else
                Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                       strItemTag, CONST_PartofPlantItem_SP_IDAttributeName, Item.PartOfPlantItemID, _
                       CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex)
            End If
        Else
            If Item.IsBulkItemIndex = CONST_TrueIndex Then
                Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                           strItemTag, CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
            Else
                Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                           strItemTag, CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex)
            End If
        End If
        bUniqueStatus = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
    Else
        'Check the local plant or project
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Equipment " & LoadResString(5010) 'Active project
        Else
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Equipment " & LoadResString(5007) 'Active plant
        End If
        If Item.PartOfPlantItemID > 0 Then
            Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_PartofPlantItem_SP_IDAttributeName, Item.PartOfPlantItemID, _
               CONST_ItemStatus, Const_ItemStatusValue)
        Else
            Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
        End If
        bUniqueStatus = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
        
        'Do we need to check the AsBuilt too?
        If bUniqueStatus = True Then
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Equipment " & LoadResString(5008) 'found in AsBuilt Plant
                If Item.PartOfPlantItemID > 0 Then
                    If Item.IsBulkItemIndex = CONST_TrueIndex Then
                        Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                          strItemTag, CONST_PartofPlantItem_SP_IDAttributeName, Item.PartOfPlantItemID, _
                         CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                    Else
                        Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                           strItemTag, CONST_PartofPlantItem_SP_IDAttributeName, Item.PartOfPlantItemID, _
                           CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex)
                    End If
                Else
                    If Item.IsBulkItemIndex = CONST_TrueIndex Then
                        Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                           strItemTag, CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                    Else
                        Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_ItemTagAttributeName, _
                           strItemTag, CONST_PlantItemTypeAttributeName, CONST_EquipmentPlantItemIndex)
                    End If
                End If
                bUniqueStatus = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
            End If
        End If
    End If
        
    CheckForEquipUnique = bUniqueStatus
    If CheckForEquipUnique = False Then
        strMessage = strDupMessage
    End If
    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::CheckForEquipUnique --> " & Err.Description
    Set objFilter = Nothing

End Function



Private Function UpdateNozzleTag(Datasource As LMADataSource, Item As Llama.LMNozzle, _
   varValue As Variant, strPropertyName As String) As Boolean
   
    Dim objLMPlantItem As LMPlantItem
    Dim objChildPlantItem As LMPlantItem
    Dim objLMEquipment As LMEquipment
    Dim objEquipComp As LMEquipComponents
    Dim objLMNozzle As LMNozzle
    Dim vPartOfID As Variant
    Dim strEquipID As String
    Dim ItemTag As String
    Dim locTagSeqNo As String
    Dim nBulkItemIndex As Long
    Dim Response As Integer
    Dim colTagValues As Collection
    Dim strDupMessage As String
    Dim strEquipTag As String
    Dim strLocTagSeqNo As String
    Dim strItemTag As String
    Dim intResponse As Integer
    Dim DoUntilUni As Boolean
    Dim objlmaitems As LMAItems
    Dim objFilter As LMAFilter
    Dim strLocTagPrefix As String
    Dim strLocTagSuffix As String
    
    On Error GoTo Errhandler
    
    UpdateNozzleTag = True
    Set colTagValues = New Collection
    strDupMessage = ""
    strEquipTag = ""
    
    Item.Attributes.BuildAttributesOnDemand = True
    
    With colTagValues
    
        .Add Trim$(VariantToString(varValue)), strPropertyName
        
        Select Case strPropertyName
        
            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagPrefixAttributeName).value)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                
            Case CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSuffixAttributeName).value)), CONST_TagSuffixAttributeName
                
            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagPrefixAttributeName).value)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSuffixAttributeName).value)), CONST_TagSuffixAttributeName
            
            Case CONST_ItemTagAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagPrefixAttributeName).value)), CONST_TagPrefixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSuffixAttributeName).value)), CONST_TagSuffixAttributeName
            
            Case Else
            
        End Select
        
    End With
        
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    strItemTag = BuildNozzleTag(colTagValues(CONST_TagPrefixAttributeName), _
                                strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
                                
    If strPropertyName = CONST_TagSequenceNoAttributeName And strLocTagSeqNo = "" Then GoTo ExitDueTOTagSeq
    If strLocTagSeqNo = "" Then
        If colTagValues(CONST_TagSuffixAttributeName) <> "" Then
            DoUntilUni = True
        Else
            If colTagValues(CONST_TagPrefixAttributeName) <> "" Then
                DoUntilUni = True
            End If
        End If
    End If
    
    strLocTagPrefix = colTagValues(CONST_TagPrefixAttributeName)
    If strPropertyName = CONST_TagPrefixAttributeName And strLocTagPrefix <> "" Then
        If strLocTagSeqNo = "" Then
            strLocTagSeqNo = 1
        End If
    End If
    strLocTagSuffix = colTagValues(CONST_TagSuffixAttributeName)
    If strPropertyName = CONST_TagSuffixAttributeName And strLocTagSuffix <> "" Then
        If strLocTagSeqNo = "" Then
            strLocTagSeqNo = 1
        End If
    End If
    
    'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & _
       strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
    
    strItemTag = BuildNozzleTag(colTagValues(CONST_TagPrefixAttributeName), _
                                strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
       
    nBulkItemIndex = Item.IsBulkItemIndex
    
    'get the EquipmentID from the Nozzle. Here Nozzle can be on Equipment Component.
    'so navigate upto the Equipment.
    If IsNull(Item.EquipmentID) Then
        
        Set objLMPlantItem = Datasource.GetPlantItem(Item.Id)
        objLMPlantItem.Attributes.BuildAttributesOnDemand = True
        
        vPartOfID = objLMPlantItem.PartOfPlantItemID
        
        While Not IsNull(vPartOfID)
            Set objLMPlantItem = objLMPlantItem.PartOfPlantItemObject
            objLMPlantItem.Attributes.BuildAttributesOnDemand = True
            
            vPartOfID = objLMPlantItem.PartOfPlantItemID
        Wend
        If objLMPlantItem.PlantItemTypeIndex = 21 Then
            strEquipID = CStr(objLMPlantItem.Attributes(CONST_SP_EquipmentIDAttributeName).value)
        Else
            strEquipID = CStr(objLMPlantItem.Id)
        End If
    Else
        strEquipID = CStr(Item.EquipmentID)
    End If
    
    'get the Equipment
    Set objLMEquipment = Datasource.GetEquipment(strEquipID)
    objLMEquipment.Attributes.BuildAttributesOnDemand = True
    If Not IsNull(objLMEquipment.Attributes("ItemTag").value) Then
        strEquipTag = objLMEquipment.Attributes("ItemTag").value
    End If
    
MainLabel::
    If intResponse = vbYes Then
        If m_NozzleSeqNo = 0 Then m_NozzleSeqNo = 1
        'reset the starting Nozzle Tag Seq No to 1 if the equipment is different
        If Len(m_PrevNozzleEqID) = 0 Then
            m_PrevNozzleEqID = objLMEquipment.Id
        ElseIf m_PrevNozzleEqID <> objLMEquipment.Id Then
            m_PrevNozzleEqID = objLMEquipment.Id
            'reset the next TagSeqNo to 1 if the equipment is different.
            m_NozzleSeqNo = 1
        End If
        
        strLocTagSeqNo = m_NozzleSeqNo + 1
        m_NozzleSeqNo = strLocTagSeqNo
        'strItemTag = colTagValues(CONST_TagPrefixAttributeName) & strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
        strItemTag = BuildNozzleTag(colTagValues(CONST_TagPrefixAttributeName), strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
    End If
    
    strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Nozzle on Equipment " & strEquipTag & " " & LoadResString(5007)
    Set m_objLMNozzles = New LMNozzles
    
    For Each objLMNozzle In objLMEquipment.Nozzles
        m_objLMNozzles.Add objLMNozzle.AsLMAItem
    Next
    
    ' The nozzles on the children
    For Each objLMPlantItem In objLMEquipment.ChildPlantItemPlantItems
        Call GetChildNozzles(objLMPlantItem)
    Next

    For Each objLMNozzle In m_objLMNozzles
        objLMNozzle.Attributes.BuildAttributesOnDemand = True
        
        If objLMNozzle.ItemStatusIndex <> 4 Then
            If Not IsNull(objLMNozzle.ItemTag) Then
                If objLMNozzle.ItemTag = strItemTag Then
                    If objLMNozzle.IsBulkItemIndex = CONST_TrueIndex And nBulkItemIndex = CONST_TrueIndex Or objLMNozzle.Id = Item.Id Then
                        UpdateNozzleTag = True
                    Else
                        UpdateNozzleTag = False
                        'Exit For
                        GoTo ExitDueToDupInActivePlant
                    End If
                End If
            End If
       End If
    Next
    
    If UpdateNozzleTag = True Then
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Nozzle on Equipment " & strEquipTag & " " & LoadResString(5008)
            Set objFilter = Nothing
            Set objFilter = GetFilter(CONST_NozzleItemName, CONST_ItemTagAttributeName, strItemTag)
            UpdateNozzleTag = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), nBulkItemIndex, strItemTag, strEquipID)
        End If
    End If
    
    If UpdateNozzleTag = True Then
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
           strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Nozzle on Equipment " & strEquipTag & " " & LoadResString(5011)
           Set objFilter = Nothing
           Set objFilter = GetFilter(CONST_NozzleItemName, CONST_ItemTagAttributeName, strItemTag)
           UpdateNozzleTag = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), nBulkItemIndex, strItemTag, strEquipID)
        End If
    End If
   
ExitDueToDupInActivePlant:
    
    If UpdateNozzleTag = True Then
ExitDueTOTagSeq::
        'If Len(strItemTag) > 0 Then
            Item.Attributes.Item(CONST_ItemTagAttributeName).value = strItemTag
        'End If
        If Len(strLocTagSeqNo) > 0 Then
            Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
        End If
        
        If Not IsNull(varValue) Then
            'trim off any spaces in the input value
            varValue = Trim$(varValue)
        End If
            
        If strPropertyName = CONST_TagPrefixAttributeName Then
            Item.Attributes.Item(CONST_TagPrefixAttributeName).value = varValue
            If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                Item.Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues(CONST_TagSuffixAttributeName)
            End If
        ElseIf strPropertyName = CONST_TagSuffixAttributeName Then
            Item.Attributes.Item(CONST_TagSuffixAttributeName).value = varValue
            If Len(colTagValues(CONST_TagPrefixAttributeName)) > 0 Then
                Item.Attributes.Item(CONST_TagPrefixAttributeName).value = colTagValues(CONST_TagPrefixAttributeName)
            End If
        Else
            If Len(colTagValues(CONST_TagPrefixAttributeName)) > 0 Then
                Item.Attributes.Item(CONST_TagPrefixAttributeName).value = colTagValues(CONST_TagPrefixAttributeName)
            End If
            If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                Item.Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues(CONST_TagSuffixAttributeName)
            End If
        End If
        Item.Commit
        UpdateNozzleTag = True
        Exit Function
    Else
        If m_isUIEnabled Then
            If intResponse = vbYes Then
                intResponse = vbYes
            Else
                If DoUntilUni = True Then
                    intResponse = vbYes
                Else
                    If strDupMessage = "" Then
                        intResponse = MsgBox(LoadResString(5000), vbYesNo + vbSystemModal + vbExclamation, LoadResString(5001))
                    Else
                        intResponse = MsgBox(strDupMessage & " " & LoadResString(5009), vbYesNo + vbSystemModal + vbExclamation, LoadResString(5001))
                    End If
               End If
            End If
        Else
            intResponse = vbYes
        End If
        If intResponse = vbYes Then
            UpdateNozzleTag = True
            GoTo MainLabel
        Else
            UpdateNozzleTag = False
        End If
    End If
        'cleanup
    Set objLMPlantItem = Nothing
    Set objChildPlantItem = Nothing
    Set objLMEquipment = Nothing
    Set objEquipComp = Nothing
    Set objLMNozzle = Nothing
    vPartOfID = Null
    Set objFilter = Nothing
    Exit Function
    
Errhandler:
    'cleanup
    Set objLMPlantItem = Nothing
    Set objChildPlantItem = Nothing
    Set objLMEquipment = Nothing
    Set objEquipComp = Nothing
    Set objLMNozzle = Nothing
    vPartOfID = Null
    Set objFilter = Nothing
End Function


Private Function UpdateLoopTag(Datasource As LMADataSource, Item As Llama.LMInstrLoop, _
   varValue As Variant, strPropertyName As String) As Boolean
   
    Dim colTagValues As Collection
    Dim objFilter As LMAFilter
    Dim strDupMessage As String
    Dim strItemTag As String
    Dim strLocTagSeqNo As String
    Dim intResponse As Integer
    Dim blnUnique As Boolean
    Dim bUniqueStatus As Boolean
    
    On Error GoTo ErrorHandler
    
    Item.Attributes.BuildAttributesOnDemand = True
    strDupMessage = ""
    
    'Use the collections unique index feature to avoid a bunch of if statements to
    'determine what property was passed in
    Set colTagValues = New Collection
    
    With colTagValues
    
        .Add Trim$(VariantToString(varValue)), strPropertyName
        
        Select Case strPropertyName
        
            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.LoopFunction)), CONST_LoopFunctionAttributeName
                .Add Trim$((VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value))), CONST_TagSequenceNoAttributeName
                
            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.LoopFunction)), CONST_LoopFunctionAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                
            Case CONST_LoopFunctionAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                
            Case Else
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.LoopFunction)), CONST_LoopFunctionAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
        End Select
    End With
    
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    
    If Len(strLocTagSeqNo) = 0 And strPropertyName <> CONST_TagSequenceNoAttributeName Then
        'Get the next tagseqno from Options Manager
        strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, CONST_NameAttributeName, _
           CONST_InstrLoopNextSeqNoAttributeName)
    End If
    
    'strItemTag = colTagValues(CONST_LoopFunctionAttributeName) & "-" & _
       strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
    
    strItemTag = BuildInstrLoopTag(colTagValues(CONST_LoopFunctionAttributeName), _
                                   strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
    UpdateLoopTag = True
    
    If Len(strLocTagSeqNo) > 0 Then
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Loop " & LoadResString(5011)
            Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrLoopPlantItemIndex)
                'Checking for Unique
            bUniqueStatus = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
        Else
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Loop " & LoadResString(5010)
            Else
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Loop " & LoadResString(5007)
            End If
            
            'Check the active plant
            Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
                'Checking for Unique
            bUniqueStatus = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
            
            'Check to see if the Asbuilt plant needs checking too
            If bUniqueStatus = True Then
                If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                    strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Loop " & LoadResString(5008)
                    Set objFilter = Nothing
                    Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
                                    strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrLoopPlantItemIndex)
                    'Checking for Unique
                    bUniqueStatus = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                End If
            End If
        End If
           
        If bUniqueStatus = False Then
            If m_isUIEnabled Then
                intResponse = MsgBox(strDupMessage & " " & LoadResString(5009), vbYesNo + vbSystemModal + _
                   vbExclamation, LoadResString(5001))
            Else
                intResponse = vbYes
            End If
            
            If intResponse = vbYes Then
            
                blnUnique = False
                
                Do While blnUnique = False
                
                    'Get the next tagseqno from Options Manager
                    strLocTagSeqNo = GetNextAvailTagSeqNo(Datasource, CONST_NameAttributeName, _
                       CONST_InstrLoopNextSeqNoAttributeName)
                       
                    'strItemTag = colTagValues(CONST_LoopFunctionAttributeName) & "-" & _
                       strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
                       
                    strItemTag = BuildInstrLoopTag(colTagValues(CONST_LoopFunctionAttributeName), _
                                                   strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
                    Set objFilter = Nothing
                    If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
                        Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
                                        strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrLoopPlantItemIndex)
                        'Checking for Unique
                        blnUnique = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                    Else
                        'Forming a filter
                        Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
                                        strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
                        'Checking for Unique
                        blnUnique = CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex)
                        If blnUnique = True Then
                            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                                Set objFilter = Nothing
                                Set objFilter = GetFilter(CONST_InstrLoopItemName, CONST_ItemTagAttributeName, _
                                        strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrLoopPlantItemIndex)
                                blnUnique = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                            End If
                        End If
                    End If
                Loop
            Else
                UpdateLoopTag = False
            End If
            
        End If
        
    End If
    
    If UpdateLoopTag Then
    
        With Item
            
            If Len(strLocTagSeqNo) > 0 Then
                .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
            End If
            
            If strLocTagSeqNo = "" Then
                Item.ItemTag = Null
            Else
                If Len(strItemTag) > 0 Then
                    Item.ItemTag = strItemTag
                End If
                If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                    .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues(CONST_TagSuffixAttributeName)
                End If
            End If
            
            If Not IsNull(varValue) Then
                'trim off any spaces in the input value
                varValue = Trim$(varValue)
            End If
            
            .Commit
            
        End With
        
    End If

    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::UpdateLoopTag --> " & Err.Description
    Set colTagValues = Nothing
    Set objFilter = Nothing

End Function

'Function to get the next tagseqno from Options Manager
Private Function GetNextAvailTagSeqNo(ByVal objDataSource As LMADataSource, _
   ByVal SourceAttributeName As String, ByVal ValueAttribute As String) As String
   
    Dim objOptionSettings As New LMOptionSettings
    Dim objFilter As LMAFilter

    Set objOptionSettings = New LMOptionSettings
    
    'Forming a filter
    Set objFilter = GetFilter(CONST_OptionSettingAttributeName, SourceAttributeName, ValueAttribute)
    
    With objDataSource
    
        .QueryCache = False
        
        With objOptionSettings
        
            .Collect objDataSource, Filter:=objFilter
            GetNextAvailTagSeqNo = Trim$(.Nth(1).value)
            
            With .Nth(1)
                .value = CLng(GetNextAvailTagSeqNo) + 1
                .Commit
            End With
            
        End With
        
        .QueryCache = True
    
    End With
    
Cleanup:
    Set objOptionSettings = Nothing
    Set objFilter = Nothing
    
    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::GetNextAvailTagSeqNo --> " & Err.Description
    Resume Cleanup
    
End Function

'Function that forms a filter
Private Function GetFilter(ByVal ItemType As String, SourceAttributeName As String, _
   ByVal ValueAttribute As String, Optional SourceAttributeName1 As String, _
   Optional ValueAttribute1 As String, Optional SourceAttributeName2 As String, _
   Optional ValueAttribute2 As String, Optional SourceAttributeName3 As String, _
   Optional ValueAttribute3 As String) As LMAFilter
   
    Dim objCriterion As LMACriterion
    
    On Error GoTo ErrorHandler
    
    Set GetFilter = New LMAFilter
    
    With GetFilter
    
        .ItemType = ItemType
        .Conjunctive = True
    
        Set objCriterion = New LMACriterion
        
        With objCriterion
            .Conjunctive = True
            .SourceAttributeName = SourceAttributeName
            .ValueAttribute = ValueAttribute
            .Operator = "="
            .Bind = True
        End With
    
        .Criteria.Add objCriterion
    
        If Len(SourceAttributeName1) > 1 Then
        
            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion
            
            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName1
                .ValueAttribute = ValueAttribute1
                .Operator = "="
            End With
            
            GetFilter.Criteria.Add objCriterion
            
        End If
        
        If Len(SourceAttributeName2) > 1 Then
        
            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion
            
            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName2
                .ValueAttribute = ValueAttribute2
                .Operator = "="
            End With
            
            GetFilter.Criteria.Add objCriterion
            
        End If
        
        If Len(SourceAttributeName3) > 1 Then
        
            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion
            
            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName3
                .ValueAttribute = ValueAttribute3
                .Operator = "="
            End With
            
            GetFilter.Criteria.Add objCriterion
            
        End If
        
    End With

    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::GetFilter --> " & Err.Description
    Set GetFilter = Nothing
    Set objCriterion = Nothing
    
End Function

'Function to check if itemtags are unique
Private Function CheckForUnique(ByVal Datasource As LMADataSource, ByVal objFilter As LMAFilter, _
   ByVal IDOFITEM As String, BulkItemIndex As Long) As Boolean
    
    Dim objLMPipeRuns As LMPipeRuns
    Dim objLMInstruments As LMInstruments
    Dim objLMInstrLoops As LMInstrLoops
    Dim objLMEquipments As LMEquipments
    Dim objLMNozzles As LMNozzles
    Dim objLMSignalRuns As LMSignalRuns
    On Error GoTo ErrorHandler

'//If certain item types does not require uniqueness check then this function shouldn't
'//even be called for those item types
'    If m_isUIEnabled = False Then
'        CheckForUnique = True
'        Exit Function
'    End If
    
    With objFilter
    
        'Check the Piperun collection
        If .ItemType = CONST_PipeRunItemName Then
            
            Set objLMPipeRuns = New LMPipeRuns
            
            With objLMPipeRuns
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
                
            End With
            
        'Check the Instrument collection
        ElseIf .ItemType = CONST_InstrumentItemName Then
            
            Set objLMInstruments = New LMInstruments
            
            With objLMInstruments
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
                
            End With
            
        'Check the InstrumentLoop collection
        ElseIf .ItemType = CONST_InstrLoopItemName Then
            
            Set objLMInstrLoops = New LMInstrLoops
            
            With objLMInstrLoops
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(objLMInstrLoops.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
            
            End With
            
        'Check the Equipment collection
        ElseIf .ItemType = CONST_EquipmentItemName Then
            
            Set objLMEquipments = New LMEquipments
            
            With objLMEquipments
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
            
            End With
            
        'Checking in the Nozzles collection
        ElseIf .ItemType = CONST_NozzleItemName Then
            
            Set objLMNozzles = New LMNozzles
            
            With objLMNozzles
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
            
            End With
        ElseIf .ItemType = Const_SignalRunItemName Then
            
            Set objLMSignalRuns = New LMSignalRuns
            
            With objLMSignalRuns
            
                .Collect Datasource, Filter:=objFilter
                
                If .Count > 0 Then
                    
                    .Nth(1).Attributes.BuildAttributesOnDemand = True
                    If .Nth(1).IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                        CheckForUnique = True
                    ElseIf .Count = 1 And CStr(.Nth(1).Id) = CStr(IDOFITEM) Then
                        CheckForUnique = True
                    Else
                        CheckForUnique = False
                    End If
                    
                Else
                    CheckForUnique = True
                End If
            
            End With
        
        End If
        
    End With
    
    Exit Function

ErrorHandler:
    LogError "ItemTag - ItemTagFunc::CheckForUnique --> " & Err.Description
    Set objLMPipeRuns = Nothing
    Set objLMInstruments = Nothing
    Set objLMInstrLoops = Nothing
    Set objLMEquipments = Nothing
    Set objLMNozzles = Nothing
 
End Function



Private Function GetUnit(Item As LMPlantItem) As LMUnit

    Dim objPlantGroup As LMPlantGroup
    
    On Error GoTo ErrorHandler
    
    'Get the Unit
'    If Not Item.PlantGroups.Count = 0 Then
    Set objPlantGroup = Item.PlantGroupObject
'        For Each objPlantGroup In Item.PlantGroups
    If Not (objPlantGroup Is Nothing) Then
        With objPlantGroup
        
            If .PlantGroupTypeIndex = 2 Then
                Set GetUnit = .Datasource.GetUnit(.Id)
'                Exit For
            End If
            
        End With
    End If
'        Next
        

    
    Exit Function
    
ErrorHandler:
    LogError "ItemTag - ItemTagFunc::GetUnit --> " & Err.Description
    Set GetUnit = Nothing

End Function

Private Function VariantToString(varValue As Variant) As String

    VariantToString = IIf(IsNull(varValue), "", varValue)

End Function

Private Function IsNozzleTagUnique(ByRef objLMPlantItem As LMPlantItem, _
                                   ByRef value As Variant, _
                                   ByVal BulkItemIndex As Long) As Boolean

    Dim objLMChildPlantItem As LMPlantItem
    Dim bIsNozzleTagUnique As Boolean
    Dim objLMNozzle As LMNozzle
    
    On Error GoTo Errhandler
    
    bIsNozzleTagUnique = True
    
    If objLMPlantItem.ItemTypeName = "Nozzle" Then
        Set objLMNozzle = objLMPlantItem.Datasource.GetNozzle(CStr(objLMPlantItem.Id))
        If (Not IsNull(value)) And (Not IsNull(objLMNozzle.ItemTag)) Then
            If objLMNozzle.ItemTag = value Then
                If objLMNozzle.IsBulkItemIndex = CONST_TrueIndex And BulkItemIndex = CONST_TrueIndex Then
                    bIsNozzleTagUnique = True
                Else
                    bIsNozzleTagUnique = False
                    IsNozzleTagUnique = False
                    Exit Function
                End If
                If CLng(objLMNozzle.Attributes.Item(CONST_TagSequenceNoAttributeName).value) > m_NozzleSeqNo Then
                    m_NozzleSeqNo = CLng(objLMNozzle.Attributes.Item(CONST_TagSequenceNoAttributeName).value)
                End If
            End If
        End If
    Else
        For Each objLMChildPlantItem In objLMPlantItem.ChildPlantItemPlantItems
            bIsNozzleTagUnique = IsNozzleTagUnique(objLMChildPlantItem, value, BulkItemIndex)
            If bIsNozzleTagUnique = False Then
                IsNozzleTagUnique = False
                Exit Function
            End If
        Next
    End If
    
    IsNozzleTagUnique = bIsNozzleTagUnique
    
    'cleanup
    Set objLMChildPlantItem = Nothing
    
    Exit Function
    
Errhandler:
    'cleanup
    Set objLMChildPlantItem = Nothing
    IsNozzleTagUnique = False
End Function


Private Function UpdateSignalRunTag(Datasource As LMADataSource, Item As Llama.LMSignalRun, varValue As Variant, strPropertyName As String) As Boolean
        
    Dim colTagValues As Collection
    Dim objFilter As LMAFilter
    Dim strDupMessage As String
    Dim strItemTag As String
    Dim strLocTagSeqNo As String
    Dim intResponse As Integer
    Dim bStatus As Boolean
    
    On Error Resume Next
    
    Item.Attributes.BuildAttributesOnDemand = True
    strDupMessage = ""
    
    'Use the collections unique index feature to avoid a bunch of if statements to
    'determine what property was passed in
    Set colTagValues = New Collection
    
    With colTagValues
    
        .Add Trim$(VariantToString(varValue)), strPropertyName

        Select Case strPropertyName

            Case CONST_TagSuffixAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName

            Case CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.TagSuffix)), CONST_TagSuffixAttributeName
            Case Else
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSequenceNoAttributeName).value)), CONST_TagSequenceNoAttributeName
                .Add Trim$(VariantToString(Item.Attributes.Item(CONST_TagSuffixAttributeName).value)), CONST_TagSuffixAttributeName
        End Select
    
    End With
    
    strLocTagSeqNo = colTagValues(CONST_TagSequenceNoAttributeName)
    
    'strItemTag = strLocTagSeqNo & colTagValues(CONST_TagSuffixAttributeName)
    strItemTag = BuildSignalRunTag(strLocTagSeqNo, colTagValues(CONST_TagSuffixAttributeName))
    
    UpdateSignalRunTag = True
    
    If Len(strLocTagSeqNo) > 0 And m_isUIEnabled = True Then
        If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuiltAndProjs Then
            strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Signal Run " & LoadResString(5011)
            'Forming a filter
            'note - CONST_InstrumentPlantItemIndex is really = 5 (SignalRun)
            If Item.IsBulkItemIndex = CONST_TrueIndex Then
                Set objFilter = GetFilter(Const_SignalRunItemName, CONST_ItemTagAttributeName, _
                   strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
            Else
                Set objFilter = GetFilter(Const_SignalRunItemName, CONST_ItemTagAttributeName, _
                   strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex)
            End If
            
            'Checking if the itemtag is unique
            bStatus = CheckForGlobalUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                If bStatus = False Then
                    If Item.Id <> m_lngID Then
                        m_lngID = Item.Id
                        intResponse = MsgBox(strDupMessage, vbOKOnly + vbExclamation, LoadResString(5001))
                    End If
                
                UpdateSignalRunTag = False
            End If
        Else
            If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
               'strDupMessage = "Duplicate Tag " & strItemTag & " found in active project."
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Signal Run " & LoadResString(5010)
            Else
               'strDupMessage = "Duplicate Tag " & strItemTag & " found in active plant."
                strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Signal Run " & LoadResString(5007)
            End If
            'check local project - same as always
            Set objFilter = GetFilter(Const_SignalRunItemName, CONST_ItemTagAttributeName, _
               strItemTag, CONST_ItemStatus, Const_ItemStatusValue)
            
            'Checking if the itemtag is unique in the local project
            If Not CheckForUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex) Then
                If Item.Id <> m_lngID Then
                    m_lngID = Item.Id
                    intResponse = MsgBox(strDupMessage, vbOKOnly + vbExclamation, LoadResString(5001))
                End If
                
                UpdateSignalRunTag = False
            Else
                'its unique in the local project but check further into AsBuilt if required
                If m_DuplicateTagCheckScope = ActiveProjAgainstAsBuilt Then
                    strDupMessage = LoadResString(5006) & " '" & strItemTag & "' for Signal Run " & LoadResString(5008)
                    Set objFilter = GetFilter(Const_SignalRunItemName, CONST_ItemTagAttributeName, _
                       strItemTag, CONST_PlantItemTypeAttributeName, CONST_InstrumentPlantItemIndex)
            
                    'Checking if the itemtag is unique
                    bStatus = CheckForAsBuiltUnique(Datasource, objFilter, CStr(Item.Id), Item.IsBulkItemIndex, strItemTag, "")
                    If bStatus = False Then
                        If Item.Id <> m_lngID Then
                            m_lngID = Item.Id
                            intResponse = MsgBox(strDupMessage, vbOKOnly + vbExclamation, LoadResString(5001))
                        End If
                
                        UpdateSignalRunTag = False
                    End If
                End If
            End If
        End If
    End If

    'Update the values
    With Item
    
        If Len(strLocTagSeqNo) > 0 Then
            .Attributes.Item(CONST_TagSequenceNoAttributeName).value = strLocTagSeqNo
        End If
        
        If strLocTagSeqNo = "" Then
            '.ItemTag = ""
            .ItemTag = Null
        Else
            If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                .TagSuffix = colTagValues(CONST_TagSuffixAttributeName)
            End If
            
            If Len(strItemTag) > 0 Then
                .ItemTag = strItemTag
            End If
        End If
        
        If strLocTagSeqNo = "" Then
            If strPropertyName = CONST_TagSuffixAttributeName Then
                If Len(colTagValues(CONST_TagSuffixAttributeName)) > 0 Then
                    .Attributes.Item(CONST_TagSuffixAttributeName).value = colTagValues(CONST_TagSuffixAttributeName)
                End If
            End If
        End If
        
        If Not IsNull(varValue) Then
            'trim off any spaces in the input value
            varValue = Trim$(varValue)
        End If
            
        .Commit
    
    End With
    
    Err.Clear
    Exit Function
ErrorHandler:
    UpdateSignalRunTag = False
End Function

Private Function GetFilter2(ByVal ItemType As String, SourceAttributeName As String, _
   ByVal OperatorAttribute As String, ByVal ValueAttribute As String, Optional SourceAttributeName1 As String, _
   Optional OperatorAttribute1 As String, Optional ValueAttribute1 As String, _
   Optional SourceAttributeName2 As String, Optional OperatorAttribute2 As String, _
   Optional ValueAttribute2 As String, _
   Optional SourceAttributeName3 As String, Optional OperatorAttribute3 As String, _
   Optional ValueAttribute3 As String _
   ) As LMAFilter

    Dim objCriterion As LMACriterion

    On Error GoTo ErrorHandler

    Set GetFilter2 = New LMAFilter

    With GetFilter2

        .ItemType = ItemType
        .Conjunctive = True

        Set objCriterion = New LMACriterion

        With objCriterion
            .Conjunctive = True
            .SourceAttributeName = SourceAttributeName
            .ValueAttribute = ValueAttribute
            '.Operator = "="
            .Operator = OperatorAttribute
            .Bind = True
        End With

        .Criteria.Add objCriterion

        If Len(SourceAttributeName1) > 1 Then

            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion

            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName1
                .ValueAttribute = ValueAttribute1
                '.Operator = "="
                .Operator = OperatorAttribute1
            End With

            GetFilter2.Criteria.Add objCriterion

        End If

        If Len(SourceAttributeName2) > 1 Then

            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion

            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName2
                .ValueAttribute = ValueAttribute2
                '.Operator = "="
                .Operator = OperatorAttribute2
            End With

            GetFilter2.Criteria.Add objCriterion

        End If

        If Len(SourceAttributeName3) > 1 Then

            Set objCriterion = Nothing
            Set objCriterion = New LMACriterion

            With objCriterion
                .Conjunctive = True
                .SourceAttributeName = SourceAttributeName3
                .ValueAttribute = ValueAttribute3
                '.Operator = "="
                .Operator = OperatorAttribute3
            End With

            GetFilter2.Criteria.Add objCriterion

        End If

    End With

    Exit Function

ErrorHandler:
    LogError "ItemTag - ItemTagFunc::GetFilter2 --> " & Err.Description
    Set GetFilter2 = Nothing
    Set objCriterion = Nothing

End Function

'Function to check if itemtags are unique
Private Function CheckForUniqueUsingViews(strTheView As String, Datasource As LMADataSource, objFilter As LMAFilter, _
                                      IDOFITEM As String, BulkItemIndex As Long, _
                                      strItemTag As String, strParentID As String) As Boolean
    
    Dim bStatus As Boolean
    Dim lngItemStatusIndex As Long
    Dim lngPlantItemGroupIndex As Long
    Dim colIDs As Collection
    Dim colIsBulkItemIndexes As Collection
    Dim colPlantItemTypeIndexes As Collection
    Dim colTags As Collection
    Dim status As Long
    Dim strSPID As Variant
    Dim strIsBulkItemIndex As String
    Dim vBulkItemStatus As Variant
    
    On Error GoTo ErrorHandler
    
'//If certain item types does not require uniqueness check then this function shouldn't
'//even be called for those item types

   
    CheckForUniqueUsingViews = True
    
    With objFilter
    
        'Check the Piperuns for duplicates
        If .ItemType = CONST_PipeRunItemName Then
             CheckForUniqueUsingViews = True
            
            Set colIDs = New Collection
            status = Datasource.GetTagDataFromView(strTheView, objFilter, colIDs)
            
            If status <> 0 Then
                GoTo ErrorHandler
            Else
                If colIDs.Count > 0 Then
                    For Each strSPID In colIDs
                        If strSPID <> IDOFITEM Then
                            'check to see if the piperun with the duplicate tag has an active status
                            status = Datasource.GetModelItemStatusFromView(strTheView, CStr(strSPID), lngItemStatusIndex)
                            If lngItemStatusIndex = Const_ItemStatusValue Then
                                CheckForUniqueUsingViews = False
                                GoTo Cleanup
                            End If
                        End If
                    Next
                End If
            End If
            
         
            
        'Check the Instruments
        ElseIf .ItemType = CONST_InstrumentItemName Then
            CheckForUniqueUsingViews = True
            
            Set colIDs = New Collection
            status = Datasource.GetTagDataFromView(strTheView, objFilter, colIDs)
            If status <> 0 Then
                GoTo ErrorHandler
            Else
                If colIDs.Count > 0 Then
                    For Each strSPID In colIDs
                        If strSPID <> IDOFITEM Then
                            'check to see if the instrument with the duplicate tag has an active status
                            status = Datasource.GetModelItemStatusFromView(strTheView, CStr(strSPID), lngItemStatusIndex)
                            If lngItemStatusIndex = Const_ItemStatusValue Then
                                CheckForUniqueUsingViews = False
                                GoTo Cleanup
                            End If
                        End If
                    Next
                End If
            End If
            
        'Check the InstrumentLoops for duplicates
        ElseIf .ItemType = CONST_InstrLoopItemName Then
            CheckForUniqueUsingViews = True
            
            Set colIDs = New Collection
            status = Datasource.GetTagDataFromView(strTheView, objFilter, colIDs)
            If status <> 0 Then
                GoTo ErrorHandler
            Else
                If colIDs.Count > 0 Then
                    For Each strSPID In colIDs
                        If strSPID <> IDOFITEM Then
                            'check to see if the plantitemgroup with the duplicate tag has an active status
                            status = Datasource.GetModelItemStatusFromView(strTheView, CStr(strSPID), lngItemStatusIndex)
                            If lngItemStatusIndex = Const_ItemStatusValue Then
                                'this is an active plantitemgroup.  See if it is a loop
                                status = Datasource.GetPlantItemGroupTypeFromView(strTheView, CStr(strSPID), lngPlantItemGroupIndex)
                                If lngPlantItemGroupIndex = 6 Then
                                    CheckForUniqueUsingViews = False
                                    GoTo Cleanup
                                End If
                            End If
                        End If
                    Next
                End If
            End If
            
        'Check the Equipment collection
        ElseIf .ItemType = CONST_EquipmentItemName Then
            CheckForUniqueUsingViews = True
            
            Set colIDs = New Collection
            status = Datasource.GetTagDataFromView(strTheView, objFilter, colIDs)
            If status <> 0 Then
                GoTo ErrorHandler
            Else
                If colIDs.Count > 0 Then
                    For Each strSPID In colIDs
                        If strSPID <> IDOFITEM Then
                            'check to see if the instrument with the duplicate tag has an active status
                            status = Datasource.GetModelItemStatusFromView(strTheView, CStr(strSPID), lngItemStatusIndex)
                            If lngItemStatusIndex = Const_ItemStatusValue Then
                                CheckForUniqueUsingViews = False
                                GoTo Cleanup
                            End If
                            
                        End If
                    Next
                End If
            End If
            
        'Checking in the Nozzles view
        ElseIf .ItemType = CONST_NozzleItemName Then
            CheckForUniqueUsingViews = True
            'this checks the nozzle that have a direct relationship to equipment
            bStatus = EqNozTagIsGlobalUnique(strTheView, Datasource, IDOFITEM, strItemTag, BulkItemIndex, strParentID)
            If bStatus = False Then
                CheckForUniqueUsingViews = False
                GoTo Cleanup
            End If
            'this checks the nozzle may be part of equipment components that are children of the main equipment
            'its not likely that these will exist but check anyway
            bStatus = ChildEqNozTagIsGlobalUnique(strTheView, Datasource, IDOFITEM, strItemTag, BulkItemIndex, strParentID)
            If bStatus = False Then
                CheckForUniqueUsingViews = False
                GoTo Cleanup
            End If
        ElseIf .ItemType = Const_SignalRunItemName Then
            CheckForUniqueUsingViews = True
            
            Set colIDs = New Collection
            status = Datasource.GetTagDataFromView(strTheView, objFilter, colIDs)
            If status <> 0 Then
                GoTo ErrorHandler
            Else
                If colIDs.Count > 0 Then
                    For Each strSPID In colIDs
                        If strSPID <> IDOFITEM Then
                            'check to see if the instrument with the duplicate tag has an active status
                            status = Datasource.GetModelItemStatusFromView(strTheView, CStr(strSPID), lngItemStatusIndex)
                            If lngItemStatusIndex = Const_ItemStatusValue Then
                                CheckForUniqueUsingViews = False
                                GoTo Cleanup
                            End If
                        End If
                    Next
                End If
            End If
        End If
        
    End With
    
Cleanup:
    
    Set colIDs = Nothing
    Set colPlantItemTypeIndexes = Nothing
    Set colTags = Nothing
    Exit Function

ErrorHandler:
    CheckForUniqueUsingViews = True
    Set colIDs = Nothing
    Set colPlantItemTypeIndexes = Nothing
    Set colTags = Nothing
    LogError "ItemTag - ItemTagFunc::CheckForUniqueUsingViews --> " & Err.Description
    
 
End Function


Private Function ChildEqNozTagIsGlobalUnique(strTheView As String, Datasource As LMADataSource, strTheNozzleID As String, _
                         strTheNozzleTag As String, lngTheNozzleBulkItemIndex As Long, strParentID As String) As Boolean
'This function will use the global views for item tag uniqueness check in a project environment.
'This function will get the nozzles on the equipment components and test the tags
'This function can not be used in a satellite plant due to not being able to access data at the host
    Dim bIsUnique As Boolean
    Dim colChildIDs As Collection
    Dim colTags As Collection
    Dim colPlantItemTypes As Collection
    Dim colIsBulkItems As Collection
    Dim colPartOfIDs As Collection
    Dim lngBulkItemIndex As Long
    Dim lngItemStatusIndex As Long
    Dim objFilter As LMAFilter
    Dim status As Long
    Dim strItemTag As String
    Dim strErrorMessage As String
    Dim vChildID As Variant
    
    On Error GoTo Errhandler
     
    ChildEqNozTagIsGlobalUnique = True
    bIsUnique = True
    strErrorMessage = ""
     
    Set objFilter = GetFilter(CONST_EquipmentItemName, CONST_PartOfIDAttributeName, strParentID)
    Set colChildIDs = New Collection
    Set colTags = New Collection
    Set colPlantItemTypes = New Collection
    
    Set colIsBulkItems = New Collection
    status = Datasource.GetTagDataFromView(strTheView, objFilter, colChildIDs, colTags, colPlantItemTypes, , colIsBulkItems)
    If status <> 0 Then
        strErrorMessage = "Error getting child items for EquipmentID=" & strParentID & " using global tag view"
        GoTo Errhandler
    End If
    For Each vChildID In colChildIDs
        If CLng(colPlantItemTypes(CStr(vChildID)) = CONST_NozzlePlantItemIndex) Then
            If CStr(vChildID) <> strTheNozzleID Then
                'Found another nozzle related to the parent
                'Is the tag duplicated
                strItemTag = ""
                On Error Resume Next
                strItemTag = colTags(CStr(vChildID))
                On Error GoTo Errhandler
                If strItemTag = "" Then
                    GoTo nextChild
                Else
                    If strItemTag = strTheNozzleTag Then
                        'Found a duplicate, ignore it if both are bulk items
                        lngBulkItemIndex = colIsBulkItems(CStr(vChildID))
                        If VBA.CLng(lngBulkItemIndex) = CONST_TrueIndex And lngTheNozzleBulkItemIndex = CONST_TrueIndex Then
                            GoTo nextChild
                        End If
                        'Is the Item Active
                        status = Datasource.GetModelItemStatusFromView(strTheView, CStr(vChildID), lngItemStatusIndex)
                        If lngItemStatusIndex <> 4 Then    '4 = Delete Pending
                            bIsUnique = False
                            GoTo Cleanup
                        End If
                    End If
                End If
            End If
        Else
            bIsUnique = ChildEqNozTagIsGlobalUnique(strTheView, Datasource, strTheNozzleID, _
                         strTheNozzleTag, lngTheNozzleBulkItemIndex, CStr(vChildID))
            If bIsUnique = False Then
                GoTo Cleanup
            End If
        End If
nextChild:
        
    Next
    
Cleanup:
    ChildEqNozTagIsGlobalUnique = bIsUnique
    Set colChildIDs = Nothing
    Set objFilter = Nothing
    Set colChildIDs = Nothing
    Set colTags = Nothing
    Set colPlantItemTypes = Nothing
    Set colIsBulkItems = Nothing
    
    Exit Function
Errhandler:
    bIsUnique = False
    LogError "ItemTag - ChildEqNozTagIsGlobalUnique --> " & Err.Description & " " & strErrorMessage
    Resume Cleanup
    
    
End Function

Private Function EqNozTagIsGlobalUnique(strTheView As String, Datasource As LMADataSource, strTheNozzleID As String, _
                         strTheNozzleTag As String, lngTheNozzleBulkItemIndex As Long, strEquipmentID As String) As Boolean
'This function will use the global views for item tag uniqueness check in a project environment.
'This function will get the nozzles on equipment using the SP_EquipmentID and test the tags
'This function can not be used in a satellite plant due to not being able to access data at the host
    Dim bIsUnique As Boolean
    Dim colDupNozTagIDs As Collection
    Dim colNozzleIDs As Collection
    Dim lngItemStatusIndex As Long
    Dim objFilter As LMAFilter
    Dim status As Long
    Dim strErrorMessage As String
    Dim vChildID As Variant
    Dim vNozzleID As Variant
    
    On Error GoTo Errhandler
    
    EqNozTagIsGlobalUnique = True
    If IsNull(strTheNozzleTag) Then
        Exit Function
    End If
    strErrorMessage = ""
    bIsUnique = True
    
    'Get the nozzles on the parent equipment from the view "GlobalNozzleList"
    Set colNozzleIDs = New Collection
    status = Datasource.GetNozzlesForEquipFromView(strTheView, strEquipmentID, colNozzleIDs)
    If status <> 0 Then
        strErrorMessage = "Error getting nozzles for EquipmentID=" & strEquipmentID & " using global nozzle view"
        GoTo Errhandler
    End If
    
    If colNozzleIDs.Count > 0 Then
        'check each nozzle to see if the tag is a duplicate
        For Each vNozzleID In colNozzleIDs
            If (CStr(vNozzleID) <> strTheNozzleID) Then
                Set objFilter = Nothing
                If lngTheNozzleBulkItemIndex = CONST_TrueIndex Then
                    Set objFilter = GetFilter(CONST_NozzleItemName, CONST_SP_IDAttributeName, CStr(vNozzleID), _
                        CONST_ItemTagAttributeName, strTheNozzleTag, CONST_IsBulkItemAttributeName, CONST_FalseIndex)
                Else
                    Set objFilter = GetFilter(CONST_NozzleItemName, CONST_SP_IDAttributeName, CStr(vNozzleID), _
                        CONST_ItemTagAttributeName, strTheNozzleTag)
                End If
                Set colDupNozTagIDs = New Collection
                'This will query the GlobalTagList view to get the Nozzle with the same tag as the input nozzle
                status = Datasource.GetTagDataFromView(strTheView, objFilter, colDupNozTagIDs)
                If status <> 0 Then
                    strErrorMessage = "Error getting nozzle data from global tag view for nozzle id=" & CStr(vNozzleID)
                    GoTo Errhandler
                End If
                If colDupNozTagIDs.Count > 0 Then
                    'found a duplicate, is it not delete pending
                    status = Datasource.GetModelItemStatusFromView(strTheView, CStr(vNozzleID), lngItemStatusIndex)
                    If status <> 0 Then
                       strErrorMessage = "Error Getting ModelItemStatus from global view for nozzle id=" & CStr(vNozzleID)
                       GoTo Errhandler
                    End If
                    If lngItemStatusIndex <> 4 Then    '4 = Delete Pending
                        bIsUnique = False
                        GoTo Cleanup
                    End If
                End If
                Set colDupNozTagIDs = Nothing
            End If
        Next
    End If
    
Cleanup:
    EqNozTagIsGlobalUnique = bIsUnique
    Set colDupNozTagIDs = Nothing
    Set colNozzleIDs = Nothing
    Set objFilter = Nothing
    
    Exit Function
Errhandler:
    bIsUnique = False
    LogError "ItemTag - EqNozTagIsGlobalUnique --> " & Err.Description & " " & strErrorMessage
    Resume Cleanup
End Function

Private Function CheckForAsBuiltUnique(Datasource As LMADataSource, objFilter As LMAFilter, _
                                      IDOFITEM As String, BulkItemIndex As Long, _
                                      strItemTag As String, strParentID As String) As Boolean
On Error GoTo Errhandler
                                      
    CheckForAsBuiltUnique = CheckForUniqueUsingViews("AsBuilt", Datasource, objFilter, IDOFITEM, BulkItemIndex, strItemTag, strParentID)
    Exit Function
Errhandler:
End Function

Private Function CheckForGlobalUnique(Datasource As LMADataSource, objFilter As LMAFilter, _
                                      IDOFITEM As String, BulkItemIndex As Long, _
                                      strItemTag As String, strParentID As String) As Boolean
  On Error GoTo Errhandler
  
  CheckForGlobalUnique = CheckForUniqueUsingViews("Global", Datasource, objFilter, IDOFITEM, BulkItemIndex, strItemTag, strParentID)
  Exit Function
Errhandler:
End Function

Private Function BuildEquipmentTag(ByVal strPrefix As String, ByVal strTagSeqNo As String, _
                                   ByVal strSuffix As String) As String

    BuildEquipmentTag = strPrefix & "-" & strTagSeqNo & strSuffix
               
End Function

Private Function BuildInstrumentTag(ByVal strMeasuredVarCode As String, _
                                    ByVal strInstrTypeMod As String, _
                                    ByVal strInstrTagSeqNo As String, _
                                    ByVal strLoopTagSuffix As String, _
                                    ByVal strInstrTagSuffix As String) As String

    BuildInstrumentTag = strMeasuredVarCode & strInstrTypeMod & "-" & _
                         strInstrTagSeqNo & strLoopTagSuffix & strInstrTagSuffix
       
End Function

Private Function BuildInstrLoopTag(ByVal strLoopFunc As String, ByVal strTagSeqNo As String, _
                                   ByVal strSuffix As String) As String

    BuildInstrLoopTag = strLoopFunc & "-" & strTagSeqNo & strSuffix
               
End Function

Private Function BuildNozzleTag(ByVal strPrefix As String, ByVal strTagSeqNo As String, _
                                ByVal strSuffix As String) As String

    BuildNozzleTag = strPrefix & strTagSeqNo & strSuffix
               
End Function

Private Function BuildPipeRunTag(ByVal strUnitName As String, ByVal strTagSeqNo As String, _
                                 ByVal strSuffix As String, ByVal strFluidCode As String) As String

    BuildPipeRunTag = strUnitName & strTagSeqNo & strSuffix
    If Len(strFluidCode) > 0 Then
        BuildPipeRunTag = BuildPipeRunTag & "-" & strFluidCode
    End If

End Function

Private Function BuildSignalRunTag(ByVal strTagSeqNo As String, ByVal strSuffix As String) As String

    BuildSignalRunTag = strTagSeqNo & strSuffix
               
End Function

