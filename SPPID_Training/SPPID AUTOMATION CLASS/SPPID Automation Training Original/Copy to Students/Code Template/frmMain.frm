VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Main Form"
   ClientHeight    =   5280
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9150
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   9150
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   372
      Left            =   4080
      TabIndex        =   3
      Top             =   2280
      Width           =   1092
   End
   Begin VB.Frame Options 
      Caption         =   "Options"
      Height          =   1332
      Left            =   3240
      TabIndex        =   0
      Top             =   600
      Width           =   2772
      Begin VB.OptionButton Option2 
         Caption         =   "Use PIDDatasource"
         Height          =   252
         Left            =   360
         TabIndex        =   2
         Top             =   840
         Width           =   2172
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Use New LMADatasource"
         Height          =   372
         Left            =   360
         TabIndex        =   1
         Top             =   360
         Value           =   -1  'True
         Width           =   2172
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private blnUsePIDDatasource As Boolean

Private Const CONST_SPID_ModelItem As String = "C76EF274525A4345A6ACE1D179362899"
Private Const CONST_SPID_ItemNote As String = "9A3B02C271754A8BB46DC4D02F9F0954"
Private Const CONST_SPID_OPC As String = "A8EC5233227A4F3AB480E9AB39205BCC"
Private Const CONST_SPID_Vessel As String = "C76EF274525A4345A6ACE1D179362899"
Private Const CONST_SPID_PipeRun As String = "8B283FA8472F4E3BABB6AF573DF161F4"
Private Const CONST_SPID_PipingComp As String = "59D6251324574734B9883C8E89E57B4E"
Private Const CONST_SPID_OfflineInstrument As String = "7EAB72658BA04FD8BD67CFEB4D96DD37"
Private Const CONST_SPID_InlineInstrument As String = "BC21A415E803496EBDA87129F5F5F540"
Private Const CONST_SPID_LabelPersist As String = "B9E88D821E8145269E5B398B858555A8"


Private Sub Form_Load()
    If Option1 Then
        blnUsePIDDatasource = False
    Else
        blnUsePIDDatasource = True
    End If
End Sub

Private Sub Option1_Click()
    
    blnUsePIDDatasource = False
    
End Sub

Private Sub Option2_Click()

    blnUsePIDDatasource = True
    
End Sub

Private Sub cmdExit_Click()
    Unload Me
End Sub

