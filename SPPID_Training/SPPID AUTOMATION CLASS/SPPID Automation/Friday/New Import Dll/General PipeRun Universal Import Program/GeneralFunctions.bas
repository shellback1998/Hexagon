Attribute VB_Name = "GeneralFunctions"
Option Explicit

Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Const CB_SETDROPPEDWIDTH = &H160
Public Const CB_GETDROPPEDWIDTH = &H15F

'decrare some constants
Public Const CONST_Directory As String = ""
Public Const CONST_LogFile As String = "\SPAError.log"
Public Const CONST_Seperator As String = "    @"
Private Const ModuleName As String = "GeneralFunctions"
Private Const CONST_PIDDocumentAttributeSetName As String = "P&ID"
Private Const CONST_DateLastSavedAttribute As String = "Date Last Saved"

'to log the properties that have been imported
Public blnLogged As Boolean


'this function generate error log file for the program
Public Sub GenerateErrorLog(error As ErrObject, Optional strError As String)
'On Error Resume Next
    '
    Dim intFileNumber As Integer
    Dim ErrorMessage As String
    Dim ErrorLocation As String
    Dim ErrorDescription As String
    Dim OriginalErrorDescription As String
    Dim ErrorNumber As String
    
    'display error message to user
    MsgBox "Error happened! See error log for details."
    
    'ErrorMessage = "Error Number: " & error.Number & " - Error Description: " & error.Description
    OriginalErrorDescription = strError & error.Description
    ErrorNumber = error.Number
    
    'write error message to error log file
    intFileNumber = FreeFile()
    InitializeLogFile intFileNumber
    
    'get specific error information
    ErrorDescription = ExtractStringOnRight(OriginalErrorDescription, "-")
    ErrorLocation = VBA.Left(OriginalErrorDescription, Len(OriginalErrorDescription) - Len(ErrorDescription) - 1)
    
    'begin write error
    Print #intFileNumber, "----------------------------------------------------------------------------------"
    Print #intFileNumber, "---------------" & Date & " " & Time & "---------------"
    Print #intFileNumber, "Error Location: " & ErrorLocation
    Print #intFileNumber, "Error Number: " & ErrorNumber
    Print #intFileNumber, "Error Description: " & ErrorDescription
    Print #intFileNumber, ""
    
    'close log file
    CloseLogFile intFileNumber
    '
End Sub
'

'this function generate error log file without dialog for the program
Public Sub GenerateErrorLogWithoutDialog(error As ErrObject, Optional strError As String)
'On Error Resume Next
    '
    Dim intFileNumber As Integer
    Dim ErrorMessage As String
    Dim ErrorLocation As String
    Dim ErrorDescription As String
    Dim OriginalErrorDescription As String
    Dim ErrorNumber As String
    
    'display error message to user
    'MsgBox "Error! See error log for details."
    
    'ErrorMessage = "Error Number: " & error.Number & " - Error Description: " & error.Description
    OriginalErrorDescription = strError & error.Description
    ErrorNumber = error.Number
    
    'write error message to error log file
    intFileNumber = FreeFile()
    InitializeLogFile intFileNumber
    
    'get specific error information
    ErrorDescription = ExtractStringOnRight(OriginalErrorDescription, "-")
    ErrorLocation = VBA.Left(OriginalErrorDescription, Len(OriginalErrorDescription) - Len(ErrorDescription) - 1)
    
    'begin write error
    Print #intFileNumber, "----------------------------------------------------------------------------------"
    Print #intFileNumber, "---------------" & Date & " " & Time & "---------------"
    Print #intFileNumber, "Error Location: " & ErrorLocation
    Print #intFileNumber, "Error Number: " & ErrorNumber
    Print #intFileNumber, "Error Description: " & ErrorDescription
    Print #intFileNumber, ""
    
    'close log file
    CloseLogFile intFileNumber
    '
End Sub
'

'this function initialize the log file
Public Sub InitializeLogFile(intFileNumber As Integer)
On Error GoTo errorHandler:
    Dim strDir As String
    strDir = GetLogFileDir()
    'Open Environ("TEMP") & "\ColorManager.log" For Append As #intFileNumber
    Open strDir & CONST_LogFile For Append As #intFileNumber
    Exit Sub
errorHandler:
    'in case file is open, ignore the error
    If Err.Number = 55 Then Resume Next
End Sub
'

'this function locate the log file directory, if it is not existing, this function
'will create one
Public Function GetLogFileDir() As String
On Error GoTo errHandler:
    Dim strDir As String
    Dim objFileSystem As Scripting.FileSystemObject
    Dim objFolder As Scripting.Folder
    Dim objFiles As Scripting.Files
    Set objFileSystem = New Scripting.FileSystemObject
    
    strDir = Environ("TEMP") & CONST_Directory
On Error Resume Next
    Set objFolder = objFileSystem.GetFolder(strDir)
    If Err.Number <> 0 Then
        If Err.Number = 76 Then
            Set objFolder = objFileSystem.CreateFolder(strDir)
        Else
            GoTo errHandler
        End If
    End If
On Error GoTo errHandler
    GetLogFileDir = strDir
    Exit Function
errHandler:
    'err.number=55 means log file is opened, it is OK
    If Err.Number = 55 Then Resume Next
End Function

'this function creates a filter
Public Function CreateAFile(strFileName As String) As Boolean
On Error GoTo errHandler:
    Dim objFileSystem As Scripting.FileSystemObject
    Dim objTextStream As Scripting.TextStream
    
    Set objFileSystem = New Scripting.FileSystemObject
    Set objTextStream = objFileSystem.CreateTextFile(strFileName)
    
    If Not objTextStream Is Nothing Then
        CreateAFile = True
    End If
    
    Exit Function
errHandler:
    
End Function

'this function close the log file
Public Sub CloseLogFile(intFileNumber As Integer)
    Close #intFileNumber
End Sub

'this function raise the error
Public Sub RaiseError(error As ErrObject, Optional strError As String)
    Err.Raise error.Number, error.Source, strError & error.Description
End Sub

'this function write a line of string to log file
Public Sub WriteToErrorLogNew(strMessage As String)
    Dim intFileNumber As Integer
    
    'write message to error log file
    intFileNumber = FreeFile()
    InitializeLogFile intFileNumber
    Print #intFileNumber, strMessage
    CloseLogFile intFileNumber
End Sub

'this function write a line of string to log file with Time
Public Sub WriteToErrorLogWithTime(strMessage As String)
    Dim intFileNumber As Integer
    
    'write message to error log file
    intFileNumber = FreeFile()
    InitializeLogFile intFileNumber
    Print #intFileNumber, "---" & Date & " " & Time & "---" & " " & strMessage
    CloseLogFile intFileNumber
End Sub



'''this function make progressbar increase a segment
''Public Sub IncrementProgressBar(objProgressBar As SPProgressBar.clsProgressBar, Optional strMessage As String)
''    Dim dblPbarFraction As Double
''    dblPbarFraction = (objProgressBar.PBValue - objProgressBar.PBMin) / (objProgressBar.PBMax - objProgressBar.PBMin)
''    dblPbarFraction = dblPbarFraction + 0.01
''    If dblPbarFraction > 1 Then dblPbarFraction = 0
''    objProgressBar.PBValue = objProgressBar.PBMin + (objProgressBar.PBMax - objProgressBar.PBMin) * dblPbarFraction
''    If strMessage <> "" Then objProgressBar.PBMessage = strMessage
''End Sub

'this function finish the progressbar
''Public Sub CompleteProgressBar(objProgressBar As SPProgressBar.clsProgressBar)
''    Do While (objProgressBar.PBMax - objProgressBar.PBValue) / objProgressBar.PBMax > 0.05
''        IncrementProgressBar objProgressBar
''    Loop
''    objProgressBar.PBValue = objProgressBar.PBMax
''    objProgressBar.PBValue = objProgressBar.PBMin
''    objProgressBar.PBMessage = "Esc button to terminate Macro..."
''End Sub
''
'
'Function That Froms a filter
Public Function GetFilter(ByVal ItemType As String, SourceAttributeName As String, ByVal ValueAttribute As String, ByVal Operator As String, Optional SourceAttributeName1 As String, Optional ValueAttribute1 As String, Optional Operator1 As String, Optional SourceAttributeName2 As String, Optional ValueAttribute2 As String, Optional Operator2 As String) As LMAFilter
On Error GoTo errorHandler:
    Dim strError As String
    Dim ProcName As String
    Dim objCriterion As LMACriterion
    
    ProcName = "GetFilter"
    
    Set GetFilter = New LMAFilter
    With GetFilter
        .ItemType = ItemType
        .Conjunctive = True
    End With
    
    Set objCriterion = New LMACriterion
    
    With objCriterion
        .Conjunctive = True
        .SourceAttributeName = SourceAttributeName
        .ValueAttribute = ValueAttribute
        .Operator = Operator
    End With
    
    GetFilter.Criteria.Add objCriterion
    
    If Len(SourceAttributeName1) > 1 Then
        Set objCriterion = Nothing
        Set objCriterion = New LMACriterion
        With objCriterion
            .Conjunctive = True
            .SourceAttributeName = SourceAttributeName1
            .ValueAttribute = ValueAttribute1
            .Operator = Operator1
        End With
        GetFilter.Criteria.Add objCriterion
    End If
    
    If Len(SourceAttributeName2) > 1 Then
        Set objCriterion = Nothing
        Set objCriterion = New LMACriterion
        With objCriterion
            .Conjunctive = True
            .SourceAttributeName = SourceAttributeName2
            .ValueAttribute = ValueAttribute2
            .Operator = Operator2
        End With
        GetFilter.Criteria.Add objCriterion
    End If
    
    Set objCriterion = Nothing
    '
    Exit Function
    '
errorHandler:
    strError = ModuleName & "::" & ProcName
    RaiseError Err, strError
    
End Function

'this function extract the pure drawing name from a string seperated by const_seperator
'the drawing name is at the right of a string, with extention name
Public Function ExtractFileNameOnRight(ByVal strFullName As String) As String
On Error GoTo errorHandler:
    Dim strError As String
    Dim ProcName As String
    Dim strChar As String
    Dim intCharLocation As Integer
    Dim intWhole As Integer
    
    intWhole = Len(strFullName)
    strChar = "\"
    intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
    Do While intCharLocation <> 0
        strFullName = Right(strFullName, intWhole - intCharLocation)
        intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
        intWhole = Len(strFullName)
    Loop
    
    ExtractFileNameOnRight = strFullName
    
    Exit Function
errorHandler:
    strError = ModuleName & "::" & ProcName
    RaiseError Err, strError
End Function

'this function extract the pure drawing name from a string seperated by const_seperator
'the drawing name is at the right of a string, with extention name
Public Function GetPureName(strFullName As String) As String
On Error GoTo errorHandler:
    Dim strError As String
    Dim ProcName As String
    Dim strChar As String
    Dim intCharLocation As Integer
    Dim intWhole As Integer
    
    intWhole = Len(strFullName)
    strChar = "\"
    intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
    Do While intCharLocation <> 0
        strFullName = Right(strFullName, intWhole - intCharLocation)
        intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
        intWhole = Len(strFullName)
    Loop
    
    GetPureName = strFullName
    
    Exit Function
errorHandler:
    strError = ModuleName & "::" & ProcName
    RaiseError Err, strError
End Function

'this function extract the pure drawing name from a string seperated by const_seperator
'the drawing name is at the left of a string, without extention name
Public Function ExtractDrawingNameOnLeft(ByVal strFullName As String) As String
On Error GoTo errorHandler:
    Dim strError As String
    Dim ProcName As String
    
    Dim strChar As String
    Dim intCharLocation As Integer
    
    
    strChar = CONST_Seperator
    intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
    Do While intCharLocation <> 0
        strError = "In the loop"
        strFullName = VBA.Left(strFullName, intCharLocation - 1)
        intCharLocation = InStr(1, strFullName, strChar, vbTextCompare)
    Loop
    
    ExtractDrawingNameOnLeft = strFullName
    
    Exit Function
errorHandler:
    strError = ModuleName & "::" & ProcName
    RaiseError Err, strError
End Function




'''Public Function GetEmbeddLabels(objDatasource As LMADataSource, objFilter As LMAFilter, strDrawingName As String) As LMLabelPersists
'''On Error GoTo errorHandler:
'''    Dim strError As String
'''    Dim objFinder As ColorManager.cLMAItemManager
'''    Dim objItems As LMAItems
'''
'''    strError = "Get all model items in current drawing "
'''    Set objFinder = New ColorManager.cLMAItemManager
'''    objItems = objFinder.GetAllFilteredLMAItemsInCurrentDrawing(objDatasource, objFilter, strDrawingName)
'''    Set GetEmbeddLabels = GetEmbeddLabelsFromLMAItems(objItems)
'''    Exit Function
'''errorHandler:
'''    strError = " error happened when " & strError & " @ Function GetEmbeddLabels"
'''    RaiseError Err, strError
'''End Function
'''Public Function GetEmbeddLabelsFromLMAItems(ByVal objItems As LMAItems) As LMLabelPersists
'''On Error GoTo errorHandler:
'''    Dim strError As String
'''    Dim objItem As LMAItem
'''    strError = "Get all model items in current drawing "
'''    For Each objItem In objItems
'''        Select Case objItem.ItemType
'''            Case const_opc
'''            Case Else
'''        End Select
'''    Next
'''
'''
'''
'''
'''    Exit Function
'''errorHandler:
'''    strError = " error happened when " & strError & " @ Function GetEmbeddLabels"
'''    RaiseError Err, strError
'''End Function



'Public Function ExtractFileNameFromPath(path As String) As String
'On Error GoTo errHandler:
'    Dim strError As String
'    Dim strChar As String
'    Dim intCharLocation As Integer
'    Dim strPath As String
'    strChar = "\"
'    strPath = path
'    intCharLocation = InStr(1, strPath, strChar, vbTextCompare)
'    Do While intCharLocation <> 0
'        strPath = Right(strPath, Len(strPath) - intCharLocation)
'        intCharLocation = InStr(1, strPath, strChar, vbTextCompare)
'    Loop
'    ExtractFileNameFromPath = strPath
'errHandler:
'    If Err > 0 Then
'        RaiseError Err, strError & "-ExtractFileNameFromPath"
'    End If
'End Function


'this function extract the string from a string separated by strSeparate
Public Function ExtractStringOnRight(ByVal strFullName As String, ByVal strSeparate As String) As String
On Error GoTo errorHandler:
    Dim strError As String
    Dim ProcName As String
    Dim strChar As String
    Dim intCharLocation As Integer
    Dim intWholeLength As Integer

    ProcName = "ExtractStringOnRight"
    intWholeLength = Len(strFullName)
    intCharLocation = InStr(1, strFullName, strSeparate, vbTextCompare)
    Do While intCharLocation <> 0
        strFullName = Right(strFullName, intWholeLength - intCharLocation)
        intCharLocation = InStr(1, strFullName, strSeparate, vbTextCompare)
        intWholeLength = Len(strFullName)
    Loop

    ExtractStringOnRight = strFullName

    Exit Function
errorHandler:
    strError = ModuleName & "::" & ProcName
    RaiseError Err, strError
End Function


'Public Function GetActiveProjectName() As String
'On Error GoTo ErrHandler
'
'    Dim strError As String
'    Dim ProcName As String
'    Dim objConfigInfo As igrConfigInfo353.igrConfigInfo
'
'    ProcName = "GetActiveProjectName"
'
'    Set objConfigInfo = New igrConfigInfo353.igrConfigInfo ' New SPConfigInfo 'igrConfigInfo
'    If Not objConfigInfo Is Nothing Then
'        objConfigInfo.ApplicationName = "SmartPlantPID"
'        GetActiveProjectName = objConfigInfo.GetConfigString(ConfigKeyUser, "Project", "Name")
'
'    End If
'    Exit Function
'
'ErrHandler:
'    strError = ModuleName & "::" & ProcName
'    RaiseError Err, strError
'End Function

'''this function initialize and return a RAD application object
''Public Function GetRadApp() As RAD2D.Application
''On Error Resume Next
''    Dim objSSApp As SmartSketch.Application
''    Dim objRadApp As RAD2D.Application
''
''    Set objSSApp = GetObject(, "SmartSketch.Application")
''    If Err.Number <> 0 Then
''        Err.Clear
''        Set objSSApp = CreateObject("SmartSketch.Application")
''    End If
''    Set objRadApp = objSSApp.RADApplication
''    objRadApp.Visible = True
''    Set GetRadApp = objRadApp
'''clean up
''    'Set objRadApp = Nothing
''    'Set objSSApp = Nothing
''End Function

'''form a compound filter
''Public Function GetCompoundFilter(objFilter As LMAFilter, lngSPID As Long) As LMAFilter
'''
''On Error GoTo ErrHandler
'''
''    Dim strError As String
''    Dim ProcName As String
''    Dim objMainFilter As LMAFilter
''    Dim objISPMainfilter As ISPFilter
''    Dim objFilter1 As LMAFilter
''    Dim objISPFilter1 As ISPFilter
''    Dim objFilter2 As LMAFilter
''    Dim objISPFilter2 As ISPFilter
''    Dim objCriterion As LMACriterion
''
''    ProcName = "GetCompoundFilter"
''
''    Set objMainFilter = New LMAFilter
''    Set objISPMainfilter = objMainFilter
''    objMainFilter.ItemType = objFilter.ItemType
''    objMainFilter.Conjunctive = True
''
''    objISPMainfilter.FilterType = ISPFilterType.Compound
''
''    'get filter from frmFilter
''    Set objISPFilter1 = objFilter
''    'objISPFilter1.Name = "Filter1"
''
''    'form second filter
'''    Set objCriterion = New LMACriterion
'''    objCriterion.SourceAttributeName = "Representation.SP_DrawingID"
'''    objCriterion.ValueAttribute = CStr(lngSPID)
'''    objCriterion.Operator = "="
'''    objCriterion.Conjunctive = True
''
''    Set objFilter2 = New LMAFilter
''    objFilter2.ItemType = objFilter.ItemType
''    objFilter2.Criteria.AddNew "C1"
''    objFilter2.Criteria.Item("C1").SourceAttributeName = "Representation.SP_DrawingID"
''    objFilter2.Criteria.Item("C1").Operator = "="
''    objFilter2.Criteria.Item("C1").ValueAttribute = CStr(lngSPID)
''    objFilter2.Criteria.AddNew "C2"
''    objFilter2.Criteria.Item("C2").SourceAttributeName = "ItemStatus"
''    objFilter2.Criteria.Item("C2").Operator = "="
''    objFilter2.Criteria.Item("C2").ValueAttribute = "1"
''    objFilter2.Criteria.Item("C2").Conjunctive = True
''    Set objISPFilter2 = objFilter2
''    objISPFilter2.Name = "Filter2"
''
''    'add two filters to form Main Compound Filter
''    objMainFilter.ChildFilters.Add objISPFilter1
''    objMainFilter.ChildFilters.Add objISPFilter2
''
''     'set return value
''    Set GetCompoundFilter = objMainFilter
'''clean up
''
''    Exit Function
''ErrHandler:
''
''    strError = ProcName & "::" & strError & "-"
''    'Err.Description = strError & Err.Description
''    'GenerateErrorLog Err
''    RaiseError Err, strError
''
''End Function

'''this sub make connection to the database
''Public Sub GetDBConnection(objDBLink As DBLink, objConnInfo As ISPClientData3.ConnectionInfo, objADOConn As ADODB.Connection, SchemaType As SPADBLinkServer.ENUM_SchemaType)
''    Dim strProjectNo As String
''    'Dim objDBLink As DBLink
''    'Dim DBConnect As SPCONNECTLib.DBConnect
''    'Dim SchemaType As DBLinkServer.ENUM_SchemaType
''    'Dim objConnInfo As ISPClientData3.ConnectionInfo
''    'Dim i As Long
''    'Dim j As Long
''
''    'Dim objADOConn As ADODB.Connection
''
''
''
''    'Set objDBLink = New DBLink
''    strProjectNo = GetActiveProjectName
''    Set objConnInfo = objDBLink.GetConnInfo
''    objDBLink.ConnectADODB objADOConn
''
'''clean up
''
''End Sub
''
''Public Function GetIgrFileName(strFullName As String) As String
''On Error GoTo errorhandler
''    Dim strError As String
''    Dim strTemp As String
''    strError = "Convert"
''
''    strTemp = Left(strFullName, (Len(strFullName) - 3))
''    GetIgrFileName = strTemp & "igr"
''
''    Exit Function
''errorhandler:
''    'getting error message
''    strError = " - error happened when " & strError & " @ function GetIgrFileName"
''    'raise error
''    RaiseError Err, strError
''End Function

Public Function GetRuleFileRootPath(datasource As LMADataSource) As String
    
    Dim objFilter As LMAFilter
    Dim criterion As LMACriterion
    Dim strRulePath As String
    Dim strRuleFile As String
    
    Set criterion = New LMACriterion
    Set objFilter = New LMAFilter
    
    criterion.SourceAttributeName = "Name"
    criterion.ValueAttribute = "Rules Library"
    criterion.Operator = "="
    
    objFilter.ItemType = "OptionSetting"
    objFilter.Criteria.Add criterion
    
    Dim objOptionSettings As LMOptionSettings
    Dim objOptionSetting As LMOptionSetting
    Set objOptionSettings = New LMOptionSettings
    'get "Default Assembly Path" from OptionSettings by filter
    objOptionSettings.Collect datasource, Filter:=objFilter
    
    Set objOptionSetting = objOptionSettings.Nth(1)
    
    strRulePath = objOptionSetting.Value
    strRuleFile = ExtractStringOnRight(strRulePath, "\")
    GetRuleFileRootPath = VBA.Left(strRulePath, Len(strRulePath) - Len(strRuleFile))
  
    Set objFilter = Nothing
    Set criterion = Nothing
    Set objOptionSetting = Nothing
    Set objOptionSettings = Nothing
    

End Function

