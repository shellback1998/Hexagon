Attribute VB_Name = "modHelper"
Option Explicit
Const MODULE = "modHelper::"

Const PROGRAM_NAME = "SHOWELEMENT_"

Public mcolCodeLists As New Collection

Public glMaxList As Long ' maximum number of relations to display

Public g_oPref As IJPreferences

Public Sub Main()
    glMaxList = 10
    InitLog True
End Sub






Public Sub HandleSessionParameters(bRead As Boolean)
    Dim oTrader As New Trader
    
    Set g_oPref = oTrader.Service(TKPreferences, "")
    
    Call Param(glMaxList, "MaxList", 10, vbLong, bRead)
 
 
    Set g_oPref = Nothing
End Sub
Private Sub Param(var As Variant, sName As String, vDefault As Variant, lTyp As Long, bRead As Boolean)
    Dim sKey As String
    sKey = PROGRAM_NAME & sName
    Select Case lTyp
    Case vbString
        If bRead Then
            var = g_oPref.GetStringValue(sKey, vDefault)
        Else
            g_oPref.SetStringValue sKey, var
        End If
    Case vbLong
        If bRead Then
            var = g_oPref.GetLongValue(sKey, vDefault)
        Else
            g_oPref.SetLongValue sKey, var
        End If
    Case vbBoolean
        If bRead Then
            var = g_oPref.GetBooleanValue(sKey, vDefault)
        Else
            g_oPref.SetBooleanValue sKey, var
        End If
    Case vbDouble
        If bRead Then
            var = g_oPref.GetDoubleValue(sKey, vDefault)
        Else
            g_oPref.SetDoubleValue sKey, var
        End If
    Case Else
        MsgBox "Unhandled Parameter typ: " & lTyp
    End Select
End Sub


Public Function getGuid(oObject As Object) As String

    On Error GoTo Handler
      
    Dim oTrader As Trader
    Dim oWorkingSet As IJDWorkingSet
    Dim oConnection As WorkingSetLibrary.IJDConnection
    Dim pStsMkr As IUnknown
    Dim pObjecInfo As WorkingSetLibrary.IJDObjectInfo
    Dim oMoniker As IMoniker
    
    Set oTrader = New Trader
    Set oWorkingSet = oTrader.Service("WorkingSet", "")
    Set oConnection = oWorkingSet.ActiveConnection
    Set oMoniker = oConnection.GetObjectName(oObject)
    Set pObjecInfo = oWorkingSet.ActiveConnection ' oConnection
    getGuid = pObjecInfo.GetDbIdentifierFromMoniker(oMoniker)
     
    Exit Function
Handler:
    Call mylog(Err.Description & " (in getGuid)")
    'Debug.Assert False
    getGuid = "(No GUID)"
    Exit Function
    Resume
End Function

Public Function getName(oObject As Object, Optional sBefore As String = "", _
                                           Optional sAfter As String = "") As String
    Dim oIJN As IJNamedItem
    If TypeOf oObject Is IJNamedItem Then
        Set oIJN = oObject
        getName = sBefore & oIJN.Name & sAfter
    End If
End Function





Public Function AddIfNotEmpty(sIn As String, sHead As String, Optional sTail As String = ")") As String
    If Len(sIn) > 0 Then
        AddIfNotEmpty = sHead & sIn & sTail
    End If
End Function
 
Public Sub EnterErrorInTree(sText As String, mForm As frmShowElement, _
                            Node0 As MSComctlLib.Node, _
                            Optional Node1 As MSComctlLib.Node, _
                            Optional Node2 As MSComctlLib.Node, _
                            Optional Node3 As MSComctlLib.Node)
    Dim MyNode As MSComctlLib.Node
    Set MyNode = Node3
    If MyNode Is Nothing Then Set MyNode = Node2
    If MyNode Is Nothing Then Set MyNode = Node1
    If MyNode Is Nothing Then Set MyNode = Node0
    
    Debug.Assert False
    Call mForm.TreeView1.Nodes.Add(MyNode, tvwChild, , sText)
End Sub





Public Function GetCodeList(strTableName As String) As IJDInfosCol
    Const METHOD = "GetCodeList"
    On Error GoTo ErrHandler
    
    Dim oCodeListMetaData As IJDCodeListMetaData
    Dim oCatlogConnection As IJDConnection
    Dim oInfosCol         As IJDInfosCol
    Dim i As Integer
    
    Set oCatlogConnection = GetCatalogDBConnection()
    Set oCodeListMetaData = oCatlogConnection.ResourceManager
    Set oInfosCol = oCodeListMetaData.CodelistValueCollection(strTableName)
    
    Set GetCodeList = oInfosCol
    Set oInfosCol = Nothing
    Set oCodeListMetaData = Nothing
    Set oCatlogConnection = Nothing

    
    Exit Function
ErrHandler:
    'ReportUnanticipatedError MODULE, METHOD
    Call mylog(Err.Description & " " & MODULE & METHOD)
End Function


Public Function SetupCodeList(strTableName As String, lShortvalue As Long) As Collection
    Const METHOD = "SetupCodeList"
    On Error GoTo Handler
    Dim oIJDInfosCol As IJDInfosCol
    Dim o As Object
    Dim oICV As IJDCodeListValue
    
    Set SetupCodeList = New Collection
    Set oIJDInfosCol = GetCodeList(strTableName)
    For Each oICV In oIJDInfosCol
        If lShortvalue = 1 Then
            SetupCodeList.Add oICV.ShortValue, CStr(oICV.ValueID)
        ElseIf lShortvalue = 2 Then
            SetupCodeList.Add oICV.LongValue, CStr(oICV.ValueID)
        Else
            SetupCodeList.Add CStr(oICV.ValueID) & vbTab & oICV.LongValue & "/" & oICV.ShortValue, CStr(oICV.ValueID)
        End If
    Next
    Exit Function
Handler:
    'Call gProKLog.Output(Err.Description & " (" & MODULE & METHOD & ")", True, ES_Tracking)
    Call mylog(Err.Description & " " & MODULE & METHOD)
End Function

Public Function getCodeListEntry(sTableName As String, lId As Long, _
            Optional bAll As Boolean = False) As String
    Dim colCl As Collection
    Dim l As Long
    
    On Error Resume Next
    Set colCl = mcolCodeLists.Item(sTableName)
    If colCl Is Nothing Then
        Set colCl = SetupCodeList(sTableName, 3)
        If colCl Is Nothing Then
            Exit Function
        End If
        mcolCodeLists.Add colCl, sTableName
    End If
    getCodeListEntry = colCl.Item(CStr(lId))
    If Not bAll Then
        l = InStr(1, getCodeListEntry, vbTab)
        If l > 0 Then
            getCodeListEntry = Mid(getCodeListEntry, l + 1)
        End If
    End If
End Function


Public Function GetCatalogDBConnection() As IJDConnection
    Const METHOD = "GetCatalogDBConnection"
    On Error GoTo ErrHandler
    Dim oTrader As IMSTrader.Trader
    Set oTrader = New Trader
    Dim oWorkingSet As IJDWorkingSet
    Set oWorkingSet = oTrader.Service("WorkingSet", "")
    Dim strCatlogDB As String
    Dim oAppCtx As IJApplicationContext
    Set oAppCtx = oTrader.Service("ApplicationContext", "")
    strCatlogDB = oAppCtx.DBTypeConfiguration.get_DataBaseFromDBType("Catalog")
    Set GetCatalogDBConnection = oWorkingSet.Item(strCatlogDB)
    Set oTrader = Nothing
    Set oWorkingSet = Nothing
    Set oAppCtx = Nothing
Exit Function
ErrHandler:
    ' ReportUnanticipatedError MODULE, METHOD
    Call mylog(Err.Description & " " & MODULE & METHOD)
End Function


Public Function getObjectByGuid(sGuid As String) As Object
    On Error GoTo Handler
      
    Dim oTrader As Trader
    Dim oWorkingSet As IJDWorkingSet
    Dim oConnection As WorkingSetLibrary.IJDConnection
    Dim pStsMkr As IUnknown
    Dim pObjecInfo As WorkingSetLibrary.IJDObjectInfo
    Dim oMoniker As IMoniker
    
    Set oTrader = New Trader
    Set oWorkingSet = oTrader.Service("WorkingSet", "")
    Set oConnection = oWorkingSet.ActiveConnection
 
    Set pObjecInfo = oWorkingSet.ActiveConnection ' oConnection
    Set oMoniker = pObjecInfo.GetMonikerFromDbIdentifier(sGuid)
       
    Set getObjectByGuid = oConnection.GetObject(oMoniker)
    Exit Function
Handler:
    Call mylog(Err.Description & " (in getObjectByGuid)")
    'Debug.Assert False
    Set getObjectByGuid = Nothing
    Exit Function
    Resume
End Function


'
' Return an array of double values from an input string
' the separator between doubles may be blank, , ; or vbTab
'
Public Function getDoubleValues(sIn As String, dArray() As Double) As Long
    Dim s As String
    Dim i As Long
    Dim x As String
 
    
    Dim j As Long
    Dim j1 As Long
    Dim sB() As String
    
        getDoubleValues = 0
        
        s = sIn
        s = Replace(s, " ", ",")
        s = Replace(s, vbTab, ",")
        s = Replace(s, ";", ",")
        
        For i = 1 To Len(s)
            x = Mid(s, i, 1)
            If (x >= "0" And x <= "9") Or x = "-" Or x = "," Then
                ' ok
            ElseIf x = "E" Or x = "e" Or x = "." Then
                If Mid(s, i - 1, 1) = " " Then
                    Mid(s, i, 1) = " " ' this is not an exponent or decimal point
                End If
            Else
                Mid(s, i, 1) = " "
            End If
        Next i
 
            sB = Split(s, ",")
            
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
            ReDim dArray(UBound(sB))
            
            If sB(0) = "" Then
                getDoubleValues = -1
                Exit Function
            End If
            
            For i = LBound(sB) To UBound(sB)
 
                On Error Resume Next
                dArray(i) = parCGetDouble(sB(i))
                On Error GoTo Handler
            Next i
            Exit Function
Handler:
            
    getDoubleValues = -1
End Function
