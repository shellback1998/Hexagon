Attribute VB_Name = "ErrorsLog"
'******************************************************************************
'Copyright © 2002, Intergraph Corporation
'
'Project:   Middle\Modules
'
'File:      ErrorsLog.bas
'
'Author:    JFF
'
'Description: Provides utilities to log errors
'
'
'History: first delivery April, 2003

'  08.SEP.2006     KKC  DI-95670  Replace names with initials in all revision history sheets and symbols
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Explicit

Private Const MODULE = "(ReportsMiddle)ErrorsLog.bas:"

Private Const REGISTRY_KEY_FOR_TRACE_LEVEL = "\HKEY_CURRENT_USER\Software\Intergraph\Applications\Environments\Reports\Debug"
Private Const REGISTRY_NAME_FOR_TRACE_LEVEL = "TraceLevel"

Global g_bRunSilent As Boolean 'Set and used solely by application, not error log
Global g_bStopAtFirstError As Boolean
Global g_lTraceLevel As Long
Global g_bTraceLevelSetByRegistry As Boolean
Global g_intWarn As Integer 'Set to some base range by application convention
Global g_intFatal As Integer 'Set to some other base range by application convention

Private m_oErrors As IJEditErrors

Public Function Log() As IJEditErrors
    Dim oRegistry As IMSRegistryHandler.IJRegistry
    Dim sRunSilent As String
    Dim sStopAtFirstError As String
    Dim sTraceLevelValue As String
        
    If m_oErrors Is Nothing Then
'       Set m_oErrors = CreateObject("IMSErrorLog.Errors")
        'Or use the following line instead for the Singleton version
        Set m_oErrors = CreateObject("IMSErrorLog.ErrorsSingleton")
        'may be not good when not standalone
        m_oErrors.PersistFileName = Environ("TEMP") & "\SP3DReports.log"
        Set oRegistry = New IMSRegistryHandler.Registry
        On Error Resume Next ' because the key for trace level may not exist
        sTraceLevelValue = oRegistry.GetStringValue(REGISTRY_KEY_FOR_TRACE_LEVEL, REGISTRY_NAME_FOR_TRACE_LEVEL)
        If Err <> 0 Then
            g_bTraceLevelSetByRegistry = False ' the key has not been found
        Else
            g_lTraceLevel = GetTraceLevel(sTraceLevelValue)
            g_bTraceLevelSetByRegistry = True
        End If
        
        If g_bRunSilent = True Then
            sRunSilent = "RunSilent = True, "
        Else
            sRunSilent = "RunSilent = False, "
        End If
        If g_bStopAtFirstError = True Then
            sStopAtFirstError = "StopAtFirstError = True, "
        Else
            sStopAtFirstError = "StopAtFirstError = False, "
        End If
        m_oErrors.Add 100000, "CCacheController", "Log started.", , , , sRunSilent & sStopAtFirstError & "Tracelevel=" & CStr(g_lTraceLevel)
    End If

    Set Log = m_oErrors
    
    Set oRegistry = Nothing
End Function

Public Sub ReleaseLog()
    If Not m_oErrors Is Nothing Then 'TR 41741
        m_oErrors.Add 100000, "CCacheController", "Log stopped."
        Set m_oErrors = Nothing
    End If
End Sub

'The trace level value is used for debugging the RuntimeFramework code.
'Possible values are 1, 2, 3, or 4, default value is '3'.
Private Function GetTraceLevel(TraceLevelValue) As Long
    
    If TraceLevelValue = "" Then
        GetTraceLevel = 3
    ElseIf VBA.IsNumeric(TraceLevelValue) = True Then
        GetTraceLevel = CInt(TraceLevelValue)
    Else
        GetTraceLevel = 3
    End If
End Function
