VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TestCmd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2007 Intergraph
'   All Rights Reserved
'
'   ShowLines.cls
'   ProgID:         ShowElement.ShowLines
'   Author:         G.Werner
'   Creation Date:  Sonntag, Aug 26, 2007
'   Description:
'       TODO - fill in header description information
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Option Explicit

Private Const MODULE = "TestCmd::"

Implements IJCommand2

    ' Declare class variables.
 
Private m_iCmdID As Long
Private m_oCmnAppErrHandler As IJCommonError


Private Sub Class_Initialize()
    Set m_oCmnAppErrHandler = New CommonError
    On Error GoTo Errx
'    TODO - any class initialize
    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports this error as "Warning". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrWarning, MODULE & "Initialize", _
                                            Err.Number, Err.Description
End Sub

Private Sub Class_Terminate()

        Set m_oCmnAppErrHandler = Nothing
End Sub


'   IJCommand2 Properties


' EnableSpecial may call for significant processing. If so, error handler is meaningful
Private Property Get IJCommand2_EnableSpecial() As Boolean
    On Error GoTo Errx
    ' NOOP
    Exit Property
Errx:
    ' TODO - Wizard-generated code reports this error as "Warning". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrWarning, MODULE & "IJCommand2_EnableSpecial", _
                                            Err.Number, Err.Description
End Property


' Other properties simply return values. In general, error handler not needed

Private Property Get IJCommand2_EnableUIFlags() As Long
    IJCommand2_EnableUIFlags = 2
End Property

Private Property Get IJCommand2_EnableViewType() As String
    IJCommand2_EnableViewType = "IJDGraphicView"
End Property

Private Property Get IJCommand2_Modal() As Boolean
    IJCommand2_Modal = True
End Property

Private Property Get IJCommand2_Suspendable() As Boolean
    IJCommand2_Suspendable = False
Errx:
End Property

Private Property Get IJCommand2_Running() As Boolean
'Property Not Used
End Property


'   IJCommand2 Methods

Private Sub IJCommand2_Start(ByVal CommandID As Long, ByVal cmdArg As Variant)
 
 
On Error GoTo Errx
    m_iCmdID = CommandID
    Dim oPart As IJDPart
    Dim oRefDB As IJDRefDBGlobal
    Dim oCol As IJDCollection
    Dim catnames() As String
    Dim loop1 As Integer
    
    Dim oEquipment1 As IJEquipment
    Dim oEquipFactory As GSCADEqpEntities.EquipmentFactory
    Dim goActiveConnection As WorkingSetLibrary.IJDConnection
    Dim goWorkingSet As IJDWorkingSet
    Dim goTrader As IMSTrader.Trader
    Dim smartCls As IJSmartClass
    Dim oSmartItem As IJSmartItem
    
    Set oRefDB = New RefDBGlobal

    test3
    
    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Start", _
                                            Err.Number, Err.Description
End Sub

Private Sub test3()

End Sub

Private Sub test2()
    Dim oUOM As IJUnitsOfMeasure
    Dim oTrader As IMSTrader.Trader
    Dim s1 As String
  
    Dim d As Double
    Dim bValid As Boolean
    
    
    
    Set oTrader = New Trader
    
    Set oUOM = oTrader.Service(TKUnitsOfMeasure, "")
    
    s1 = "113 mm"
    While s1 <> "stop"
    s1 = InputBox("Enter Length value including unit", "UNIT", "113 mm")
    d = ConvertUnit(s1, bValid, "myfield")
    If bValid Then
        MsgBox d
 
    End If
    
    Wend
    
    Set oUOM = Nothing
    Set oTrader = Nothing
    
End Sub



Private Function ConvertUnit(sIn As String, bValid As Boolean, sMsg As String) As Double
    Dim oUOM As IJUnitsOfMeasure
    Dim oTrader As IMSTrader.Trader
 
    On Error GoTo ErrHandler
    bValid = True
    
    Set oTrader = New Trader
    Set oUOM = oTrader.Service(TKUnitsOfMeasure, "")
    
    ConvertUnit = oUOM.ParseUnit(UNIT_DISTANCE, sIn)
 
CleanUp:
    Set oUOM = Nothing
    Set oTrader = Nothing
    Exit Function
ErrHandler:
    MsgBox "Invalid Unit in field " & sMsg & ": " & sIn
    bValid = False
    Resume CleanUp
End Function

Private Sub test1()
    Dim oPart As IJDPart
    Dim oRefDB As IJDRefDBGlobal
 
 
    Dim oEquipment1 As IJEquipment
    Dim oEquipFactory As GSCADEqpEntities.EquipmentFactory
 
    Dim goWorkingSet As IJDWorkingSet
    Dim goTrader As IMSTrader.Trader
'    Dim smartCls As IJSmartClass
    Dim oSmartItem As IJSmartItem
    'oRefDB.GetCatalogNames catnames         'Get all PartClasses
    'Set oPart = oRefDB.GetCatalogPart("ElectricalSpeakerAsm", "ElectricalSpeaker05-E")
    Set oPart = oRefDB.GetCatalogPart("PumpAsm", "PUMP 001A-E")
    
    'MsgBox "MirrorBehOpt " & oPart.MirrorBehaviorOption & " PNumber" & oPart.PartNumber & " PDescr " & oPart.PartDescription
    
    Set goTrader = New IMSTrader.Trader
    Set goWorkingSet = goTrader.Service(TKWorkingSet, "")
    'Set goActiveConnection = goWorkingSet.ActiveConnection
    
'    MsgBox goWorkingSet.ActiveConnection.Name
'    MsgBox Str(goWorkingSet.ActiveConnection.ScopeCount)
'    MsgBox Str(goWorkingSet.ActiveConditionID)
'    MsgBox goWorkingSet.ActiveConnection.ProjectID
    
    Set oEquipFactory = New GSCADEqpEntities.EquipmentFactory
    'goWorkingSet.Refresh
'    Set oEquipment1 = oEquipFactory.CreateEquipment(oPart, goWorkingSet.ActiveConnection.ResourceManager, True)
    
    Set oSmartItem = oPart
    Set oEquipment1 = oEquipFactory.CreateSmartEquipmentFromItem(oSmartItem, goWorkingSet.ActiveConnection.ResourceManager, Nothing)

    Dim oName As IJNamedItem
    Set oName = oEquipment1
    
    oName.Name = "TestName"
    Set oName = Nothing

    
    Dim m_TransactionMgr As IJTransactionMgr
    Set m_TransactionMgr = goTrader.Service(TKTransactionMgr, "")
    
    Set oEquipment1 = Nothing
    Set oSmartItem = Nothing
    Set oPart = Nothing
    
    
    m_TransactionMgr.Commit "redoName"
    Exit Sub
End Sub
Private Sub IJCommand2_Stop()
    On Error GoTo Errx
 

    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Stop", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_Suspend()
    On Error GoTo Errx

    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Suspend", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_Resume()
    On Error GoTo Errx

    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Resume", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_OnIdle()
    On Error GoTo Errx
    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_OnIdle", _
                                            Err.Number, Err.Description
End Sub


'End Of Template - V2
