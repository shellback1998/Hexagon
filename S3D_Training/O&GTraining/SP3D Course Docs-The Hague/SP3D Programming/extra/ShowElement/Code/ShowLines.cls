VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ShowLines"
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
'       Show lines given by absolute coordinate values
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Option Explicit

Private Const MODULE = "ShowLines::"

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
    ' Create form & display form since it's a Modal command.
    frmShowLines.Show

    Exit Sub
Errx:
    ' TODO - Wizard-generated code reports error as "Critical". Modify as needed
    m_oCmnAppErrHandler.ReportEnhancedError ERRORLEVEL_ErrCritical, MODULE & "IJCommand2_Start", _
                                            Err.Number, Err.Description
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