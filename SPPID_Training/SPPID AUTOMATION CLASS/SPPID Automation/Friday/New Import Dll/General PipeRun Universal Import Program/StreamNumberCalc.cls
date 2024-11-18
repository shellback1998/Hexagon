VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "StreamNumberCalc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Implements ILMForeignCalc

Private Enum ImportProperties
    CurrStreamNumber = 1
    ZyqadExportDate = 2
    ZyqadUserName = 3
    MassFlow = 4
    MassflowUnits = 5
    LiquidVolFlow = 6
    LiquidVolFlowUnits = 7
    VaporVolFlow = 8
    VaporVolFlowUnits = 9
    OperPressure = 10
    OperPressureUnits = 11
    OperTemp = 12
    OperTempUnits = 13
    SpecificGravity = 14
    Density = 15
    DensityUnits = 16
    Compressibility = 17
    Viscocity = 18
    ViscUnits = 19
    PipeThickness = 20
    PipeThicknessUnits = 21
    PipeCode = 22
    PipeCodeUnits = 23
    Velocity = 24
    VelocityUnits = 25
    ZyqadObjectID = 26
    ZyqadWorkGroupName = 27
End Enum

Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

    Dim sFileName As String
    Dim sStreamNumber As String
    Dim objConfigInfo As New igrConfigInfo
    Dim objStreamData As Collection
    Dim objPipeRun As LMPipeRun
    Dim i As Long
    Dim Item As LMAItem
    
    On Error GoTo ErrHandler
    
    'Clear the import log.
    frmImportStatus.lstStatus.Clear
    
    UpdateStatus LoadResString(141)
    
    objConfigInfo.ApplicationName = "SmartPlantPID"
    sFileName = objConfigInfo.GetConfigString(ConfigKeyUser, "Import", "ZyqadStreamData")
    
    'Import stream data from the Zyqad file.
    If (sFileName <> "") And (Dir(sFileName) <> "") Then
        UpdateStatus LoadResString(142)
        frmSelectStream.txtFileName.Text = sFileName
        frmSelectStream.OriginalFileName = sFileName
        Set objStreamData = GetStreamDataFromFile(sFileName)   'returns a collection of variant arrays
    End If
    
    ' Populate the comboBox
    Call Populate(objStreamData)
    
    'If the stream number was already set for this pipe run, make it the default.
    If IsNull(Value) = False Then
        frmSelectStream.Combo1.Text = Value
    End If
    
    frmSelectStream.Show vbModal
        
    If (sFileName <> frmSelectStream.txtFileName.Text) Then
        Set objStreamData = frmSelectStream.StreamData
    End If
        
    If (Trim(frmSelectStream.Combo1.Text) <> "") Then
        ILMForeignCalc_DoCalculate = True
        sStreamNumber = Trim(frmSelectStream.Combo1.Text)
        Value = sStreamNumber
    Else
        ILMForeignCalc_DoCalculate = False
    End If
    
    Unload frmSelectStream
    
    If (ILMForeignCalc_DoCalculate) Then
        On Error Resume Next
        If (IsEmpty(objStreamData(sStreamNumber))) Then
            On Error GoTo ErrHandler
            If MsgBox(LoadResString(102) & sFileName & LoadResString(105) & sStreamNumber & LoadResString(106), _
                      vbYesNo + vbExclamation, _
                      LoadResString(104)) = vbNo Then
                ILMForeignCalc_DoCalculate = False
            End If
        Else
            On Error GoTo ErrHandler
            'Get the pipe runs that needs to be updated.
            For Each Item In Items
                Set objPipeRun = PIDDataSource.GetPipeRun(Item.ID)
                If Not (objPipeRun Is Nothing) Then
                    UpdateStatus "Updating pipe run properties"
                    UpdatePipeRunProperties objPipeRun, objStreamData(sStreamNumber)
                End If
            Next
        End If
    End If
            
Cleanup:
    Set objConfigInfo = Nothing
    Set objStreamData = Nothing
    Set objPipeRun = Nothing
    ShowImportLog
    Exit Function
    
ErrHandler:
    UpdateStatus LoadResString(120) & Err.Description
    Resume Cleanup

End Function

Public Function GetStreamDataFromFile(sFileName As String) As Collection

    Dim AttrCollection As New Collection
    Dim vPropertyValues(27) As Variant
    Dim sFirstLine  As String
    
    On Error GoTo ErrHandler
    
    Open sFileName For Input As #1
        Line Input #1, sFirstLine
        While Not (EOF(1))
            'Stream-number,Zyqad load date, Zyqad username, MassFlow, Massflow units,
            'LiquidVolFlow, LiquidVolFlow Units, VaporVolFlow, VaporVolFlow units,
            'Operating Pressure, Pressure units, Operating Temperature, Temperature
            'Units, Specific Gravity, Density, Density Units, Compressibility,
            'Viscocity, Visc Units, Pipe Thickness, Thickness Units, Pipe Code, Code
            'Units, Velocity, Velocity Units, Zyqad Object ID, Zyqad WorkGroup Name
            Input #1, _
                vPropertyValues(ImportProperties.CurrStreamNumber), vPropertyValues(ImportProperties.ZyqadExportDate), _
                vPropertyValues(ImportProperties.ZyqadUserName), vPropertyValues(ImportProperties.MassFlow), _
                vPropertyValues(ImportProperties.MassflowUnits), vPropertyValues(ImportProperties.LiquidVolFlow), _
                vPropertyValues(ImportProperties.LiquidVolFlowUnits), vPropertyValues(ImportProperties.VaporVolFlow), _
                vPropertyValues(ImportProperties.VaporVolFlowUnits), vPropertyValues(ImportProperties.OperPressure), _
                vPropertyValues(ImportProperties.OperPressureUnits), vPropertyValues(ImportProperties.OperTemp), _
                vPropertyValues(ImportProperties.OperTempUnits), vPropertyValues(ImportProperties.SpecificGravity), _
                vPropertyValues(ImportProperties.Density), vPropertyValues(ImportProperties.DensityUnits), _
                vPropertyValues(ImportProperties.Compressibility), vPropertyValues(ImportProperties.Viscocity), _
                vPropertyValues(ImportProperties.ViscUnits), vPropertyValues(ImportProperties.PipeThickness), _
                vPropertyValues(ImportProperties.PipeThicknessUnits), vPropertyValues(ImportProperties.PipeCode), _
                vPropertyValues(ImportProperties.PipeCodeUnits), vPropertyValues(ImportProperties.Velocity), _
                vPropertyValues(ImportProperties.VelocityUnits), vPropertyValues(ImportProperties.ZyqadObjectID), _
                vPropertyValues(ImportProperties.ZyqadWorkGroupName)
        
            AttrCollection.Add vPropertyValues, CStr(vPropertyValues(ImportProperties.CurrStreamNumber))
        Wend
    Close #1
   
    Set GetStreamDataFromFile = AttrCollection
    
    Exit Function
    
ErrHandler:
    Close #1
    UpdateStatus LoadResString(120) & Err.Description
    
End Function

Public Sub Populate(objStreamData As Collection)
    Dim i As Long
    
    'Clear the Contents first if any present
    frmSelectStream.Combo1.Clear
    'Load the stream numbers into the drop-down list.
    If Not (objStreamData Is Nothing) Then
        For i = 1 To objStreamData.Count
            frmSelectStream.Combo1.AddItem objStreamData(i)(ImportProperties.CurrStreamNumber)
        Next i
    End If
    
End Sub

Public Sub UpdatePipeRunProperties(objPipeRun As LMPipeRun, ByVal vProperties As Variant)

    Dim objStatus As LMStatus
    Dim objHistory As LMHistory
    Dim objSource As LMSource
    Dim bFoundZyqadObjectID As Boolean
    Dim bFoundZyqadWorkGroupName As Boolean
    Dim bFoundLoadZyqadDataStatus As Boolean
    Dim oAttrLMAAttributes As LMAAttributes
    
    On Error GoTo ErrHandler
      
    bFoundZyqadObjectID = False
    bFoundZyqadWorkGroupName = False
    bFoundLoadZyqadDataStatus = False
        
    'set ExpandAttributes = TRUE to get complete set of attributes on the item
    objPipeRun.AsLMAItem.ISPItem.ExpandAttributes = True
    
    'get reference to LMAttributes object
    Set oAttrLMAAttributes = objPipeRun.Attributes
    
    SetValue oAttrLMAAttributes, CONST_SchOrThkAttributeName, vProperties(ImportProperties.PipeThickness) & " " & _
                                     vProperties(ImportProperties.PipeThicknessUnits)
    
    'objPipeRun.ScheduleOrThickness = vProperties(ImportProperties.PipeThickness) & " " & _
                                     vProperties(ImportProperties.PipeThicknessUnits)
    
    If (LCase(vProperties(ImportProperties.OperPressureUnits)) = "psig") Then
        SetValue oAttrLMAAttributes, CONST_OperMaxPressureAttributeName, vProperties(ImportProperties.OperPressure) & " " & "psi-g"
        'objPipeRun.AsLMAItem.ISPItem.Attributes("ProcessOperating.Max.Pressure").Value = vProperties(ImportProperties.OperPressure) & " " & "psi-g"
    ElseIf (LCase(vProperties(ImportProperties.OperPressureUnits)) = "psia") Then
        SetValue oAttrLMAAttributes, CONST_OperMaxPressureAttributeName, vProperties(ImportProperties.OperPressure) & " " & "psi-a"
        'objPipeRun.AsLMAItem.ISPItem.Attributes("ProcessOperating.Max.Pressure").Value = vProperties(ImportProperties.OperPressure) & " " & "psi-a"
    End If
    
    SetValue oAttrLMAAttributes, CONST_OperMaxTempAttributeName, vProperties(ImportProperties.OperTemp) & " " & vProperties(ImportProperties.OperTempUnits)
    'objPipeRun.AsLMAItem.ISPItem.Attributes("ProcessOperating.Max.Temperature").Value = vProperties(ImportProperties.OperTemp) & " " & vProperties(ImportProperties.OperTempUnits)
    
    If Not IsNull(vProperties(ImportProperties.SpecificGravity)) Then
        SetValue oAttrLMAAttributes, CONST_OperMaxSpGravityAttributeName, CStr(vProperties(ImportProperties.SpecificGravity))
        'objPipeRun.AsLMAItem.ISPItem.Attributes("ProcessOperating.Max.SpecificGravity").Value = CStr(vProperties(ImportProperties.SpecificGravity))
    End If
    
    'commit the changes
    objPipeRun.Commit
        
    'Update the Source data.
    For Each objSource In objPipeRun.Sources
        If (objSource.SourceFor = "ZyqadObjectID") Then
            objSource.Origin = vProperties(ImportProperties.ZyqadObjectID)
            objSource.Commit
            bFoundZyqadObjectID = True
        ElseIf (objSource.SourceFor = "ZyqadWorkGroupName") Then
            objSource.Origin = vProperties(ImportProperties.ZyqadWorkGroupName)
            objSource.Commit
            bFoundZyqadWorkGroupName = True
        End If
    Next

    If (bFoundZyqadObjectID = False) Then
        Set objSource = objPipeRun.Sources.Add(Nothing) ' TBD.. srini
        objSource.SourceFor = "ZyqadObjectID"
        objSource.Origin = vProperties(ImportProperties.ZyqadObjectID)
        objSource.Commit
    End If

    If (bFoundZyqadWorkGroupName = False) Then
        Set objSource = objPipeRun.Sources.Add(Nothing) ' TBD... srini
        objSource.SourceFor = "ZyqadWorkGroupName"
        objSource.Origin = vProperties(ImportProperties.ZyqadWorkGroupName)
        objSource.Commit
    End If

'    'Update the Status data.
'   Commenting this process out as this is no longer valid
'    For Each objStatus In objPipeRun.Statuses
'        If (objStatus.StatusType = "Load Zyqad Data") Then
'            objStatus.StatusTimestamp = vProperties(ImportProperties.ZyqadExportDate)
'            objStatus.Text = vProperties(ImportProperties.ZyqadUserName)
'            objStatus.Commit
'            bFoundLoadZyqadDataStatus = True
'        End If
'    Next
'
'    If (bFoundLoadZyqadDataStatus = False) Then
'        Set objStatus = objPipeRun.Statuses.Add(Nothing)    ' TBD.. srini
'        objStatus.StatusTimestamp = vProperties(ImportProperties.ZyqadExportDate)
'        objStatus.StatusType = "Load Zyqad Data"
'        objStatus.Text = vProperties(ImportProperties.ZyqadUserName)
'        objStatus.Commit
'    End If

    'Add a History record to the piperun.
    Set objHistory = objPipeRun.Histories.Add(Nothing)  ' TBD... Srini
    objHistory.EventType = "Load Zyqad Data"
    objHistory.Text = vProperties(ImportProperties.ZyqadUserName)
    objHistory.TimeStamp = vProperties(ImportProperties.ZyqadExportDate)
    objHistory.Commit
    
    Set objStatus = Nothing
    Set objHistory = Nothing
    Set objSource = Nothing
    
    Exit Sub
    
ErrHandler:
    
    UpdateStatus LoadResString(120) & Err.Description
    
    Set objStatus = Nothing
    Set objHistory = Nothing
    Set objSource = Nothing
    
End Sub

Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant)

End Sub
