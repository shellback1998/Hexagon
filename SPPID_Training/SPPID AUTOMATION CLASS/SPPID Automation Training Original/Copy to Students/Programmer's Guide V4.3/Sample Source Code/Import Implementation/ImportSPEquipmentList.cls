VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportSPEquipmentList"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit
Option Base 1

Private m_Pbar As igrProgressBar412.clsProgressBar
Private m_BaseSymbolDir As String

Private Enum ImportAttributes
    ItemTag = 1
    Name = 2
    EquipmentType = 3
    HTraceRequirement = 4
    PipingMaterialsClass = 5
    MaterialOfConstClass = 6
    HTraceMedium = 7
    HTraceMediumTemp = 8
    CoatingReqmts = 9
    InsulationTemp = 10
    InsulationPurpose = 11
    InsulationThickness = 12
    CleaningReqmts = 13
    SymbolName = 14
    TagPrefix = 15
    TagSequenceNo = 16
    TagSuffix = 17
    ConstructionStatus = 18
    HoldStatus = 19
    TypeOfDriver = 20
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
    Dim objEquipments As New LMEquipments
    Dim objEquipment As LMEquipment
    Dim objFilter As LMAFilter
    Dim sSymbolFileName As String
    Dim vPropertyValues As Variant
    Dim objNewItem As LMAItem
    Dim sItemTag As String
    Dim sFullSymFileName As String
    
    On Error GoTo errHandler
                
    UpdateStatus LoadResString(150)
    
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = ImportItems.Count
    m_Pbar.PBValue = m_Pbar.PBMin
    m_Pbar.PBMessage = LoadResString(143) & CStr(ImportItems.Count) & ") "
    
    For i = 1 To ImportItems.Count
    
        vPropertyValues = ImportItems(i)
        sItemTag = vPropertyValues(ImportAttributes.ItemTag)
        
        'set up a filter for the current itemtag.
        Set objFilter = New LMAFilter
        If (sItemTag <> "") Then
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(1).SourceAttributeName = "ItemTag"
            objFilter.Criteria.Item(1).Operator = "="
            objFilter.Criteria.Item(1).ValueAttribute = sItemTag
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(2).SourceAttributeName = CONST_RepresentationItemStatusAttribute
            objFilter.Criteria.Item(2).Operator = "="
            objFilter.Criteria.Item(2).ValueAttribute = 1   'active status
            objFilter.Criteria.Item(2).Conjunctive = -1     'match all
                        
            'See if this item already exists in the database.
            If (objFilter.Criteria.Count > 0) Then
                objEquipments.Collect DataSource:=LMADataSource, Filter:=objFilter
            End If
            
            If (objEquipments.Count = 0) Then   'Add a new item.
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
                    Set objEquipment = LMADataSource.GetEquipment(objNewItem.ID)
                    If Not (objEquipment Is Nothing) Then
                        Call UpdateItemProperties(objEquipment, vPropertyValues)
                    End If
                Else
                    UpdateStatus LoadResString(145) & sFullSymFileName & "'"
                End If
            Else                                'Update the existing item.
                UpdateStatus LoadResString(146), sItemTag
                For Each objEquipment In objEquipments
                    Call UpdateItemProperties(objEquipment, vPropertyValues)
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

Private Sub UpdateItemProperties(objEquipment As LMEquipment, vPropertyValues As Variant)
    
    Dim EquipmentOther As LMEquipmentOther
    Dim EquipmentVessel As LMVessel
    Dim EquipmentExchanger As LMExchanger
    Dim EquipmentMechanical As LMMechanical
    Dim EquipmentComponent As LMEquipComponent
    Dim oAttrLMAAttributes As LMAAttributes
    
    On Error GoTo errHandler
    
    Select Case objEquipment.ClassIndex
        Case 1  'General Equipment
            'get specific LMEquipmentOther item
            Set EquipmentOther = PIDDataSource.GetEquipmentOther(objEquipment.ID)
            
            'set ExpandAttributes = TRUE to get complete set of attributes on the item
            EquipmentOther.AsLMAItem.ISPItem.ExpandAttributes = True
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentOther.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            SetValue oAttrLMAAttributes, CONST_EquipTypeAttributeName, vPropertyValues(ImportAttributes.EquipmentType)
            SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MaterialOfConstClass)
            SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipingMaterialsClass)
            SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceRequirement)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMedium)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceMediumTemp)
            SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulationPurpose)
            SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulationThickness)
            SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmts)
            SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmts)
            SetValue oAttrLMAAttributes, CONST_TagPrefixAttributeName, vPropertyValues(ImportAttributes.TagPrefix)
            SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
            SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
            SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstructionStatus)
            SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
            
            'commit the changes
            EquipmentOther.Commit

        Case 2  'Vessel Equipment
            'get specific LMVessel item
            Set EquipmentVessel = PIDDataSource.GetVessel(objEquipment.ID)
            
            'set ExpandAttributes = TRUE to get complete set of attributes on the item
            EquipmentVessel.AsLMAItem.ISPItem.ExpandAttributes = True
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentVessel.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            SetValue oAttrLMAAttributes, CONST_EquipTypeAttributeName, vPropertyValues(ImportAttributes.EquipmentType)
            SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MaterialOfConstClass)
            SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipingMaterialsClass)
            SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceRequirement)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMedium)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceMediumTemp)
            SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulationPurpose)
            SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulationThickness)
            SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmts)
            SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmts)
            SetValue oAttrLMAAttributes, CONST_TagPrefixAttributeName, vPropertyValues(ImportAttributes.TagPrefix)
            SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
            SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
            SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstructionStatus)
            SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
            
            'commit the changes
            EquipmentVessel.Commit
            
        Case 3  'Heat Transfer Equipment
            'get specific LMExchanger item
            Set EquipmentExchanger = PIDDataSource.GetExchanger(objEquipment.ID)
            
            'set ExpandAttributes = TRUE to get complete set of attributes on the item
            EquipmentExchanger.AsLMAItem.ISPItem.ExpandAttributes = True
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentExchanger.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            SetValue oAttrLMAAttributes, CONST_EquipTypeAttributeName, vPropertyValues(ImportAttributes.EquipmentType)
            SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MaterialOfConstClass)
            SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipingMaterialsClass)
            SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceRequirement)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMedium)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceMediumTemp)
            SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulationPurpose)
            SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulationThickness)
            SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmts)
            SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmts)
            SetValue oAttrLMAAttributes, CONST_TagPrefixAttributeName, vPropertyValues(ImportAttributes.TagPrefix)
            SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
            SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
            SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstructionStatus)
            SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
            
            'commit the changes
            EquipmentExchanger.Commit
            
        Case 4  'Mechanical Equipment
            'get specific LMMechanical item
            Set EquipmentMechanical = PIDDataSource.GetMechanical(objEquipment.ID)
            
            'set ExpandAttributes = TRUE to get complete set of attributes on the item
            EquipmentMechanical.AsLMAItem.ISPItem.ExpandAttributes = True
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentMechanical.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            SetValue oAttrLMAAttributes, CONST_EquipTypeAttributeName, vPropertyValues(ImportAttributes.EquipmentType)
            SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MaterialOfConstClass)
            SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipingMaterialsClass)
            SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceRequirement)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMedium)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceMediumTemp)
            SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulationPurpose)
            SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulationThickness)
            SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmts)
            SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmts)
            SetValue oAttrLMAAttributes, CONST_TagPrefixAttributeName, vPropertyValues(ImportAttributes.TagPrefix)
            SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
            SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
            SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstructionStatus)
            SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
            SetValue oAttrLMAAttributes, CONST_TypeOfDriverAttributeName, vPropertyValues(ImportAttributes.TypeOfDriver)
            
            'commit the changes
            EquipmentMechanical.Commit
            
        Case 6  'Equipment Component
            'get specific LMEquipComponent item
            Set EquipmentComponent = PIDDataSource.GetEquipComponent(objEquipment.ID)
            
            'set ExpandAttributes = TRUE to get complete set of attributes on the item
            EquipmentComponent.AsLMAItem.ISPItem.ExpandAttributes = True
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentComponent.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            SetValue oAttrLMAAttributes, CONST_EquipTypeAttributeName, vPropertyValues(ImportAttributes.EquipmentType)
            SetValue oAttrLMAAttributes, CONST_MtlConstClassAttributeName, vPropertyValues(ImportAttributes.MaterialOfConstClass)
            SetValue oAttrLMAAttributes, CONST_PpMtlClassAttributeName, vPropertyValues(ImportAttributes.PipingMaterialsClass)
            SetValue oAttrLMAAttributes, CONST_HTraceReqmtAttributeName, vPropertyValues(ImportAttributes.HTraceRequirement)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumAttributeName, vPropertyValues(ImportAttributes.HTraceMedium)
            SetValue oAttrLMAAttributes, CONST_HTraceMediumTempAttributeName, vPropertyValues(ImportAttributes.HTraceMediumTemp)
            SetValue oAttrLMAAttributes, CONST_InsulPurposeAttributeName, vPropertyValues(ImportAttributes.InsulationPurpose)
            SetValue oAttrLMAAttributes, CONST_InsulThickAttributeName, vPropertyValues(ImportAttributes.InsulationThickness)
            SetValue oAttrLMAAttributes, CONST_CoatingReqmtsAttributeName, vPropertyValues(ImportAttributes.CoatingReqmts)
            SetValue oAttrLMAAttributes, CONST_CleaningReqmtsAttributeName, vPropertyValues(ImportAttributes.CleaningReqmts)
            SetValue oAttrLMAAttributes, CONST_TagPrefixAttributeName, vPropertyValues(ImportAttributes.TagPrefix)
            SetValue oAttrLMAAttributes, CONST_TagSequenceNoAttributeName, vPropertyValues(ImportAttributes.TagSequenceNo)
            SetValue oAttrLMAAttributes, CONST_TagSuffixAttributeName, vPropertyValues(ImportAttributes.TagSuffix)
            SetValue oAttrLMAAttributes, CONST_ConstStatusAttributeName, vPropertyValues(ImportAttributes.ConstructionStatus)
            SetValue oAttrLMAAttributes, CONST_HoldStatusValueAttributeName, vPropertyValues(ImportAttributes.HoldStatus)
            
            'commit the changes
            EquipmentComponent.Commit
            
    End Select
    
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
    Dim vPropertyValues(20) As Variant
    Dim i As Long
    Dim lLastRow As Long
    Dim sItemTag As String
    Dim sSymbolName As String
    Dim strPrefixCharacter As String
    
    On Error GoTo errHandler
            
    UpdateStatus LoadResString(148) & objExcelSheet.Name & "'"
    m_Pbar.PBMessage = LoadResString(149)
    m_Pbar.PBMin = 6

    lLastRow = 1
    On Error Resume Next
    lLastRow = objExcelSheet.Cells.Find("*", objExcelSheet.Range("A1"), , , xlByRows, xlPrevious).Row
    On Error GoTo errHandler
    
    m_Pbar.PBMax = lLastRow
    
    For i = 7 To lLastRow
        sItemTag = objExcelSheet.Cells(i, 1)
        sSymbolName = objExcelSheet.Cells(i, 20)
        If (sItemTag <> "" Or sSymbolName <> "") Then
            vPropertyValues(ImportAttributes.ItemTag) = sItemTag
            vPropertyValues(ImportAttributes.Name) = objExcelSheet.Cells(i, 2)
            vPropertyValues(ImportAttributes.EquipmentType) = objExcelSheet.Cells(i, 3)
            vPropertyValues(ImportAttributes.ConstructionStatus) = objExcelSheet.Cells(i, 5)
            vPropertyValues(ImportAttributes.HoldStatus) = objExcelSheet.Cells(i, 6)
            vPropertyValues(ImportAttributes.MaterialOfConstClass) = objExcelSheet.Cells(i, 7)
            vPropertyValues(ImportAttributes.TypeOfDriver) = objExcelSheet.Cells(i, 8)
            vPropertyValues(ImportAttributes.PipingMaterialsClass) = objExcelSheet.Cells(i, 9)
            vPropertyValues(ImportAttributes.HTraceRequirement) = objExcelSheet.Cells(i, 10)
            vPropertyValues(ImportAttributes.HTraceMedium) = objExcelSheet.Cells(i, 11)
            vPropertyValues(ImportAttributes.InsulationPurpose) = objExcelSheet.Cells(i, 13)
            vPropertyValues(ImportAttributes.CoatingReqmts) = objExcelSheet.Cells(i, 15)
            vPropertyValues(ImportAttributes.CleaningReqmts) = objExcelSheet.Cells(i, 16)
            vPropertyValues(ImportAttributes.SymbolName) = sSymbolName
            vPropertyValues(ImportAttributes.TagPrefix) = objExcelSheet.Cells(i, 25)
            vPropertyValues(ImportAttributes.TagSequenceNo) = objExcelSheet.Cells(i, 26)
            vPropertyValues(ImportAttributes.TagSuffix) = objExcelSheet.Cells(i, 27)
            
            'UoM properties can be allowed to have apostophe as prefix
            strPrefixCharacter = objExcelSheet.Cells(i, 12).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.HTraceMediumTemp) = strPrefixCharacter & objExcelSheet.Cells(i, 12)
            Else
                vPropertyValues(ImportAttributes.HTraceMediumTemp) = objExcelSheet.Cells(i, 12)
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 14).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.InsulationThickness) = strPrefixCharacter & objExcelSheet.Cells(i, 14)
            Else
                vPropertyValues(ImportAttributes.InsulationThickness) = objExcelSheet.Cells(i, 14)
            End If
            
            ReplaceEmptyWithNull vPropertyValues
            ImportItems.Add vPropertyValues
            m_Pbar.PBValue = i
        End If
    Next i
    
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
