VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportXML"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private m_Pbar As igrProgressBar412.clsProgressBar

Private Const CONST_AttributeNameItem = "AttributeName"
Private Const CONST_AttributeValueItem = "AttributeValue"
Private Const CONST_AttributeUnitsItem = "AttributeUnits"
Private Const CONST_ItemClassificationItem = "ItemClassification"
Private Const CONST_ItemTagName = "Item"
Private Const CONST_ClassificationTagName = "Classification"
Private Const CONST_ItemAttributeTagName = "ItemAttribute"
Private Const CONST_SymbolFileTagName = "SymbolFile"
Private Const CONST_ItemSymbolFileItem = "ItemSymbolFile"
Private Const CONST_ItemTagAttribute = "ItemTag"
Private Const CONST_ItemTypeNameAttribute = "ItemTypeName"

'***************************************************************************
' Procedure:    Import
' Description:  Main import procedure.  This procedure gets called from the
'               main drop handler in the ImportFromFile class.
'***************************************************************************
Public Sub Import(strFileName As String)

    Dim objXMLDoc As New DOMDocument
    Dim objItems As IXMLDOMNodeList
    Dim objItem As IXMLDOMElement
    Dim objItemAtts As IXMLDOMNodeList
    Dim objItemAtt As IXMLDOMNode
    Dim objItemAttNodeMap As IXMLDOMNamedNodeMap
    Dim objAttName As IXMLDOMAttribute
    Dim objAttValue As IXMLDOMAttribute
    Dim objAttUnits As IXMLDOMAttribute
    Dim objClassificationNodeMap As IXMLDOMNamedNodeMap
    Dim objSymbolFileNodeMap As IXMLDOMNamedNodeMap
    Dim strItemType As String
    Dim strSymbolFile As String
    Dim objImportItems As New ImportItems
    Dim objImportItemAtts As ImportItemAtts
    
    On Error GoTo errHandler
    
    objXMLDoc.async = False
    objXMLDoc.Load strFileName
    
    Set objItems = objXMLDoc.getElementsByTagName(CONST_ItemTagName)
    For Each objItem In objItems
        Set objClassificationNodeMap = objItem.getElementsByTagName(CONST_ClassificationTagName).Item(0).Attributes
        strItemType = objClassificationNodeMap.getNamedItem(CONST_ItemClassificationItem).Text
        Set objSymbolFileNodeMap = objItem.getElementsByTagName(CONST_SymbolFileTagName).Item(0).Attributes
        strSymbolFile = objSymbolFileNodeMap.getNamedItem(CONST_ItemSymbolFileItem).Text
        Set objItemAtts = objItem.getElementsByTagName(CONST_ItemAttributeTagName)
        Set objImportItemAtts = New ImportItemAtts
        For Each objItemAtt In objItemAtts
            Set objItemAttNodeMap = objItemAtt.Attributes
            Set objAttName = objItemAttNodeMap.getNamedItem(CONST_AttributeNameItem)
            Set objAttValue = objItemAttNodeMap.getNamedItem(CONST_AttributeValueItem)
            Set objAttUnits = objItemAttNodeMap.getNamedItem(CONST_AttributeUnitsItem)
            If (objAttUnits Is Nothing) Then
                objImportItemAtts.Add objAttName.Value, objAttValue.Value, ""
            Else
                objImportItemAtts.Add objAttName.Value, objAttValue.Value, objAttUnits.Value
            End If
        Next objItemAtt
        objImportItems.Add strItemType, strSymbolFile, objImportItemAtts
    Next
    
    UpdateDatabase objImportItems
    Exit Sub
    
errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description

End Sub

'***************************************************************************
' Procedure:    UpdateDatabase
' Description:  Updates the SmartPlant P&ID database with data imported
'               from the XML file using SmartPlant Logical Model Automation
'***************************************************************************
Private Sub UpdateDatabase(objImportItems As ImportItems)

    Dim i As Long
    Dim sItemTag As String
    Dim objFilter As LMAFilter
    Dim objLMAItem As LMAItem
    Dim objImportItem As ImportItem
    Dim objPlantItem As LMPlantItem
    Dim objPlantItems As New LMPlantItems
            
    On Error GoTo errHandler
                                
    UpdateStatus LoadResString(150)
                                
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = objImportItems.Count
    m_Pbar.PBValue = m_Pbar.PBMin
    m_Pbar.PBMessage = LoadResString(143) & CStr(objImportItems.Count) & ") "
                                                
    i = 1
    For Each objImportItem In objImportItems
        sItemTag = ""
        On Error Resume Next
        sItemTag = objImportItem.ImportItemAtts.Item(CONST_ItemTagAttribute).Value
        On Error GoTo errHandler
        
        'set up a filter for the current itemtag.
        Set objFilter = New LMAFilter
        If (sItemTag <> "") Then
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(1).SourceAttributeName = CONST_ItemTagAttribute
            objFilter.Criteria.Item(1).Operator = "="
            objFilter.Criteria.Item(1).ValueAttribute = sItemTag
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(2).SourceAttributeName = CONST_RepresentationItemStatusAttribute
            objFilter.Criteria.Item(2).Operator = "="
            objFilter.Criteria.Item(2).ValueAttribute = 1   'active status
            objFilter.Criteria.Item(2).Conjunctive = -1     'match all
            objFilter.Criteria.AddNew
            objFilter.Criteria.Item(3).SourceAttributeName = CONST_ItemTypeNameAttribute
            objFilter.Criteria.Item(3).Operator = "="
            objFilter.Criteria.Item(3).ValueAttribute = objImportItem.ItemTypeName
            objFilter.Criteria.Item(3).Conjunctive = -1     'match all
                    
            'See if this item already exists in the database.
            If (objFilter.Criteria.Count > 0) Then
                objPlantItems.Collect PIDDataSource, Filter:=objFilter
            End If
        
            If (objPlantItems.Count = 0) Then   'Create a new item.
                UpdateStatus LoadResString(144), sItemTag
                Set objLMAItem = CreateItem(objImportItem.ItemSymbolFile)
                If Not (objLMAItem Is Nothing) Then
                    Call UpdateItemProperties(objLMAItem, objImportItem)
                End If
            Else                                'Update the existing item(s).
                UpdateStatus LoadResString(146), sItemTag
                For Each objPlantItem In objPlantItems
                    Set objLMAItem = PIDDataSource.GetItem(objImportItem.ItemTypeName, objPlantItem.ID)
                    If Not (objLMAItem Is Nothing) Then
                        Call UpdateItemProperties(objLMAItem, objImportItem)
                    End If
                Next
            End If
        End If
        
        If (i < objImportItems.Count) Then
            i = i + 1
            m_Pbar.PBMessage = LoadResString(147) & CStr(i) & " of " & CStr(objImportItems.Count) & ") "
        End If
        m_Pbar.PBValue = m_Pbar.PBValue + 1
    Next objImportItem

    Exit Sub

errHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description

End Sub

'strSymbolFile argument accepts only relative path
Private Function CreateItem(strSymbolFile As String) As LMAItem
    Dim strCompleteFileName As String
    Dim strRelFileName As String
    
    strRelFileName = strSymbolFile
    
    If Left$(strRelFileName, 1) <> "\" Then
        strRelFileName = "\" & strRelFileName
    End If
    
    'construct the full file name
    strCompleteFileName = GetBaseSymbolDir(PIDDataSource) & strRelFileName
    
    If (Dir(strCompleteFileName, vbNormal) <> "") Then
        'pass only the path relative to Catalog Root Path specified in
        'Options Manager
        Set CreateItem = PIDCreateItem(strRelFileName)
    Else
        UpdateStatus LoadResString(145) & strCompleteFileName & "'"
    End If

End Function

Private Sub UpdateItemProperties(objLMAItem As LMAItem, objImportItem As ImportItem)

    Dim objImportItemAtt As ImportItemAtt
    Dim objAttrLMAAttributes As LMAAttributes
    
    On Error GoTo errHandler
    
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set objAttrLMAAttributes = objLMAItem.Attributes
    
    For Each objImportItemAtt In objImportItem.ImportItemAtts
        'update the item with the values read from XML file
        SetValue objAttrLMAAttributes, objImportItemAtt.Name, Trim(objImportItemAtt.Value & " " & objImportItemAtt.Units)
    Next
    
    'commit the changes
    objLMAItem.Commit

    Exit Sub
    
errHandler:
    
    UpdateStatus LoadResString(120) & Err.Description
    
End Sub

Public Property Set ProgressBar(objPBar As igrProgressBar412.clsProgressBar)
    Set m_Pbar = objPBar
End Property

Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub
