Attribute VB_Name = "ErrorLogging"
Option Explicit

'***********************************************************************
'Copyright (c) 1998-2003, Intergraph Corporation
'
'Module:
'   ErrorLogging
'
'
'Abstract:
'   Error Logging routines
'
'Description:
'   Call LogAndRaiseError, LogError, and DisplayError to provide error logging.
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

Private Enum ReportingLevelConstants
    igReportingLevelOff = 0
    igReportingLevelLog = 1
    igReportingLevelDisplay = 2
    igReportingLevelLogAndDisplay = 3
End Enum
' ------------- Error Logging Public Subroutines -------------

Public Sub LogError(ErrorTag As String, Optional ErrorNumber As Variant)
Dim eNumber As Long
    If IsMissing(ErrorNumber) Then
       eNumber = Err.Number
    Else
       eNumber = ErrorNumber
    End If
    Dim objErrorLog As Object
    Set objErrorLog = CreateObject("igrErrorLogging412.ErrorLog")
    Dim level As ReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelLog
    objErrorLog.LogError "", ErrorTag, , , , , , eNumber
    objErrorLog.ReportingLevel = level
    
End Sub

Public Function DisplayError(ErrorTag As String, ErrorNumber As Variant, Optional Buttons As VbMsgBoxStyle = vbOKOnly) As VbMsgBoxResult
Dim eNumber As Long
    If IsMissing(ErrorNumber) Then
       eNumber = Err.Number
    Else
       eNumber = ErrorNumber
    End If
    
    Dim objErrorLog As Object
    Set objErrorLog = CreateObject("igrErrorLogging412.ErrorLog")
    Dim level As ReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelDisplay
    DisplayError = objErrorLog.LogError("", ErrorTag, , , , , Buttons, eNumber)
    objErrorLog.ReportingLevel = level

End Function


Public Sub LogAndRaiseError(ErrorTag As String, Optional ErrorNumber As Variant)
Dim eNumber As Long

    '   the following was added so that the original error and description are preserved / propagated
    '   to the top of the stack
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
            Err.Number = vbObjectError
        End If
        m_strDescription = ErrorTag
    End If

    eNumber = Err.Number


    Dim objErrorLog As Object
    Set objErrorLog = CreateObject("igrErrorLogging412.ErrorLog")
    Dim level As ReportingLevelConstants
    objErrorLog.ReportingLevel = igReportingLevelLog
    
    objErrorLog.LogError ErrorTag, m_strDescription, nErrorNumberForLogFile:=eNumber, bRaise:=True
    
    objErrorLog.ReportingLevel = level

End Sub


Public Sub WriteToErrorLog(strMsg As String, Optional bPrintTime As Boolean = True, Optional ShowMsgBox As Boolean = False)

    Dim objErrorLog As Object
    Set objErrorLog = CreateObject("igrErrorLogging412.ErrorLog")
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



