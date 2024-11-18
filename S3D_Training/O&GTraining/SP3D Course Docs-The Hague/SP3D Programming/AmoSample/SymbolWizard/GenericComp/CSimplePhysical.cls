VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CSimplePhysical"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' This class module is the place for user to implement graphical part of VBSymbol for this aspect
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'  Intergraph Copyright(c)2005 . All Rights Reserved.
'
'  "SimplePhysical:".cls
'  Author:        Student
'  Creation Date:  Tuesday, Dec 21 2010
'  Description:
'      This class module is the place for user to implement graphical part of VBSymbol for this aspect
'      TODO - fill in header description information
'
'  Change History:
'  dd.mmm.yyyy    who    change description
'  -----------    ---    ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


Option Explicit
Private Const MODULE = "CGenericComp" 'Used for error messages
Private m_oGeomHelper As IJSymbolGeometryHelper


Private Const E_FAIL = &H80004005
Private Sub Class_Initialize()
    Const METHOD = "Class_Initialize"
    On Error GoTo Errx
    
    Set m_oGeomHelper = New SymbolServices
    
    Exit Sub
    
Errx:
    Err.Raise Err.Number, Err.Source & " " & METHOD, Err.Description, _
        Err.HelpFile, Err.HelpContext
End Sub


Public Sub run(ByVal m_OutputColl As Object, ByRef arrayOfInputs(), arrayOfOutputs() As String)
    
    Const METHOD = "run"
    On Error GoTo ErrorLabel
    
    Dim oPartFclt       As PartFacelets.IJDPart
    Dim pipeDiam        As Double
    Dim flangeThick     As Double
    Dim cptOffset       As Double
    Dim flangeDiam      As Double
    Dim depth           As Double
    Dim CenterPos       As New AutoMath.DPosition

    CenterPos.Set 0, 0, 0
    
    Dim iOutput     As Double
    Dim ObjFABody As Object
    
    Dim parFacetoFace As Double
    Dim parMajorBodyDiameter As Double

' Inputs
    Set oPartFclt = arrayOfInputs(1)
    parFacetoFace = arrayOfInputs(2)
    parMajorBodyDiameter = arrayOfInputs(3)
    m_oGeomHelper.OutputCollection = m_OutputColl
    
    iOutput = 0
 ' Insert your code for output (FABody)
 
    RetrieveParameters 1, oPartFclt, m_OutputColl, pipeDiam, flangeThick, flangeDiam, cptOffset, depth

    Dim stPoint As IJDPosition
    Dim enPoint As IJDPosition
    Set stPoint = New DPosition
    Set enPoint = New DPosition
    stPoint.Set -parFacetoFace / 2 + flangeThick, 0, 0
    enPoint.Set parFacetoFace / 2 - flangeThick, 0, 0
 

' Set the output
    iOutput = iOutput + 1
    Set ObjFABody = m_oGeomHelper.CreateCylinder(arrayOfOutputs(iOutput), stPoint, enPoint, parMajorBodyDiameter)
    Set stPoint = Nothing
    Set enPoint = Nothing
    
' Place Nozzle 1
    
    RetrieveParameters 1, oPartFclt, m_OutputColl, pipeDiam, flangeThick, flangeDiam, cptOffset, depth
    
    Dim oPlacePoint As AutoMath.DPosition
    Dim oDir        As AutoMath.DVector
    Dim objNozzle   As GSCADNozzleEntities.IJDNozzle
    Dim faceToFace  As Double

    Set oPlacePoint = New AutoMath.DPosition
    Set oDir = New AutoMath.DVector
    faceToFace = arrayOfInputs(2)
    oPlacePoint.Set -faceToFace / 2 - cptOffset + depth, 0, 0
    oDir.Set -1, 0, 0
    Set objNozzle = CreateNozzle(1, oPartFclt, m_OutputColl, oDir, oPlacePoint)
' Set the output
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), objNozzle
    Set objNozzle = Nothing
    
' Place Nozzle 2
    RetrieveParameters 2, oPartFclt, m_OutputColl, pipeDiam, flangeThick, flangeDiam, cptOffset, depth
    oPlacePoint.Set faceToFace / 2 + cptOffset - depth, 0, 0
    oDir.Set 1, 0, 0

    Set objNozzle = CreateNozzle(2, oPartFclt, m_OutputColl, oDir, oPlacePoint)

' Set the output
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), objNozzle
    Set objNozzle = Nothing
    Set CenterPos = Nothing
    Set oPlacePoint = Nothing
    Set oDir = Nothing
    Set ObjFABody = Nothing
    
    
Dim oSymbolHelper As IJSymbolGeometryHelper
Set oSymbolHelper = New SP3DSymbolHelper.SymbolServices
oSymbolHelper.OutputCollection = m_OutputColl
On Error Resume Next
Dim oDirX As IJDVector
Dim oDirY As IJDVector
Dim oDirZ As IJDVector
Set oDirX = New DVector
Set oDirY = New DVector
Set oDirZ = New DVector
oDirX.Set 1, 0, 0
oDirY.Set 0, 1, 0

oDirZ.Set 0, 0, 1
Dim oPipeComponent As IJDPipeComponent
Set oPipeComponent = oPartFclt
On Error GoTo ErrorLabel
Dim oOperatorPart As IJDPart
Dim oOperatorOcc As IJPartOcc
If Not oPipeComponent Is Nothing Then
Set oOperatorPart = oPipeComponent.GetValveOperatorPart
If Not oOperatorPart Is Nothing Then
Dim OpOrigin As IJDPosition
Set OpOrigin = New DPosition
OpOrigin.Set 0, 0, 0
Set oOperatorOcc = oSymbolHelper.CreateChildPartOcc("ValveOperator", oOperatorPart, OpOrigin, oDirX, oDirY, oDirZ)
End If
End If
Set oSymbolHelper = Nothing
Set oOperatorPart = Nothing
Set oPipeComponent = Nothing
Set oOperatorOcc = Nothing
    
    
    Exit Sub
    
ErrorLabel:
    Err.Raise Err.Number, Err.Source & " " & METHOD, Err.Description, _
        Err.HelpFile, Err.HelpContext
    Resume Next
    
End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''' This is a sample of placing cylinder and 2 nozzles
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''' Use nozzle 1 as pipe port for flange and pipe parameters
'''    Dim pipeDiam        As Double
'''    Dim flangeThick     As Double
'''    Dim cptOffset       As Double
'''    Dim flangeDiam      As Double
'''    Dim depth           As Double
'''    RetrieveParameters 1, oPartFclt, m_OutputColl, pipeDiam, flangeThick, flangeDiam, cptOffset, depth
'''    Dim parOperatorWidth    As Double
'''    parOperatorWidth = arrayOfInputs(2)
'''    Dim stPoint   As New AutoMath.DPosition
'''    Dim enPoint   As New AutoMath.DPosition
'''    stPoint.Set -parOperatorWidth / 2 + flangeThick, 0, 0
'''    enPoint.Set parOperatorWidth / 2 - flangeThick, 0, 0
'''
'''' Set the output
'''    iOutput = iOutput + 1
'''    m_oGeomHelper.CreateCylinder arrayOfOutputs(iOutput), stPoint, enPoint, pipeDiam
'''    Set stPoint = Nothing
'''    Set enPoint = Nothing
'''
'''    Dim oPlacePoint As AutoMath.DPosition
'''    Dim oDir        As AutoMath.DVector
'''    Dim objNozzle   As GSCADNozzleEntities.IJDNozzle
'''
'''    Set oPlacePoint = New AutoMath.DPosition
'''    Set oDir = New AutoMath.DVector
'''    oPlacePoint.Set -parOperatorWidth / 2 - cptOffset + depth, 0, 0
'''    oDir.Set -1, 0, 0
'''    Set objNozzle = CreateNozzle(1, oPartFclt, m_OutputColl, oDir, oPlacePoint)
'''
'''' Set the output
'''    iOutput = iOutput + 1
'''    m_OutputColl.AddOutput arrayOfOutputs(iOutput), objNozzle
'''    Set objNozzle = Nothing
'''
'''    oPlacePoint.Set parOperatorWidth / 2 + cptOffset - depth, 0, 0
'''    oDir.Set 1, 0, 0
'''
'''    Set objNozzle = CreateNozzle(2, oPartFclt, m_OutputColl, oDir, oPlacePoint)
'''
'''' Set the output
'''    iOutput = iOutput + 1
'''    m_OutputColl.AddOutput arrayOfOutputs(iOutput), objNozzle
'''    Set objNozzle = Nothing
'''    Set oPlacePoint = Nothing
'''    Set oDir = Nothing
'''
Private Sub Class_Terminate()
    Set m_oGeomHelper = Nothing
End Sub
