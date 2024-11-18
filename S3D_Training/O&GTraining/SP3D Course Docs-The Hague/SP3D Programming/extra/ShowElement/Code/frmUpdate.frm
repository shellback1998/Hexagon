VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmUpdate 
   Caption         =   "Update Code"
   ClientHeight    =   2055
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7905
   LinkTopic       =   "Form1"
   ScaleHeight     =   2055
   ScaleWidth      =   7905
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox chkUserCode 
      Caption         =   "User Code"
      Height          =   255
      Left            =   3840
      TabIndex        =   5
      Top             =   1200
      Width           =   2295
   End
   Begin VB.CommandButton cmdOverWrite 
      Caption         =   "Overwrite Old File"
      Height          =   372
      Left            =   1440
      TabIndex        =   4
      Top             =   1200
      Width           =   2172
   End
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   1800
      Width           =   7905
      _ExtentX        =   13944
      _ExtentY        =   450
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtOut 
      Height          =   372
      Left            =   120
      TabIndex        =   2
      Text            =   "updated.cls"
      Top             =   720
      Width           =   7572
   End
   Begin VB.TextBox txtIn 
      Height          =   372
      Left            =   120
      TabIndex        =   1
      Text            =   "clsShow.cls"
      Top             =   240
      Width           =   7575
   End
   Begin VB.CommandButton cmdUpdate 
      Caption         =   "Update File"
      Height          =   372
      Left            =   120
      TabIndex        =   0
      Top             =   1200
      Width           =   1212
   End
End
Attribute VB_Name = "frmUpdate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdOverWrite_Click()
    If gstrFout <> "" And gstrFin <> "" Then
        ' make backup copy
        FileCopy gstrFin, gstrFin & ".bak"
        FileCopy gstrFout, gstrFin
        Me.StatusBar1.Panels(1).Text = "old file=" & gstrFin & ".bak"
    Else
        MsgBox "On file is empty,", vbOKOnly
    End If
End Sub

Private Sub cmdUpdate_Click()
    Call UpdateSourceFile(Me.txtIn.Text, Me.txtOut.Text, Me.chkUserCode.Value)
    Me.StatusBar1.Panels(1).Text = "finished."
End Sub

Private Sub Form_Load()
    Dim s As String
    
    s = Command
    
'    s = Me.txtIn.Text
    If Len(s) <= 0 Then
        Me.txtIn.Text = App.Path & "\" & "clsShow.cls"
    ElseIf InStr(s, "\") > 0 Then
        ' assume path ok,
        Me.txtIn.Text = s
        ' assume user code (use object)
        chkUserCode.Value = 1
    Else
        Me.txtIn.Text = App.Path & "\" & s
    End If
    
    
    s = Me.txtOut.Text
    If Len(s) <= 0 Then
        Me.txtOut.Text = App.Path & "\" & "update.cls"
    ElseIf InStr(s, "\") > 0 Then
        ' assume path ok
    Else
        Me.txtOut.Text = App.Path & "\" & s
    End If
End Sub
