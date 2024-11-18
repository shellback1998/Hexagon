VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H80000001&
   Caption         =   "Main Form"
   ClientHeight    =   4830
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9375
   LinkTopic       =   "Form1"
   ScaleHeight     =   4830
   ScaleWidth      =   9375
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton btnLab17 
      Caption         =   "Lab 17"
      Height          =   375
      Left            =   2880
      TabIndex        =   19
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton btnLab16 
      Caption         =   "Lab 16"
      Height          =   375
      Left            =   2880
      TabIndex        =   18
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton btnLab15 
      Caption         =   "Lab15"
      Height          =   375
      Left            =   1560
      TabIndex        =   17
      Top             =   3840
      Width           =   1095
   End
   Begin VB.CommandButton btnLab14 
      Caption         =   "Lab 14"
      Height          =   375
      Left            =   1560
      TabIndex        =   16
      Top             =   3240
      Width           =   1095
   End
   Begin VB.CommandButton btnLab13 
      Caption         =   "Lab 13"
      Height          =   375
      Left            =   1560
      TabIndex        =   15
      Top             =   2640
      Width           =   1095
   End
   Begin VB.CommandButton btnLab12 
      Caption         =   "Lab 12"
      Height          =   375
      Left            =   1560
      TabIndex        =   14
      Top             =   2040
      Width           =   1095
   End
   Begin VB.CommandButton btnLab11 
      Caption         =   "Lab 11"
      Height          =   375
      Left            =   1560
      TabIndex        =   13
      Top             =   1440
      Width           =   1095
   End
   Begin VB.CommandButton btnLab10 
      Caption         =   "Lab10"
      Height          =   375
      Left            =   1560
      TabIndex        =   12
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton btnLab9 
      Caption         =   "Lab 9"
      Height          =   375
      Left            =   1560
      TabIndex        =   11
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton btnLab8 
      Caption         =   "Lab 8"
      Height          =   375
      Left            =   240
      TabIndex        =   10
      Top             =   3840
      Width           =   1095
   End
   Begin VB.CommandButton btnLab7 
      Caption         =   "Lab 7"
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   3240
      Width           =   1095
   End
   Begin VB.CommandButton btnLab6 
      Caption         =   "Lab 6"
      Height          =   375
      Left            =   240
      TabIndex        =   8
      Top             =   2640
      Width           =   1095
   End
   Begin VB.CommandButton btnLab5 
      Caption         =   "Lab 5"
      Height          =   375
      Left            =   240
      TabIndex        =   7
      Top             =   2040
      Width           =   1095
   End
   Begin VB.CommandButton btnLab4 
      Caption         =   "Lab 4"
      Height          =   375
      Left            =   240
      TabIndex        =   6
      Top             =   1440
      Width           =   1095
   End
   Begin VB.CommandButton btnLab3 
      Caption         =   "Lab 3"
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton btnLab1 
      Caption         =   "Lab 1"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   372
      Left            =   6480
      TabIndex        =   3
      Top             =   2400
      Width           =   1092
   End
   Begin VB.Frame Options 
      Caption         =   "Options"
      Height          =   1332
      Left            =   5640
      TabIndex        =   0
      Top             =   720
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

Private Const CONST_SPID_ModelItem As String = "D6BB4EF0C76F41DFA4116619258CC92F"
Private Const CONST_SPID_ItemNote As String = "D0D9F38E9B9240B0933C86EBFA0F214F"
Private Const CONST_SPID_OPC As String = "707A3B991258424098806561B5430318"
Private Const CONST_SPID_Vessel As String = "D6BB4EF0C76F41DFA4116619258CC92F"
Private Const CONST_SPID_PipeRun As String = "770871FB53D747B5875D91A87D7356EB"
Private Const CONST_SPID_PipingComp As String = "2E3F163537234E2E9539CF5B6762202E"
Private Const CONST_SPID_OfflineInstrument As String = "765168BE51DE492995F6C605CFDDD89B"
Private Const CONST_SPID_InlineInstrument As String = "0F7008C96715498BB300B57E02900F0E"
Private Const CONST_SPID_LabelPersist As String = "3B1C747DD63E4271A4969178650E9965"


Private Sub btnLab1_Click()
Dim datasource As LMADataSource


If Not blnUsePIDDatasource Then
Set datasource = New LMADataSource
Else
Set datasource = PIDDataSource
End If
Debug.Print datasource.ProjectNumber
Debug.Print datasource.SiteNode
Debug.Print datasource.IsSatellite
Debug.Print datasource.GetSystemEditingToolbarSetting

Set datasource = Nothing

End Sub

Private Sub btnLab10_Click()
    Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objVessel As LMVessel
    
    Set objVessel = datasource.GetVessel(CONST_SPID_Vessel)    'get vessel by id
    
    Dim objAttr As LMAAttribute
    Debug.Print "Total attributes for Vessel: " & objVessel.Attributes.Count
    For Each objAttr In objVessel.Attributes
        Debug.Print "Attribute Name=" & objAttr.Name & Space(50 - Len(objAttr.Name)) & "   Value=" & objAttr.Value
    Next
    
    Debug.Print objVessel.Attributes.Item("ProcessAlternateDesign.Max.Pressure").Value
    Debug.Print "Total attributes for Vessel: " & objVessel.Attributes.Count
    For Each objAttr In objVessel.Attributes
        Debug.Print "Attribute Name=" & objAttr.Name & Space(50 - Len(objAttr.Name)) & "   Value=" & objAttr.Value
    Next
        
    Set datasource = Nothing
    Set objVessel = Nothing
    Set objAttr = Nothing

End Sub

Private Sub btnLab11_Click()
    Dim datasource As LMADataSource
    Dim i As Integer
    Dim objAttr As LMAAttribute
    Dim vValue As Variant
    Dim objVessel As LMVessel
      
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objExcel As Excel.Application
    
    Set objExcel = CreateObject("Excel.Application")
    objExcel.Visible = True
      
    Dim xlWorkbook As Excel.Workbook
    Set xlWorkbook = objExcel.Workbooks.Add
    
    Dim xlWorksheet As Excel.Worksheet
    Set xlWorksheet = xlWorkbook.Worksheets("SHEET1")
    
    Dim Row As Long
    Dim CodeListCount As Long
    
    Row = 1
    
    xlWorksheet.Cells(Row, 1) = "ItemType"
    
    xlWorksheet.Cells(Row, 2) = "Attribute Name"
    
    xlWorksheet.Cells(Row, 3) = "Format"
    
    xlWorksheet.Cells(Row, 4) = "IsCodeList"
    
    xlWorksheet.Cells(Row, 5) = "CodeList Index"
    
    xlWorksheet.Cells(Row, 6) = "Calculation ProgID"
    
    xlWorksheet.Cells(Row, 7) = "Validation ProgID"
    Row = Row + 1
    
    Set objVessel = datasource.GetVessel(CONST_SPID_Vessel)
    xlWorksheet.Cells(Row, 1) = "Total attributions for Vessel: " & objVessel.Attributes.Count
    Row = Row + 1
    For Each objAttr In objVessel.Attributes
        xlWorksheet.Cells(Row, 1) = objVessel.AsLMAItem.ItemType
        xlWorksheet.Cells(Row, 2) = objAttr.Name
        xlWorksheet.Cells(Row, 3) = objAttr.ISPAttribute.Attribution.Format
On Error Resume Next
        CodeListCount = 0
        CodeListCount = objAttr.ISPAttribute.Attribution.ISPEnumAtts.Count
On Error GoTo 0
        If CodeListCount > 0 Then
            xlWorksheet.Cells(Row, 4) = "True"
        Else
            xlWorksheet.Cells(Row, 4) = "False"
        End If
        xlWorksheet.Cells(Row, 5) = objAttr.Index
        xlWorksheet.Cells(Row, 6) = objAttr.ISPAttribute.Attribution.CalculationProgID
        xlWorksheet.Cells(Row, 7) = objAttr.ISPAttribute.Attribution.ValidationProgID
        Row = Row + 1
    Next

    Row = Row + 1
On Error Resume Next
    vValue = objVessel.Attributes("ProcessDesign.Max.Pressure")
On Error GoTo 0
    xlWorksheet.Cells(Row, 1) = "Total attributions for Vessel: " & objVessel.Attributes.Count
    Row = Row + 1
    For Each objAttr In objVessel.Attributes
        xlWorksheet.Cells(Row, 1) = objVessel.AsLMAItem.ItemType
        xlWorksheet.Cells(Row, 2) = objAttr.Name
        xlWorksheet.Cells(Row, 3) = objAttr.ISPAttribute.Attribution.Format
On Error Resume Next
        CodeListCount = 0
        CodeListCount = objAttr.ISPAttribute.Attribution.ISPEnumAtts.Count
On Error GoTo 0
        If CodeListCount > 0 Then
            xlWorksheet.Cells(Row, 4) = "True"
        Else
            xlWorksheet.Cells(Row, 4) = "False"
        End If
        xlWorksheet.Cells(Row, 5) = objAttr.Index
        xlWorksheet.Cells(Row, 6) = objAttr.ISPAttribute.Attribution.CalculationProgID
        xlWorksheet.Cells(Row, 7) = objAttr.ISPAttribute.Attribution.ValidationProgID
        Row = Row + 1
    Next
    
    Dim strFileName As String
    strFileName = Environ("TEMP") & "\ItemAttributions.xls"
    objExcel.Workbooks(1).SaveAs (strFileName)
    xlWorkbook.Close True
    objExcel.Quit
    
    MsgBox "Done"
    
    Set datasource = Nothing
    Set objVessel = Nothing
    Set xlWorksheet = Nothing
    Set xlWorkbook = Nothing
    Set objExcel = Nothing

End Sub




Private Sub btnLab12_Click()
Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objFilter As LMAFilter
    Dim criterion As LMACriterion
     Set criterion = New LMACriterion
    Set objFilter = New LMAFilter

    criterion.SourceAttributeName = "TagSuffix"
    criterion.ValueAttribute = "P"
    criterion.Operator = "="
    objFilter.ItemType = "PipeRun"
    objFilter.Criteria.Add criterion
    
    Dim piperun As LMPipeRun
    Dim piperuns As LMPipeRuns
    Set piperuns = New LMPipeRuns
    piperuns.Collect datasource, Filter:=objFilter
    
    Debug.Print "Number of Piperuns retrieved = " & piperuns.Count
    datasource.BeginTransaction
    For Each piperun In piperuns
        Debug.Print piperun.Attributes("TagSuffix").Value
        
        Debug.Print "Piperun ID = " & piperun.ID
        piperun.Attributes("Name").Value = "P-Run"
        piperun.Commit
    Next
    datasource.CommitTransaction
    Set datasource = Nothing
    Set objFilter = Nothing
    Set criterion = Nothing
    Set piperun = Nothing
    Set piperuns = Nothing

End Sub

Private Sub btnLab13_Click()
Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objFilter As LMAFilter
    Set objFilter = New LMAFilter
    
    objFilter.Criteria.AddNew ("FirstOne")
    objFilter.Criteria.Item("FirstOne").SourceAttributeName = "ItemTag"
    objFilter.Criteria.Item("FirstOne").ValueAttribute = "%K%"
    objFilter.Criteria.Item("FirstOne").Operator = "like"
    objFilter.ItemType = "PipeRun"
    
    objFilter.Criteria.AddNew ("SecondOne")
    objFilter.Criteria.Item("SecondOne").SourceAttributeName = "TagSuffix"
    objFilter.Criteria.Item("SecondOne").ValueAttribute = "P_"
    objFilter.Criteria.Item("SecondOne").Operator = "like"
    objFilter.Criteria.Item("SecondOne").Conjunctive = False
    
    objFilter.Criteria.AddNew ("ThirdOne")
    objFilter.Criteria.Item("ThirdOne").SourceAttributeName = "Name"
    objFilter.Criteria.Item("ThirdOne").ValueAttribute = Null
    objFilter.Criteria.Item("ThirdOne").Operator = "!="
    objFilter.Criteria.Item("ThirdOne").Conjunctive = False
    
    Dim piperun As LMPipeRun
    Dim piperuns As LMPipeRuns
    Set piperuns = New LMPipeRuns
    piperuns.Collect datasource, Filter:=objFilter
    
    Debug.Print "Number of piperuns filtered = " & piperuns.Count
    For Each piperun In piperuns
        Debug.Print "ID = " & piperun.ID
        Debug.Print "ItemTag = " & piperun.Attributes("ItemTag").Value
        Debug.Print "TagSuffix = " & piperun.Attributes("TagSuffix").Value
        Debug.Print "Name = " & piperun.Attributes("Name").Value
    Next
    
    Set datasource = Nothing
    Set objFilter = Nothing
    Set piperun = Nothing
    Set piperuns = Nothing

End Sub

Private Sub btnLab14_Click()
 Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objFilter As LMAFilter
    Set objFilter = New LMAFilter
    
    objFilter.Criteria.AddNew ("FirstOne")
    objFilter.Criteria.Item("FirstOne").SourceAttributeName = "ItemStatus"
    objFilter.Criteria.Item("FirstOne").ValueAttribute = "1"
    objFilter.Criteria.Item("FirstOne").Operator = "="
    objFilter.ItemType = "PipeRun"
    
    objFilter.Criteria.AddNew ("SecondOne")
    objFilter.Criteria.Item("SecondOne").SourceAttributeName = "NominalDiameter"
    objFilter.Criteria.Item("SecondOne").ValueAttribute = "5064" '2"
    objFilter.Criteria.Item("SecondOne").Operator = "="
    objFilter.Criteria.Item("SecondOne").Conjunctive = True
        
    Dim piperun As LMPipeRun
    Dim piperuns As LMPipeRuns
    Set piperuns = New LMPipeRuns
    piperuns.Collect datasource, Filter:=objFilter
    
    Debug.Print "Number of piperuns filtered = " & piperuns.Count
    For Each piperun In piperuns
        Debug.Print "ID = " & piperun.ID
        Debug.Print "ItemStatus = " & piperun.Attributes("ItemStatus").Value
        Debug.Print "NominalDiameter = " & piperun.Attributes("NominalDiameter").Value
    Next

    Set datasource = Nothing
    Set objFilter = Nothing
    Set piperun = Nothing
    Set piperuns = Nothing

End Sub

Private Sub btnLab15_Click()
 Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objFilter As LMAFilter
    Dim objChildFilter1 As LMAFilter
    Dim objChildFilter2 As LMAFilter
    
    Set objFilter = New LMAFilter
    Set objChildFilter1 = New LMAFilter
    Set objChildFilter2 = New LMAFilter
       
    objChildFilter1.ItemType = "PipeRun"
    objChildFilter1.Name = "Filter 1"
    objChildFilter1.Criteria.AddNew ("FirstOne")
    objChildFilter1.Criteria.Item("FirstOne").SourceAttributeName = "ItemStatus"
    objChildFilter1.Criteria.Item("FirstOne").ValueAttribute = "1"
    objChildFilter1.Criteria.Item("FirstOne").Operator = "="
    
    objChildFilter2.ItemType = "PipeRun"
    objChildFilter2.Name = "Filter 2"
    objChildFilter2.Criteria.AddNew ("FirstOne")
    objChildFilter2.Criteria.Item("FirstOne").SourceAttributeName = "NominalDiameter"
    objChildFilter2.Criteria.Item("FirstOne").ValueAttribute = "5032" '1"
    objChildFilter2.Criteria.Item("FirstOne").Operator = "="
    
    objChildFilter2.Criteria.AddNew ("SecondOne")
    objChildFilter2.Criteria.Item("SecondOne").SourceAttributeName = "NominalDiameter"
    objChildFilter2.Criteria.Item("SecondOne").ValueAttribute = 5064 '2"
    objChildFilter2.Criteria.Item("SecondOne").Operator = "="
    objChildFilter2.Criteria.Item("SecondOne").Conjunctive = False
    
    objFilter.ItemType = "PipeRun"
    objFilter.FilterType = 1 '1 for compound filter, 0 for simple filter
    objFilter.ChildLMAFilters.Add objChildFilter1
    objFilter.ChildLMAFilters.Add objChildFilter2
    objFilter.Conjunctive = True
    
    Dim piperun As LMPipeRun
    Dim piperuns As LMPipeRuns
    Set piperuns = New LMPipeRuns
    piperuns.Collect datasource, Filter:=objFilter
    
    Debug.Print "Number of piperuns filtered = " & piperuns.Count
    For Each piperun In piperuns
        Debug.Print "ItemStatus = " & piperun.Attributes("ItemStatus").Value
        Debug.Print "NominalDiameter = " & piperun.Attributes("NominalDiameter").Value
    Next

    Set datasource = Nothing
    Set objFilter = Nothing
    Set objChildFilter1 = Nothing
    Set objChildFilter2 = Nothing
    Set piperun = Nothing
    Set piperuns = Nothing

End Sub

Private Sub btnLab16_Click()
  Dim datasource As LMADataSource
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    Dim objFiltersCollection As Collection
    Set objFiltersCollection = datasource.Filters
    
    Debug.Print "Number of filters = " & objFiltersCollection.Count
    Dim objFilter As LMAFilter
    For Each objFilter In datasource.Filters 'objFiltersCollection
        If objFilter.ItemType = "Instrument" Then
            If Not objFilter.Criteria Is Nothing Then
                If objFilter.Criteria.Count >= 1 Then
                    Debug.Print "Filter item type = " & objFilter.ItemType & Space(20 - Len(objFilter.ItemType)) _
                    & "Filter name = " & objFilter.Name & Space(50 - Len(objFilter.Name)) _
                    & objFilter.Criteria.Item(1).SourceAttributeName & Space(30 - Len(objFilter.Criteria.Item(1).SourceAttributeName)) _
                    & objFilter.Criteria.Item(1).Operator & Space(5) _
                    & objFilter.Criteria.Item(1).ValueAttribute & Space(40 - Len(objFilter.Criteria.Item(1).ValueAttribute))
                End If
            End If
        End If
    Next
    
    'use the pre-defined filter
    Set objFilter = datasource.Filters.Item("Active Equipment")
    Dim objEquipments As LMEquipments
    Set objEquipments = New LMEquipments
    objEquipments.Collect datasource, Filter:=objFilter
    Debug.Print objEquipments.Count
    
    Set datasource = Nothing
    Set objFilter = Nothing
    Set objFiltersCollection = Nothing
    Set objEquipments = Nothing

End Sub

Private Sub btnLab17_Click()
Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    
    Dim objEnum As LMAEnumAttList
    Dim objEnums As LMAEnumAttLists
    Dim objEnumAttr As LMAEnumeratedAttribute
    Dim objEnumAttrs As LMAEnumeratedAttributes
    
    Set objEnums = datasource.CodeLists
    
    Debug.Print "Total Select List Data found: " & objEnums.Count
    
    For Each objEnum In objEnums
        Debug.Print ""
        Debug.Print "Select List Name = " & objEnum.ListName & Space(40 - Len(objEnum.ListName)) _
        & "DependName = " & objEnum.DependName & Space(30 - Len(objEnum.DependName)) _
        & "DependID = " & objEnum.DependID
        Set objEnumAttrs = objEnum.EnumeratedAttributes
        For Each objEnumAttr In objEnumAttrs
            Debug.Print "Name = " & objEnumAttr.Name & Space(65 - Len(objEnumAttr.Name)) _
            & "Index = " & objEnumAttr.Index
        Next
    Next
    
    Set datasource = Nothing
    Set objEnum = Nothing
    Set objEnums = Nothing
    Set objEnumAttr = Nothing
    Set objEnumAttrs = Nothing

End Sub

Private Sub btnLab3_Click()
Dim datasource As LMADataSource
Dim i As Integer

If Not blnUsePIDDatasource Then
Set datasource = New LMADataSource
Else
Set datasource = PIDDataSource
End If
Debug.Print "Total Item Types:" & datasource.TypeNames.Count
For i = 1 To datasource.TypeNames.Count
Debug.Print datasource.TypeNames.Item(i)
Next
Set datasource = Nothing
End Sub



Private Sub btnLab4_Click()
Dim datasource As LMADataSource

If Not blnUsePIDDatasource Then
Set datasource = New LMADataSource
Else
Set datasource = PIDDataSource
End If
Dim objVessel As LMVessel
Set objVessel = datasource.GetVessel(CONST_SPID_Vessel) 'get objVessel by id\
'print out some objVessel's properties
    Debug.Print "ObjVessel ID =" & objVessel.ID
    Debug.Print "Equipment Subclass = " & objVessel.Attributes("EquipmentSubclass").Value
    Debug.Print "Equipment Type = " & objVessel.Attributes("EquipmentType").Value
    Debug.Print "aabbcc code = " & objVessel.Attributes("aabbcc_code").Value
    Debug.Print "Class = " & objVessel.Attributes("Class").Value
    Debug.Print "Item TypeName = " & objVessel.Attributes("ItemTypeName").Value
    Debug.Print "Volume Rating =" & objVessel.Attributes("VolumeRating").Value
    Debug.Print "Volume Rating in SI units = " & objVessel.Attributes("VolumeRating").SIValue
    
Set datasource = Nothing
Set objVessel = Nothing

End Sub



Private Sub btnLab5_Click()
    Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    datasource.BeginTransaction
    
    Dim objVessel As LMVessel
    Set objVessel = datasource.GetVessel(CONST_SPID_Vessel)    'get vessel by id
    objVessel.Attributes("Name").Value = "Vessel 7"              'assign value to vessel name
    objVessel.Attributes("DesignBy").Value = "By B"
    objVessel.Commit
    
    datasource.CommitTransaction
    
    Set objVessel = Nothing
    Set datasource = Nothing
End Sub



Private Sub btnLab6_Click()
    Dim datasource As LMADataSource
    Dim objPipeRun As LMPipeRun
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    datasource.InitObjectsReadonly = True
    
    datasource.BeginTransaction
    
    Set objPipeRun = datasource.GetPipeRun(CONST_SPID_PipeRun)    'get PipeRun by id
    objPipeRun.Attributes("Name").Value = "TEST1"              'assign value to PipeRun name
    objPipeRun.Commit
    
    datasource.CommitTransaction
    
    Set objPipeRun = Nothing
    Set datasource = Nothing

End Sub



Private Sub btnLab7_Click()
    Dim datasource As LMADataSource
    Dim objPipeRun As LMPipeRun
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    datasource.BeginTransaction
    
    Set objPipeRun = datasource.GetPipeRun(CONST_SPID_PipeRun)    'get PipeRun by id
    objPipeRun.Attributes("Name").Value = "TEST1"              'assign value to PipeRun name
    objPipeRun.Commit
    datasource.CommitTransaction
    
    datasource.BeginTransaction
    objPipeRun.Attributes("Name").Value = "TEST2"              'assign value to PipeRun name
    objPipeRun.Commit
    datasource.RollbackTransaction
    
    Set objPipeRun = Nothing
    Set datasource = Nothing
End Sub



Private Sub btnLab8_Click()
    Dim datasource As LMADataSource
    Dim objPipeRun As LMPipeRun
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    
    datasource.BeginTransaction
    
    Set objPipeRun = datasource.GetPipeRun(CONST_SPID_PipeRun)    'get PipeRun by id
    
    datasource.PropagateChanges = True
    objPipeRun.Attributes("SupplyBy").Value = "By D"            'assign value to PipeRun Supply By
    objPipeRun.Commit
    
    datasource.PropagateChanges = False
    objPipeRun.Attributes("CleaningReqmts").Value = "CC1"            'assign value to PipeRun Supply By
    objPipeRun.Commit
    
    datasource.CommitTransaction
    
    
    Set objPipeRun = Nothing
    Set datasource = Nothing
End Sub


Private Sub btnLab9_Click()
    Dim datasource As LMADataSource
    
    If Not blnUsePIDDatasource Then
        Set datasource = New LMADataSource
    Else
        Set datasource = PIDDataSource
    End If
    
    Dim objVessel As LMVessel
    Dim objItem1 As LMAItem
    Dim objEquipment As LMEquipment
    Dim objItem2 As LMAItem
    
    Set objVessel = datasource.GetVessel(CONST_SPID_Vessel)    'get vessel by id
    Set objItem1 = objVessel.AsLMAItem
    Set objEquipment = datasource.GetEquipment(CONST_SPID_Vessel) 'get equipment by id
    Set objItem2 = objEquipment.AsLMAItem
    
    'print out some properties of objItem1 and objItem2
    Debug.Print "ItemType = " & objItem1.ItemType
    Debug.Print "VolumeRating = " & objItem1.Attributes("VolumeRating").Value
    Debug.Print "ItemType = " & objItem2.ItemType
    Debug.Print "VolumeRating = " & objItem2.Attributes("VolumeRating").Value
    
    Set datasource = Nothing
    Set objVessel = Nothing
    Set objItem1 = Nothing
    Set objEquipment = Nothing
    Set objItem2 = Nothing

End Sub

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

