VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
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
Private Sub Command1_Click()
    Dim datasource As LMADataSource
    Dim objPIDAutoApp As PIDAutomation.Application
    Dim objPIDADrawing As PIDAutomation.Drawing
    Dim objPlantGroupName As LMPlantGroup
    Dim TemplateFileName As String
    Dim DrawingNumber As String
    Dim DrawingName As String
    Dim UnitName As String
    Dim AreaName As String
    Dim PlangGroupName As String
    Dim i As Long
    
    Dim odatasource As LMADataSource
    Set odatasource = New LMADataSource
    Set odatasource = Nothing
    
        
    datasource.SiteNode = "\\swibossp02\STNSPSITE01\s\smartplantv4.ini"
    datasource.ProjectNumber = "Plant02!Plant02"
    
    Set objPIDAutoApp = CreateObject("PIDAutomation.Application")
     
    TemplateFileName = "\\swibossp02\STNSPSITE01\Plant 1\SPPID\Reference Data\Template Files\ssw-a1.pid"
    'TemplateFileName = "\\swibossp02\STNSPSITE01\Plant 2\SPPID\Reference Data\Template Files\ssw-a1.pid"
    'TemplateFileName = "ssw-a1.pid"
    
    PlantGroupName = "Plant01"
    'PlantGroupName = "Plant02"
    
    UnitName = "Unit01"
    'UnitName = "Scotts"
    
    AreaName = "Area001"
    'AreaName = "ScottArea"

    DrawingNumber = "Scott"
    DrawingName = "Scott"
        
       
    Set objPIDADrawing = objPIDAutoApp.Drawings.Add(UnitName, TemplateFileName, DrawingNumber, DrawingName) 'use unit name as plant group name
    'Set objPIDADrawing = objPIDAutoApp.Drawings.Add(AreaName, TemplateFileName, DrawingNumber, DrawingName)
        objPIDADrawing.CloseDrawing True
        
    objPIDAutoApp.Quit
    Set objPIDAutoApp = Nothing
    Set objPIDADrawing = Nothing
    Set datasource = Nothing

    

End Sub
