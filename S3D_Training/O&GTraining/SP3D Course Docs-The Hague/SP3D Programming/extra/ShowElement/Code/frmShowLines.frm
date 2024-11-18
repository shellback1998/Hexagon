VERSION 5.00
Begin VB.Form frmShowLines 
   Caption         =   "Show Line"
   ClientHeight    =   2490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8430
   LinkTopic       =   "Form1"
   ScaleHeight     =   2490
   ScaleWidth      =   8430
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Clear"
      Height          =   372
      Left            =   2400
      TabIndex        =   3
      Top             =   1920
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Cancel"
      Height          =   372
      Left            =   4200
      TabIndex        =   2
      Top             =   1920
      Width           =   1695
   End
   Begin VB.TextBox txtPoints 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   0
      Width           =   4335
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "Show Line"
      Height          =   372
      Left            =   0
      TabIndex        =   0
      Top             =   1920
      Width           =   2292
   End
End
Attribute VB_Name = "frmShowLines"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


'Private m_oTxnMgr As IJTransactionMgr
'Private m_oLine As Line3d
Private m_oGraphicFactory As IJGeometryFactory
Private m_oConn As IJDConnection
Private m_oWorkingSet As IJDWorkingSet
Private m_oPref As IJPreferences

Private colLines As Collection
Private m_lSwitch As Long

Private mlWeight As Long
Private mlColor As Long

Private Sub cmdOpen_Click()
    Dim oPos() As AutoMath.DPosition
    Dim sArr() As String
    Dim sB() As String
    Dim i As Long
    Dim j As Long
    Dim j1 As Long
    Dim k As Long
    Dim d(2) As Double
    Dim s As String
    Dim x As String
    
    On Error GoTo Handler
    
    If m_lSwitch = 0 Then
        s = Me.txtPoints.Text
        s = Replace(s, " ", ",")
        s = Replace(s, vbTab, ",")
        s = Replace(s, ";", ",")
        
        For i = 1 To Len(s)
            x = Mid(s, i, 1)
            If (x >= "0" And x <= "9") Or x = "-" Or x = "." Or x = "," Or x = vbCr Or x = vbLf Then
                ' ok
            Else
                Mid(s, i, 1) = " "
            End If
        Next i
        sArr = Split(s, vbCrLf)
        ReDim oPos(UBound(sArr))
        k = 0
        For i = 0 To UBound(sArr)
            sB = Split(sArr(i), ",")
            j1 = -1
            For j = LBound(sB) To UBound(sB)
                If Len(Trim(sB(j))) > 0 Then
                    j1 = j1 + 1
                    sB(j1) = sB(j)
                End If
            Next j
            If j1 >= 0 Then
                ReDim Preserve sB(j1)
            End If
            ReDim Preserve sB(2)

            If sB(0) = "" Then
                GoTo NextI
            End If
            
            Set oPos(k) = New DPosition
            On Error Resume Next
            d(0) = parCGetDouble(sB(0))
            d(1) = parCGetDouble(sB(1))
            d(2) = parCGetDouble(sB(2))
            On Error GoTo Handler
            oPos(k).Set d(0), d(1), d(2)
            
            sB(0) = sDouble(oPos(k).x)
            sB(1) = sDouble(oPos(k).y)
            sB(2) = sDouble(oPos(k).z)
            sArr(k) = Join(sB, ", ")
            k = k + 1
NextI:
        Next i
        If k > 0 Then
            ReDim Preserve sArr(k - 1)
            Me.txtPoints.Text = Join(sArr, vbCrLf)
            m_oPref.SetStringValue "SHOWELEMENT_SHOWLINEs", Me.txtPoints.Text
            For i = 1 To k - 1
                Call drawLine(oPos(i - 1).x, oPos(i - 1).y, oPos(i - 1).z, _
                            oPos(i).x, oPos(i).y, oPos(i).z, mlWeight, mlColor)
'                    Set m_oLine = m_oGraphicFactory.Lines3d.CreateBy2Points( _
'                                m_oConn.ResourceManager, _
'                                oPos(i - 1).x, oPos(i - 1).y, oPos(i - 1).z, _
'                                oPos(i).x, oPos(i).y, oPos(i).z)
            Next i
            If k = 1 Then
                Call drawLine(oPos(0).x, oPos(0).y, oPos(0).z, _
                                    0#, 0#, 0#, mlWeight, mlColor)
'                Set m_oLine = m_oGraphicFactory.Lines3d.CreateBy2Points( _
'                                    m_oConn.ResourceManager, _
'                                    oPos(0).x, oPos(0).y, oPos(0).z, _
'                                    0#, 0#, 0#)
            End If
            
            
'            m_oTxnMgr.Compute
        End If
        m_lSwitch = 1
        cmdOpen.Caption = "Abort"
    Else
'        If Not m_oLine Is Nothing Then
            Call clearLines
'            Set m_oLine = Nothing
'            m_oTxnMgr.Abort
'        End If
        m_lSwitch = 0
        cmdOpen.Caption = "Show Line(s)"
    End If
    Exit Sub
Handler:
    MsgBox Err.Description
    m_lSwitch = 0
    cmdOpen.Caption = "Show Line(s)"
    Exit Sub
    Resume
End Sub

Private Sub Command1_Click()
    Call clearLines
    Unload Me
End Sub

Private Sub Command2_Click()
    
    Me.txtPoints.Text = ""
    If m_lSwitch = 1 Then
        Call cmdOpen_Click ' abort the line
    End If
    m_oPref.SetStringValue "SHOWELEMENT_SHOWLINEs", Me.txtPoints.Text
End Sub

Private Sub Form_Load()
    Dim oTrader As New Trader
'    Set m_oTxnMgr = oTrader.Service(TKTransactionMgr, "")
    Set m_oGraphicFactory = New GeometryFactory
    
    Set m_oWorkingSet = oTrader.Service(TKWorkingSet, "")
    Set m_oConn = m_oWorkingSet.ActiveConnection
    
    Set m_oWorkingSet = Nothing
    
    Set m_oPref = oTrader.Service(TKPreferences, "")
    
    Set colLines = New Collection
    mlWeight = 5
    mlColor = vbRed
    
    Me.txtPoints.Text = m_oPref.GetStringValue("SHOWELEMENT_SHOWLINEs", "")
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    txtPoints.Width = Me.Width - txtPoints.Left * 2 - 200
    txtPoints.Height = Me.Height - cmdOpen.Height - 500
    
    cmdOpen.Top = Me.Height - cmdOpen.Height - 450
    Command1.Top = cmdOpen.Top
    Command2.Top = cmdOpen.Top
End Sub

Private Sub Form_Unload(Cancel As Integer)
'    If Not m_oLine Is Nothing Then
'        Set m_oLine = Nothing
'        m_oTxnMgr.Abort
'    End If
    Call clearLines
    Set colLines = Nothing
'    Set m_oTxnMgr = Nothing
    Set m_oGraphicFactory = Nothing
    Set m_oPref = Nothing
    Set m_oConn = Nothing
End Sub


Public Function Vector(x As Double, y As Double, z As Double) As String
    Vector = "( " & sDouble(x) & ", " & sDouble(y) & ", " & sDouble(z) & " )"
End Function

Public Function sDouble(d As Double) As String
If (Abs(d) < 0.0001 And Abs(d) > 0.000000000001) Or Abs(d) > 1000000# Then
    sDouble = d
Else
    sDouble = Format(d, "####0.000")
End If
sDouble = Replace(sDouble, ",", ".")
End Function

Public Function VectorAsString(x As Double, y As Double, z As Double) As String
    VectorAsString = x & "," & y & "," & z
End Function

Public Function VectorP(oPos As DPosition) As String
    VectorP = Vector(oPos.x, oPos.y, oPos.z)
End Function
Public Function VectorV(oPos As DVector) As String
    VectorV = Vector(oPos.x, oPos.y, oPos.z)
End Function

Public Sub drawLine(x As Double, y As Double, z As Double, _
                x2 As Double, y2 As Double, z2 As Double, _
                Optional weigth As Long = 5, Optional mycolor As Long = vbRed)
                
 
    Dim dP As DPosition
    Dim oTempSolidLines   As IMSElementDisplayService.LineDisplay
    On Error GoTo Handler
    
    Set oTempSolidLines = New IMSElementDisplayService.LineDisplay
    
        Set dP = New DPosition
        dP.Set x, y, z
        oTempSolidLines.RootPoint = dP
        Set dP = New DPosition
        dP.Set x2, y2, z2
        oTempSolidLines.EndPoint = dP
        
        oTempSolidLines.Pattern = imsSolid
        oTempSolidLines.Color = mycolor
        oTempSolidLines.Weight = weigth
        
        oTempSolidLines.Hidden = False
        
        colLines.Add oTempSolidLines
        
    Exit Sub
Handler:
    MsgBox Err.Description, vbOKOnly, "drawLine"
End Sub
Private Sub clearLines()
    Set colLines = New Collection
End Sub
