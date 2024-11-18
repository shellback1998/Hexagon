VERSION 5.00
Begin VB.Form frmImportStatus 
   Caption         =   "Import Log"
   ClientHeight    =   3210
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4530
   Icon            =   "frmImportStatus.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3210
   ScaleWidth      =   4530
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox lstStatus 
      Height          =   2010
      Left            =   150
      MultiSelect     =   2  'Extended
      TabIndex        =   2
      Top             =   510
      Width           =   4185
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "Close"
      Default         =   -1  'True
      Height          =   375
      Left            =   1665
      TabIndex        =   0
      Top             =   2730
      Width           =   1215
   End
   Begin VB.Label lblStatus 
      Caption         =   "Import Log:"
      Height          =   255
      Left            =   165
      TabIndex        =   1
      Top             =   120
      Width           =   4215
   End
End
Attribute VB_Name = "frmImportStatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdClose_Click()
    Unload Me
End Sub

Private Sub Form_Load()

    Me.caption = LoadResString(111)
    lblStatus.caption = LoadResString(111) & ":"
    cmdClose.caption = LoadResString(112)

End Sub

Private Sub Form_Resize()

    If (Me.Height < 3615) Then Me.Height = 3615
    If (Me.Width < 4650) Then Me.Width = 4650
    
    lstStatus.Height = Me.Height - 1095 - lstStatus.Top
    lstStatus.Width = Me.Width - 425
    cmdClose.Left = (Me.Width / 2) - 607
    cmdClose.Top = Me.Height - 885

End Sub
