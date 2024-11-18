VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Transformation Programs"
   ClientHeight    =   3990
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5775
   ControlBox      =   0   'False
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3990
   ScaleWidth      =   5775
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   315
      HelpContextID   =   3
      Left            =   4440
      TabIndex        =   7
      Top             =   3600
      Width           =   1200
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Clear Process Data"
      Height          =   195
      Left            =   360
      TabIndex        =   6
      Top             =   3120
      Width           =   2415
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Clear Piping Material Classification"
      Height          =   195
      Left            =   360
      TabIndex        =   5
      Top             =   2760
      Width           =   4455
   End
   Begin VB.Frame Frame1 
      Caption         =   "Transformation Programs:"
      Height          =   3255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   5535
      Begin VB.Frame Frame2 
         Caption         =   "Sequence"
         Height          =   1935
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Width           =   4935
         Begin VB.OptionButton Option3 
            Caption         =   "Option3"
            Height          =   375
            Left            =   240
            TabIndex        =   4
            Top             =   1440
            Width           =   4575
         End
         Begin VB.TextBox Text1 
            Alignment       =   2  'Center
            Enabled         =   0   'False
            Height          =   285
            Left            =   520
            TabIndex        =   3
            Text            =   "_"
            Top             =   1080
            Width           =   975
         End
         Begin VB.OptionButton Option2 
            Caption         =   "Option2"
            Height          =   375
            Left            =   240
            TabIndex        =   2
            Top             =   640
            Width           =   4455
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Option1"
            Height          =   255
            Left            =   240
            TabIndex        =   1
            Top             =   360
            Width           =   4455
         End
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdOK_Click()
    If Option2.Value = True Then
        If Text1.Text = "" Then
            MsgBox LoadResString(5009), vbOKOnly, LoadResString(5000)
            Exit Sub
        End If
    End If
    Me.Hide
End Sub

Private Sub Form_Load()
    Form1.Caption = LoadResString(5000)
    Frame1.Caption = LoadResString(5001)
    Frame2.Caption = LoadResString(5011)
    Option1.Caption = LoadResString(5002)
    Option2.Caption = LoadResString(5004)
    Option3.Caption = LoadResString(5012)
    cmdOK.Caption = LoadResString(5008)
    Check3.Caption = LoadResString(5006)
    Check4.Caption = LoadResString(5007)
End Sub

Private Sub Option1_Click()
    Text1.Enabled = False
End Sub

Private Sub Option2_Click()
    Text1.Enabled = True
End Sub

Private Sub Option3_Click()
    Text1.Enabled = False
End Sub

