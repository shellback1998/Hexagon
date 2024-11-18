VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdInstrumentTag 
      Caption         =   "Get Instrument Piperun"
      Height          =   495
      Left            =   1800
      TabIndex        =   0
      Top             =   1320
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdInstrumentTag_Click()
    Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objInstr As LMInstrument
    Set objInstr = datasource.GetInstrument("B9F3DDACB026421E80BB2C7D245C280D")
    
    Dim strPipeRunItemTag As String
    strPipeRunItemTag = GetPipeRunTagFromInstr(objInstr, datasource)
    
    MsgBox strPipeRunItemTag
End Sub


Private Function GetPipeRunTagFromInstr(objInstr As LMInstrument, datasource As LMADataSource) As String
    Dim objSymbol As LMSymbol
    Dim objConnector As LMConnector
    Dim objConnectedRun As LMPlantItem
    Dim objConnectToProcessRun As LMConnector
    Dim objPipeRun As LMPipeRun
    
    Set objSymbol = datasource.GetSymbol(objInstr.Representations.Nth(1).ID)
    
    For Each objConnector In objSymbol.Connect1Connectors
        Set objConnectedRun = datasource.GetPlantItem(objConnector.ModelItemID)
        If objConnectedRun.Attributes("PlantItemType") = "Pipe Run" Then
            Set objConnectToProcessRun = objConnector
            Exit For
        End If
    Next
    
    If objConnectToProcessRun Is Nothing Then
        For Each objConnector In objSymbol.Connect2Connectors
            Set objConnectedRun = datasource.GetPlantItem(objConnector.ModelItemID)
            If objConnectedRun.Attributes("PlantItemType") = "PipeRun" Then
                Set objConnectToProcessRun = objConnector
                Exit For
            End If
        Next
    End If
    
    If Not objConnectToProcessRun Is Nothing Then
        If objConnectToProcessRun.ConnectItem1SymbolID <> objSymbol.ID Then
            Set objPipeRun = datasource.GetPipeRun(objConnectToProcessRun.ConnectItem1SymbolObject.ModelItemID)
        Else
            Set objPipeRun = datasource.GetPipeRun(objConnectToProcessRun.ConnectItem2SymbolObject.ModelItemID)
        End If
        
        If Not objPipeRun Is Nothing Then
            GetPipeRunTagFromInstr = objPipeRun.Attributes("ItemTag").Value
        End If
    End If
End Function

