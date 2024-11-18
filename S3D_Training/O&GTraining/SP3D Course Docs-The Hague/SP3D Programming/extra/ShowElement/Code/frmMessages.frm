VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmMessages 
   Caption         =   "Messages"
   ClientHeight    =   6555
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9075
   LinkTopic       =   "Form1"
   ScaleHeight     =   6555
   ScaleWidth      =   9075
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdClear 
      Caption         =   "Clear"
      Height          =   492
      Left            =   3600
      TabIndex        =   3
      Top             =   6000
      Width           =   1332
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Height          =   492
      Left            =   7560
      TabIndex        =   2
      Top             =   6000
      Width           =   1332
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   492
      Left            =   120
      TabIndex        =   1
      Top             =   6000
      Width           =   1332
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   6960
      Top             =   6000
      _ExtentX        =   688
      _ExtentY        =   688
      _Version        =   393216
   End
   Begin VB.ListBox lstTexts 
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5235
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8772
   End
End
Attribute VB_Name = "frmMessages"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*******************************************************************
'Copyright (C) 2007, Intergraph Corporation. All rights reserved.
'
'Abstract:
'    frmMessages.frm - form  to show a list , e.g. logfile or similar stuff
'
'Description:
'
'
'Notes:
'
'
'  missing features: append to existing logfile
'
'History
'   GWE          Sep/01/2007      created
'
'******************************************************************

Option Explicit

Private isShown As Boolean

Private Sub cmdClear_Click()
    Me.lstTexts.Clear
End Sub

Private Sub cmdExit_Click()
    Me.Hide
End Sub

Private Sub cmdSave_Click()
    
Dim strPath As String
Dim lngFnr As Long
Dim i As Long

On Error Resume Next
    
    With Me.CommonDialog1
        .CancelError = True
        .Flags = cdlOFNOverwritePrompt Or cdlOFNHideReadOnly Or cdlOFNNoReadOnlyReturn Or cdlOFNOverwritePrompt Or cdlOFNPathMustExist
        .Filter = "Log Files|*.log|All Files|*.*"
        .InitDir = "."
        .DialogTitle = "Select Path for Error Messages"
        .FileName = "Errors.log"
        .DefaultExt = "log"
    
        .ShowSave
        If Err = 32755 Then
            ' cancel selected
            Exit Sub
        End If
    
        If .FileName = "" Then
            Exit Sub
        End If
    
        strPath = .FileName
    
    End With

    lngFnr = FreeFile
    Open strPath For Output As #lngFnr
    If Err Then
        Me.lstTexts.AddItem "Cannot open file: " & strPath
        Exit Sub
    End If
    
    For i = 0 To Me.lstTexts.ListCount - 1
        Print #lngFnr, Me.lstTexts.List(i)
    Next
    
    Me.lstTexts.AddItem "Errorlist written to file: " & strPath
    
    Close lngFnr
    
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    Me.lstTexts.Width = Me.Width - Me.lstTexts.Left * 2
    
    Me.lstTexts.Height = Me.Height - 1000
    
    Me.cmdExit.Top = Me.Height - Me.cmdExit.Height - 500
    
    Me.cmdClear.Top = Me.cmdExit.Top
    Me.cmdSave.Top = Me.cmdExit.Top
    
    Me.cmdSave.Left = Me.Width - Me.cmdSave.Width - 500
    
End Sub

'
'   Output
'
'   use this public function to add lines to the list
'
Public Sub Output(ByVal txt As String)

    Dim ar() As String
    Dim i As Long
    
    ar = Split(txt, vbCrLf)
    For i = LBound(ar) To UBound(ar)
        Call Me.lstTexts.AddItem(ar(i))
    Next i
 
    
    If Not isShown Then
        isShown = True
        Me.Show
    End If
    
    Me.lstTexts.ListIndex = Me.lstTexts.ListCount - 1
    
    DoEvents
    
End Sub

Public Sub ShowFile(path As String)
        Dim lfnr As Long
        Dim txt As String
        
        lfnr = FreeFile
        On Error Resume Next
        Open path For Input As lfnr
        If Err Then Exit Sub
        While Not EOF(lfnr)
                Line Input #lfnr, txt
                Call lstTexts.AddItem(txt)
        Wend
        On Error Resume Next
        Me.Show
        If Err Then
            Me.Show vbModal
        End If
        Me.lstTexts.ListIndex = Me.lstTexts.ListCount - 1
        Close lfnr
End Sub
