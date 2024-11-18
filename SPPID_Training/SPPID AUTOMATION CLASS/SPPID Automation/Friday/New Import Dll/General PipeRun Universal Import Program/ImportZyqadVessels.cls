VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportZyqadVessels"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit
Option Base 1

Private m_Pbar As igrProgressBar412B.clsProgressBar
Private m_BaseSymbolDir As String

Private Enum ImportAttributes
    ItemTag = 1
    Description = 2
    DesignTemperature = 3
    DesignPressure = 4
    SymbolName = 5
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
    Dim objVessels As New LMVessels
    Dim objVessel As LMVessel
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
                objVessels.Collect datasource:=LMADataSource, Filter:=objFilter
            End If
            
            If (objVessels.Count = 0) Then   'Add a new item.
                UpdateStatus LoadResString(144), sItemTag
                'returns the path relative to Catalog Root Path in the Options Manager.
                sSymbolFileName = vPropertyValues(ImportAttributes.SymbolName)
                If Left$(sSymbolFileName, 1) <> "\" Then
                    sSymbolFileName = "\" & sSymbolFileName
                End If
                'construct full symbol file name
                sFullSymFileName = m_BaseSymbolDir & sSymbolFileName
                
                'check for the existence of file
                'sSymbolFileName = m_BaseSymbolDir & "\" & Mid(vPropertyValues(ImportAttributes.SymbolName), _
                                  InStr(1, vPropertyValues(ImportAttributes.SymbolName), "\") + 1)
                If (Dir(sFullSymFileName) <> "") Then
                    Set objNewItem = PIDCreateItem(sSymbolFileName)
                    Set objVessel = LMADataSource.GetVessel(objNewItem.ID)
                    If Not (objVessel Is Nothing) Then
                        Call UpdateItemProperties(objVessel, vPropertyValues)
                    End If
                Else
                    UpdateStatus LoadResString(145) & sFullSymFileName & "'"
                End If
            Else                                'Update the existing item.
                UpdateStatus LoadResString(146), sItemTag
                For Each objVessel In objVessels
                    Call UpdateItemProperties(objVessel, vPropertyValues)
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

Private Sub UpdateItemProperties(objVessel As LMVessel, vPropertyValues As Variant)
    Dim oAttrLMAAttributes As LMAAttributes
    
    On Error GoTo errHandler
    
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objVessel.AsLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objVessel.Attributes
        
    'update the item with the values read from Excel Sheet
    SetValue oAttrLMAAttributes, CONST_ItemTagAttributeName, vPropertyValues(ImportAttributes.ItemTag)
    SetValue oAttrLMAAttributes, CONST_DescriptionAttributeName, vPropertyValues(ImportAttributes.Description)
    SetValue oAttrLMAAttributes, CONST_DgnMaxTempAttributeName, Trim(vPropertyValues(ImportAttributes.DesignTemperature)) & " C"
    SetValue oAttrLMAAttributes, CONST_DgnMaxPressureAttributeName, Trim(vPropertyValues(ImportAttributes.DesignPressure)) & " bar"
    
    'commit the changes
    objVessel.Commit
    
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
    Dim vPropertyValues(5) As Variant
    Dim i As Long
    Dim lLastRow As Long
    Dim sItemTag As String
    Dim sSymbolName As String
    Dim strPrefixCharacter As String
    
    On Error GoTo errHandler
            
    UpdateStatus LoadResString(148) & objExcelSheet.Name & "'"
    m_Pbar.PBMessage = LoadResString(149)
    m_Pbar.PBMin = 11

    lLastRow = 1
    On Error Resume Next
    lLastRow = objExcelSheet.Cells.Find("*", objExcelSheet.Range("A1"), , , xlByRows, xlPrevious).Row
    On Error GoTo errHandler
    
    m_Pbar.PBMax = lLastRow
    
    For i = 12 To lLastRow Step 3
        sItemTag = objExcelSheet.Cells(i, 2)
        sSymbolName = objExcelSheet.Cells(i, 7)
        If (sItemTag = "NOTES: ") Then   'We have reached the end of the report.
            Exit For
        ElseIf (sItemTag <> "" Or sSymbolName <> "") Then
            vPropertyValues(ImportAttributes.ItemTag) = sItemTag
            vPropertyValues(ImportAttributes.SymbolName) = sSymbolName
            vPropertyValues(ImportAttributes.Description) = objExcelSheet.Cells(i, 5)
            
            'UoM properties can be allowed to have apostophe as prefix
            strPrefixCharacter = objExcelSheet.Cells(i, 20).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.DesignTemperature) = strPrefixCharacter & objExcelSheet.Cells(i, 20)
            Else
                vPropertyValues(ImportAttributes.DesignTemperature) = objExcelSheet.Cells(i, 20)
            End If
            
            strPrefixCharacter = objExcelSheet.Cells(i, 24).PrefixCharacter
            If Len(strPrefixCharacter) > 0 Then
                vPropertyValues(ImportAttributes.DesignPressure) = strPrefixCharacter & objExcelSheet.Cells(i, 24)
            Else
                vPropertyValues(ImportAttributes.DesignPressure) = objExcelSheet.Cells(i, 24)
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

Public Property Set ProgressBar(objPBar As igrProgressBar412B.clsProgressBar)
    Set m_Pbar = objPBar
End Property

Public Property Let BaseSymbolDir(sBaseSymbolDir As String)
    m_BaseSymbolDir = sBaseSymbolDir
End Property




Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub
