VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportPipeRunListReport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*******************************************************************************
' for BL's demo purpose
'*******************************************************************************
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





'***************************************************************************
' Procedure:    Import
' Description:  Main import procedure.  This procedure gets called from the
'               ImportFromFile class.
'***************************************************************************
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
    
    For j = 1 To objImportDefinitions.Count
        Debug.Print objImportDefinitions.Item(j).Attr
        If objImportDefinitions.Item(j).Attr = CONST_SP_ID Then
            SP_ID_Location = j
            Exit For
        End If
    Next
    For j = 1 To objImportDefinitions.Count
        If objImportDefinitions.Item(j).Attr = CONST_FileName Then
            FileName_Location = j
            Exit For
        End If
    Next
    'find ItemTag
    For j = 1 To objImportDefinitions.Count
        If objImportDefinitions.Item(j).Attr = CONST_ItemTag Then
            ItemTag_Location = j
            Exit For
        End If
    Next
    For i = 1 To ImportItems.Count
        vPropertyValues = ImportItems(i)
        m_Pbar.PBValue = m_Pbar.PBValue + 1
        m_Pbar.PBMessage = LoadResString(147) & CStr(i) & " of " & CStr(ImportItems.Count) & ") "
'        sItemTag = vPropertyValues(ImportAttributes.PipeRunItemTag)
'        sPipeRunID = vPropertyValues(ImportAttributes.PipeRunID)
        'find where SP_ID located
        
        sPipeRunID = IIf(IsNull(vPropertyValues(SP_ID_Location)), "", vPropertyValues(SP_ID_Location))
        If ItemTag_Location > 0 Then
            sItemTag = IIf(IsNull(vPropertyValues(ItemTag_Location)), "", vPropertyValues(ItemTag_Location))
        Else
            sItemTag = ""
        End If
        
        'set up a filter for the current id/itemtag.
        Set objFilter = New LMAFilter
        If (sPipeRunID <> "") Or (sItemTag <> "") Then
            If (sPipeRunID <> "") Then
                objFilter.Criteria.AddNew
                objFilter.Criteria.Item(1).SourceAttributeName = "SP_ID"
                objFilter.Criteria.Item(1).Operator = "="
                objFilter.Criteria.Item(1).ValueAttribute = sPipeRunID
            ElseIf (sItemTag <> "") Then
                objFilter.Criteria.AddNew
                objFilter.Criteria.Item(1).SourceAttributeName = "ItemTag"
                objFilter.Criteria.Item(1).Operator = "="
                objFilter.Criteria.Item(1).ValueAttribute = sItemTag
            End If
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(2).SourceAttributeName = CONST_RepresentationItemStatusAttribute
            objFilter.Criteria.Item(2).Operator = "="
            objFilter.Criteria.Item(2).ValueAttribute = 1   'active status
            objFilter.Criteria.Item(2).Conjunctive = -1     'match all
            
            'See if this item already exists in the database.
            Set objPipeRuns = New LMPipeRuns
            objPipeRuns.Collect datasource:=LMADataSource, Filter:=objFilter
            'add by BL 4/4/01
            If objPipeRuns.Count = 0 Then
                'UpdateStatus LoadResString(120) & "Cannot find piperun with ID= " & sPipeRunID
                UpdateStatus LoadResString(144), sItemTag
                sSymbolFileName = IIf(IsNull(vPropertyValues(FileName_Location)), "", vPropertyValues(FileName_Location))
                If Left$(sSymbolFileName, 1) <> "\" Then
                        sSymbolFileName = "\" & sSymbolFileName
                End If
                'construct full symbol file name
                sFullSymFileName = m_BaseSymbolDir & sSymbolFileName
                'check for the existence of file
                If (Dir(sFullSymFileName) <> "") Then
                
                    Set objNewItem = PIDCreateItem(sSymbolFileName)
                    Set objPipeRun = LMADataSource.GetPipeRun(objNewItem.ID)
                    If Not (objPipeRun Is Nothing) Then
                        Call UpdateItemProperties(objPipeRun, vPropertyValues)
                    '2/17/04 comment out by BL, not necessary any more in v4.0
                        'add by BL to call ItemTag validation code
'''                        If Not objItemTag Is Nothing Then
'''                            Set objItemTag = Nothing
'''                        End If
'''                        If Not Items Is Nothing Then
'''                            Set Items = Nothing
'''                        End If
'''                        Set Items = New LMAItems
'''                        Items.Add objPipeRun.AsLMAItem
'''                        Set objItemTag = CreateObject("ItemTag.ItemTagFunc")
'''                        objItemTag.DoValidateProperty LMADataSource, Items, "ItemTag", objPipeRun.ItemTag
                    End If
                Else
                    UpdateStatus LoadResString(145) & sSymbolFileName & "'"
                End If
            Else                                'Update the existing item.
                UpdateStatus LoadResString(146), sItemTag
                For Each objPipeRun In objPipeRuns
                    Call UpdateItemProperties(objPipeRun, vPropertyValues)
                    '2/17/04 comment out by BL, not necessary any more in v4.0
'''                    'add by BL to call ItemTag validation code
'''                    If Not objItemTag Is Nothing Then
'''                        Set objItemTag = Nothing
'''                    End If
'''                    If Not Items Is Nothing Then
'''                        Set Items = Nothing
'''                    End If
'''                    Set Items = New LMAItems
'''                    Items.Add objPipeRun.AsLMAItem
'''                    Set objItemTag = CreateObject("ItemTag.ItemTagFunc")
'''                    objItemTag.DoValidateProperty LMADataSource, Items, "ItemTag", objPipeRun.ItemTag
                    
                Next
            End If
        Else
            'no SP_ID or ItemTag, just create new item
            UpdateStatus LoadResString(144)
            sSymbolFileName = IIf(IsNull(vPropertyValues(FileName_Location)), "", vPropertyValues(FileName_Location))
            If Left$(sSymbolFileName, 1) <> "\" Then
                    sSymbolFileName = "\" & sSymbolFileName
            End If
            'construct full symbol file name
            sFullSymFileName = m_BaseSymbolDir & sSymbolFileName
            'check for the existence of file
            If (Dir(sFullSymFileName) <> "") Then
            
                Set objNewItem = PIDCreateItem(sSymbolFileName)
                Set objPipeRun = LMADataSource.GetPipeRun(objNewItem.ID)
                If Not (objPipeRun Is Nothing) Then
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
                End If
            Else
                UpdateStatus LoadResString(145) & sSymbolFileName & "'"
            End If
            
        End If
    Next i

    Exit Sub

errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description & " @ sub UpdateDatabase"
End Sub



Private Sub UpdateItemProperties(objPipeRun As LMPipeRun, vPropertyValues As Variant)
On Error GoTo errorHandler
    Dim i As Long
    Dim oAttrLMAAttributes As LMAAttributes
    
    UpdateStatus "1"
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objPipeRun.AsLMAItem.ISPItem.ExpandAttributes = True
    UpdateStatus "2"
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objPipeRun.Attributes
    UpdateStatus "3"
    For i = 1 To objImportDefinitions.Count
        If objImportDefinitions.Item(i).Item = CONST_PipeRun Then
            If objImportDefinitions.Item(i).Attr <> CONST_SP_ID _
                And objImportDefinitions.Item(i).Attr <> CONST_ItemTag _
                And objImportDefinitions.Item(i).Attr <> CONST_PlantGroupName _
                And objImportDefinitions.Item(i).Attr <> CONST_UnitCode _
                And objImportDefinitions.Item(i).Attr <> CONST_TestSysItemTag _
                And objImportDefinitions.Item(i).Attr <> CONST_FileName _
                And objImportDefinitions.Item(i).Attr <> CONST_DrawingName Then
                UpdateStatus 4 + i & objImportDefinitions.Item(i).Attr
                SetValue oAttrLMAAttributes, objImportDefinitions.Item(i).Attr, vPropertyValues(i)
                UpdateStatus 4 + i & " done"
            End If
        End If
    Next
    UpdateStatus "100"
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
        Column = objImportDefinitions.Item(CONST_FileName).Column
        sSymbolName = objExcelSheet.Cells(i, Column)
        Column = objImportDefinitions.Item(CONST_SP_ID).Column
        sID = objExcelSheet.Cells(i, Column)
'        sItemTag = objExcelSheet.Cells(i, 1)
'        If (sSymbolName <> "" Or sID <> "" Or sItemTag <> "") Then
        If (sSymbolName <> "" Or sID <> "") Then
            For j = 1 To objImportDefinitions.Count
                Column = objImportDefinitions.Item(j).Column
                vPropertyValues(j) = objExcelSheet.Cells(i, Column).Value
            Next
            ReplaceEmptyWithNull vPropertyValues
            ImportItems.Add vPropertyValues
        End If
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
        ReadHeadInfo = CLng(strValue) + 1
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
    Set objRange = objExcelSheet.Range("200:200").SpecialCells(xlCellTypeConstants)
    
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

