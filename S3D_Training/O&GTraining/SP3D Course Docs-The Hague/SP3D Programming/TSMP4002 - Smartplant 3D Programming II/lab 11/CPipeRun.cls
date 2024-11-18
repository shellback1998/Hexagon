VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPiperun"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'**********************************************************************************************************
' Copyright (C) 2005, Intergraph Corporation.  All rights reserved.
' Objective:
' VB Template for creating Naming Rule
' Created by Ramon for training purposes
' Author:Ramon Him
' Date: 05/2005
' **********************************************************************************************************

Option Explicit

Implements IJNameRule
Const vbInvalidArg = &H80070057
Private Const Module = "piperun: "
Private Const E_FAIL = -2147467259

Dim m_oErrors As IJEditErrors

Private Sub Class_Initialize()
    Set m_oErrors = New IMSErrorLog.JServerErrors 'Set the error handling errors
End Sub

Private Sub Class_Terminate()
    Set m_oErrors = Nothing
End Sub
'--------------------------------------------------------------------------------------------------------------------------
' Description
' This method is used to format the name of the object
' Arguments:
' oObject:  - Inputs. Object to be named
' elements: - Inputs. Naming parents collection
' oActiveEnity: - Inputs. Naming rules active entity on which the NamingParentsString is stored.
'--------------------------------------------------------------------------------------------------------------------------
Private Sub IJNameRule_ComputeName(ByVal oObject As Object, ByVal elements As IJElements, ByVal oActiveEntity As Object)

    Const METHOD = "IJNameRule_ComputeName"
    On Error GoTo label
    
    If oObject Is Nothing Then
        Err.Raise vbInvalidArg, Module, METHOD
        Exit Sub
    End If
    
        
    Dim oChildNamedItem As IJNamedItem
    Dim strChildName As String
    Set oChildNamedItem = oObject
    strChildName = vbNullString
    
    
    Dim oAttributes As IJDAttributes
    Set oAttributes = oObject
    
     Dim strNPD As String
 Dim strNPDUnitType As String

    strNPD = CStr(oAttributes.CollectionOfAttributes("IJRtePipeRun").Item("NPD").Value)
    strNPDUnitType = oAttributes.CollectionOfAttributes("IJRtePipeRun").Item("NPDUnitType").Value

    If strNPDUnitType = "in" Then
        strNPDUnitType = Chr(34)
    End If
    
    Dim bIsInsulated As Boolean
    bIsInsulated = oAttributes.CollectionOfAttributes("IJRteInsulation").Item("IsInsulated").Value
   



    Dim oRelationHelper As IMSRelation.DRelationHelper
    Dim oCollection As IMSRelation.DCollectionHelper
    Set oRelationHelper = oObject
    Dim oSpec As IJDSpec
    Dim strSpecName As String
    Set oCollection = oRelationHelper.CollectionRelations("IJRtePathRun", "Spec")
    Set oSpec = oCollection.Item(1)
    strSpecName = oSpec.SpecName


Dim oParentNamedItem As IJNamedItem
    Dim strParentName As String
    strParentName = vbNullString
    Set oParentNamedItem = elements.Item(1)
    strParentName = oParentNamedItem.Name
        
    If bIsInsulated = True Then
        strChildName = strNPD & strNPDUnitType & "-" & strSpecName & "-" & strParentName
    Else
        strChildName = strNPD & strNPDUnitType & "-" & strSpecName & "-" & strParentName & "-NI"
    End If
    
    oChildNamedItem.Name = strChildName

    Set oChildNamedItem = Nothing
    Set oAttributes = Nothing
    Set oRelationHelper = Nothing
    Set oCollection = Nothing
    Set oSpec = Nothing
    Set oParentNamedItem = Nothing


Exit Sub

label:
' log the error in middle tier and propagate the error code to the caller
    m_oErrors.Add Err.Number, "IJNameRule_ComputeName", Err.Description
    Err.Raise E_FAIL
    
End Sub

'------------------------------------------------------------------------------------------------
'Description
' This method is used to return the related object or objects that are used to forming the name.
' All the Naming Parents that need to participate in an objects naming are added here to the
' IJElements collection. The parents added here are used in computing the name of the object in
' ComputeName() of the same interface.
' Arguments:
' oEntity - Input.  Child object that needs to have the naming rule naming.
'------------------------------------------------------------------------------------------------
Private Function IJNameRule_GetNamingParents(ByVal oEntity As Object) As IJElements
    Const METHOD = "IJNameRule_GetNamingParents"
    On Error GoTo label
    
    Set IJNameRule_GetNamingParents = Nothing
    Set IJNameRule_GetNamingParents = Nothing
    Set IJNameRule_GetNamingParents = New IMSCoreCollections.JObjectCollection

 Dim oSysChild As IJSystemChild
 Set oSysChild = oEntity

Dim oSysParent As IJSystem
Set oSysParent = oSysChild.GetParent

    If Not (oSysParent Is Nothing) Then
        Call IJNameRule_GetNamingParents.Add(oSysParent)
    End If
    Set oSysChild = Nothing
    Set oSysParent = Nothing




' If you need the Parent objects, then Add code Here to get the Naming Parents that will participate in the naming.

Exit Function

label:
    ' log the error in middle tier and propagate the error code to the caller
    m_oErrors.Add Err.Number, "IJNameRule_GetNamingParents", Err.Description
    Err.Raise E_FAIL
End Function
