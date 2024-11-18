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

    Dim parDiameter As Double
    Dim parLength As Double
    Dim ObjBody1 As Object
    Dim ObjBody2 As Object
    Dim ObjBody3 As Object

' Insert your code for inputs
    Set oPartFclt = arrayOfInputs(1)
    parDiameter = arrayOfInputs(2)
    parLength = arrayOfInputs(3)

' Insert your code for output (Body1)
    Dim pPos1 As IJDPosition
    Dim pPos2 As IJDPosition

    Set pPos1 = New DPosition
    Set pPos2 = New DPosition

    pPos1.Set 0, 0, 0
    pPos2.Set parLength, 0, 0
    iOutput = iOutput + 1
    Set ObjBody1 = m_oGeomHelper.CreateCylinder(arrayOfOutputs(iOutput), pPos1, pPos2, parDiameter)

' Insert your code for output (Body2)
    pPos1.Set 0, -parLength / 3, -parLength / 3
    pPos2.Set parLength / 10, parLength / 3, 0
    Set ObjBody2 = PlaceBox(m_OutputColl, pPos1, pPos2)
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), ObjBody2

' Insert your code for output (Body3)
    pPos1.Set parLength - parLength / 10, -parLength / 3, -parLength / 3
    pPos2.Set parLength, parLength / 3, 0
    Set ObjBody3 = PlaceBox(m_OutputColl, pPos1, pPos2)
    iOutput = iOutput + 1
    m_OutputColl.AddOutput arrayOfOutputs(iOutput), ObjBody3

'Release BO 's
    Set ObjBody1 = Nothing
    Set ObjBody2 = Nothing
    Set ObjBody3 = Nothing
    Set pPos1 = Nothing
    Set pPos2 = Nothing
   
    Exit Sub
    
Errx:
    Err.Raise Err.Number, Err.Source & " " & METHOD, Err.Description, _
        Err.HelpFile, Err.HelpContext
End Sub

Private Sub Class_Terminate()
    Set m_oGeomHelper = Nothing
End Sub
