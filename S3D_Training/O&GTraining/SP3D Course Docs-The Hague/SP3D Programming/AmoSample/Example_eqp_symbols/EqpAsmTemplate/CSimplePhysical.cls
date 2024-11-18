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
' Copyright (C) 2005, Intergraph Corporation. All rights reserved.
'
'  "SimplePhysical:".cls
'  Author:        Ramon Him
'  Creation Date:  August 2005
'  Description:
'      This class module is the place for user to implement graphical part of VBSymbol for this aspect
'      TODO - fill in header description information
'
'  Change History:
'  dd.mmm.yyyy    who    change description
'  -----------    ---    ------------------


Option Explicit
Private Const MODULE = "CSimplePhysical" 'Used for error messages
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
    Dim iOutput     As Double
    iOutput = 0
    m_oGeomHelper.OutputCollection = m_OutputColl
    
' Declare variables for Inputs and Outputs
    Dim parLength As Double
    Dim ObjBody1 As Object
    Dim pipeDiam As Double
    Dim flangeThick As Double
    Dim cptOffset As Double
    Dim flangeDiam As Double
    Dim depth As Double
    
    ' Insert your code for inputs
    Set oPartFclt = arrayOfInputs(1)
    parLength = arrayOfInputs(2)
    
    ' Insert your code for output (Body1)
    Dim pPos1 As IJDPosition
    Dim pPos2 As IJDPosition
    Set pPos1 = New DPosition
    Set pPos2 = New DPosition
    pPos1.Set -parLength / 2, -parLength / 2, -parLength / 2
    pPos2.Set parLength / 2, parLength / 2, parLength / 2
    Set ObjBody1 = PlaceBox(m_OutputColl, pPos1, pPos2)
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), ObjBody1
    
    Dim oDir As AutoMath.DVector
    Dim objNozzle As IJDNozzle
    Set oDir = New AutoMath.DVector
    Dim CenterPos As New AutoMath.DPosition
    RetrieveParameters 1, oPartFclt, m_OutputColl, pipeDiam, flangeThick, flangeDiam, cptOffset, depth
    CenterPos.Set 0, 0, parLength - depth + cptOffset
    oDir.Set 0, 0, 1
    
    Set objNozzle = CreateNozzlePHWithLength(1, oPartFclt, m_OutputColl, oDir, CenterPos, parLength - depth + cptOffset)
    
    ' Set the output
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), objNozzle
    
    'Release BO 's

    Set ObjBody1 = Nothing
    Set pPos1 = Nothing
    Set pPos2 = Nothing
    Set objNozzle = Nothing
    Set CenterPos = Nothing
    Set oDir = Nothing
     
   
    Exit Sub
    
Errx:
    Err.Raise Err.Number, Err.Source & " " & METHOD, Err.Description, _
        Err.HelpFile, Err.HelpContext
End Sub

Private Sub Class_Terminate()
    Set m_oGeomHelper = Nothing
End Sub
