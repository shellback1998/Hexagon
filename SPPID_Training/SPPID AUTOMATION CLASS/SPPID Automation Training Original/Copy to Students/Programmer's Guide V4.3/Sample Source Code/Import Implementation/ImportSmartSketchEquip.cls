VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportSmartSketchEquip"
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
    Name = 2
    SymbolName = 3
End Enum

'***************************************************************************
' Procedure:    Import
' Description:  Main import procedure.  This procedure gets called from the
'               ImportFromFile class.
'***************************************************************************
Public Sub Import(objExcelSheet As Object, LMADataSource As LMADataSource)

    Dim vItems As Variant
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
    Dim sFullSymFileName As StreamNumberCalc
    
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
            objFilter.Criteria.Item(1).SourceAttributeName = CONST_ItemTagAttributeName '"ItemTag"
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
                'sSymbolFileName = m_BaseSymbolDir & "\" & vPropertyValues(ImportAttributes.SymbolName)
                
                'check for the existence of file
                If (Dir(sFullSymFileName) <> "") Then
                    'PIDCreateItem accepts only the Path relative to Catalog Root Path
                    'for DefinitionFile .
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
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentOther.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            
            'commit the changes
            EquipmentOther.Commit
            
        Case 2  'Vessel Equipment
            'get specific LMVessel item
            Set EquipmentVessel = PIDDataSource.GetVessel(objEquipment.ID)
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentVessel.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
             
             'commit the changes
            EquipmentVessel.Commit

        Case 3  'Heat Transfer Equipment
            'get specific LMExchanger item
            Set EquipmentExchanger = PIDDataSource.GetExchanger(objEquipment.ID)
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentExchanger.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            
            'commit the changes
            EquipmentExchanger.Commit
            
        Case 4  'Mechanical Equipment
            'get specific LMMechanical item
            Set EquipmentMechanical = PIDDataSource.GetMechanical(objEquipment.ID)
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentMechanical.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            
            'commit the changes
            EquipmentMechanical.Commit
        
        Case 6  'Equipment Component
            'get specific LMEquipComponent item
            Set EquipmentComponent = PIDDataSource.GetEquipComponent(objEquipment.ID)
            
            'get reference to LMAttributes object
            Set oAttrLMAAttributes = EquipmentComponent.Attributes
            
            'update the item with the values read from Excel Sheet
            SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
            SetValue oAttrLMAAttributes, CONST_NameAttributeName, vPropertyValues(ImportAttributes.Name)
            
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
    Dim vPropertyValues(3) As Variant
    Dim i As Long
    Dim lLastRow As Long
    Dim sItemTag As String
    Dim sSymbolName As String
    
    On Error GoTo errHandler
            
    UpdateStatus LoadResString(148) & objExcelSheet.Name & "'"
    m_Pbar.PBMessage = LoadResString(149)
    m_Pbar.PBMin = 8
    
    lLastRow = 1
    On Error Resume Next
    lLastRow = objExcelSheet.Cells.Find("*", objExcelSheet.Range("A1"), , , xlByRows, xlPrevious).Row
    On Error GoTo errHandler
    
    m_Pbar.PBMax = lLastRow
    
    For i = 9 To lLastRow
        sItemTag = objExcelSheet.Cells(i, 2)
        sSymbolName = objExcelSheet.Cells(i, 1)
        If (sItemTag <> "" Or sSymbolName <> "") Then
            vPropertyValues(ImportAttributes.ItemTag) = sItemTag
            vPropertyValues(ImportAttributes.SymbolName) = sSymbolName
            vPropertyValues(ImportAttributes.Name) = objExcelSheet.Cells(i, 3)
            
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
