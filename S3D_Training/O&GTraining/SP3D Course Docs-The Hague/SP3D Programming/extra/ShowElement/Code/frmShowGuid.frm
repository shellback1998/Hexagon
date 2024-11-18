VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmShowGuid 
   Caption         =   "Show GUID"
   ClientHeight    =   1455
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5595
   LinkTopic       =   "Form1"
   ScaleHeight     =   1455
   ScaleWidth      =   5595
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   4080
      TabIndex        =   5
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton cmdShGuid 
      Caption         =   "HighLight"
      Height          =   375
      Index           =   1
      Left            =   2160
      TabIndex        =   4
      Top             =   600
      Width           =   1815
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   3
      Top             =   1080
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   661
      Style           =   1
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton cmdShGuid 
      Caption         =   "Show"
      Height          =   375
      Index           =   0
      Left            =   240
      TabIndex        =   2
      Top             =   600
      Width           =   1815
   End
   Begin VB.TextBox txtGuid 
      Height          =   375
      Left            =   1320
      TabIndex        =   0
      Top             =   120
      Width           =   3975
   End
   Begin VB.Label Label1 
      Caption         =   "GUID"
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "frmShowGuid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'
'  frmShowGuid - highlight a Sp3d object given its GUID.
'
'  or show all interfaces using ShowElement.ShowObject.
'

'
'  SHOWELEMENTEXTERN - 1 use the ShowElement.ShowObject dll to display object
'                      0 use the internal clsObject class
'
#Const SHOWELEMENTEXTERN = 0

Private m_oHiliter As IJHiliter ' Used to display selected objects


Private Sub cmdExit_Click()
    Unload Me
End Sub



Private Sub cmdShGuid_Click(Index As Integer)
    Dim sGuid As String
    Dim o As Object
  
    Dim oSelSet As IJSelectSet
    On Error GoTo Handler
    
    StatusBar1.SimpleText = ""
    sGuid = RetrieveGuid(txtGuid.Text)
    If sGuid = "" Then
        StatusBar1.SimpleText = "Enter GUID:  {.....}"
        Exit Sub
    End If
    Set o = getObjectByGuid(sGuid)
    If o Is Nothing Then
        StatusBar1.SimpleText = "No object found"
        Exit Sub
    End If
'
    If Index = 0 Then
#If SHOWELEMENTEXTERN = 1 Then
        Call ShowObject(o)
#Else
        Dim oObject As clsObject
        Set oObject = New clsObject
        If oObject.ShowObject(o) < 0 Then
            StatusBar1.SimpleText = "Cannot show object"
        Else
            StatusBar1.SimpleText = "See object form"
        End If
#End If
    Else
     
            Dim oTrader As New Trader
            Dim oGraphicViews As IJDGraphicViews
            Dim oWorkingSet As IJDWorkingSet
            Dim oMoniker As IUnknown
            
            Set oSelSet = oTrader.Service(TKSelectSet, "")
            Set oWorkingSet = oTrader.Service(TKWorkingSet, "")
            
            ' we have to add the moniker, not the object.
            ' in case the object was just in the selectset, the object will not work, but the moniker
            
            Set oMoniker = oWorkingSet.ActiveConnection.GetObjectName(o)
            
            oSelSet.Elements.Clear

            oSelSet.Elements.Add oMoniker
            StatusBar1.SimpleText = "Object in selectset."
            Set oMoniker = Nothing
    End If
    Set o = Nothing
    Exit Sub
Handler:
    StatusBar1.SimpleText = Err.Description
    Set o = Nothing
End Sub

'
'  retrieve complete guid string, (or empty string)
'
Private Function RetrieveGuid(sIn As String) As String
 
    RetrieveGuid = Trim(sIn)
    If Left(RetrieveGuid, 1) <> "{" Or Right(RetrieveGuid, 1) <> "}" Then
        RetrieveGuid = ""
    End If
End Function

 
Private Sub Form_Unload(Cancel As Integer)
    Set m_oHiliter = Nothing
End Sub




Public Sub ShowObject(o As Object)
    Dim oSH As Object
    Const SHOWELMENT_SHOWOBJECT As String = "ShowElement.ShowObject"
    On Error Resume Next
    Set oSH = CreateObject(SHOWELMENT_SHOWOBJECT)
    If oSH Is Nothing Then
'        Call MsgBox("Cannot create " & SHOWELMENT_SHOWOBJECT)
        Exit Sub
    End If
    
    Call oSH.Show(o)
    
    Set oSH = Nothing
    
End Sub


