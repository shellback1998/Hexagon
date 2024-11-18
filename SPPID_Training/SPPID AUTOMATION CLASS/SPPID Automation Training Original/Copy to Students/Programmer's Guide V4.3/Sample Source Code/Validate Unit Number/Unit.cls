VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Unit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*************************************************************************
'Copyright © 1998, Intergraph Corporation. All rights reserved.
'
'File
'     Unit.Cls
'
'Author
'     Sai Chitta
'
'Abstract
'     Validates unit property values.
'
'Description
'     Validates and calculates UnitName property value.  The value of UnitName is
'     the name of a Unit to which the drawing belongs.
'
'Modifications:
'Date:          Changes:
'5/10/00        Added standard document header; removed obsolete code -- dmw.
'7/10/00        Added standardized error handling -- dmw
'**************************************************************************

Option Explicit
Const CONST_NozzleItemName As String = "Nozzle"
Const CONST_RepresentationItemName As String = "Representation"
Const CONST_ModelItemAttributeName As String = "SP_ModelItemID"
Const CONST_DrawingItemAttributeName As String = "SP_DrawingID"
Const CONST_PlantGroupAttributeName As String = "SP_PlantGroupID"

'Sets a value to an UnitName Property for Items if nothing is set. The value of
'UnitName is the name of a Unit to which the drawing belongs.
Public Function UpdateUnitNumber(DataSource As LMADataSource, _
   objLMAItems As LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean


    Dim objLMDrawing As LMDrawing
    Dim objLMFilter As LMAFilter
    Dim objLMPlantGroup As LMPlantGroup
    Dim objLMAItem As LMAItem
    Dim objLMPlantItem As LMPlantItem
    Dim objLMRepresentation As LMRepresentation
    Dim objLMRepresentations As LMRepresentations
    Dim bUnitFound As Boolean
    
    On Error GoTo ErrorHandler
    
    'Set the default return value to TRUE
    UpdateUnitNumber = True
    
    For Each objLMAItem In objLMAItems
        objLMAItem.Attributes.BuildAttributesOnDemand = True
        
        'Get the active Drawing Item
        If objLMAItem.ItemType <> CONST_NozzleItemName Then
            Set objLMRepresentations = New LMRepresentations
            Set objLMFilter = Nothing
            Set objLMFilter = GetFilter(CONST_RepresentationItemName, CONST_ModelItemAttributeName, objLMAItem.Id)
            If Not objLMFilter Is Nothing Then
                objLMRepresentations.Collect DataSource, , , objLMFilter
                If Not objLMRepresentations Is Nothing Then
                    If objLMRepresentations.Count > 0 Then
                        For Each objLMRepresentation In objLMRepresentations
                            objLMRepresentation.Attributes.BuildAttributesOnDemand = True
                            If Not objLMRepresentation.Attributes.Item(CONST_DrawingItemAttributeName) Is Nothing Then
                                Exit For
                            End If
                        Next
                    End If
                End If
                If Not objLMRepresentation Is Nothing Then
                    Set objLMDrawing = DataSource.GetDrawing(objLMRepresentation.Attributes.Item("SP_DrawingID").Value)
                    If Not objLMDrawing Is Nothing Then
                        objLMDrawing.Attributes.BuildAttributesOnDemand = True
                    
                        'Get the PlantGroup Item to which the Drawing belongs
                        Set objLMPlantGroup = DataSource.GetPlantGroup(objLMDrawing.PlantGroupID)
                        If Not objLMPlantGroup Is Nothing Then
                            Set objLMPlantItem = DataSource.GetPlantItem(objLMAItem.Id)
                            If Not objLMPlantItem Is Nothing Then
                                objLMAItem.Attributes.Item(CONST_PlantGroupAttributeName).Value = CStr(objLMPlantGroup.Id)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    Next
        
ErrorHandler:
    If Err Then
        UpdateUnitNumber = False
        LogError "ValidateUnit - Unit::UpdateUnitNumber --> " & Err.Description
        Err.Clear
    End If

    Set objLMPlantItem = Nothing
    Set objLMDrawing = Nothing
    Set objLMFilter = Nothing
    Set objLMPlantGroup = Nothing
    Set objLMAItem = Nothing
    Set objLMRepresentations = Nothing
    Set objLMRepresentation = Nothing
End Function

Private Function GetFilter(ByVal ItemType As String, SourceAttributeName As String, _
   ByVal ValueAttribute As String) As LMAFilter
   
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
    End With

    Exit Function
    
ErrorHandler:
    LogError "ValidateUnit - Unit::GetFilter --> " & Err.Description
    Set GetFilter = Nothing
    Set objCriterion = Nothing
    
End Function



