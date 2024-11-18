Attribute VB_Name = "ImportModule"
Option Explicit

Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

Public Const CONST_PidCommonResourceDll As String = "SPpidCommon" ' I18N OK
Public Const CONST_RepresentationItemStatusAttribute = "Representation.ItemStatus"

Private Const ModuleName As String = "ImportModule"

'Attribute Constants
Public Const CONST_ItemTagAttributeName As String = "ItemTag"
Public Const CONST_NameAttributeName As String = "Name"
Public Const CONST_EquipTypeAttributeName As String = "EquipmentType"
Public Const CONST_MtlConstClassAttributeName As String = "MaterialOfConstClass"
Public Const CONST_PpMtlClassAttributeName  As String = "PipingMaterialsClass"
Public Const CONST_HTraceReqmtAttributeName As String = "HTraceReqmt"
Public Const CONST_HTraceMediumAttributeName As String = "HTraceMedium"
Public Const CONST_InsulPurposeAttributeName As String = "InsulPurpose"
Public Const CONST_InsulThickAttributeName As String = "InsulThick"
Public Const CONST_CoatingReqmtsAttributeName As String = "CoatingReqmts"
Public Const CONST_CleaningReqmtsAttributeName As String = "CleaningReqmts"
Public Const CONST_TagPrefixAttributeName As String = "TagPrefix"
Public Const CONST_TagSequenceNoAttributeName As String = "TagSequenceNo"
Public Const CONST_TagSuffixAttributeName As String = "TagSuffix"
Public Const CONST_ConstStatusAttributeName As String = "ConstructionStatus"
Public Const CONST_HoldStatusValueAttributeName As String = "HoldStatus.StatusValue"
Public Const CONST_HTraceMediumTempAttributeName As String = "HTraceMediumTemp"
Public Const CONST_TypeOfDriverAttributeName As String = "TypeOfDriver"
Public Const CONST_NominalDiameterAttributeName As String = "NominalDiameter"
Public Const CONST_SchOrThkAttributeName As String = "ScheduleOrThickness"
Public Const CONST_FluidCodeAttributeName As String = "OperFluidCode"
Public Const CONST_DgnMaxPressureAttributeName As String = "ProcessDesign.Max.Pressure"
Public Const CONST_DgnMaxTempAttributeName As String = "ProcessDesign.Max.Temperature"
Public Const CONST_AltDgnMaxPressureAttributeName As String = "ProcessAlternateDesign.Max.Pressure"
Public Const CONST_AltDgnMaxTempAttributeName As String = "ProcessAlternateDesign.Max.Temperature"
Public Const CONST_OperMaxPressureAttributeName As String = "ProcessOperating.Max.Pressure"
Public Const CONST_OperMaxTempAttributeName As String = "ProcessOperating.Max.Temperature"
Public Const CONST_OperMaxSpGravityAttributeName As String = "ProcessOperating.Max.SpecificGravity"
Public Const CONST_AltOperMaxPressureAttributeName As String = "ProcessAlternateOperating.Max.Pressure"
Public Const CONST_AltOperMaxTempAttributeName As String = "ProcessAlternateOperating.Max.Temperature"
Public Const CONST_TestMaxPressureAttributeName As String = "ProcessTest.Max.Pressure"
Public Const CONST_TestNameAttributeName As String = "ProcessTest.Name"
Public Const CONST_TestFluidTypeAttributeName As String = "ProcessTest.FluidType"
Public Const CONST_NozzleTypeAttributeName As String = "NozzleType"
Public Const CONST_PpPt1EndPrepAttributeName As String = "PipingPoint1.EndPrep"
Public Const CONST_PpPt1DiameterAttributeName As String = "PipingPoint1.NominalDiameter"
Public Const CONST_PpPt1RatingAttributeName As String = "PipingPoint1.Rating"
Public Const CONST_DescriptionAttributeName As String = "Description"
Public Const CONST_SPIDAttributeName As String = "SP_ID"
Public Const CONST_ItemTypeNameAttributeName As String = "ItemTypeName"

'returns the Catalog Root Path setting from Options Manager
Public Function GetBaseSymbolDir(objDatasource As LMADataSource) As String

    On Error GoTo errHandler
    
    GetBaseSymbolDir = Trim(objDatasource.PIDMgr.PIDOptionsHelper.CatalogExplorerRootPath)
    If (GetBaseSymbolDir = "") Then
        UpdateStatus LoadResString(120) & LoadResString(121)
    End If
    Exit Function
    
errHandler:
    
    UpdateStatus LoadResString(120) & Err.Description

End Function


Public Sub UpdateStatus(sMessage As String, Optional sItemTag As String = "")
    If (sItemTag <> "") Then
        sMessage = LoadResString(122) & sItemTag & " --> " & sMessage
    End If
    
    frmImportStatus.lstStatus.AddItem sMessage
End Sub
'shows progessbar control to indicate the progress
Public Sub ShowProgressBar(objProgressBar As igrProgressBar412B.clsProgressBar)
    
    Set objProgressBar = New igrProgressBar412B.clsProgressBar
    With objProgressBar
        .PBMin = 0
        .PBMax = 100
        .PBHeight = 300
        .PBMessage = "Initializing..."
        .MakeTopMostWindow True
        .PBTop = Screen.Height / 2
        .PBLeft = Screen.Width / 4
        .PBWidth = Screen.Width / 2
        .PBValue = 0
        'TR14532 set font for internationalization  1/24/2000 mw
        .FontName = LoadResString(20)
        .FontSize = LoadResString(21)
        .Show
    End With
    
End Sub
'show Import Error Log
Public Sub ShowImportLog()
    
    Dim i As Integer
    Dim sImportLogFile As String
    Dim bError As Boolean
    
    sImportLogFile = Environ("TEMP") & "\SPImport.log"
'    If (Dir(sImportLogFile) <> "") Then
'        Kill sImportLogFile
'    End If
    
    'Open sImportLogFile For Output As #1
    Open sImportLogFile For Append As #1
    
    Print #1, ""
    Print #1, "-------------------------------------------------------"
    Print #1, LoadResString(123)
    Print #1, LoadResString(124) & Now
    Print #1, "-------------------------------------------------------"
    For i = 0 To frmImportStatus.lstStatus.ListCount - 1
        Print #1, frmImportStatus.lstStatus.List(i)
        If (InStr(1, frmImportStatus.lstStatus.List(i), LoadResString(125), vbTextCompare) <> 0) Then
            bError = True
        End If
    Next i
    Close #1
    
    If (bError) Then
        ResetHScrollBar frmImportStatus.lstStatus
        frmImportStatus.Show vbModal
    End If
    
End Sub
'replaces empty with Null values
Public Sub ReplaceEmptyWithNull(vValues As Variant)

    Dim i As Long
    
    If IsArray(vValues) Then
        For i = LBound(vValues) To UBound(vValues)
            'modified by BL 6/1/05 for solve the inconsistency issue after import
            'If IsEmpty(vValues(i)) Then
            If Len(vValues(i)) = 0 Then
                vValues(i) = Null
            End If
        Next
    Else
        'If IsEmpty(vValues) Then
        If Len(vValues) = 0 Then
            vValues = Null
        End If
    End If

End Sub
'sets the given value on an attribute. If it is unable to set the value then
'it writes the Item and Attribute information to Import Log.
Public Function SetValue(oLMAAttributes As LMAAttributes, strAttrName, varValue As Variant)
    Dim oLMAAttribute As LMAAttribute
    Dim sItemTag As String
    Dim bFailure As Boolean
    Dim lIndex As Long
    Dim strParsedValue As String
    Dim lPos As Long
    Dim strDoubleQuotes As String
    
    On Error GoTo eHandler
    
    'get the LMAAttribute from LMAAttributes
    Set oLMAAttribute = oLMAAttributes.Item(strAttrName)
    
    If Not oLMAAttribute Is Nothing Then
        If Not IsNull(varValue) Then
            'set the value on the LMAAttribute
            oLMAAttribute.Value = varValue & ""
        Else
            If Not IsNull(oLMAAttribute.Value) Then
                'set the value on the LMAAttribute
                oLMAAttribute.Value = Null 'varValue
            End If
        End If
        'No errors are generated when an invalid value is set. The invalid
        'value will be just ignored.
        'Checking to see if the value is set on the item attribute
        If IsNull(varValue) Then
            If Not IsNull(oLMAAttribute.Value) Then
                bFailure = True
            End If
        ElseIf IsNull(oLMAAttribute.Value) Then
            bFailure = True
        Else
            'UoM values can be allowed to have Apostophe character or
            'value enclosed inside a double quotes. Such strings are
            'considered as valid values.
            strParsedValue = varValue
            lPos = 0
            lPos = InStr(1, strParsedValue, "'", vbTextCompare)
            If lPos = 1 Then
                strParsedValue = Mid$(strParsedValue, 2)
            Else
                strDoubleQuotes = Chr(34)
                lPos = InStr(1, strParsedValue, strDoubleQuotes, vbTextCompare)
                If lPos = 1 Then
                    lPos = InStr(Len(strParsedValue), strParsedValue, strDoubleQuotes, vbTextCompare)
                    If lPos = Len(strParsedValue) Then
                        strParsedValue = Mid(strParsedValue, 2, Len(strParsedValue) - 2)
                    End If
                End If
            End If
            
            If CStr(oLMAAttribute.Value) <> strParsedValue Then
                bFailure = True
            End If
        End If
        'Unable to set the value
        If bFailure = True Then
            sItemTag = GetItemTag(oLMAAttributes)
            UpdateStatus LoadResString(154) & strAttrName & "=" & varValue, sItemTag
        Else
            lIndex = oLMAAttribute.Index
            If lIndex <> 0 Then
                'resetting it will set the dependent properties
On Error Resume Next
                oLMAAttribute.Index = lIndex
            End If
        End If
    Else
        sItemTag = GetItemTag(oLMAAttributes)
        
        'attribute doesn't exist on the Item
        UpdateStatus LoadResString(153) & " '" & strAttrName & "'", sItemTag
    End If
    
    Exit Function

eHandler:
    sItemTag = GetItemTag(oLMAAttributes)
    UpdateStatus LoadResString(154) & strAttrName & "=" & varValue & "->" & Err.Description, sItemTag
End Function

Public Function GetItemTag(oLMAAttributes As LMAAttributes) As String
    Dim sItemTag As String
    Dim sItemTypeName As String
    Dim sID As String
    
    On Error GoTo eHandler
    
    If Not oLMAAttributes.Item(CONST_ItemTagAttributeName) Is Nothing Then
        If Not IsNull(oLMAAttributes.Item(CONST_ItemTagAttributeName).Value) Then
            sItemTag = oLMAAttributes.Item(CONST_ItemTagAttributeName).Value
        End If
    End If
        
    If Len(sItemTag) = 0 Then
        sItemTypeName = oLMAAttributes.Item(CONST_ItemTypeNameAttributeName).Value
        sID = oLMAAttributes.Item(CONST_SPIDAttributeName).Value
        sItemTag = sItemTypeName & "-" & sID
    End If
    
    GetItemTag = sItemTag
    
    Exit Function

eHandler:
    UpdateStatus LoadResString(120) & Err.Description
End Function
