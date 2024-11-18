Attribute VB_Name = "ErrorLogging"
Option Explicit

'***********************************************************************
'Copyright (c) 1998, Intergraph Corporation
'
'Module:
'   ErrorLogging
'
'Author:
'   DFW
'
'Abstract:
'   Error Logging routines
'
'Description:
'   Call LogAndRaiseError, LogError, and DisplayError to provide error logging
'   Look at the documentation to see how to use this
'
'***********************************************************************

Private m_strDescription As String


Public Const ERROR_PROCESS_ABORTED = 1067&

' error code from RegQueryValueEx
Public Const ERROR_NONE = 0
Public Const ERROR_BADDB = 1
Public Const ERROR_BADKEY = 2
Public Const ERROR_CANTOPEN = 3
Public Const ERROR_CANTREAD = 4
Public Const ERROR_CANTWRITE = 5
Public Const ERROR_OUTOFMEMORY = 6
Public Const ERROR_ARENA_TRASHED = 7
Public Const ERROR_ACCESS_DENIED = 8
Public Const ERROR_INVALID_PARAMETERS = 87
Public Const ERROR_NO_MORE_ITEMS = 259

' ------------- Error Logging Public Subroutines -------------

Public Sub LogError(ErrorTag As String, Optional ErrorNumber As Variant)
Dim eNumber As Long
    If IsMissing(ErrorNumber) Then
       eNumber = Err.Number
    Else
       eNumber = ErrorNumber
    End If

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    Dim level As igrErrorLogging412.igReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelLog
    objErrorLog.LogError "", ErrorTag, , , , , , eNumber
    objErrorLog.ReportingLevel = level

End Sub

Public Sub DisplayErrorAndTerminate(ErrorTag As String, ErrorNumber As Variant)
Dim eNumber As Long
    If IsMissing(ErrorNumber) Then
       eNumber = Err.Number
    Else
       eNumber = ErrorNumber
    End If

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    Dim level As igrErrorLogging412.igReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelDisplay
    objErrorLog.LogErrorAndTerminate "", ErrorTag, , , , , , eNumber
    objErrorLog.ReportingLevel = level

End Sub

Public Function DisplayError(ErrorTag As String, ErrorNumber As Variant, Optional Buttons As VbMsgBoxStyle = vbOKOnly) As VbMsgBoxResult
Dim eNumber As Long
    If IsMissing(ErrorNumber) Then
       eNumber = Err.Number
    Else
       eNumber = ErrorNumber
    End If
    
    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    Dim level As igrErrorLogging412.igReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelDisplay
    DisplayError = objErrorLog.LogError("", ErrorTag, , , , , Buttons, eNumber)
    objErrorLog.ReportingLevel = level

End Function

Public Sub SetupErrorhandler(sAppTitle As String, sDocName As String, Optional bAppend As Boolean, Optional sErrorLogFilename As String)

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    objErrorLog.Initialize2 sAppTitle, sDocName, "", bAppend, sErrorLogFilename

End Sub

Public Function DisplayErrorFromResource(ResourceName As String, ResourceNumber As Long, Optional Buttons As VbMsgBoxStyle = vbOKOnly) As VbMsgBoxResult
Dim objErrorLog As New igrErrorLogging412.ErrorLog
Dim level As igrErrorLogging412.igReportingLevelConstants
Dim sError As String
Dim objSPRes As SPRes
    
    'Get create a resource object.
    Set objSPRes = New SPRes
    'Setup the resource to use the common resource and then get the title.
    objSPRes.SPCompName = ResourceName
    sError = objSPRes.GetString(ResourceNumber)
    
    objErrorLog.ReportingLevel = igReportingLevelDisplay
    DisplayErrorFromResource = objErrorLog.LogError("", sError, , , , , Buttons, 0)
    objErrorLog.ReportingLevel = level

End Function

Public Sub ClearErrorhandler()
    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    objErrorLog.UnInitialize
End Sub

Public Sub SetupErrorLogging()

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    'objErrorLog.SetupErrorLogging

End Sub

'Public Sub CloseErrorLoging()
'
'    Dim objErrorLog As New igrErrorLogging412.ErrorLog
'    'objErrorLog.CloseErrorLogging
'
'End Sub

Public Function ExitAppIfFatalErrorOccured(objApp As Object) As Boolean

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    ExitAppIfFatalErrorOccured = objErrorLog.ExitAppIfFatalErrorOccurred(objApp)

End Function

Public Sub LogAndRaiseError(ErrorTag As String, Optional ErrorNumber As Variant)
Dim eNumber As Long

    
    

    '   the following was added so that the original error and description are preserved / propagated
    '   to the top of the stack - jgb
    If IsMissing(ErrorNumber) Then
        If Err.Number = 0 Then          'first call on stack, app wants to raise an error
            Err.Number = vbObjectError ' SOME number, a system error has not occurred
            m_strDescription = ErrorTag
        Else                            'err.number has already been set , preserve the description
            m_strDescription = Err.Description
        End If
    Else            ' if app is setting the error number, I assume its the first call on stack
        If ErrorNumber > 512 Then
            Err.Number = vbObjectError + ErrorNumber
        Else
            Err.Number = vbObjectError ' SOME number
        End If
        m_strDescription = ErrorTag
    End If

    eNumber = Err.Number

'    If IsMissing(ErrorNumber) Then
'
'       eNumber = Err.Number
'    Else
'       eNumber = ErrorNumber
'    End If

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    Dim level As igrErrorLogging412.igReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelLog
    'objErrorLog.LogError "", ErrorTag, nErrorNumberForLogFile:=eNumber, bRaise:=True
    
    objErrorLog.LogError ErrorTag, m_strDescription, nErrorNumberForLogFile:=eNumber, bRaise:=True
    
    objErrorLog.ReportingLevel = level

End Sub

Public Property Let ExitAppFlag(varExitAppFlag As Boolean)

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    objErrorLog.ExitAppFlag = varExitAppFlag

End Property

Public Property Get ExitAppFlag() As Boolean

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    ExitAppFlag = objErrorLog.ExitAppFlag

End Property

Public Sub WriteToErrorLog(strMsg As String, Optional bPrintTime As Boolean = True, Optional ShowMsgBox As Boolean = False)

    Dim objErrorLog As New igrErrorLogging412.ErrorLog
    If bPrintTime = True Then
        objErrorLog.LogMsgWithTimeStamp strMsg
    Else
        objErrorLog.LogMsg strMsg
    End If

End Sub


Public Function DisplayTime(strQualifier As String, Optional fPreviousTime As Single = 0#) As Single
    Dim fDelta As Single
    Dim fCurrentTime As Single
    
    fCurrentTime = Timer
    If fPreviousTime <> 0# Then
        fDelta = fCurrentTime - fPreviousTime
        WriteToErrorLog strQualifier & vbTab & ";Time: " & CStr(fCurrentTime) & vbTab & ";Delta: " & CStr(fDelta), False
    Else
        WriteToErrorLog strQualifier & vbTab & ";Time: " & CStr(fCurrentTime), False
    End If
    DisplayTime = fCurrentTime
End Function



