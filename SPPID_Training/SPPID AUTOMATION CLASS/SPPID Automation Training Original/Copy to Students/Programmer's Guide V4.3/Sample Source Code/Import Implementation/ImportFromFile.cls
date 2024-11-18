VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ImportFromFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
 '***********************************************************************
'Copyright (c) 1999, Intergraph Corporation
'
'Class:         ImportFromFile
'
'Description:   This class implements a drop handler for the SmartPlant
'               P&ID stockpile.  The entry point into this class is the
'               ISPImport_FileDrop procedure.
'
'04/13/01 Raj    Removed the reference to the rad.tlb file.
'

'***********************************************************************

Option Explicit

Private m_Pbar As igrProgressBar412.clsProgressBar

Implements ISPImport

'***************************************************************************
' Procedure:    ISPImport_FileDrop
' Description:  This procedure is called whenever a file is dropped into
'               the stockpile. A separate call will be made for each file
'               dropped.
'***************************************************************************
Sub ISPImport_FileDrop(Filename As String, objLMADataSource As Object)

    On Error GoTo ErrHandler

    'Clear the import log.
    frmImportStatus.lstStatus.Clear
    
    Call ShowProgressBar(m_Pbar)
    m_Pbar.PBMax = 100
    m_Pbar.PBValue = m_Pbar.PBMax * 0.1
    m_Pbar.PBMessage = LoadResString(126)
            
    m_Pbar.PBValue = m_Pbar.PBMax * 0.2
    
    'Determine the file type that was dropped and call the appropriate procedure.
    'If StrComp(Right(Filename, 4), ".sym", vbTextCompare) = 0 Or StrComp(Right(Filename, 4), ".lnk", vbTextCompare) = 0 Then
    '    Call SymbolDrop(Filename)
    'Else
    If StrComp(Right(Filename, 4), ".xls", vbTextCompare) = 0 Then
        Call ExcelDrop(Filename, objLMADataSource)
    ElseIf (StrComp(Right(Filename, 4), ".txt", vbTextCompare) = 0) Then
        Call TextDrop(Filename, objLMADataSource)
    ElseIf (StrComp(Right(Filename, 4), ".xml", vbTextCompare) = 0) Then
        Call XMLDrop(Filename)
    Else
        'doesnot support importing this file type
        UpdateStatus LoadResString(151) & " " & Right(Filename, 4)
    End If
    
    'Show the import log.
    Screen.MousePointer = vbDefault
    
endSub:
    Set m_Pbar = Nothing
    'Show the import log dialog.
    ShowImportLog
    Exit Sub
    
ErrHandler:
    UpdateStatus LoadResString(120) & Err.Description
    Resume endSub
End Sub

Private Sub Class_Terminate()
    Set m_Pbar = Nothing
End Sub

'***************************************************************************
' Procedure:    SymbolDrop
' Description:  Drop handler for symbol files.  Creates the provided symbol
'               in the stockpile.
'***************************************************************************
Private Sub SymbolDrop(Filename As String)

    Dim caption As String
    Dim start As Long
    Dim loc As Long
    Dim length As Long
    
    On Error GoTo ErrHandler
    
    UpdateStatus LoadResString(127)
    m_Pbar.PBMessage = LoadResString(128)
    
    'Create the symbol in the stockpile.
    PIDCreateItem Filename
    
    m_Pbar.PBValue = m_Pbar.PBMax
    Exit Sub

ErrHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description

End Sub


'***************************************************************************
' Procedure:    TextDrop
' Description:  Drop handler for text files.
'***************************************************************************
Sub TextDrop(sFileName As String, LMADataSource As LMADataSource)
    
    Dim sFirstLine As String

    On Error GoTo ErrHandler

    Open sFileName For Input As #1
    Line Input #1, sFirstLine
    Close #1
    
    m_Pbar.PBValue = m_Pbar.PBMax
    
    If (StrComp(sFirstLine, "Zyqad Stream Data", vbTextCompare) = 0) Then
        'This is a Zyqad stream data file, so call the import procedure.
        ImportZyqadStreamData sFileName, LMADataSource
    End If
    
    Exit Sub

ErrHandler:
    Close
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description

End Sub


'***************************************************************************
' Procedure:    ExcelDrop
' Description:  Drop handler for Microsoft Excel workbooks.  Calls the
'               appropriate import class based on the contents of the
'               workbook.
'***************************************************************************
Sub ExcelDrop(sFileName As String, LMADataSource As LMADataSource)

    Dim objExcel As Excel.Application
    Dim objWorkbook As Excel.Workbook
    Dim objSheet As Worksheet
    Dim sShortFileName As String
    Dim iStart As Integer
    Dim iLoc As Integer
    Dim bLeaveOpen As Boolean
    Dim bExcelRunning As Boolean
    Dim objImport As Object
    Dim bFoundImportSheet As Boolean
    Dim sBaseSymbolDir As String

    On Error Resume Next
    
    UpdateStatus LoadResString(129)
    m_Pbar.PBMessage = LoadResString(130)
    
    'Start excel.
    Set objExcel = GetObject(, "Excel.Application")
    On Error GoTo ErrHandler
    
    If objExcel Is Nothing Then
        Set objExcel = CreateObject("Excel.Application")
        bExcelRunning = False
    Else
        bExcelRunning = True
    End If
    
    'Make sure Excel started successfully.
    If (objExcel Is Nothing) Then
        UpdateStatus LoadResString(131)
        Exit Sub
    End If
    
    m_Pbar.PBValue = m_Pbar.PBMax * 0.5
    
    'Get the short filename from the full file path.
    iLoc = 1
    While iLoc
        iStart = iLoc + 1
        iLoc = InStr(iStart, sFileName, "\")
    Wend
    sShortFileName = Mid(sFileName, iStart)
        
    m_Pbar.PBMessage = LoadResString(132)
    
    UpdateStatus LoadResString(133) & sShortFileName & "'"
    bLeaveOpen = True   'we don't want to close the workbook later if it was already open.
    On Error Resume Next
    Set objWorkbook = objExcel.Workbooks(sShortFileName)
    On Error GoTo ErrHandler
    If objWorkbook Is Nothing Then
        bLeaveOpen = False
        objExcel.Workbooks.Open sFileName
        Set objWorkbook = objExcel.Workbooks(sShortFileName)
    End If
    
    Set objWorkbook = objExcel.Workbooks(sShortFileName)
    
    'Make sure the workbook was opened successfully.
    If (objWorkbook Is Nothing) Then
        UpdateStatus LoadResString(134) & sShortFileName & "'"
        Exit Sub
    End If
    
    m_Pbar.PBValue = m_Pbar.PBMax * 0.7
    m_Pbar.PBMessage = LoadResString(135)
    
    'Determine the base directory for symbols.
    sBaseSymbolDir = GetBaseSymbolDir(LMADataSource)
    
    'Look in the workbook to find out what type of report we're importing.
    bFoundImportSheet = False
    For Each objSheet In objWorkbook.Sheets   'Process all sheets in the workbook.
        If (objSheet.Visible = xlSheetVisible) Then
            m_Pbar.PBMessage = LoadResString(135)
            m_Pbar.PBValue = m_Pbar.PBMax * 0.3
            If objSheet.Cells(5, 1) = "EQUIPMENT LIST" Then
                Set objImport = New ImportSPEquipmentList
            ElseIf objSheet.Cells(5, 1) = "PIPE RUN LIST" Then
                Set objImport = New ImportSPLineList
            ElseIf objSheet.Cells(5, 1) = "EQUIPMENT NOZZLE LIST" Then
                Set objImport = New ImportSPNozzleList
            ElseIf objSheet.Cells(2, 24) = "EQUIPMENT LIST FOR VESSELS (V)" Then
                Set objImport = New ImportZyqadVessels
            ElseIf objSheet.Cells(2, 19) = "EQUIPMENT LIST FOR PUMPS (P)" Then
                Set objImport = New ImportZyqadPumps
            ElseIf objSheet.Cells(2, 22) = "EQUIPMENT LIST FOR HEAT EXCHANGERS (E)" Then
                Set objImport = New ImportZyqadExchangers
            ElseIf objSheet.Cells(1, 1) = "Report Critera and Raw Data" Then
                Set objImport = New ImportSmartSketchEquip
            End If
            
            m_Pbar.PBValue = m_Pbar.PBMax * 0.7
    
            'Call the appropriate import class.
            If Not (objImport Is Nothing) Then
                UpdateStatus LoadResString(136) & objSheet.Name & "'"
                Set objImport.ProgressBar = m_Pbar
                objImport.BaseSymbolDir = sBaseSymbolDir
                Call objImport.Import(objSheet, LMADataSource)
                Set objImport = Nothing
                bFoundImportSheet = True
            End If
            m_Pbar.PBValue = m_Pbar.PBMax
            m_Pbar.PBMin = 1
            m_Pbar.PBMax = 100
        End If
    Next
    
    If (bFoundImportSheet = False) Then
        MsgBox LoadResString(107) & objWorkbook.Name & LoadResString(108), _
                vbCritical + vbMsgBoxSetForeground, LoadResString(109)
    End If
            
    'Close excel.
    objWorkbook.Saved = True
    If Not bLeaveOpen Then
        UpdateStatus LoadResString(137)
        objWorkbook.Close
    End If

    'Exit excel.
    If Not bExcelRunning Then
        objExcel.Quit
    End If

    'Release excel object.
    Set objExcel = Nothing
    
    Exit Sub

ErrHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description
    Set objExcel = Nothing
    
End Sub

'***************************************************************************
' Procedure:    XMLDrop
' Description:  Drop handler for XML files.
'***************************************************************************
Sub XMLDrop(Filename As String)
    
    Dim objImportXML As New ImportXML
    
    On Error GoTo ErrHandler
    
    Set objImportXML.ProgressBar = m_Pbar
    objImportXML.Import Filename
    
    m_Pbar.PBValue = m_Pbar.PBMax
    Exit Sub

ErrHandler:
    Set m_Pbar = Nothing
    UpdateStatus LoadResString(120) & Err.Description

End Sub


Private Sub ImportZyqadStreamData(sFileName As String, LMADataSource As LMADataSource)

    Dim objPipeRuns As New LMPipeRuns
    Dim objPipeRun As LMPipeRun
    Dim objFilter As LMAFilter
    Dim sStreamNumber As String
    Dim objStreamData As Collection
    Dim objStreamNumberCalc As New StreamNumberCalc
    Dim vStreamProperties As Variant
    Dim lStreamCount As Long
    Dim i As Long

    UpdateStatus LoadResString(138)

    Set objFilter = New LMAFilter
    objFilter.Criteria.AddNew
    objFilter.Criteria.Item(1).SourceAttributeName = "StreamNo"
    objFilter.Criteria.Item(1).Operator = "="
    objFilter.Criteria.AddNew
    objFilter.Criteria.Item(2).SourceAttributeName = CONST_RepresentationItemStatusAttribute
    objFilter.Criteria.Item(2).Operator = "="
    objFilter.Criteria.Item(2).ValueAttribute = 1   'active status
    objFilter.Criteria.Item(2).Conjunctive = -1     'match all
     
    Set objStreamData = objStreamNumberCalc.GetStreamDataFromFile(sFileName)
    
    lStreamCount = objStreamData.Count
    m_Pbar.PBMin = 0
    m_Pbar.PBMax = lStreamCount
    For i = 1 To lStreamCount
        m_Pbar.PBMessage = LoadResString(139) & CStr(i) & LoadResString(140) & CStr(lStreamCount) & ")"
        vStreamProperties = objStreamData.Item(i)
        objFilter.Criteria.Item(1).ValueAttribute = vStreamProperties(1)
        objPipeRuns.Collect LMADataSource, Filter:=objFilter
        For Each objPipeRun In objPipeRuns
            objStreamNumberCalc.UpdatePipeRunProperties objPipeRun, vStreamProperties
        Next
        m_Pbar.PBValue = i
    Next i

    m_Pbar.PBValue = m_Pbar.PBMax

    Set objPipeRuns = Nothing
    Set objPipeRun = Nothing
    Set objFilter = Nothing
    Set objStreamData = Nothing
    Set objStreamNumberCalc = Nothing
    
End Sub

