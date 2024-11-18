Attribute VB_Name = "modLogAS"
Option Explicit

'  modLogAS - helper routines for debugging
'
Public gLogLevel As Long        ' 0 - no logging
                                ' 100 - full logging
                                ' 20  - some logging


Public gsLogFilePath As String   ' path to a logfile, %TEMP%\logSE.log

'Public gbShowLogfile As Boolean  ' If True, show the logfile at the end of processing (as long as gLogLeve>0


Public Sub InitLog(Optional bInit As Boolean = False)
    gLogLevel = 100
    
    If Len(gsLogFilePath) <= 0 Then
        gsLogFilePath = Environ("TEMP")
        If Len(gsLogFilePath) <= 0 Then
            gsLogFilePath = Environ("TMP")
            If Len(gsLogFilePath) <= 0 Then
                gsLogFilePath = "c:\temp"
            End If
        End If
        gsLogFilePath = gsLogFilePath & "\logSE.log"
    End If
    
    If bInit Then
        Call mylog(App.EXEName & " " & App.Major & "." & App.Minor & "." & App.Revision, False)
    End If
End Sub

Public Sub mylog(ByVal strText As String, _
        Optional bAppend As Boolean = True, _
        Optional bLevel As Long = 90)
      Dim lngnr As Long
    On Error GoTo Handler
    
    If bLevel >= gLogLevel Then
        Exit Sub
    End If
    
    If Len(gsLogFilePath) <= 0 Then
        gsLogFilePath = Environ("TEMP")
        If Len(gsLogFilePath) <= 0 Then
            gsLogFilePath = Environ("TMP")
            If Len(gsLogFilePath) <= 0 Then
                gsLogFilePath = "c:\temp"
            End If
        End If
        gsLogFilePath = gsLogFilePath & "\logSE.log"
    End If
    
    lngnr = FreeFile
    If bAppend Then
        Open gsLogFilePath For Append As lngnr
    Else
        Open gsLogFilePath For Output As lngnr
    End If
    
    Print #lngnr, strText
    Close lngnr
    
    Exit Sub
Handler:
    ' MsgBox strText, vbOKOnly, "Mylog"
    ' do not write a logfile.
    
End Sub



Public Function Vector(x As Double, y As Double, z As Double) As String
    Vector = "( " & sDouble(x) & ", " & sDouble(y) & ", " & sDouble(z) & " )"
End Function

Public Function sDouble(d As Double) As String
If (Abs(d) < 0.0001 And Abs(d) > 1E-16) Or Abs(d) > 1000000 Then
    sDouble = d
Else
    sDouble = Format(d, "####0.000")
End If
End Function

Public Function VectorAsString(x As Double, y As Double, z As Double) As String
    VectorAsString = x & "," & y & "," & z
End Function

Public Function GetVersion() As String
    GetVersion = App.Major & "." & App.Minor & "." & App.Revision
End Function
