VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmSelectStream 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Stream Number"
   ClientHeight    =   2700
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   Icon            =   "frmSelectStreamID.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2700
   ScaleWidth      =   5175
   StartUpPosition =   2  'CenterScreen
   WhatsThisHelp   =   -1  'True
   Begin MSComDlg.CommonDialog cmndlgStreamFile 
      Left            =   150
      Top             =   2220
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "&Browse"
      Height          =   300
      Left            =   3855
      TabIndex        =   2
      Top             =   1005
      Width           =   1020
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   300
      Left            =   2700
      TabIndex        =   5
      Top             =   2280
      Width           =   1020
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   300
      Left            =   3840
      TabIndex        =   6
      Top             =   2280
      Width           =   1020
   End
   Begin VB.TextBox txtFileName 
      Height          =   285
      Left            =   240
      TabIndex        =   1
      Top             =   1005
      Width           =   3480
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   240
      TabIndex        =   4
      Top             =   1800
      Width           =   4635
   End
   Begin VB.Label Label3 
      Caption         =   "Stream ID:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   1560
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "File name:"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   765
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Select a stream number from the list, or key in a stream number and select OK."
      Height          =   435
      Left            =   240
      TabIndex        =   7
      Top             =   240
      Width           =   4950
   End
End
Attribute VB_Name = "frmSelectStream"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objStreamNumberCalc As StreamNumberCalc
Private m_OriginalFileName As String
Private m_StreamData As Collection

Public Property Get StreamData() As Collection
    Set StreamData = m_StreamData
End Property

Public Property Let OriginalFileName(sNewValue As String)
    m_OriginalFileName = sNewValue
End Property

Private Sub cmdBrowse_Click()
    
    With cmndlgStreamFile
        .DialogTitle = LoadResString(119)
        .CancelError = True
        .Flags = cdlOFNHelpButton Or cdlOFNHideReadOnly
        .Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
        On Error Resume Next
        .ShowOpen
        txtFileName.Text = .Filename
    End With

End Sub

Private Sub cmdCancel_Click()

    Combo1.Text = ""
    Me.Hide

End Sub

Private Sub cmdOK_Click()

    On Error Resume Next
    If (Trim(txtFileName.Text) = "") Or (Dir(txtFileName.Text)) = "" Then
        MsgBox LoadResString(102) & txtFileName.Text & LoadResString(103), vbOKOnly + vbExclamation, _
                  LoadResString(104)
        Combo1.Clear
    Else
        Me.Hide
    End If

End Sub

Private Sub Combo1_DropDown()

    Dim objConfigInfo As New igrConfigInfo
                
    If m_OriginalFileName <> txtFileName.Text Then
        On Error Resume Next
        If (Trim(txtFileName.Text) = "") Or (Dir(txtFileName.Text)) = "" Then
            MsgBox LoadResString(102) & txtFileName.Text & LoadResString(103), vbOKOnly + vbExclamation, _
                      LoadResString(104)
            Combo1.Clear
            m_OriginalFileName = ""
        Else
            objConfigInfo.ApplicationName = "SmartPlantPID"
            objConfigInfo.SetConfigString ConfigKeyUser, "Import", "ZyqadStreamData", txtFileName.Text
            Set m_StreamData = objStreamNumberCalc.GetStreamDataFromFile(txtFileName.Text)
            objStreamNumberCalc.Populate m_StreamData
            m_OriginalFileName = txtFileName.Text
        End If
    End If

    Set objConfigInfo = Nothing
    
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF1 Then
        Call GetHtmlHelpTopic(Me, "SPPIDHelp409.chm", 13000)
    End If
    Exit Sub
End Sub

Private Sub Form_Load()
    Set objStreamNumberCalc = New StreamNumberCalc
    
    'Set up browse for file.
    cmdBrowse.ToolTipText = LoadResString(110)
    
    Me.caption = LoadResString(113)
    Label1.caption = LoadResString(114)
    Label2.caption = LoadResString(115)
    Label3.caption = LoadResString(155)
    cmdBrowse.caption = LoadResString(116)
    cmdOK.caption = LoadResString(117)
    cmdCancel.caption = LoadResString(118)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objStreamNumberCalc = Nothing
End Sub

