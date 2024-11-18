VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPipeRunLength"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************************
'Copyright © 2004, Intergraph Corporation
'
'Project:   SP3DReportLAbel
'
'File:      CPipeRunLength.cls
'
'Description:Returns the true length of a pipe run for reporting
'
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Explicit

Private Const MODULE = "SP3DReportLabel.CPipeRunLength:"

Implements IJQueryInterpreter

Private m_bEvaluateOnly             As Boolean
Private m_oADORecordset             As ADODB.Recordset
Private m_oLabeledObject            As Object
Private m_oParameters               As IJQueriesParameters
Private m_oQParams                  As IJQueryParameters

'******************************************************************************
'Class Constructor/Destructor
'******************************************************************************
Private Sub Class_Initialize()

End Sub

Private Sub Class_Terminate()
    Set m_oLabeledObject = Nothing
    Set m_oADORecordset = Nothing
End Sub

'******************************************************************************
'Private implementation of IJQueryInterpreter
'******************************************************************************
Private Property Set IJQueryInterpreter_CacheController(RHS As SP3DReportsRuntimeInterfaces.IJCacheController)
End Property

Private Property Get IJQueryInterpreter_CacheController() As SP3DReportsRuntimeInterfaces.IJCacheController
End Property

Private Property Let IJQueryInterpreter_EvaluateOnly(ByVal RHS As Boolean)
    m_bEvaluateOnly = RHS
End Property

Private Property Get IJQueryInterpreter_EvaluateOnly() As Boolean
    IJQueryInterpreter_EvaluateOnly = m_bEvaluateOnly
End Property

Private Sub IJQueryInterpreter_Execute(Command As String, Argument As String)
    Const METHOD = "IJQueryInterpreter_Execute"
    
    Dim dLength As Double
    
    Dim oQPField                As IJField
           
    On Error GoTo ErrorHandler
            
    If Not m_oADORecordset Is Nothing Then
        Set m_oADORecordset = Nothing
    End If
    Set m_oADORecordset = CreateOpenRecordset     'open the RS to add the records
    
    If m_bEvaluateOnly = True Then ' we just return the header (the definition, no data)
        Exit Sub
    End If
    
'    SELECT clst.ShortStringValue AS ScheduleThickness

    If m_oLabeledObject Is Nothing Then
        If Not m_oQParams Is Nothing Then
        ' Get oid and bind object so this approach is transparent
            For Each oQPField In m_oQParams.Fields
                If oQPField.FieldName = "OID" Then
                    Set m_oLabeledObject = BindOID(oQPField.Value)
                End If
            Next
        End If
    End If

    If Not m_oLabeledObject Is Nothing Then
    
                
    If TypeOf m_oLabeledObject Is IJRtePathRun Then
        
    dLength = ComputeRunLength(m_oLabeledObject)
    
    m_oADORecordset.AddNew
                
                
    m_oADORecordset.Fields.Item("eLength").Value = dLength
        
    Else
        
    m_oADORecordset.AddNew
                
    m_oADORecordset.Fields.Item("eLength").Value = 0#
    Log.Add 1000, MODULE & METHOD, "", , , , "This label only works for a run. Object passed into label was not a run."

     End If
    
    End If
    
    GoTo ShutDown

ErrorHandler:
'    Call ErrHandler(Err, MODULE & METHOD)

ShutDown:
    
End Sub

Private Property Set IJQueryInterpreter_FilterResult(ByVal RHS As Object)
    Set m_oLabeledObject = RHS
End Property

Private Property Get IJQueryInterpreter_FilterResult() As Variant
    Set IJQueryInterpreter_FilterResult = m_oLabeledObject
End Property

Private Property Set IJQueryInterpreter_Parameters(RHS As SP3DReportsObjectsInterfaces.IJQueryParameters)
    Set m_oQParams = RHS
End Property

Private Property Get IJQueryInterpreter_Parameters() As SP3DReportsObjectsInterfaces.IJQueryParameters
    Set IJQueryInterpreter_Parameters = m_oQParams
End Property

Private Property Get IJQueryInterpreter_ParticipatingObjects() As SP3DReportsRuntimeInterfaces.IJElements
End Property

Private Property Set IJQueryInterpreter_Query(RHS As SP3DReportsObjectsInterfaces.IJQuery)
End Property

Private Property Get IJQueryInterpreter_Query() As SP3DReportsObjectsInterfaces.IJQuery
End Property

Private Property Set IJQueryInterpreter_QueryFilter(RHS As SP3DReportsObjectsInterfaces.IJQueryFilter)
End Property

Private Property Get IJQueryInterpreter_QueryFilter() As SP3DReportsObjectsInterfaces.IJQueryFilter
End Property

Private Property Get IJQueryInterpreter_QueryResult() As Variant
    Set IJQueryInterpreter_QueryResult = m_oADORecordset
End Property

'******************************************************************************
'Private methods
'******************************************************************************
Private Function CreateOpenRecordset() As ADODB.Recordset
    Const METHOD = "CreateOpenRecordset"
    Dim oRs                 As ADODB.Recordset
    
    On Error GoTo ErrorHandler
    
    Set oRs = New ADODB.Recordset
    
    oRs.Fields.Append "eLength", adDouble, , adFldIsNullable
    
    oRs.Open , , , adLockOptimistic     'open the RS to add the records
    Set CreateOpenRecordset = oRs
    
    GoTo ShutDown
    
ErrorHandler:
'    Call ErrHandler(Err, MODULE & METHOD)
ShutDown:
    Set oRs = Nothing
End Function

Private Function BindOID(oid As String) As Object
    Dim oContext As IMSServerContextSupport.IJContext
    Dim oDBTypeConfig As IJDBTypeConfiguration
    Dim oConnectMiddle As IMSConnectMiddle.IJDAccessMiddle
    Dim sDBID As String
    Dim oPom As RESPOMLib.IJDPOM
    Dim oObject As Object
    
    On Error GoTo ErrorHandler
    
    'Get the middle context
    Set oContext = GetJContext()
    
    'Determine the Database ID
    Set oDBTypeConfig = oContext.GetService("DBTypeConfiguration")
    sDBID = oDBTypeConfig.get_DataBaseFromDBType("Model")
    
    'Get the POM based on the Database ID
    Set oConnectMiddle = oContext.GetService("ConnectMiddle")
    Set oPom = oConnectMiddle.GetResourceManager(sDBID)

    Set oObject = GetObjectFromDbUsingMoniker(oPom, oid)

    Set BindOID = oObject
    GoTo ShutDown
    
ErrorHandler:

ShutDown:
    Set oObject = Nothing
    Set oContext = Nothing
    Set oDBTypeConfig = Nothing
    Set oConnectMiddle = Nothing
    Set oPom = Nothing
End Function


Private Function GetObjectFromDbUsingMoniker(oPom As RESPOMLib.IJDPOM, _
                                             Moniker As Variant) As Object
    Dim oMoniker As IUnknown
    
    On Error GoTo ErrorHandler
    
    If Not TypeOf Moniker Is IUnknown Then
        If IsOIDWithDBType(CStr(Moniker)) = True Then
            'We assume it is an OID (DBIdentifier)
            Set oMoniker = oPom.MonikerFromDbIdentifier(Mid(CStr(Moniker), 1, 38))
            Set GetObjectFromDbUsingMoniker = oPom.GetObject(oMoniker)
        Else
            'It is the string of the NamedObject
            Set GetObjectFromDbUsingMoniker = oPom.GetObject(Moniker)
        End If
    Else
        'Get the Object based on the moniker (binding)
        Set GetObjectFromDbUsingMoniker = oPom.GetObject(Moniker)
    End If

    GoTo ShutDown

ErrorHandler:

ShutDown:

    Set oMoniker = Nothing
End Function


Private Function IsOIDWithDBType(Arg As String) As Boolean
    Dim pos1 As Long
    Dim pos2 As Long
    
    pos1 = InStr(1, Arg, "{")
    pos2 = InStrRev(Arg, "}")
    
    If pos1 = 1 And pos2 = 38 Then
        IsOIDWithDBType = True
    Else
        IsOIDWithDBType = False
    End If
End Function
Private Function ComputeRunLength(oPipeRun As Object) As Double
    Dim dCumLength As Double
    Dim dLegLength As Double
    Dim oLegColl As IJDObjectCollection
    Dim oPathRun As IJRteRunUtility
    Dim oLeg As IJRtePathLeg
    
    Set oPathRun = oPipeRun 'Assuming different interface point for pipe run
    oPathRun.GetLegs oLegColl
    
    dCumLength = 0
    For Each oLeg In oLegColl
        dCumLength = dCumLength + oLeg.Length + GetLegLengthAdjustment(oLeg)
    Next oLeg
     
    ComputeRunLength = dCumLength
End Function
Private Function GetLegLengthAdjustment(oLeg As IJRtePathLeg) As Double
    Dim oFirstFeat As IJRtePathFeat
    Dim oLastFeat As IJRtePathFeat
    Dim dLegStartAdj As Double, dLegEndAdj As Double
    
    Set oFirstFeat = oLeg.GetFirstFeature
    dLegStartAdj = GetLegEndLenghtAdjustment(oFirstFeat, True)
    
    Set oLastFeat = oLeg.GetLastFeature
    dLegEndAdj = GetLegEndLenghtAdjustment(oLastFeat, False)
    
    GetLegLengthAdjustment = dLegStartAdj + dLegEndAdj
    
End Function
Private Function GetLegEndLenghtAdjustment(oTermFeat As IJRtePathFeat, bIsStartOfLeg As Boolean) As Double
    Dim oOfflinefeat As IJRteOfflinePathFeat
    Dim oInlineFeat As IJRtePathFeat
    Dim lHasComponents As Long
    Dim oBranchLoc As IJDPosition
    Dim oHeaderLoc As IJDPosition
    
    GetLegEndLenghtAdjustment = 0#

    If TypeOf oTermFeat Is IJRteBranchPathFeat Then
        Set oOfflinefeat = oTermFeat
        If Not oOfflinefeat Is Nothing Then
            Set oInlineFeat = oOfflinefeat.GetInLineFeature
            lHasComponents = oInlineFeat.HasComponents
            If lHasComponents = 1 Then ' Inline feature has components.  Hence it is Tee, RTE, Y etc and not olet, stub-in
                If bIsStartOfLeg Then
                    PathFeatGetStartLocation oTermFeat, oBranchLoc
                Else
                    PathFeatGetEndLocation oTermFeat, oBranchLoc
                End If
                
                ' Note, since we are using the location of the header feature, in some situations
                ' this may result in an adjusted length that is greater than the actual required length.
                ' This would happen when the branch port vector does not intersect with the symbol origin when
                ' projected into the symbol.  Prime candidates for such anomalies would be end-leg components
                ' such as steam traps.
                PathFeatGetLocation oInlineFeat, oHeaderLoc
                
                GetLegEndLenghtAdjustment = oHeaderLoc.DistPt(oBranchLoc)
            End If ' If lHasComponents = 1 Then
        End If ' If Not oOfflinefeat Is Nothing Then
    End If ' If TypeOf oTermFeat Is IJRteBranchPathFeat Then
End Function
Private Sub PathFeatGetLocation(oPathFeat As IJRtePathFeat, oPos As IJDPosition)
   Debug.Assert (Not oPathFeat Is Nothing)
   Dim x As Double, y As Double, z As Double
   
   oPathFeat.GetLocation x, y, z
   If oPos Is Nothing Then
      Set oPos = New DPosition
   End If
   oPos.Set x, y, z
End Sub

Private Sub PathFeatGetStartLocation(oPathFeat As IJRtePathFeat, oPos As IJDPosition)
   Debug.Assert (Not oPathFeat Is Nothing)
   Dim x As Double, y As Double, z As Double
   
   oPathFeat.GetStartLocation x, y, z
   If oPos Is Nothing Then
      Set oPos = New DPosition
   End If
   oPos.Set x, y, z
End Sub
Private Sub PathFeatGetEndLocation(oPathFeat As IJRtePathFeat, oPos As IJDPosition)
   Debug.Assert (Not oPathFeat Is Nothing)
   Dim x As Double, y As Double, z As Double
   
   oPathFeat.GetEndLocation x, y, z
   If oPos Is Nothing Then
      Set oPos = New DPosition
   End If
   oPos.Set x, y, z
End Sub

