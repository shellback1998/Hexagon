VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPipeline"
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
Private Const Module = "Pipelines: "
Private Const E_FAIL = -2147467259
Private m_oCodeListMetadata As IJDCodeListMetaData
Dim m_oErrors As IJEditErrors

Private Sub Class_Initialize()
    Set m_oErrors = New IMSErrorLog.JServerErrors 'Set the error handling errors
End Sub

Private Sub Class_Terminate()
    Set m_oErrors = Nothing
Set m_oCodeListMetadata = Nothing
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
    
    Dim strSequenceNumber As String
    
    strSequenceNumber = oAttributes.CollectionOfAttributes("IJPipelineSystem").Item("SequenceNumber").Value
    
    Dim FluidCodeID As Long
    Dim strFluidCode As String
    strFluidCode = vbNullString

    Set m_oCodeListMetadata = GetCatalogResourceManager
    FluidCodeID = _
    oAttributes.CollectionOfAttributes("IJPipelineSystem").Item("FluidCode").Value
    strFluidCode = m_oCodeListMetadata.ShortStringValue("FluidCode", FluidCodeID)


    strChildName = strFluidCode & "-" & strSequenceNumber
    oChildNamedItem.Name = strChildName

    Set oChildNamedItem = Nothing
    Set oAttributes = Nothing



Exit Sub

label:
' log the error in middle tier and propagate the error code to the caller
    m_oErrors.Add Err.Number, "IJNameRule_ComputeName", Err.Description
    Err.Raise E_FAIL
    
End Sub

'----------------------------------------------------------------------------------------
'Description
' Function returns the CatalogResourceManager
'----------------------------------------------------------------------------------------
Private Function GetCatalogResourceManager() As IUnknown
    Const METHOD = "GetCatalogResourceManager"
    On Error GoTo ErrHandler
    
    Dim oDBTypeConfig As IJDBTypeConfiguration
    Dim pConnMiddle As IJDConnectMiddle
    Dim pAccessMiddle As IJDAccessMiddle
    Dim jContext As IJContext
    Set jContext = GetJContext()
    Set oDBTypeConfig = jContext.GetService("DBTypeConfiguration")
    Set pConnMiddle = jContext.GetService("ConnectMiddle")
    Set pAccessMiddle = pConnMiddle
 
    Dim strCatlogDB As String
    strCatlogDB = oDBTypeConfig.get_DataBaseFromDBType("Catalog")
    Set GetCatalogResourceManager = pAccessMiddle.GetResourceManager(strCatlogDB)
    Set jContext = Nothing
    Set oDBTypeConfig = Nothing
    Set pConnMiddle = Nothing
    Set pAccessMiddle = Nothing
Exit Function
ErrHandler:
    m_oErrors.Add Err.Number, "GetCatalogResourceManager", Err.Description
    Err.Raise E_FAIL
End Function

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

' If you need the Parent objects, then Add code Here to get the Naming Parents that will participate in the naming.

Exit Function

label:
    ' log the error in middle tier and propagate the error code to the caller
    m_oErrors.Add Err.Number, "IJNameRule_GetNamingParents", Err.Description
    Err.Raise E_FAIL
End Function
