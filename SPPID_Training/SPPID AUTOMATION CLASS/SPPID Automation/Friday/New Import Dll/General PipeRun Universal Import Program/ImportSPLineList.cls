VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportSPLineList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit
Option Base 1

Private m_Pbar As igrProgressBar412B.clsProgressBar
Private m_BaseSymbolDir As String

Private Enum ImportAttributes
    PipeRunItemTag = 1
    PipMatlClass = 2
    NormOpPressure = 3
    NormOpTemperature = 4
    AltOpPressure = 5
    AltOpTemp = 6
    ConstStatus = 7
    HTraceReqmt = 8
    HTraceMed = 9
    HTraceTemp = 10
    CoatingReqmt = 11
    TestingSysNumber = 12
    Diameter = 13
    SchThickness = 14
    NormDesignPressure = 15
    NormDesignTemperature = 16
    AltDesignPressure = 17
    AltDesignTemp = 18
    NormOpSpcificGravity = 19
    HoldStatus = 20
    InsulPurpose = 21
    InsulThickness = 22
    CleaningReqmt = 23
    TestingPressure = 24
    TestingFluid = 25
    SymbolName = 26
    PipeRunID = 27
    TagSequenceNo = 28
    TagSuffix = 29
    FluidCode = 30
End Enum

'***************************************************************************
' Procedure:    Import
' Description:  Main import procedure.  This procedure gets called from the
'               ImportFromFile class.
'***************************************************************************
Public Sub Import(objExcelSheet As Object, LMADataSource As LMADataSource)

    Dim ImportItems As Collection
    
    'Get the equipment list data from the spreadsheet.
    Set ImportItems = GetDataFromExcel(objExcelSheet)
    
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
    Dim objPipeRuns As New LMPipeRuns
    Dim objPipeRun As LMPipeRun
    Dim objFilter As LMAFilter
    Dim sSymbolFileName As String
    Dim vPropertyValues As Variant
    Dim objNewItem As LMAItem
    Dim sItemTag As String
    Dim sPipeRunID As String
    Dim sFullSymFileName As String
    
    On Error GoTo errHandler
                
    UpdateStatus LoadResString(150)
    
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = ImportItems.Count
    m_Pbar.PBValue = m_Pbar.PBMin
    m_Pbar.PBMessage = LoadResString(143) & CStr(ImportItems.Count) & ") "
    
    For i = 1 To ImportItems.Count
        vPropertyValues = ImportItems(i)
        sItemTag = vPropertyValues(ImportAttributes.PipeRunItemTag)
        sPipeRunID = vPropertyValues(ImportAttributes.PipeRunID)
        
        'set up a filter for the current id/itemtag.
        Set objFilter = New LMAFilter
        
        If (sPipeRunID <> "") Or (sItemTag <> "") Then
            If (sPipeRunID <> "") Then
                objFilter.Criteria.AddNew
                objFilter.Criteria.Item(1).SourceAttributeName = "SP_ID"
                objFilter.Criteria.Item(1).Operator = "="
                objFilter.Criteria.Item(1).ValueAttribute = CLng(sPipeRunID)
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
            If (objFilter.Criteria.Count > 0) Then
                objPipeRuns.Collect datasource:=LMADataSource, Filter:=objFilter
            End If
            
            If (objPipeRuns.Count = 0) Then   'Add a new item.
                UpdateStatus LoadResString(144), sItemTag
                'returns the path relative to Catalog Root Path in the Options Manager.
                sSymbolFileName = vPropertyValues(ImportAttributes.SymbolName)
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
                    End If
                Else
                    UpdateStatus LoadResString(145) & sFullSymFileName & "'"
                End If
            Else                                'Update the existing item.
                UpdateStatus LoadResString(146), sItemTag
                For Each objPipeRun In objPipeRuns
                    Call UpdateItemProperties(objPipeRun, vPropertyValues)
                Next
            End If
        End If
        
        m_Pbar.PBValue = m_Pbar.PBValue + 1
        m_Pbar.PBMessage = LoadResString(147) & CStr(i) & " of " & CStr(ImportItems.Count) & ") "
    Next i

    Exit Sub

errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description
    
End Sub


Private Sub UpdateItemProperties(objPipeRun As LMPipeRun, vPropertyValues As Variant)
    
    Dim oAttrLMAAttributes As LMAAttributes
    
    On Error GoTo errHandler
    
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objPipeRun.AsLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objPipeRun.Attributes
    
    'update the item with the values read from Excel Sheet
    SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.PipeRunItemTag)
    SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmt)
    SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmt)
    SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceReqmt)
    SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMed)
    SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceTemp)
    SetValue oAttrLMAAttributes, CONST_NominalDiameterAttributeName, vPropertyValues(ImportAttributes.Diameter)
    SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipMatlClass)
    SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulPurpose)
    SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulThickness)
    SetValue oAttrLMAAttributes, CONST_SchOrThkAttributeName, vPropertyValues(ImportAttributes.SchThickness)
    SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstStatus)
    SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
    SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
    SetValue oAttrLMAAttributes, CONST_FluidCodeAttributeName, vPropertyValues(ImportAttributes.FluidCode)
    SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
    SetValue oAttrLMAAttributes, CONST_DgnMaxPressureAttributeName, vPropertyValues(ImportAttributes.NormDesignPressure)
    SetValue oAttrLMAAttributes, CONST_DgnMaxTempAttributeName, vPropertyValues(ImportAttributes.NormDesignTemperature)
    SetValue oAttrLMAAttributes, CONST_AltDgnMaxPressureAttributeName, vPropertyValues(ImportAttributes.AltDesignPressure)
    SetValue oAttrLMAAttributes, CONST_AltDgnMaxTempAttributeName, vPropertyValues(ImportAttributes.AltDesignTemp)
    SetValue oAttrLMAAttributes, CONST_OperMaxPressureAttributeName, vPropertyValues(ImportAttributes.NormOpPressure)
    SetValue oAttrLMAAttributes, CONST_OperMaxTempAttributeName, vPropertyValues(ImportAttributes.NormOpTemperature)
    SetValue oAttrLMAAttributes, CONST_AltOperMaxPressureAttributeName, vPropertyValues(ImportAttributes.AltOpPressure)
    SetValue oAttrLMAAttributes, CONST_AltOperMaxTempAttributeName, vPropertyValues(ImportAttributes.AltOpTemp)
    SetValue oAttrLMAAttributes, CONST_TestMaxPressureAttributeName, vPropertyValues(ImportAttributes.TestingPressure)
    SetValue oAttrLMAAttributes, CONST_TestNameAttributeName, vPropertyValues(ImportAttributes.TestingSysNumber)
    SetValue oAttrLMAAttributes, CONST_TestFluidTypeAttributeName, vPropertyValues(ImportAttributes.TestingFluid)
    If Not IsNull(vPropertyValues(ImportAttributes.NormOpSpcificGravity)) Then
        SetValue oAttrLMAAttributes, CONST_OperMaxSpGravityAttributeName, CStr(vPropertyValues(ImportAttributes.NormOpSpcificGravity))
    Else
        SetValue oAttrLMAAttributes, CONST_OperMaxSpGravityAttributeName, Null
    End If
     
    'commit the changes
    objPipeRun.Commit
    
'    objPipeRun.ItemTag = vPropertyValues(ImportAttributes.PipeRunItemTag)
'    objPipeRun.CoatingReqmts = vPropertyValues(ImportAttributes.CoatingReqmt)
'    objPipeRun.CleaningReqmts = vPropertyValues(ImportAttributes.CleaningReqmt)
'    objPipeRun.HTraceReqmt = vPropertyValues(ImportAttributes.HTraceReqmt)
'    objPipeRun.HTraceMedium = vPropertyValues(ImportAttributes.HTraceMed)
'    objPipeRun.HTraceMediumTemp = vPropertyValues(ImportAttributes.HTraceTemp)
'    objPipeRun.NominalDiameter = vPropertyValues(ImportAttributes.Diameter)
'    objPipeRun.PipingMaterialsClass = vPropertyValues(ImportAttributes.PipMatlClass)
'    objPipeRun.InsulPurpose = vPropertyValues(ImportAttributes.InsulPurpose)
'    objPipeRun.InsulThick = vPropertyValues(ImportAttributes.InsulThickness)
'    objPipeRun.ScheduleOrThickness = vPropertyValues(ImportAttributes.SchThickness)
'    objPipeRun.ConstructionStatus = vPropertyValues(ImportAttributes.ConstStatus)
'    objPipeRun.Attributes.Item("TagSequenceNo").Value = vPropertyValues(ImportAttributes.TagSequenceNo)
'    objPipeRun.TagSuffix = vPropertyValues(ImportAttributes.TagSuffix)
'    objPipeRun.OperFluidCode = vPropertyValues(ImportAttributes.FluidCode)
'    objPipeRun.AsLMAItem.ISPItem.ExpandAttributes = True
'    objPipeRun.Attributes("HoldStatus.StatusValue").Value = vPropertyValues(ImportAttributes.HoldStatus)
'    objPipeRun.Attributes("ProcessDesign.Max.Pressure").Value = vPropertyValues(ImportAttributes.NormDesignPressure)
'    objPipeRun.Attributes("ProcessDesign.Max.Temperature").Value = vPropertyValues(ImportAttributes.NormDesignTemperature)
'    objPipeRun.Attributes("ProcessAlternateDesign.Max.Pressure").Value = vPropertyValues(ImportAttributes.AltDesignPressure)
'    objPipeRun.Attributes("ProcessAlternateDesign.Max.Temperature").Value = vPropertyValues(ImportAttributes.AltDesignTemp)
'    objPipeRun.Attributes("ProcessOperating.Max.Pressure").Value = vPropertyValues(ImportAttributes.NormOpPressure)
'    objPipeRun.Attributes("ProcessOperating.Max.Temperature").Value = vPropertyValues(ImportAttributes.NormOpTemperature)
'    objPipeRun.Attributes("ProcessAlternateOperating.Max.Pressure").Value = vPropertyValues(ImportAttributes.AltOpPressure)
'    objPipeRun.Attributes("ProcessAlternateOperating.Max.Temperature").Value = vPropertyValues(ImportAttributes.AltOpTemp)
'    objPipeRun.Attributes("ProcessTest.Max.Pressure").Value = vPropertyValues(ImportAttributes.TestingPressure)
'    objPipeRun.Attributes("ProcessTest.Name").Value = vPropertyValues(ImportAttributes.TestingSysNumber)
'    objPipeRun.Attributes("ProcessTest.FluidType").Value = vPropertyValues(ImportAttributes.TestingFluid)
'    If Not IsNull(vPropertyValues(ImportAttributes.NormOpSpcificGravity)) Then
'        objPipeRun.Attributes("ProcessOperating.Max.SpecificGravity").Value = CStr(vPropertyValues(ImportAttributes.NormOpSpcificGravity))
'    Else
'        objPipeRun.Attributes("ProcessOperating.Max.SpecificGravity").Value = Null
'    End If
    
    Exit Sub
    
errHandler:
    
    UpdateStatus LoadResString(120) & Err.Description
                        
End Sub

'***************************************************************************
' Procedure:    GetDataFromExcel
' Description:  Reads data from a Microsoft Excel worksheet. The data is
'               returned as a collection of variant arrays which contain each
'               items property values.
'***************************************************************************
Private Function GetDataFromExcel(objExcelSheet As Worksheet) As Collection
    
    Dim ImportItems As New Collection
    Dim vPropertyValues(30) As Variant
    Dim i As Long
    Dim lLastRow As Long
    Dim sItemTag As String
    Dim sID As String
    Dim sSymbolName As String
    Dim strPrefixCharacter As String
    
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

    For i = 8 To lLastRow
        sSymbolName = objExcelSheet.Cells(i, 18)
        sID = objExcelSheet.Cells(i, 19)
        sItemTag = objExcelSheet.Cells(i, 1)
        If (sSymbolName <> "" Or sID <> "" Or sItemTag <> "") Then
            vPropertyValues(ImportAttributes.PipeRunItemTag) = sItemTag
            vPropertyValues(ImportAttributes.PipMatlClass) = objExcelSheet.Cells(i, 2).Value
            vPropertyValues(ImportAttributes.ConstStatus) = objExcelSheet.Cells(i, 9).Value
            vPropertyValues(ImportAttributes.HTraceReqmt) = objExcelSheet.Cells(i, 10).Value
            vPropertyValues(ImportAttributes.HTraceMed) = objExcelSheet.Cells(i, 11).Value
            vPropertyValues(ImportAttributes.CoatingReqmt) = objExcelSheet.Cells(i, 13).Value
            vPropertyValues(ImportAttributes.TestingSysNumber) = objExcelSheet.Cells(i, 14).Value
            vPropertyValues(ImportAttributes.Diameter) = objExcelSheet.Cells(i + 1, 1).Value
            vPropertyValues(ImportAttributes.HoldStatus) = objExcelSheet.Cells(i + 1, 9).Value
            vPropertyValues(ImportAttributes.InsulPurpose) = objExcelSheet.Cells(i + 1, 10).Value
            vPropertyValues(ImportAttributes.CleaningReqmt) = objExcelSheet.Cells(i + 1, 12).Value
            vPropertyValues(ImportAttributes.TestingFluid) = objExcelSheet.Cells(i + 1, 14).Value
            vPropertyValues(ImportAttributes.TagSequenceNo) = objExcelSheet.Cells(i, 20).Value
            vPropertyValues(ImportAttributes.TagSuffix) = objExcelSheet.Cells(i, 21).Value
            vPropertyValues(ImportAttributes.FluidCode) = objExcelSheet.Cells(i, 22).Value
            vPropertyValues(ImportAttributes.SymbolName) = sSymbolName
            vPropertyValues(ImportAttributes.PipeRunID) = sID
            
            'UoM properties can be allowed to have apostophe as prefix
            strPrefixCharacter = objExcelSheet.Cells(i, 4).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.NormOpPressure) = strPrefixCharacter & objExcelSheet.Cells(i, 4).Value
            Else
                vPropertyValues(ImportAttributes.NormOpPressure) = objExcelSheet.Cells(i, 4).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 13).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.TestingPressure) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 13).Value
            Else
                vPropertyValues(ImportAttributes.TestingPressure) = objExcelSheet.Cells(i + 1, 13).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 11).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.InsulThickness) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 11).Value
            Else
                vPropertyValues(ImportAttributes.InsulThickness) = objExcelSheet.Cells(i + 1, 11).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 12).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.HTraceTemp) = strPrefixCharacter & objExcelSheet.Cells(i, 12).Value
            Else
                vPropertyValues(ImportAttributes.HTraceTemp) = objExcelSheet.Cells(i, 12).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 5).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.NormOpTemperature) = strPrefixCharacter & objExcelSheet.Cells(i, 5).Value
            Else
                vPropertyValues(ImportAttributes.NormOpTemperature) = objExcelSheet.Cells(i, 5).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 6).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.AltOpPressure) = strPrefixCharacter & objExcelSheet.Cells(i, 6).Value
            Else
                vPropertyValues(ImportAttributes.AltOpPressure) = objExcelSheet.Cells(i, 6).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 7).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.AltOpTemp) = strPrefixCharacter & objExcelSheet.Cells(i, 7).Value
            Else
                vPropertyValues(ImportAttributes.AltOpTemp) = objExcelSheet.Cells(i, 7).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 2).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.SchThickness) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 2).Value
            Else
                vPropertyValues(ImportAttributes.SchThickness) = objExcelSheet.Cells(i + 1, 2).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 4).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.NormDesignPressure) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 4).Value
            Else
                vPropertyValues(ImportAttributes.NormDesignPressure) = objExcelSheet.Cells(i + 1, 4).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 5).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.NormDesignTemperature) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 5).Value
            Else
                vPropertyValues(ImportAttributes.NormDesignTemperature) = objExcelSheet.Cells(i + 1, 5).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 6).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.AltDesignPressure) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 6).Value
            Else
                vPropertyValues(ImportAttributes.AltDesignPressure) = objExcelSheet.Cells(i + 1, 6).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i + 1, 7).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.AltDesignTemp) = strPrefixCharacter & objExcelSheet.Cells(i + 1, 7).Value
            Else
                vPropertyValues(ImportAttributes.AltDesignTemp) = objExcelSheet.Cells(i + 1, 7).Value
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 8).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.NormOpSpcificGravity) = strPrefixCharacter & objExcelSheet.Cells(i, 8).Value
            Else
                vPropertyValues(ImportAttributes.NormOpSpcificGravity) = objExcelSheet.Cells(i, 8).Value
            End If
            
            ReplaceEmptyWithNull vPropertyValues
            ImportItems.Add vPropertyValues
            i = i + 1
        End If
        m_Pbar.PBValue = i
    Next i
    
    Set GetDataFromExcel = ImportItems
            
    Exit Function
    
errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description
    
End Function

Public Property Set ProgressBar(objPBar As igrProgressBar412B.clsProgressBar)
    Set m_Pbar = objPBar
End Property

Public Property Let BaseSymbolDir(sBaseSymbolDir As String)
    m_BaseSymbolDir = sBaseSymbolDir
End Property



Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub
