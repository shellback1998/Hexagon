VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportCustomPipeList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'***************************************************************************
' Procedure:    Import
' Description:  Main import procedure.  This procedure gets called from the
'               ImportFromFile class.
' For Tim Ng, using sPlantGroupName, sTagSequenceNo, sNominalDiameter,
' sOperFluidCode, sPipingMaterialsClass, sInsulPurpose, sHTraceMedium as criterion
' and no new item will be created.
'***************************************************************************

Option Explicit
Option Base 1

Private m_Pbar As igrProgressBar412B.clsProgressBar
Private m_BaseSymbolDir As String
Private objImportDefinitions As ImportDefinitions

Private Const CONST_PipeRun As String = "Pipe Run"
Private Const CONST_SP_ID As String = "SP_ID"
Private Const CONST_ItemTag = "ItemTag"
Private Const CONST_PlantGroupName = "PlantGroup.Name"
Private Const CONST_TestSysItemTag = "TestSystem.ItemTag"
Private Const CONST_UnitCode = "Unit.UnitDetail.UnitCode"
Private Const CONST_Representation As String = "Representation"
Private Const CONST_FileName As String = "FileName"
Private Const CONST_DrawingName As String = "Drawing.Name"
Private Const CONST_DrawingNumber As String = "Drawing.DrawingNumber"
'
Private Const CONST_TagSequenceNo As String = "TagSequenceNo"
Private Const CONST_NominalDiameter As String = "NominalDiameter"
Private Const CONST_OperFluidCode As String = "OperFluidCode"
Private Const CONST_PipingMaterialsClass As String = "PipingMaterialsClass"
Private Const CONST_InsulPurpose As String = "InsulPurpose"
Private Const CONST_HTraceMedium As String = "HTraceMedium"
'





Public Sub Import(objExcelSheet As Object, LMADataSource As LMADataSource, Optional objDefinitionSheet As Object)

    Dim ImportItems As Collection
    
    'Get the equipment list data from the spreadsheet.
    Set ImportItems = GetDataFromExcel(objDefinitionSheet, objExcelSheet)
    
    If Not ImportItems Is Nothing Then
        'Now that we have the data, let's update the database/stockpile.
        If (ImportItems.Count > 0) Then
            Call UpdateDatabase(LMADataSource, ImportItems)
        End If
    End If
End Sub

'***************************************************************************
' Procedure:    UpdateDatabase
' Description:  Updates the SmartPlant P&ID database with data imported
'               from Microsoft Excel using SmartPlant Logical Model
'               Automation
'***************************************************************************

Private Sub UpdateDatabase(LMADataSource As LMADataSource, ImportItems As Collection)

    Dim i As Long
    Dim objPipeRuns As LMPipeRuns
    Dim objPipeRun As LMPipeRun
    Dim objFilter As LMAFilter
    Dim sSymbolFileName As String
    Dim vPropertyValues As Variant
    Dim objNewItem As LMAItem
    Dim sItemTag As String
    Dim sPipeRunID As String
    Dim objItemTag As ILMForeignCalc
    Dim Items As LMAItems
    Dim sFullSymFileName As String
    Dim sPlantGroupName As String, sTagSequenceNo As String, sNominalDiameter As String, sOperFluidCode As String, sPipingMaterialsClass As String, sInsulPurpose As String, sHTraceMedium As String
    Dim PlantGroupName_Location As Long, TagSequenceNo_Location As Long, NominalDiameter_Location As Long, OperFluidCode_Location As Long, PipingMaterialsClass_Location As Long, InsulPurpose_Location As Long, HTraceMedium_Location As Long
    Dim blnWrong As Boolean
    Dim objISPChildFilter As ISPFilter
            
    On Error GoTo errHandler
                
    UpdateStatus LoadResString(150)
    
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = ImportItems.Count
    m_Pbar.PBValue = m_Pbar.PBMin
    m_Pbar.PBMessage = LoadResString(143) & CStr(ImportItems.Count) & ") "
    
    'find where SP_ID is located and where filename is located
    Dim j As Long
    Dim SP_ID_Location As Long
    Dim FileName_Location As Long
    Dim ItemTag_Location As Long
    
'    For j = 1 To objImportDefinitions.Count
'        Debug.Print objImportDefinitions.Item(j).Attr
'        If objImportDefinitions.Item(j).Attr = CONST_SP_ID Then
'            SP_ID_Location = j
'            Exit For
'        End If
'    Next
    
'    'find FileName
'    For j = 1 To objImportDefinitions.Count
'        If objImportDefinitions.Item(j).Attr = CONST_FileName Then
'            FileName_Location = j
'            Exit For
'        End If
'    Next

    'file name
    sSymbolFileName = "\Piping\Routing\Process Lines\Primary Piping.sym"
    'find ItemTag
    For j = 1 To objImportDefinitions.Count
        If objImportDefinitions.Item(j).Attr = CONST_PlantGroupName Then
            PlantGroupName_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_TagSequenceNo Then
            TagSequenceNo_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_NominalDiameter Then
            NominalDiameter_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_OperFluidCode Then
            OperFluidCode_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_PipingMaterialsClass Then
            PipingMaterialsClass_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_InsulPurpose Then
            InsulPurpose_Location = j
        End If
        If objImportDefinitions.Item(j).Attr = CONST_HTraceMedium Then
            HTraceMedium_Location = j
        End If
    Next
    
    If PlantGroupName_Location > 0 And TagSequenceNo_Location > 0 And NominalDiameter_Location > 0 _
        And OperFluidCode_Location > 0 And PipingMaterialsClass_Location > 0 _
        And InsulPurpose_Location > 0 And HTraceMedium_Location > 0 Then
    
        For i = 1 To ImportItems.Count
            vPropertyValues = ImportItems(i)
            m_Pbar.PBValue = m_Pbar.PBValue + 1
            m_Pbar.PBMessage = LoadResString(147) & CStr(i) & " of " & CStr(ImportItems.Count) & ") "
    '        sItemTag = vPropertyValues(ImportAttributes.PipeRunItemTag)
    '        sPipeRunID = vPropertyValues(ImportAttributes.PipeRunID)
            'find where SP_ID located
            
            'sPipeRunID = IIf(IsNull(vPropertyValues(SP_ID_Location)), "", vPropertyValues(SP_ID_Location))
            
            sPlantGroupName = IIf(IsNull(vPropertyValues(PlantGroupName_Location)), vbNullString, vPropertyValues(PlantGroupName_Location))
            sTagSequenceNo = IIf(IsNull(vPropertyValues(TagSequenceNo_Location)), vbNullString, vPropertyValues(TagSequenceNo_Location))
            sNominalDiameter = IIf(IsNull(vPropertyValues(NominalDiameter_Location)), vbNullString, vPropertyValues(NominalDiameter_Location))
            sOperFluidCode = IIf(IsNull(vPropertyValues(OperFluidCode_Location)), vbNullString, vPropertyValues(OperFluidCode_Location))
            sPipingMaterialsClass = IIf(IsNull(vPropertyValues(PipingMaterialsClass_Location)), vbNullString, vPropertyValues(PipingMaterialsClass_Location))
            sInsulPurpose = IIf(IsNull(vPropertyValues(InsulPurpose_Location)), vbNullString, vPropertyValues(InsulPurpose_Location))
            sHTraceMedium = IIf(IsNull(vPropertyValues(HTraceMedium_Location)), vbNullString, vPropertyValues(HTraceMedium_Location))
            
            'set up a filter with 6 criteria plus itemstus
            'strError = "Forming compound filter"
            Set objFilter = New LMAFilter
            Set objFilter = FormCompoundFilter(LMADataSource, sPlantGroupName, sTagSequenceNo, sNominalDiameter, sOperFluidCode, sPipingMaterialsClass, sInsulPurpose, sHTraceMedium)
            'collection piperuns with the Criteria from database
            'following code make sure that objFilter is successfully
            'initialize before use it to collect piperuns
            'set blnWrong to False first
            blnWrong = False
            If Not objFilter Is Nothing Then
                If Not objFilter.ChildFilters Is Nothing Then
                    If objFilter.ChildFilters.Count > 0 Then
                        For Each objISPChildFilter In objFilter.ChildFilters
                            If objISPChildFilter.Criteria.Count = 0 Then
                                blnWrong = True
                            End If
                        Next
                        If Not blnWrong Then
                            'strError = "call LMPiepruns.Collect method"
                            Set objPipeRuns = New LMPipeRuns
                            objPipeRuns.Collect datasource:=LMADataSource, Filter:=objFilter
                        End If
                    End If
                End If
            End If
            'strError = "Finished call LMPiperuns.colleciton method"
            If Not blnWrong Then
                'strError = "Call objPiperuns.count"
                If objPipeRuns.Count = 0 Then
                    'BL 1/27/04 comments out per Colt's request, don't create new items
                    UpdateStatus "Couldn't find match Piperun, no new item is created."
'''                    'UpdateStatus LoadResString(120) & "Cannot find piperun with ID= " & sPipeRunID
'''                    UpdateStatus LoadResString(144), sItemTag
''''                    sSymbolFileName = IIf(IsNull(vPropertyValues(FileName_Location)), "", vPropertyValues(FileName_Location))
''''                    If Left$(sSymbolFileName, 1) <> "\" Then
''''                            sSymbolFileName = "\" & sSymbolFileName
''''                    End If
'''                    'construct full symbol file name
'''                    sFullSymFileName = m_BaseSymbolDir & sSymbolFileName
'''                    'check for the existence of file
'''                    If (Dir(sFullSymFileName) <> "") Then
'''
'''                        Set objNewItem = PIDCreateItem(sSymbolFileName)
'''                        Set objPipeRun = LMADataSource.GetPipeRun(objNewItem.ID)
'''                        If Not (objPipeRun Is Nothing) Then
'''                            Call UpdateItemProperties(objPipeRun, vPropertyValues)
'''                            'BL 1/27/04, comment this routine per Colt's request, don't touch ItemTag during import
'''''                            'add by BL to call ItemTag validation code
'''''                            If Not objItemTag Is Nothing Then
'''''                                Set objItemTag = Nothing
'''''                            End If
'''''                            If Not Items Is Nothing Then
'''''                                Set Items = Nothing
'''''                            End If
'''''                            Set Items = New LMAItems
'''''                            Items.Add objPipeRun.AsLMAItem
'''''                            Set objItemTag = CreateObject("ItemTag.ItemTagFunc")
'''''                            objItemTag.DoValidateProperty LMADataSource, Items, "ItemTag", objPipeRun.ItemTag
'''                        End If
'''                    Else
'''                        UpdateStatus LoadResString(145) & sSymbolFileName & "'"
'''                    End If
'''                    UpdateStatus "Finished - Creating new item"
                Else                                'Update the existing item.
                    UpdateStatus LoadResString(146), sItemTag
                    For Each objPipeRun In objPipeRuns
                        Call UpdateItemProperties(objPipeRun, vPropertyValues)
                        'add by BL to call ItemTag validation code
                        If Not objItemTag Is Nothing Then
                            Set objItemTag = Nothing
                        End If
                        If Not Items Is Nothing Then
                            Set Items = Nothing
                        End If
                        Set Items = New LMAItems
                        Items.Add objPipeRun.AsLMAItem
                        Set objItemTag = CreateObject("ItemTag.ItemTagFunc")
                        objItemTag.DoValidateProperty LMADataSource, Items, "ItemTag", objPipeRun.ItemTag
                        
                    Next
                    UpdateStatus "Finished - Updating item properties"
                End If
            Else
                'if failed to initialize a filter, ignore this Record in
                'Excel file
                Err.Raise 10003, , "Failed to initialize a Filter"
            End If
NextItem: Next i
    Else
        MsgBox "Missing properties needed for search criteria, import quits..."
    End If
    Exit Sub

errHandler:
    'Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description & " @ sub UpdateDatabase"
    Resume NextItem
End Sub



Private Sub UpdateItemProperties(objPipeRun As LMPipeRun, vPropertyValues As Variant)
On Error GoTo errorHandler
    Dim i As Long
    Dim oAttrLMAAttributes As LMAAttributes
    
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objPipeRun.AsLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objPipeRun.Attributes
    
    For i = 1 To objImportDefinitions.Count
        If objImportDefinitions.Item(i).Item = CONST_PipeRun Then
            If objImportDefinitions.Item(i).Attr <> CONST_SP_ID _
                And objImportDefinitions.Item(i).Attr <> CONST_ItemTag _
                And objImportDefinitions.Item(i).Attr <> CONST_PlantGroupName _
                And objImportDefinitions.Item(i).Attr <> CONST_UnitCode _
                And objImportDefinitions.Item(i).Attr <> CONST_TestSysItemTag _
                And objImportDefinitions.Item(i).Attr <> CONST_FileName _
                And objImportDefinitions.Item(i).Attr <> CONST_DrawingName _
                And objImportDefinitions.Item(i).Attr <> CONST_TagSequenceNo _
                And objImportDefinitions.Item(i).Attr <> CONST_NominalDiameter _
                And objImportDefinitions.Item(i).Attr <> CONST_OperFluidCode _
                And objImportDefinitions.Item(i).Attr <> CONST_PipingMaterialsClass _
                And objImportDefinitions.Item(i).Attr <> CONST_InsulPurpose _
                And objImportDefinitions.Item(i).Attr <> CONST_HTraceMedium Then
                SetValue oAttrLMAAttributes, objImportDefinitions.Item(i).Attr, vPropertyValues(i)
            End If
        End If
    Next
    objPipeRun.Commit
    Exit Sub
errorHandler:
    UpdateStatus LoadResString(120) & Err.Description & " SP_ID=" & objPipeRun.ID & " @ Sub UpdateItemProperties"
    Resume Next
End Sub



'***************************************************************************
' Procedure:    GetDataFromExcel
' Description:  Reads data from a Microsoft Excel worksheet. The data is
'               returned as a collection of variant arrays which contain each
'               items property values.
'***************************************************************************
Private Function GetDataFromExcel(objDefinitionSheet As Worksheet, objExcelSheet As Worksheet) As Collection
    
    Dim ImportItems As New Collection
    Dim vPropertyValues(50) As Variant
    Dim i As Long
    Dim lLastRow As Long
    Dim sItemTag As String
    Dim sID As String
    Dim sSymbolName As String
    Dim strError As String
    
    On Error GoTo errHandler
            
    UpdateStatus LoadResString(148) & objExcelSheet.Name & "'"
    m_Pbar.PBMessage = LoadResString(149)
    m_Pbar.PBMin = 7
    m_Pbar.PBValue = m_Pbar.PBMin
    
    lLastRow = 1
    On Error Resume Next
    lLastRow = objExcelSheet.Cells.Find("*", objExcelSheet.Range("A1"), , , xlByRows, xlPrevious).Row
    On Error GoTo errHandler

    m_Pbar.PBMax = lLastRow
    
    'add by BL 4/2/01
    '==================================================================
    Dim lngFirstRow As Long
    Dim j As Long
    Dim Column As Long
    
    'call ReadHeadInfo to read report head information
    strError = "Calling ReadHeadInfo"
    lngFirstRow = ReadHeadInfo(objDefinitionSheet)
    strError = "Finished - Calling ReadHeadInfo"
    'call ReadDefinition sub to get definition information
    strError = "Calling ReadDefinition"
    ReadDefinition objDefinitionSheet
    strError = "Finished - Calling ReadDefinition"

'    For i = 8 To lLastRow
    strError = "Starting loop"
    For i = lngFirstRow To lLastRow
'        Column = objImportDefinitions.Item(CONST_FileName).Column
'        sSymbolName = objExcelSheet.Cells(i, Column)
'        Column = objImportDefinitions.Item(CONST_SP_ID).Column
'        sID = objExcelSheet.Cells(i, Column)

'        If (sSymbolName <> "" Or sID <> "") Then
            For j = 1 To objImportDefinitions.Count
                Column = objImportDefinitions.Item(j).Column
                vPropertyValues(j) = objExcelSheet.Cells(i, Column).Value
            Next
            ReplaceEmptyWithNull vPropertyValues
            ImportItems.Add vPropertyValues
'        End If
        m_Pbar.PBValue = i
    Next i
    strError = "Finished - Starting loop"
    
    Set GetDataFromExcel = ImportItems
            
    Exit Function
    
errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description
    
End Function


'added by BL on 4/2/01
Private Function ReadHeadInfo(ByVal objExcelSheet As Worksheet) As Long
On Error GoTo errorHandler
    Dim strValue As String
    
    strValue = objExcelSheet.Cells(2, 1).Value
    If Not IsEmpty(strValue) Then
        ReadHeadInfo = CLng(strValue)
    Else
        Err.Raise 3001, , "Couldn't find report head information"
    End If
    
    Exit Function
errorHandler:
    UpdateStatus LoadResString(120) & Err.Description
End Function

'added by BL on 4/2/01
Private Sub ReadDefinition(ByVal objExcelSheet As Worksheet)
On Error GoTo errorHandler

    Dim objRange As Range
    Dim objCell As Object
    Dim strAttribute As String
    Dim strItem As String
    Dim lngAttributeID As Long
    Dim objPipeRun As LMPipeRun
    Dim lngSPID As Long
    Dim strSPID As String
    
    Dim strCellValue As String
    Dim objImportDefinition As ImportDefinition
    
    Set objImportDefinitions = New ImportDefinitions
    Set objRange = objExcelSheet.Range("3:3").SpecialCells(xlCellTypeConstants)
    
    For Each objCell In objRange
        'example of string
        'Old report v2.2
        '#Pipe Run::Piping Matl Class::161#
        'New report v3.0
        '#Pipe Run::Tag Seq No::TagSequenceNo#
        strCellValue = ""
        strAttribute = ""
        strItem = ""
        strCellValue = objCell.Value
        'get rid of #
        strCellValue = Mid(strCellValue, 2, Len(strCellValue) - 2)
        strItem = Left(strCellValue, InStr(1, strCellValue, "::") - 1)
        'lngAttributeID = CLng(Mid(strCellValue, InStr(InStr(1, strCellValue, "::") + 1, strCellValue, "::") + 2))
        strAttribute = Mid(strCellValue, InStr(InStr(1, strCellValue, "::") + 1, strCellValue, "::") + 2)
        'strAttribute = ResolveName(strItem, lngAttributeID, DataSource, objPipeRun)
        If strAttribute = "" Then
            UpdateStatus LoadResString(120) & " Cannot resolve an attribute name. Attribute ID = " & lngAttributeID
        End If
        Set objImportDefinition = New ImportDefinition
        objImportDefinition.Column = objCell.Column
        'objImportDefinition.Value = lngAttributeID
        objImportDefinition.Attr = strAttribute
        objImportDefinition.Item = strItem
        objImportDefinitions.Add objImportDefinition
    Next
    Set objPipeRun = Nothing
    Exit Sub
errorHandler:
    'UpdateStatus LoadResString(120) & Err.Description
    Err.Raise Err.Number, Err.Source, Err.Description
End Sub

Public Property Set ProgressBar(objPBar As igrProgressBar412B.clsProgressBar)
    Set m_Pbar = objPBar
End Property

Public Property Let BaseSymbolDir(sBaseSymbolDir As String)
    m_BaseSymbolDir = sBaseSymbolDir
End Property



Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub


Private Function FormCompoundFilter(objDatasource As LMADataSource, strPlantGroupName As String, strTagSeqNo As String, strNPD As String, strFluidCode As String, strPMC As String, strInsulPurpose As String, strHTMedium As String) As LMAFilter

On Error GoTo errHandler

    Dim lngFluidCode As Long
    Dim lngNPD As Long
    Dim lngInsulPurpose As Long
    Dim lngHTMedium As Long
    Dim objMainFilter As LMAFilter
    Dim objISPMainfilter As ISPFilter
    Dim objFilter1 As LMAFilter
    Dim objISPFilter1 As ISPFilter
    Dim objFilter2 As LMAFilter
    Dim objISPFilter2 As ISPFilter
    Dim objFilter3 As LMAFilter
    Dim objISPFilter3 As ISPFilter
    Dim objFilter4 As LMAFilter
    Dim objISPFilter4 As ISPFilter
    Dim objFilter5 As LMAFilter
    Dim objISPFilter5 As ISPFilter
    Dim objFilter6 As LMAFilter
    Dim objISPFilter6 As ISPFilter
    Dim objFilter7 As LMAFilter
    Dim objISPFilter7 As ISPFilter
    'added a new child filter for PMC, BL 1/22/02
    Dim objFilter8 As LMAFilter
    Dim objISPFilter8 As ISPFilter
    Dim objFilter9 As LMAFilter
    Dim objISPFilter9 As ISPFilter
    
    'If strFluidCode <> "" Then
        lngFluidCode = ConvertToIndex(objDatasource, "OperFluidCode", strFluidCode)
    'End If
    'Nominal diameter doesn't have Index for blank/Null value
    If strNPD <> "" Then
        lngNPD = ConvertToIndex(objDatasource, "NominalDiameter", strNPD)
    End If
    'If strInsulPurpose <> "" Then
        lngInsulPurpose = ConvertToIndex(objDatasource, "InsulPurpose", strInsulPurpose)
    'End If
    'If strHTMedium <> "" Then
        lngHTMedium = ConvertToIndex(objDatasource, "HTraceMedium", strHTMedium)
    'End If
    
    Set objMainFilter = New LMAFilter
    Set objISPMainfilter = objMainFilter 'using the ispfilter interface
    objMainFilter.ItemType = CONST_PipeRun
    objMainFilter.Conjunctive = True
    'FilterType can be set only through ISPFilter, since it is reay only property
    'for SPFilter
    objISPMainfilter.FilterType = ISPFilterType.Compound '1 represents compound filter
    
    'initialize the filters
    Set objFilter1 = New LMAFilter
    Set objISPFilter1 = objFilter1
    Set objFilter2 = New LMAFilter
    Set objISPFilter2 = objFilter2
    Set objFilter3 = New LMAFilter
    Set objISPFilter3 = objFilter3
    Set objFilter4 = New LMAFilter
    Set objISPFilter4 = objFilter4
    Set objFilter5 = New LMAFilter
    Set objISPFilter5 = objFilter5
    Set objFilter6 = New LMAFilter
    Set objISPFilter6 = objFilter6
    Set objFilter7 = New LMAFilter
    Set objISPFilter7 = objFilter7
    Set objFilter8 = New LMAFilter
    Set objISPFilter8 = objFilter8
    Set objFilter9 = New LMAFilter
    Set objISPFilter9 = objFilter9
    
'        strFluidCode = "X"
'        strUnitName = "unit1"
'        strTagSeqNo = "110"
'        strNPD = "4"""
'        strInsulPurpose = "Brick"
'        strHTMedium = "SR"
    
    'set up a filter for the current id/itemtag.
    
    'create filter with criteria
    objISPFilter1.ItemType = CONST_PipeRun
    objISPFilter1.Name = "ImportFilter1"
    objISPFilter1.Criteria.AddNew ("c1")
    objISPFilter1.Criteria.Item("c1").SourceAttributeName = "OperFluidCode"
    objISPFilter1.Criteria.Item("c1").Operator = "="
    If strFluidCode <> "" Then
        objISPFilter1.Criteria.Item("c1").ValueAttribute = lngFluidCode
    Else
        'this way, you can fine either NULL or Blank value
        objISPFilter1.Criteria.Item("c1").ValueAttribute = vbNullString 'if you use index, index value is 0
        objISPFilter1.Criteria.AddNew ("c2")
        objISPFilter1.Criteria.Item("c2").SourceAttributeName = "OperFluidCode"
        objISPFilter1.Criteria.Item("c2").Operator = "="
        objISPFilter1.Criteria.Item("c2").ValueAttribute = lngFluidCode
        objISPFilter1.Criteria.Item("c2").Conjunctive = False 'match any
    End If
    
    objISPFilter2.ItemType = CONST_PipeRun
    objISPFilter2.Name = "ImportFilter2"
    objISPFilter2.Criteria.AddNew ("c1")
    objISPFilter2.Criteria.Item("c1").SourceAttributeName = "PlantGroup.Name"
    objISPFilter2.Criteria.Item("c1").Operator = "="
    objISPFilter2.Criteria.Item("c1").ValueAttribute = strPlantGroupName
    
    
    objISPFilter3.ItemType = CONST_PipeRun
    objISPFilter3.Name = "ImportFilter3"
    objISPFilter3.Criteria.AddNew ("c1")
    objISPFilter3.Criteria.Item("c1").SourceAttributeName = "TagSequenceNo"
    objISPFilter3.Criteria.Item("c1").Operator = "="
    objISPFilter3.Criteria.Item("c1").ValueAttribute = strTagSeqNo
    
    
    objISPFilter4.ItemType = CONST_PipeRun
    objISPFilter4.Name = "ImportFilter4"
    objISPFilter4.Criteria.AddNew ("c1")
    objISPFilter4.Criteria.Item("c1").SourceAttributeName = "NominalDiameter"
    objISPFilter4.Criteria.Item("c1").Operator = "="
    If strNPD <> "" Then
        objISPFilter4.Criteria.Item("c1").ValueAttribute = lngNPD
    Else
        'NominalDiameter is special, it doesn't have a Blank value, it can only be NULL
        objISPFilter4.Criteria.Item("c1").ValueAttribute = vbNullString
    End If
    
    objISPFilter5.ItemType = CONST_PipeRun
    objISPFilter5.Name = "ImportFilter5"
    objISPFilter5.Criteria.AddNew ("c1")
    objISPFilter5.Criteria.Item("c1").SourceAttributeName = "InsulPurpose"
    objISPFilter5.Criteria.Item("c1").Operator = "="
    If strInsulPurpose <> "" Then
        objISPFilter5.Criteria.Item("c1").ValueAttribute = lngInsulPurpose
    Else
        objISPFilter5.Criteria.Item("c1").ValueAttribute = vbNullString
        objISPFilter5.Criteria.AddNew ("c2")
        objISPFilter5.Criteria.Item("c2").SourceAttributeName = "InsulPurpose"
        objISPFilter5.Criteria.Item("c2").Operator = "="
        objISPFilter5.Criteria.Item("c2").ValueAttribute = lngInsulPurpose
        objISPFilter5.Criteria.Item("c2").Conjunctive = False 'match any
    End If
    
    objISPFilter6.ItemType = CONST_PipeRun
    objISPFilter6.Name = "ImportFilter6"
    objISPFilter6.Criteria.AddNew ("c1")
    objISPFilter6.Criteria.Item("c1").SourceAttributeName = "HTraceMedium"
    objISPFilter6.Criteria.Item("c1").Operator = "="
    If strHTMedium <> "" Then
        objISPFilter6.Criteria.Item("c1").ValueAttribute = lngHTMedium
    Else
        objISPFilter6.Criteria.Item("c1").ValueAttribute = vbNullString
        objISPFilter6.Criteria.AddNew ("c2")
        objISPFilter6.Criteria.Item("c2").SourceAttributeName = "HTraceMedium"
        objISPFilter6.Criteria.Item("c2").Operator = "="
        objISPFilter6.Criteria.Item("c2").ValueAttribute = lngHTMedium
        objISPFilter6.Criteria.Item("c2").Conjunctive = False 'match any
    End If
    
    objISPFilter7.ItemType = CONST_PipeRun
    objISPFilter7.Name = "ImportFilter7"
    objISPFilter7.Criteria.AddNew ("c1")
    objISPFilter7.Criteria.Item("c1").SourceAttributeName = "Representation.ItemStatus"
    objISPFilter7.Criteria.Item("c1").Operator = "="
    objISPFilter7.Criteria.Item("c1").ValueAttribute = 1 'active
    
    objISPFilter8.ItemType = CONST_PipeRun
    objISPFilter8.Name = "ImportFilter8"
    objISPFilter8.Criteria.AddNew ("c1")
    objISPFilter8.Criteria.Item("c1").SourceAttributeName = "PipingMaterialsClass"
    objISPFilter8.Criteria.Item("c1").Operator = "="
    objISPFilter8.Criteria.Item("c1").ValueAttribute = strPMC 'active
    
    objISPFilter9.ItemType = CONST_PipeRun
    objISPFilter9.Name = "ImportFilter9"
    objISPFilter9.Criteria.AddNew ("c1")
    objISPFilter9.Criteria.Item("c1").SourceAttributeName = "ItemStatus"
    objISPFilter9.Criteria.Item("c1").Operator = "="
    objISPFilter9.Criteria.Item("c1").ValueAttribute = 1 'active
    
    'set objMainFilter
    objMainFilter.ChildFilters.Add objISPFilter1
    objMainFilter.ChildFilters.Add objISPFilter2
    objMainFilter.ChildFilters.Add objISPFilter3
    objMainFilter.ChildFilters.Add objISPFilter4
    objMainFilter.ChildFilters.Add objISPFilter5
    objMainFilter.ChildFilters.Add objISPFilter6
    objMainFilter.ChildFilters.Add objISPFilter7
    objMainFilter.ChildFilters.Add objISPFilter8
    objMainFilter.ChildFilters.Add objISPFilter9
    
    'set return value
    Set FormCompoundFilter = objMainFilter
    
errHandler:
    Set objMainFilter = Nothing
    Set objISPMainfilter = Nothing
    Set objFilter1 = Nothing
    Set objFilter2 = Nothing
    Set objFilter3 = Nothing
    Set objFilter4 = Nothing
    Set objFilter5 = Nothing
    Set objFilter6 = Nothing
    Set objFilter7 = Nothing
    Set objISPFilter1 = Nothing
    Set objISPFilter2 = Nothing
    Set objISPFilter3 = Nothing
    Set objISPFilter4 = Nothing
    Set objISPFilter5 = Nothing
    Set objISPFilter6 = Nothing
    Set objISPFilter7 = Nothing
    
    If Err.Number <> 0 Then
        'Set m_Pbar = Nothing
        Err.Raise Err.Number, Err.Source, Err.Description
        'UpdateStatus LoadResString(120) & Err.Description
        Set FormCompoundFilter = Nothing
    End If
    
End Function


'this function convert String value of an enumeration to Index
Private Function ConvertToIndex(objDatasource As LMADataSource, strProperty As String, strValue As String) As Long
On Error GoTo errorHandler
    Dim lngCount As Long
    Dim i As Long
    Dim objAttribute As LMAAttribute
    Dim blnFound As Boolean
    Dim strCodeList As String
    
    Select Case strProperty
        Case CONST_NominalDiameter
            strCodeList = "Nominal Diameter"
        Case CONST_OperFluidCode
            strCodeList = "Fluid Code"
        
        Case CONST_InsulPurpose
            strCodeList = "Insulation Purpose"
        
        Case CONST_HTraceMedium
            strCodeList = "Heat Trace Medium"
    End Select
    
    ConvertToIndex = objDatasource.CodeList(strCodeList).EnumeratedAttributes.GetItemIndex(strValue)
    
    Exit Function
errorHandler:
    If Err.Number <> 0 Then
        UpdateStatus LoadResString(120) & Err.Description
    End If
    If Not blnFound Then
        On Error GoTo 0
        Err.Raise 10001, , "Cannot find Index for Enumeration value for " & strProperty & ". The Value is " & strValue
    End If

End Function

