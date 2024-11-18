VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportSPNozzleList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit
Option Base 1

Private m_Pbar As igrProgressBar412.clsProgressBar
Private m_BaseSymbolDir As String

Private Enum ImportAttributes
    ItemTag = 1
    EquipmentItemTag = 2
    ConstStatus = 3
    NormOpPressure = 4
    NormOpTemperature = 5
    AltOpPressure = 6
    AltOpTemp = 7
    MatOfConst = 8
    HTraceReqmt = 9
    HTraceTemp = 10
    HTraceMed = 11
    Diameter = 12
    Rating = 13
    NozzleType = 14
    HoldStatus = 15
    NormDesignPressure = 16
    NormDesignTemperature = 17
    AltDesignPressure = 18
    AltDesignTemp = 19
    PipMatlClass = 20
    InsulPurpose = 21
    InsulThickness = 22
    Prep = 23
    Remarks = 24
    SymbolName = 25
    NozzleID = 26
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
    Dim objNozzles As New LMNozzles
    Dim objNozzle As LMNozzle
    Dim objFilter As LMAFilter
    Dim sSymbolFileName As String
    Dim vPropertyValues As Variant
    Dim objNewItem As LMAItem
    Dim sID As String
            
    On Error GoTo errHandler
                
    UpdateStatus LoadResString(150)
    
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = ImportItems.Count
    m_Pbar.PBValue = m_Pbar.PBMin
    m_Pbar.PBMessage = LoadResString(143) & CStr(ImportItems.Count) & ") "
    
    For i = 1 To ImportItems.Count
        vPropertyValues = ImportItems(i)
        sID = vPropertyValues(ImportAttributes.NozzleID)
        
        If sID <> "" Then
            'set up a filter for the current nozzle id.
            Set objFilter = New LMAFilter
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(1).SourceAttributeName = "SP_ID"
            objFilter.Criteria.Item(1).Operator = "="
            objFilter.Criteria.Item(1).ValueAttribute = sID
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(2).SourceAttributeName = CONST_RepresentationItemStatusAttribute
            objFilter.Criteria.Item(2).Operator = "="
            objFilter.Criteria.Item(2).ValueAttribute = 1   'active status
            objFilter.Criteria.Item(2).Conjunctive = -1     'match all
                    
            'See if this item already exists in the database.
            objNozzles.Collect DataSource:=LMADataSource, Filter:=objFilter
            
            If (objNozzles.Count = 0) Then  'Nozzle was not found in the database.
                UpdateStatus "Error -> Item not found in the database. ID=" & sID
            Else                            'Update the existing item.
                UpdateStatus LoadResString(146), sID
                For Each objNozzle In objNozzles
                    Call UpdateItemProperties(objNozzle, vPropertyValues)
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

Private Sub UpdateItemProperties(objNozzle As LMNozzle, vPropertyValues As Variant)
    Dim oAttrLMAAttributes As LMAAttributes
    Dim oLMPipingPoint As LMPipingPoint
    Dim i As Integer
    
    On Error GoTo errHandler
    
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objNozzle.AsLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objNozzle.Attributes
        
    'update the item with the values read from Excel Sheet
    SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
    SetValue oAttrLMAAttributes, CONST_NozzleTypeAttributeName, vPropertyValues(ImportAttributes.NozzleType)
    SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceReqmt)
    SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMed)
    SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceTemp)
    SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MatOfConst)
    SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipMatlClass)
    SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulPurpose)
    SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulThickness)
    SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstStatus)
    SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
    SetValue oAttrLMAAttributes, CONST_DgnMaxPressureAttributeName, vPropertyValues(ImportAttributes.NormDesignPressure)
    SetValue oAttrLMAAttributes, CONST_DgnMaxTempAttributeName, vPropertyValues(ImportAttributes.NormDesignTemperature)
    SetValue oAttrLMAAttributes, CONST_AltOperMaxPressureAttributeName, vPropertyValues(ImportAttributes.AltOpPressure)
    SetValue oAttrLMAAttributes, CONST_AltOperMaxTempAttributeName, vPropertyValues(ImportAttributes.AltOpTemp)
    SetValue oAttrLMAAttributes, CONST_OperMaxPressureAttributeName, vPropertyValues(ImportAttributes.NormOpPressure)
    SetValue oAttrLMAAttributes, CONST_OperMaxTempAttributeName, vPropertyValues(ImportAttributes.NormOpTemperature)
    SetValue oAttrLMAAttributes, CONST_AltDgnMaxPressureAttributeName, vPropertyValues(ImportAttributes.AltDesignPressure)
    SetValue oAttrLMAAttributes, CONST_AltDgnMaxTempAttributeName, vPropertyValues(ImportAttributes.AltDesignTemp)
        
    i = 0
    For Each oLMPipingPoint In objNozzle.PipingPoints
        i = i + 1
        SetValue oAttrLMAAttributes, CONST_PipingPointItemName & CStr(i) & "." & CONST_EndPrepAttributeName, vPropertyValues(ImportAttributes.Prep)
        SetValue oAttrLMAAttributes, CONST_PipingPointItemName & CStr(i) & "." & CONST_NominalDiameterAttributeName, vPropertyValues(ImportAttributes.Diameter)
        SetValue oAttrLMAAttributes, CONST_PipingPointItemName & CStr(i) & "." & CONST_RatingAttributeName, vPropertyValues(ImportAttributes.Rating)
    Next
    
    'update Nozzle item changes
    objNozzle.Commit
    
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
    Dim vPropertyValues(26) As Variant
    Dim i As Long
    Dim lRow As Long
    Dim sID As String
    Dim objRange As Range
    Dim objCell As Object
    Dim strPrefixCharacter As String
    
    On Error GoTo errHandler
            
    UpdateStatus LoadResString(148) & objExcelSheet.Name & "'"
    m_Pbar.PBMessage = LoadResString(149)
    m_Pbar.PBMin = 0
    m_Pbar.PBValue = 0

    'Find any cells that have a nozzle id in column Q.
    On Error Resume Next
    Set objRange = objExcelSheet.Range("Q:Q").SpecialCells(xlCellTypeConstants)
    On Error GoTo errHandler

    If (objRange Is Nothing) Then
        Exit Function
    End If

    m_Pbar.PBMax = objRange.Cells.Count

    i = 1
    For Each objCell In objRange.Cells
        lRow = objCell.Row
        vPropertyValues(ImportAttributes.NozzleID) = objExcelSheet.Cells(lRow, 17).Value
        vPropertyValues(ImportAttributes.ItemTag) = objExcelSheet.Cells(lRow, 2).Value
        vPropertyValues(ImportAttributes.EquipmentItemTag) = objExcelSheet.Cells(lRow, 1).Value
        vPropertyValues(ImportAttributes.ConstStatus) = objExcelSheet.Cells(lRow, 3).Value
        vPropertyValues(ImportAttributes.MatOfConst) = objExcelSheet.Cells(lRow, 8).Value
        vPropertyValues(ImportAttributes.HTraceReqmt) = objExcelSheet.Cells(lRow, 9).Value
        vPropertyValues(ImportAttributes.HTraceMed) = objExcelSheet.Cells(lRow, 11).Value
        vPropertyValues(ImportAttributes.Diameter) = objExcelSheet.Cells(lRow, 12).Value
        vPropertyValues(ImportAttributes.Rating) = objExcelSheet.Cells(lRow, 13).Value
        vPropertyValues(ImportAttributes.NozzleType) = objExcelSheet.Cells(lRow + 1, 2).Value
        vPropertyValues(ImportAttributes.HoldStatus) = objExcelSheet.Cells(lRow + 1, 3).Value
        vPropertyValues(ImportAttributes.PipMatlClass) = objExcelSheet.Cells(lRow + 1, 8).Value
        vPropertyValues(ImportAttributes.InsulPurpose) = objExcelSheet.Cells(lRow + 1, 9).Value
        vPropertyValues(ImportAttributes.Prep) = objExcelSheet.Cells(lRow + 1, 12).Value
        vPropertyValues(ImportAttributes.Remarks) = objExcelSheet.Cells(lRow + 1, 13).Value
        vPropertyValues(ImportAttributes.SymbolName) = objExcelSheet.Cells(lRow, 16).Value
        
        'UoM properties can be allowed to have apostophe as prefix
        strPrefixCharacter = objExcelSheet.Cells(lRow, 4).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.NormOpPressure) = strPrefixCharacter & objExcelSheet.Cells(lRow, 4).Value
        Else
            vPropertyValues(ImportAttributes.NormOpPressure) = objExcelSheet.Cells(lRow, 4).Value
        End If
                
        strPrefixCharacter = objExcelSheet.Cells(lRow, 5).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.NormOpTemperature) = strPrefixCharacter & objExcelSheet.Cells(lRow, 5).Value
        Else
            vPropertyValues(ImportAttributes.NormOpTemperature) = objExcelSheet.Cells(lRow, 5).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow, 6).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.AltOpPressure) = strPrefixCharacter & objExcelSheet.Cells(lRow, 6).Value
        Else
            vPropertyValues(ImportAttributes.AltOpPressure) = objExcelSheet.Cells(lRow, 6).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow, 7).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.AltOpTemp) = strPrefixCharacter & objExcelSheet.Cells(lRow, 7).Value
        Else
            vPropertyValues(ImportAttributes.AltOpTemp) = objExcelSheet.Cells(lRow, 7).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow, 10).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.HTraceTemp) = strPrefixCharacter & objExcelSheet.Cells(lRow, 10).Value
        Else
            vPropertyValues(ImportAttributes.HTraceTemp) = objExcelSheet.Cells(lRow, 10).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow + 1, 4).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.NormDesignPressure) = strPrefixCharacter & objExcelSheet.Cells(lRow + 1, 4).Value
        Else
            vPropertyValues(ImportAttributes.NormDesignPressure) = objExcelSheet.Cells(lRow + 1, 4).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow + 1, 5).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.NormDesignTemperature) = strPrefixCharacter & objExcelSheet.Cells(lRow + 1, 5).Value
        Else
            vPropertyValues(ImportAttributes.NormDesignTemperature) = objExcelSheet.Cells(lRow + 1, 5).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow + 1, 6).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.AltDesignPressure) = strPrefixCharacter & objExcelSheet.Cells(lRow + 1, 6).Value
        Else
            vPropertyValues(ImportAttributes.AltDesignPressure) = objExcelSheet.Cells(lRow + 1, 6).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow + 1, 7).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.AltDesignTemp) = strPrefixCharacter & objExcelSheet.Cells(lRow + 1, 7).Value
        Else
            vPropertyValues(ImportAttributes.AltDesignTemp) = objExcelSheet.Cells(lRow + 1, 7).Value
        End If
        
        strPrefixCharacter = objExcelSheet.Cells(lRow + 1, 10).PrefixCharacter
        If Len(strPrefixCharacter) > 0 Then
            vPropertyValues(ImportAttributes.InsulThickness) = strPrefixCharacter & objExcelSheet.Cells(lRow + 1, 10).Value
        Else
            vPropertyValues(ImportAttributes.InsulThickness) = objExcelSheet.Cells(lRow + 1, 10).Value
        End If
        
        
        ReplaceEmptyWithNull vPropertyValues
        ImportItems.Add vPropertyValues
        m_Pbar.PBValue = i
        i = i + 1
    Next
    
    Set GetDataFromExcel = ImportItems
            
    Exit Function
    
errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description
    
End Function

Public Property Set ProgressBar(objPBar As igrProgressBar412.clsProgressBar)
    Set m_Pbar = objPBar
End Property

Public Property Let BaseSymbolDir(sBaseSymbolDir As String)
    m_BaseSymbolDir = sBaseSymbolDir
End Property

Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub
