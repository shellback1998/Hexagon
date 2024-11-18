VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmFilmon 
   Caption         =   "Filter NTFilmon Output"
   ClientHeight    =   2820
   ClientLeft      =   60
   ClientTop       =   348
   ClientWidth     =   6168
   LinkTopic       =   "Form1"
   ScaleHeight     =   2820
   ScaleWidth      =   6168
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdRpt 
      Caption         =   "Cr.Report"
      Height          =   495
      Left            =   3120
      TabIndex        =   8
      Top             =   2160
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Exit"
      Height          =   495
      Left            =   4320
      TabIndex        =   7
      Top             =   2160
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "..."
      Height          =   375
      Left            =   5280
      TabIndex        =   5
      Top             =   1680
      Width           =   615
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   1680
      Width           =   4935
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Extract"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   2160
      Width           =   2535
   End
   Begin VB.CommandButton Command1 
      Caption         =   "..."
      Height          =   375
      Left            =   5280
      TabIndex        =   1
      Top             =   840
      Width           =   615
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   4935
   End
   Begin MSComDlg.CommonDialog CMDialog 
      Left            =   5520
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label Label3 
      Caption         =   "Select the Output of a NtFilmon run as Input file and Press Extract."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   7.8
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   0
      Width           =   4695
   End
   Begin VB.Label Label2 
      Caption         =   "Output File:"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1320
      Width           =   2295
   End
   Begin VB.Label Label1 
      Caption         =   "Input File:"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   480
      Width           =   1935
   End
End
Attribute VB_Name = "frmFilmon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' NtFilmon Filter
'
' G. Werner, 3.7.2000
'
' The output of a NtFilmon run will be filtered.
' The result is a file, which contains the
' count of occurences of each file/process in the input.
'

Public mLastOpenDir As String

Private Type entry
   nr As String
   process As String
   request As String
   path As String
   result As String
   other As String
   count As Long
End Type
 
Private ntList() As entry
Public ntSize As Long
Public ntIndex As Long


'
' Select Input file
'
Private Sub Command1_Click()
Dim s As String
Dim l As Long

With Me.CMDialog
    .InitDir = mLastOpenDir
    '.CancelError = True
    .Flags = cdlOFNAllowMultiselect Or cdlOFNHideReadOnly Or cdlOFNPathMustExist Or cdlOFNLongNames Or cdlOFNExplorer
    .Filter = "Fil Files|*.fil|Text Files|*.txt|All Files|*.*"
    .DialogTitle = "Select NtFilemon Output"
    .FileName = ""
    .MaxFileSize = 5000
End With
Me.CMDialog.ShowOpen
If Err = 32755 Then
    ' cancel selected
    Exit Sub
End If
s = Me.CMDialog.FileName
Text1.text = s
l = Len(s)
If l <= 0 Then
ElseIf LCase(Mid(s, l - 3)) = ".txt" Or LCase(Mid(s, l - 3)) = ".fil" Then
   Text2.text = Left(s, l - 4) & ".out"
Else
   Text2.text = ""
End If
End Sub

'
' Process file
'
Private Sub Command2_Click()
Dim fni As Long
Dim fno As Long


fni = FreeFile

On Error Resume Next
Open Text1.text For Input As #fni
If Err Then
   MsgBox "Cannot open file " & Text1.text
   Exit Sub
End If
fno = FreeFile
Open Text2.text For Output As #fno
If Err Then
   Close fni
   MsgBox "Cannot open file " & Text2.text
   Exit Sub
End If
Command2.Enabled = False
Call extractfilmon(fni, fno)
Command2.Enabled = True
Close fni
Close fno
End Sub

'
' Select output file
'
Private Sub Command3_Click()
With Me.CMDialog
    .InitDir = mLastOpenDir
    '.CancelError = True
    .Flags = cdlOFNAllowMultiselect Or cdlOFNHideReadOnly Or cdlOFNPathMustExist
    .Filter = "Text Files|*.txt|All Files|*.*"
    .DialogTitle = "Select NtFilemon Output"
    .FileName = ""
    .MaxFileSize = 5000
End With
Me.CMDialog.ShowOpen
If Err = 32755 Then
    ' cancel selected
    Exit Sub
End If
Text2.text = Me.CMDialog.FileName

End Sub

Private Sub Command4_Click()
End
End Sub

' Read input file
' create output file
Public Sub extractfilmon(fni As Long, fno As Long)
Dim linedata As String
Dim i As Long
Dim j As Long
Dim lnr As Long

ntSize = 10000
ReDim ntList(ntSize)
ntIndex = 0

lnr = 0

Do While Not EOF(fni)

  Line Input #fni, linedata
  lnr = lnr + 1
  Call readline(linedata, lnr, fno)
  
Loop

' count duplicates
collectInfos

' Print output. Print same process next

For i = 0 To ntIndex - 1
 If ntList(i).count < 0 Then GoTo nextI
 Print #fno, fixSize(ntList(i).count, 6) & vbTab & ntList(i).process & vbTab & ntList(i).path
 For j = i + 1 To ntIndex - 1
   If ntList(j).count > 0 And ntList(i).process = ntList(j).process Then
     Print #fno, fixSize(ntList(j).count, 6) & vbTab & ntList(j).process & vbTab & ntList(j).path
     ntList(j).count = -1
   End If
   
 Next j
nextI:
Next i
 
End Sub
'
' Interpret input line
'
Public Sub readline(linedata As String, lnr As Long, fno As Long)

Dim i As Long
Dim s As String

s = linedata
i = InStr(s, vbTab)
If i <= 0 Then
   GoTo failed
End If
ntList(ntIndex).nr = Left(s, i - 1)
s = Mid(s, i + 1)

i = InStr(s, vbTab)
If i <= 0 Then
  GoTo failed
End If
ntList(ntIndex).process = Left(s, i - 1)
s = Mid(s, i + 1)


i = InStr(s, vbTab)
If i <= 0 Then
   GoTo failed
End If
ntList(ntIndex).request = Left(s, i - 1)
s = Mid(s, i + 1)


i = InStr(s, vbTab)
If i <= 0 Then
   GoTo failed
End If
ntList(ntIndex).path = Left(s, i - 1)
s = Mid(s, i + 1)


i = InStr(s, vbTab)
If i <= 0 Then
   GoTo failed
End If
ntList(ntIndex).result = Left(s, i - 1)
s = Mid(s, i + 1)


i = InStr(s, vbTab)
If i <= 0 Then
   GoTo failed
End If
ntList(ntIndex).other = Left(s, i - 1)
s = Mid(s, i + 1)

useit:
ntIndex = ntIndex + 1
If ntIndex >= ntSize Then
  ntSize = ntSize + ntSize
  ReDim Preserve ntList(ntSize)
End If
Exit Sub

failed:
Print #fno, "Line " & lnr & " in error: " & linedata
GoTo useit
End Sub


'
' Count duplicates of Process/path
'
Public Sub collectInfos()
Dim i As Long
Dim j As Long

For i = 0 To ntIndex - 1
  If ntList(i).count < 0 Then
    GoTo nextI
  End If
  ntList(i).count = 1
  For j = i + 1 To ntIndex - 1
     If ntList(j).count >= 0 Then
        If ntList(i).process = ntList(j).process And _
           ntList(i).path = ntList(j).path Then
             ntList(i).count = ntList(i).count + 1
             ntList(j).count = -1
        End If
     End If
  Next j
nextI:
Next i

End Sub

Public Function fixSize(i As Long, size As Long, _
  Optional vorbelegung As String = "                           ")
Dim s As String
s = vorbelegung & i
fixSize = Right(s, size)

End Function

Private Sub Command5_Click()
Dim fni As Long
Dim fno As Long
Dim sfo As String
Dim fname As String
Dim i As Long

cmdRpt.Enabled = False

sfo = Text2.text
If LCase(Right(sfo, 4)) <> ".out" Then
  MsgBox "Falscher Outputfile"
  GoTo wrapup
End If
sfo = Left(sfo, Len(sfo) - 4)


For i = 1 To 100
fname = sfo & i & ".rpt"

fni = FreeFile

On Error Resume Next
Open Text1.text For Input As #fni
If Err Then
   MsgBox "Cannot open file " & Text1.text
   GoTo wrapup
End If




fno = FreeFile
Open fname For Output As #fno
If Err Then
   Close fni
   MsgBox "Cannot open file " & fname
   GoTo wrapup
End If

Call copyfile(fni, fno, fixSize(i, 3, "00000000"))

Close fni
Close fno
Next i

wrapup:
cmdRpt.Enabled = True
End Sub

Public Sub copyfile(fni As Long, fno As Long, text As String)
Dim linedata As String
Dim i As Long
Dim j As Long
Dim lnr As Long

lnr = 0

Do While Not EOF(fni)

  Line Input #fni, linedata
  lnr = lnr + 1
  If Left(linedata, 8) = "m1dEt|12" Then
    linedata = "m1dEt|12" & text & Mid(linedata, 12)
  End If
  Print #fno, linedata
  
Loop


End Sub
Private Sub cmdRpt_Click()
Dim fno As Long
Dim i As Long
Dim j As Long
Dim fname As String

cmdRpt.Enabled = False
fname = Text1.text
fno = FreeFile
On Error Resume Next
Open fname For Output As #fno
If Err Then
   MsgBox "Cannot open file " & fname
   GoTo wrapup
End If

Print #fno, "[Setup]"
Print #fno, "ProjectName = Translam"
Print #fno, "[begin]"

For i = 1 To 1000
  For j = 1 To 100
    Print #fno, "(New Drawing)"
    Print #fno, "m1dEt|" & (320000 + i) & "|" & j & _
    "|205APR01|WR1|Neztgeräteschrank|Reserve|$NULL$|$NULL$|$NULL$|$NULL$|$NULL$|$NULL$|$NULL$|+205a.K|/E103|+205a/E103|1995/10/10|Wimmer|P S G|$NULL$|1996/03/29|Stromlaufplan|$NULL$|$NULL$|a|$NULL$|$NULL$|$NULL$|$NULL$|$NULL$|Binder|$NULL$|DIN A3|CAD|CAE|FREIGEGEBEN|$NULL$|$NULL$|$NULL$|$NULL$|\205APR01\125154_6.tif|205a|$NULL$|1 - Besitzer|4 - Konzernteil|IT-TZ-ET"
    Print #fno, "(End Drawing)"
  Next j
Next i
Print #fno, "[END]"
Close fno
wrapup:
cmdRpt.Enabled = True

End Sub

