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
Private Const MODULE = "CSp3dOP431" 'Used for error messages
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
    On Error GoTo Errx
    
    Dim oPartFclt       As PartFacelets.IJDPart
    Dim CenterPos       As New AutoMath.DPosition

    CenterPos.Set 0, 0, 0
    
    Dim iOutput     As Double
    'Dim ObjOPBody As Object
    
    Dim parOperatorHeight As Double
    Dim parOperatorDiameter As Double

' Inputs
    Set oPartFclt = arrayOfInputs(1)
    parOperatorHeight = arrayOfInputs(2)
    parOperatorDiameter = arrayOfInputs(3)
    m_oGeomHelper.OutputCollection = m_OutputColl
    
    iOutput = 0
 ' Insert your code for output (OPBody)
    Dim ConeCenterBasePt As IJDPosition
    Dim ConeCenterTopPt As IJDPosition
    Set ConeCenterBasePt = New DPosition
    Set ConeCenterTopPt = New DPosition

 ' A value of 0.0000001 is used to avoid symbol placement failure (gives assertion errors).
    ConeCenterTopPt.Set 0, parOperatorHeight, 0
    ConeCenterBasePt.Set 0, 0, 0.0000001
    Dim ObjOPBody As IngrGeom3D.Cone3d

 ' Set the output
    iOutput = iOutput + 1
    
 ' A value of 0.00001 is used to avoid symbol placement failure (gives assertion errors).
    Set ObjOPBody = m_oGeomHelper.CreateCone(arrayOfOutputs(iOutput), ConeCenterBasePt, ConeCenterTopPt, 0.00001, parOperatorDiameter)
    
    Dim oGeomFactory As New IngrGeom3D.GeometryFactory
    Dim oEllipticalArc As IngrGeom3D.EllipticalArc3d
    Dim oRevolution As IngrGeom3D.Revolution3d
    Dim PI As Double
    Dim dRadius As Double
    'Center: 0,opdiameter/2,0
    'Normal: 0,0,1 (North)
    'MajorAxis: 0,radius,0
    'Ratio: 1
    'Start angle: 270
    'Sweep angle 90
    PI = 4 * Atn(1)
    dRadius = parOperatorDiameter / 2
    Set oEllipticalArc = oGeomFactory.EllipticalArcs3d.CreateByCenterNormalMajAxisRatioAngle(Nothing, _
        0, parOperatorHeight, 0, 0, 0, 1, 0, dRadius, 0, _
        1, PI * 1.5, PI / 2)
    Set oRevolution = oGeomFactory.Revolutions3d.CreateByCurve(m_OutputColl.ResourceManager, _
    oEllipticalArc, 0, 1, 0, 0, 0, 0, 2 * PI, False)
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), oRevolution
    Dim oCircle As IngrGeom3D.Circle3d
    Set oCircle = oGeomFactory.Circles3d.CreateByCenterNormalRadius(m_OutputColl.ResourceManager, _
    0, parOperatorHeight, 0, 0, 1, 0, dRadius)
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), oCircle
    Set oCircle = Nothing
    Set oRevolution = Nothing
    Set oEllipticalArc = Nothing
    Set oGeomFactory = Nothing
    Set ConeCenterBasePt = Nothing
    Set ConeCenterTopPt = Nothing
    Set ObjOPBody = Nothing
    
    Exit Sub
    
Errx:
    Err.Raise Err.Number, Err.Source & " " & METHOD, Err.Description, _
        Err.HelpFile, Err.HelpContext
End Sub

Private Sub Class_Terminate()
    Set m_oGeomHelper = Nothing
End Sub
