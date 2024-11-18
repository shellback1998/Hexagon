VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ShowObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2006 Intergraph
'   All Rights Reserved
'
'   ShowMember.cls
'   ProgID:         ShowElement.ShowObject
'   Author:         G. Werner
'   Creation Date:  Wednesday, Nov 6, 2006
'   Description:
'       Test program: display an Object's attribute
'
'   TODO:
'      - when expanding a node in the treeview, the treeview changes its position, why?
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'    7.Nov.2006     GWE     created
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Explicit


Private Const MODULE = "ShowObject::"

Implements IJCommand2

    ' Declare class variables.
Private m_fOnIdleEnableState As Boolean
Private m_fIdleTimerDisabled As Boolean
 
Private m_iCmdID As Long
Private m_oCmnAppErrHandler As IJCommonError


Private Sub Class_Initialize()
    Set m_oCmnAppErrHandler = New CommonError
    On Error GoTo Errx
'      - any class initialize
    Exit Sub
Errx:
    '   - Wizard-generated code reports this error as "Warning". Modify as needed
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
    '   - Wizard-generated code reports this error as "Warning". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrWarning, MODULE & "IJCommand2_EnableSpecial", _
                                            Err.Number, Err.Description
End Property


' Other properties simply return values. In general, error handler not needed

Private Property Get IJCommand2_EnableUIFlags() As Long
    IJCommand2_EnableUIFlags = 20 ' = 16 + 4
    '  2 - active view
    '  4 - Selectset
    '  8 - special check
    ' 16 - database connection
End Property

Private Property Get IJCommand2_EnableViewType() As String
    IJCommand2_EnableViewType = "IJDGraphicView"
End Property

Private Property Get IJCommand2_Modal() As Boolean
    IJCommand2_Modal = False
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
    Dim oTrader As New Trader

    ' Disable Idle Timer
    Dim oIdleGen As IJIdleGenerator
    Set oIdleGen = oTrader.Service(TKIdleGenerator, vbNullString)
    m_fOnIdleEnableState = oIdleGen.Enable
    oIdleGen.Enable = False
    m_fIdleTimerDisabled = True
    
     ' read session parameters
    Call HandleSessionParameters(True)
    
    ' Create form & display form since it's a Modal command.
    ShowElement

    Exit Sub
Errx:
    '   - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Start", _
                                            Err.Number, Err.Description
End Sub
Private Sub ShowElement()
    Const METHOD = "ShowElement"
    Dim o As Object
'    Dim pMemberSys As SPSMembers.ISPSMemberSystem
'    Dim oDesignParts As IJElements
'    Dim pMember As SPSMembers.ISPSMemberPartPrismatic
'    Dim j As Long
    Dim lInvalid As Long
Dim oTrader As New Trader
Dim oSelSet As IJSelectSet
Dim nCount As Long
'

'
    Dim oObject As clsObject
    
    On Error GoTo Handler

    Set oSelSet = oTrader.Service(TKSelectSet, "")
    
    If oSelSet.Elements.Count <= 0 Then ' This question is unnecessary, because the command will start only with nonempty selectset
        MsgBox "Select Objects before calling this command!", vbOKOnly, App.Title
        Exit Sub
    End If
    For Each o In oSelSet.Elements
    
'            MsgBox TypeName(o)

            Set oObject = New clsObject
            If oObject.ShowObject(o) < 0 Then
                lInvalid = lInvalid + 1
            Else
                nCount = nCount + 1
                If nCount > 10 Then
                    Exit For ' stop after 10 windows.
                End If
            End If
 
    Next
    If lInvalid > 0 Then
        MsgBox lInvalid & " element(s) in the selectset are not shown", vbOKOnly, "View SP3d Elements"
    End If
    Exit Sub
Handler:
    Debug.Assert False
    MsgBox Err.Description & " (" & MODULE & METHOD & ")", vbOKOnly
    
    Exit Sub
    Resume
End Sub
 
Private Sub IJCommand2_Stop()
    On Error GoTo Errx
    Dim oTrader As New Trader
 
    If m_fIdleTimerDisabled Then
        Dim oIdleGen As IJIdleGenerator
        Set oIdleGen = oTrader.Service(TKIdleGenerator, vbNullString)
        oIdleGen.Enable = m_fOnIdleEnableState
    End If

    Exit Sub
Errx:
    '   - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Stop", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_Suspend()
    On Error GoTo Errx

    Exit Sub
Errx:
    '   - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Suspend", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_Resume()
    On Error GoTo Errx

    Exit Sub
Errx:
    '   - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Resume", _
                                            Err.Number, Err.Description
End Sub


Private Sub IJCommand2_OnIdle()
    On Error GoTo Errx
    Exit Sub
Errx:
    '   - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_OnIdle", _
                                            Err.Number, Err.Description
End Sub


'End Of Template - V2

Public Sub Show(o As Object)
    Dim oObject As clsObject
    Set oObject = New clsObject
    
    Call oObject.ShowObject(o, , True)
    
End Sub

