VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsShow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
 '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2006 Intergraph
'   All Rights Reserved
'
'   clsShow.cls
'   ProgID:         ShowElement.ShowObject
'   Author:         G. Werner
'   Creation Date:  Wednesday, Nov 6, 2006
'   Description:
'       class to show interface specific information of objects
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'    7.Nov.2006     GWE     created
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Explicit




'   clsShow.cls - class to show interface specific information of objects

 

'   clsShow.cls - class to show objects

'Public mcolPrinted As Collection

' Global variables (used in various subroutines)
Private d1 As Double
Private d2 As Double
Private d3 As Double
Private d4 As Double
Private d5 As Double
Private d6 As Double
Private d7 As Double
Private d8 As Double
Private d9 As Double
Private d10 As Double
Private d11 As Double
Private d12 As Double
Private d13 As Double
Private d14 As Double
Private d15 As Double
Private d16 As Double
Private d17 As Double
Private d18 As Double

Private s1 As String
Private s2 As String
Private s3 As String

Private l1 As Long
Private l2 As Long
Private l3 As Long
Private l4 As Long
Private l5 As Long
Private l6 As Long
Private l7 As Long
Private l8 As Long
Private l9 As Long
Private l11 As Long

Private b1 As Boolean
Private b2 As Boolean
Private b3 As Boolean
Private b4 As Boolean
Private b5 As Boolean

Private M1 As IJDT4x4

Private o1 As Object
Private o2 As Object
Private o3 As Object
Private o4 As Object
Private o5 As Object
Private o6 As Object

' Generated Code:

'#function,IJRteCableway
Public Function outputIJRteCableway(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableway
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableway = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,DefaultTransitionLength
   sMsg = "DefaultTransitionLength= "
   sMsg = sMsg & obj.DefaultTransitionLength
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetUsedSpec,ref,IJDCablewaySpec
   sMsg = "*GetUsedSpec"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetUsedSpec
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJRteCableway = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
     
 


'#function,IJRteCableRun
Public Function outputIJRteCableRun(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableRun
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableRun = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,EMICode
   sMsg = "EMICode= "
   sMsg = sMsg & obj.EMICode
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetConnectedEquipments,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetConnectedEquipments=... [ ]")
'#Property,GetSpecificCablePart,ref,IJCablePart
   sMsg = "*GetSpecificCablePart"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSpecificCablePart
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,OperatingVoltage
   sMsg = "OperatingVoltage= "
   sMsg = sMsg & obj.OperatingVoltage
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,RouteStatus
   sMsg = "RouteStatus= "
   sMsg = sMsg & obj.RouteStatus
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SetSpecificCablePart,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetSpecificCablePart=... [ ]")
'#Property,SignalType
   sMsg = "SignalType= "
   sMsg = sMsg & obj.SignalType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Stackable
   sMsg = "Stackable= "
   sMsg = sMsg & obj.Stackable
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
' show the IJRteCableRouter interface
    If TypeOf o Is IJRteCableRouter Then
        Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IJRteCableRouter interface:")
'        Call outputIJRteCableRouter(Form, Node2, o)
    Else
        Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IJRteCableRouter interface missing.")
    End If
'#endspecial
     
  outputIJRteCableRun = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
      



'#function,IJDSpec
Public Function outputIJDSpec(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDSpec
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDSpec = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,SpecName
   sMsg = "SpecName= "
   sMsg = sMsg & obj.SpecName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDSpec = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
      


'#function,IJRtePathFeat
Public Function outputIJRtePathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetAddedPort,ref,IJDistribPort
   sMsg = "*GetAddedPort"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetAddedPort
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetAllMatingParts,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAllMatingParts=... [ ]")
'#Property,GetBaseParts(l1),ref,IJElements
   sMsg = "*GetBaseParts(l1)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetBaseParts(l1)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetEndLocation,fun,ddd
   sMsg = "GetEndLocation= "
   Call obj.GetEndLocation(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetEnumOfflineByType,ref,IJDTargetObjectCol
   sMsg = "*GetEnumOfflineByType"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetEnumOfflineByType
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetFunction
   sMsg = "GetFunction= "
   sMsg = sMsg & obj.GetFunction
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetGenPartOccurs,ref,IJDTargetObjectCol
   sMsg = "*GetGenPartOccurs"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetGenPartOccurs
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetLegs,comment,(ppLeg1 As IJRtePathLeg, ppLeg2 As IJRtePathLeg) As Long
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetLegs=... [ (ppLeg1 As IJRtePathLeg, ppLeg2 As IJRtePathLeg) As Long]")
'#special
' does not work with "Object"
' Property,GetLegs,fun,oo
   sMsg = ""
   Dim oo1 As IJRtePathLeg
   Dim oo2 As IJRtePathLeg
   l1 = obj.GetLegs(oo1, oo2)
   sMsg = "GetLegs= " & "( " & "Par1" & ", " & "Par2" & ")" & sMsg
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)

   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = oo1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = oo2
'#endspecial
'#Property,GetLength
   sMsg = "GetLength= "
   sMsg = sMsg & obj.GetLength
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetLocation,fun,ddd
   sMsg = "GetLocation= "
   Call obj.GetLocation(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetMatingParts,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetMatingParts=... [ ]")
'#Property,GetMFParts,ref,IJDTargetObjectCol
   sMsg = "*GetMFParts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetMFParts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetNamedOfflineFeature,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetNamedOfflineFeature=... [ ]")
'#Property,GetOfflineByType,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetOfflineByType=... [ ]")
'#Property,GetOfflineFeats(),ref,IJDTargetObjectCol
   sMsg = "*GetOfflineFeats()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetOfflineFeats()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetOffsetVector,fun,ddd
   sMsg = "GetOffsetVector= "
   Call obj.GetOffsetVector(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOverride,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetOverride=... [ ]")
'#Property,GetParts,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetParts=... [ ]")
'#special
    sMsg = ""
    Dim oParts As IJElements
    Call obj.GetParts(l1, oParts)
    sMsg = "GetParts(" & l1 & ", par1)"
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
    Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
    Set Node3.Tag = oParts
'#endspecial
'#Property,GetPathFeatFlags,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetPathFeatFlags=... [ ]")
'#Property,GetPathFeatTransientFlags
   sMsg = "GetPathFeatTransientFlags= "
   sMsg = sMsg & obj.GetPathFeatTransientFlags
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPathFeatureObjectType
   sMsg = "GetPathFeatureObjectType= "
   sMsg = sMsg & obj.GetPathFeatureObjectType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPathRun(),ref,IJRtePathRun
   sMsg = "*GetPathRun()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPathRun()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#special
    Dim oSpec As IJDSpec
    sMsg = "*GetSpec"
    Call obj.GetSpec(oSpec)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = oSpec
    Node2.Text = sMsg
'#endspecial
'#Property,GetStartLocation,fun,ddd
   sMsg = "GetStartLocation= "
   Call obj.GetStartLocation(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTapFeats(),ref,IJDTargetObjectCol
   sMsg = "*GetTapFeats()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTapFeats()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetTransitionFlag,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetTransitionFlag=... [ ]")
'#Property,GetTypeAndFunction,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetTypeAndFunction=... [ ]")
'#Property,HasComponents
   sMsg = "HasComponents= "
   sMsg = sMsg & obj.HasComponents
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsMatingFunction,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IsMatingFunction=... [ ]")
'#Property,...,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "...=... [ ]")
'#special
 
 
   
   If TypeOf o Is IJRtePathFeatUtility Then
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IJRtePathFeatUtility")
    Call outputIJRtePathFeatUtility(Form, Node2, o)
   End If
   
'#endspecial
     
  outputIJRtePathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
     
   

'#function,IJRtePathRun
Public Function outputIJRtePathRun(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePathRun
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePathRun = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetConnectionItems() As IJDObjectCollection
   sMsg = "*GetConnectionItems()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnectionItems()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetDistribConnections() As IJDObjectCollection
   sMsg = "*GetDistribConnections()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetDistribConnections()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetLogicalDistribConnections() As IJDObjectCollection
   sMsg = "*GetLogicalDistribConnections()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetLogicalDistribConnections()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetParts() As IJDObjectCollection
   sMsg = "*GetParts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetParts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPathFeatures() As IJDTargetObjectCol
   sMsg = "*GetPathFeatures()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPathFeatures()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSpec() As IJDSpec
   sMsg = "*GetSpec()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSpec()
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJRtePathRun = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJRteEndPathFeat
Public Function outputIJRteEndPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteEndPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteEndPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetConnectToDistribPartOcc() As Unknown
   sMsg = "*GetConnectToDistribPartOcc()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnectToDistribPartOcc()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsIntermediateFeature
   sMsg = "IsIntermediateFeature= "
   sMsg = sMsg & obj.IsIntermediateFeature
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsRunChange,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IsRunChange=... [ ]")
'#Property,RotateAngle
   sMsg = "RotateAngle= "
   sMsg = sMsg & obj.RotateAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SizeReductionPreference
   sMsg = "SizeReductionPreference= "
   sMsg = sMsg & obj.SizeReductionPreference
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRteEndPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRteStraightPathFeat
Public Function outputIJRteStraightPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteStraightPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteStraightPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetInsertedFeatures() As IJElements
   sMsg = "*GetInsertedFeatures()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetInsertedFeatures()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetProjectionEntityForOutline,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetProjectionEntityForOutline=... [ ]")
'#Property,Length
   sMsg = "Length= "
   sMsg = sMsg & obj.Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRteStraightPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJRteTurnPathFeat
Public Function outputIJRteTurnPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteTurnPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteTurnPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,BendAngle
   sMsg = "BendAngle= "
   sMsg = sMsg & obj.BendAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,BendRadius
   sMsg = "BendRadius= "
   sMsg = sMsg & obj.BendRadius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,BRadMulti
   sMsg = "BRadMulti= "
   sMsg = sMsg & obj.BRadMulti
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetNumMiters
   sMsg = "GetNumMiters= "
   sMsg = sMsg & obj.GetNumMiters
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPlaneNormal() As IJDVector
   sMsg = "*GetPlaneNormal()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPlaneNormal()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPrimaryLeg() As IJRtePathLeg
   sMsg = "*GetPrimaryLeg()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPrimaryLeg()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetTangent,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetTangent=... [ ]")
'#Property,GetTurnType,enum,RefDataPipingTurnTypes
   sMsg = "GetTurnType= " & obj.GetTurnType & " [RefDataPipingTurnTypes]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,ThroatRadius
   sMsg = "ThroatRadius= "
   sMsg = sMsg & obj.ThroatRadius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TransientBendAngle,comment,compile error!
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "TransientBendAngle=... [ compile error!]")
     
  outputIJRteTurnPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRteCableEnterExitPathFeat
Public Function outputIJRteCableEnterExitPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableEnterExitPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableEnterExitPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetNormal,fun,ddd
   sMsg = "GetNormal= "
   Call obj.GetNormal(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPortIndex
   sMsg = "GetPortIndex= "
   sMsg = sMsg & obj.GetPortIndex
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTrunkFeature() As IJRtePathFeat
   sMsg = "*GetTrunkFeature()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTrunkFeature()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetTrunkLeg() As IJRtePathLeg
   sMsg = "*GetTrunkLeg()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTrunkLeg()
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJRteCableEnterExitPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

 


'#function,IJRteAlongLegPathFeat
Public Function outputIJRteAlongLegPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteAlongLegPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteAlongLegPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetAfterDistance
   sMsg = "GetAfterDistance= "
   sMsg = sMsg & obj.GetAfterDistance
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetBeforeDistance
   sMsg = "GetBeforeDistance= "
   sMsg = sMsg & obj.GetBeforeDistance
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOffset() As IJDVector
   sMsg = "*GetOffset()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetOffset()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetRotAngle
   sMsg = "GetRotAngle= "
   sMsg = sMsg & obj.GetRotAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsFlipped
   sMsg = "IsFlipped= "
   sMsg = sMsg & obj.IsFlipped
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRteAlongLegPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJRteEntryExitTrunkPathFeat
Public Function outputIJRteEntryExitTrunkPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteEntryExitTrunkPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteEntryExitTrunkPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetNormal,fun,ddd
   sMsg = "GetNormal= "
   Call obj.GetNormal(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPortIndex
   sMsg = "GetPortIndex= "
   sMsg = sMsg & obj.GetPortIndex
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTrunkFeature() As IJRtePathFeat
   sMsg = "*GetTrunkFeature()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTrunkFeature()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetTrunkLeg() As IJRtePathLeg
   sMsg = "*GetTrunkLeg()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTrunkLeg()
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJRteEntryExitTrunkPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRteCableOccur
Public Function outputIJRteCableOccur(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableOccur
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableOccur = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,SpareCableLength
   sMsg = "SpareCableLength= "
   sMsg = sMsg & obj.SpareCableLength
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Straight1Length
   sMsg = "Straight1Length= "
   sMsg = sMsg & obj.Straight1Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Straight2Length
   sMsg = "Straight2Length= "
   sMsg = sMsg & obj.Straight2Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Tail1Length
   sMsg = "Tail1Length= "
   sMsg = sMsg & obj.Tail1Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Tail2Length
   sMsg = "Tail2Length= "
   sMsg = sMsg & obj.Tail2Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRteCableOccur = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


 



'#function,IJDistribConnection
Public Function outputIJDistribConnection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDistribConnection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDistribConnection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetConnectionItems() As IJDTargetObjectCol
   sMsg = "*GetConnectionItems()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnectionItems()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetOtherPorts,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetOtherPorts=... [ ]")
'#Property,GetPorts() As IJDTargetObjectCol
   sMsg = "*GetPorts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPorts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsParent
   sMsg = "IsParent= "
   sMsg = sMsg & obj.IsParent
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDistribConnection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJRtePathLeg
Public Function outputIJRtePathLeg(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePathLeg
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePathLeg = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#special
   Dim oIJRtePathFeat As IJRtePathFeat
   Dim i As Long
   sMsg = "List of features:"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set oIJRtePathFeat = obj.GetFirstFeature()
   While Not oIJRtePathFeat Is Nothing
        i = i + 1
        Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*PathFeat " & i)
        Set o1 = oIJRtePathFeat
        Set Node3.Tag = oIJRtePathFeat
        Set oIJRtePathFeat = obj.GetNextFeature(oIJRtePathFeat)
   Wend
   Set oIJRtePathFeat = Nothing
'#endspecial
'#Property,GetActualSlope
   sMsg = "GetActualSlope= "
   sMsg = sMsg & obj.GetActualSlope
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetAdjacentFeatures,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAdjacentFeatures=... [ ]")
'#Property,GetDirectionAndOffset,fun,dddddd
   sMsg = "GetDirectionAndOffset= "
   Call obj.GetDirectionAndOffset(d1, d2, d3, d4, d5, d6)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetDirectionVector,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetDirectionVector=... [ ]")
'#Property,GetFeatureIndex,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetFeatureIndex=... [ ]")
'#Property,GetFeatures,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetFeatures=... [ ]")
'#Property,GetFirstFeature() As IJRtePathFeat
   sMsg = "*GetFirstFeature()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetFirstFeature()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetInsertedFeatures() As IJElements
   sMsg = "*GetInsertedFeatures()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetInsertedFeatures()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetLastFeature() As IJRtePathFeat
   sMsg = "*GetLastFeature()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetLastFeature()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#special
#If VERSION < 7 Then
'#endspecial
'#Property,GetMinSlope
   sMsg = "GetMinSlope= "
   sMsg = sMsg & obj.GetMinSlope
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
#Else
'#endspecial
'#Property,GetMinSlope,fun,dl
   sMsg = "GetMinSlope= "
   Call obj.GetMinSlope(d1, l2)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & l2 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
#End If
'#endspecial
'#Property,GetNextFeature,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetNextFeature=... [ ]")
'#Property,GetStartEndLocs,fun,dddddd
   sMsg = "GetStartEndLocs= "
   Call obj.GetStartEndLocs(d1, d2, d3, d4, d5, d6)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsSlopeValid
   sMsg = "IsSlopeValid= "
   sMsg = sMsg & obj.IsSlopeValid
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsTopologicalDirectionNormal
   sMsg = "IsTopologicalDirectionNormal= "
   sMsg = sMsg & obj.IsTopologicalDirectionNormal
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Length
   sMsg = "Length= "
   sMsg = sMsg & obj.Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,LengthLocked
   sMsg = "LengthLocked= "
   sMsg = sMsg & obj.LengthLocked
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRtePathLeg = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJCablePart
Public Function outputIJCablePart(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJCablePart
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJCablePart = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CableDiameter
   sMsg = "CableDiameter= "
   sMsg = sMsg & obj.CableDiameter
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,MinBendRadius
   sMsg = "MinBendRadius= "
   sMsg = sMsg & obj.MinBendRadius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,NoOfConductors
   sMsg = "NoOfConductors= "
   sMsg = sMsg & obj.NoOfConductors
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,UnitWeight
   sMsg = "UnitWeight= "
   sMsg = sMsg & obj.UnitWeight
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJCablePart = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRtePathFeatInTrunk
Public Function outputIJRtePathFeatInTrunk(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePathFeatInTrunk
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePathFeatInTrunk = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetBoundaries,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetBoundaries=... [ ]")
'#Property,GetTrunkFeatures() As IJDObjectCollection
   sMsg = "*GetTrunkFeatures()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTrunkFeatures()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsDetermined
   sMsg = "IsDetermined= "
   sMsg = sMsg & obj.IsDetermined
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRtePathFeatInTrunk = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJDPipeSpec
Public Function outputIJDPipeSpec(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDPipeSpec
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDPipeSpec = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetAbsoluteBendRadius,fun,dsd
   sMsg = "GetAbsoluteBendRadius= "
   Call obj.GetAbsoluteBendRadius(d1, s2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & s2 & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetAllComponents,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAllComponents=... [ ]")
'#Property,GetAllowableNPDs,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAllowableNPDs=... [ ]")
'#Property,GetAllowableRoutingAngles,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAllowableRoutingAngles=... [ ]")
'#Property,GetAllowableTurnTypes,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAllowableTurnTypes=... [ ]")
'#Property,GetBendRadiusData,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetBendRadiusData=... [ ]")
'#Property,GetBoltConnectionParts,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetBoltConnectionParts=... [ ]")
'#Property,GetBoltExtensionData,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetBoltExtensionData=... [ ]")
'#Property,GetCorrosionAllowance,fun,ll
   sMsg = "GetCorrosionAllowance= "
   Call obj.GetCorrosionAllowance(l1, l2)
   sMsg = sMsg & "( " & l1 & ", " & l2 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetDefaultPipeOutsideDiameter,fun,ds
   sMsg = "GetDefaultPipeOutsideDiameter= "
   Call obj.GetDefaultPipeOutsideDiameter(d1, s2)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & s2 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,...,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "...=... [ ]")
     
  outputIJDPipeSpec = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJLine
Public Function outputIJLine(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJLine
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJLine = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetDirection,fun,ddd
   sMsg = "GetDirection= "
   Call obj.GetDirection(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetEndPoint,fun,ddd
   sMsg = "GetEndPoint= "
   Call obj.GetEndPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetStartPoint,fun,ddd
   sMsg = "GetStartPoint= "
   Call obj.GetStartPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Infinite
   sMsg = "Infinite= "
   sMsg = sMsg & obj.Infinite
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Length
   sMsg = "Length= "
   sMsg = sMsg & obj.Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJLine = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJArc
Public Function outputIJArc(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJArc
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJArc = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Circumference
   sMsg = "Circumference= "
   sMsg = sMsg & obj.Circumference
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetCenterPoint,fun,ddd
   sMsg = "GetCenterPoint= "
   Call obj.GetCenterPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetEndPoint,fun,ddd
   sMsg = "GetEndPoint= "
   Call obj.GetEndPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property, GetMajorAxis,fun,ddd
   sMsg = " GetMajorAxis= "
   Call obj.GetMajorAxis(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property, GetNormal,fun,ddd
   sMsg = " GetNormal= "
   Call obj.GetNormal(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetStartPoint,fun,ddd
   sMsg = "GetStartPoint= "
   Call obj.GetStartPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Radius
   sMsg = "Radius= "
   sMsg = sMsg & obj.Radius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,StartAngle
   sMsg = "StartAngle= "
   sMsg = sMsg & obj.StartAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SweepAngle
   sMsg = "SweepAngle= "
   sMsg = sMsg & obj.SweepAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJArc = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJRteCablewayPathFeat
Public Function outputIJRteCablewayPathFeat(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCablewayPathFeat
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCablewayPathFeat = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#special
    sMsg = "*GetSelectedSpec"
    Dim ppSelectedSpec As IJDCablewaySpec
    Call obj.GetSelectedSpec(ppSelectedSpec)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = ppSelectedSpec
    Node2.Text = sMsg
'#endspecial
     
  outputIJRteCablewayPathFeat = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'  CHILDS
'============================================================================

'#function,IJSystemChild
Public Function outputIJSystemChild(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJSystemChild
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJSystemChild = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetParent,ref
   sMsg = "*GetParent"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetParent
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJSystemChild = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJDesignChild
Public Function outputIJDesignChild(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDesignChild
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDesignChild = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetParent,ref
   sMsg = "*GetParent"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetParent
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,RelationType,comment,Error accessing in VB!
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RelationType=... [ Error accessing in VB!]")
     
  outputIJDesignChild = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJDesignParent
Public Function outputIJDesignParent(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDesignParent
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDesignParent = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetCount,fun,l
   sMsg = "GetCount= "
   Call obj.GetCount(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
    sMsg = "*GetChildren= "
    Dim ppChildren As IJDObjectCollection
    Call obj.GetChildren(ppChildren)
    sMsg = sMsg & ppChildren.Count
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = ppChildren
    Node2.Text = sMsg
'#endspecial
     
  outputIJDesignParent = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJAssemblyChild
Public Function outputIJAssemblyChild(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJAssemblyChild
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJAssemblyChild = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Index
   sMsg = "Index= "
   sMsg = sMsg & obj.Index
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Locked
   sMsg = "Locked= "
   sMsg = sMsg & obj.Locked
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,MfgParts As IJElements
   sMsg = "*MfgParts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MfgParts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Parent As Unknown
   sMsg = "*Parent"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Parent
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Spaces As IJElements
   sMsg = "*Spaces"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Spaces
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJAssemblyChild = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJElements
Public Function outputIJElements(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJElements
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJElements = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Count
   sMsg = "Count= "
   sMsg = sMsg & obj.Count
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
    sMsg = ""
    Dim oElement As Object
    For Each oElement In obj
        sMsg = "*Object= " & TypeName(oElement)
        Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
        Set Node2.Tag = oElement
        Node2.Text = sMsg
    Next oElement
'#endspecial
     
  outputIJElements = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'' Hanger
'===============================================================================


 



'#function,IJHgrSupport
Public Function outputIJHgrSupport(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrSupport
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrSupport = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CommandType,enum,HgrCmdType
   sMsg = "CommandType= " & obj.CommandType & " [HgrCmdType]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,GetConnectedAssemblyJoints() As Object
   sMsg = "*GetConnectedAssemblyJoints()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnectedAssemblyJoints()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetDesignNextSupportingPort,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetDesignNextSupportingPort=... [ ]")
'#Property,GetFreePortColl,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetFreePortColl=... [ ]")
'#Property,GetSecAssmSelRule,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetSecAssmSelRule=... [ ]")
'#Property,GetSupportInputs,fun,ooo
   sMsg = "GetSupportInputs= "
   Set o1 = Nothing
   Set o2 = Nothing
   Set o3 = Nothing
   Call obj.GetSupportInputs(o1, o2, o3)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ", " & "Par3" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par3")
   Set Node3.Tag = o3
'#Property,GetSupportPosition,fun,ddd
   sMsg = "GetSupportPosition= "
   Call obj.GetSupportPosition(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsBuiltUpAssembly,fun,b
   sMsg = "IsBuiltUpAssembly= "
   Call obj.IsBuiltUpAssembly(b1)
   sMsg = sMsg & "( " & b1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsDesignSupportAssembly,fun,b
   sMsg = "IsDesignSupportAssembly= "
   Call obj.IsDesignSupportAssembly(b1)
   sMsg = sMsg & "( " & b1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsPlacementCommand
   sMsg = "IsPlacementCommand= "
   sMsg = sMsg & obj.IsPlacementCommand
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsStandardSupportAssembly,fun,b
   sMsg = "IsStandardSupportAssembly= "
   Call obj.IsStandardSupportAssembly(b1)
   sMsg = sMsg & "( " & b1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,MaxLoad
   sMsg = "MaxLoad= "
   sMsg = sMsg & obj.MaxLoad
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PrimaryRunName
   sMsg = "PrimaryRunName= "
   sMsg = sMsg & obj.PrimaryRunName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,RouteConnectionEnabled
   sMsg = "RouteConnectionEnabled= "
   sMsg = sMsg & obj.RouteConnectionEnabled
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,StructConnectionEnabled
   sMsg = "StructConnectionEnabled= "
   sMsg = sMsg & obj.StructConnectionEnabled
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,StructFacePosConnectionEnabled
   sMsg = "StructFacePosConnectionEnabled= "
   sMsg = sMsg & obj.StructFacePosConnectionEnabled
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SupportDefinition As Unknown
   sMsg = "*SupportDefinition"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.SupportDefinition
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,TypeSelectionRule
   sMsg = "TypeSelectionRule= "
   sMsg = sMsg & obj.TypeSelectionRule
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
   '
   If TypeOf o Is IJHgrInputObjectInfo Then
     sMsg = "Implements also IJHgrInputObjectInfo"
     Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     Call outputIJHgrInputObjectInfo(Form, Node2, o)
   End If
   If TypeOf o Is IJHgrInputConfigHlpr Then
     sMsg = "Implements also IJHgrInputConfigHlpr"
     Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     Call outputIJHgrInputConfigHlpr(Form, Node2, o)
   End If
   
     sMsg = "Tests for Slab Positions"
     Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Call TestSlabPositions(Form, Node2, o)
   
'#endspecial
     
  outputIJHgrSupport = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'STRUCTS
'=======================================================================

'#function,IJAnalysisChild
Public Function outputIJAnalysisChild(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJAnalysisChild
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJAnalysisChild = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetParent() As Unknown
   sMsg = "*GetParent()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetParent()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,RelationType,comment,GUID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RelationType=... [ GUID]")
     
  outputIJAnalysisChild = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

 



'#function,ISPSCrossSection
Public Function outputISPSCrossSection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSCrossSection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSCrossSection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CardinalPoint
   sMsg = "CardinalPoint= "
   sMsg = sMsg & obj.CardinalPoint
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Definition As IJCrossSection
   sMsg = "*Definition"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Definition
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetCardinalPointOffset,fun,ddd
   sMsg = "GetCardinalPointOffset= "
   Call obj.GetCardinalPointOffset(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SectionName
   sMsg = "SectionName= "
   sMsg = sMsg & obj.SectionName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SectionStandard
   sMsg = "SectionStandard= "
   sMsg = sMsg & obj.SectionStandard
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SectionType
   sMsg = "SectionType= "
   sMsg = sMsg & obj.SectionType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Symbol As Object
   sMsg = "*Symbol"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Symbol
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSCrossSection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,ISPSAxisRotation
Public Function outputISPSAxisRotation(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSAxisRotation
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSAxisRotation = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,BetaAngle
   sMsg = "BetaAngle= "
   sMsg = sMsg & obj.BetaAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Control As Object
   sMsg = "*Control"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Control
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetOrientationVector,fun,ddd
   sMsg = "GetOrientationVector= "
   Call obj.GetOrientationVector(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTransform,fun,M
   sMsg = "GetTransform= "
   Call obj.GetTransform(M1)
   sMsg = sMsg & "( " & outputIJDT4x4(M1) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTransformAtPosition,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetTransformAtPosition=... [ ]")
'#Property,Mirror
   sMsg = "Mirror= "
   sMsg = sMsg & obj.Mirror
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SetOrientationVector,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetOrientationVector=... [ ]")
     
  outputISPSAxisRotation = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,ISPSMemberPartPrismatic
Public Function outputISPSMemberPartPrismatic(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSMemberPartPrismatic
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSMemberPartPrismatic = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,AddCutbackSurface,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "AddCutbackSurface=... [ ]")
'#Property,Axis As IJCurve
   sMsg = "*Axis"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Axis
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,AxisPort(SPSMemberAxisStart) As ISPSSplitAxisPort
   sMsg = "*AxisPort(SPSMemberAxisStart)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.AxisPort(SPSMemberAxisStart)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,AxisPort(SPSMemberAxisEnd) As ISPSSplitAxisPort
   sMsg = "*AxisPort(SPSMemberAxisEnd)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.AxisPort(SPSMemberAxisEnd)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,AxisPort(SPSMemberAxisAlong) As ISPSSplitAxisPort
   sMsg = "*AxisPort(SPSMemberAxisAlong)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.AxisPort(SPSMemberAxisAlong)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,CrossSection As ISPSCrossSection
   sMsg = "*CrossSection"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.CrossSection
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Cutbacks(SPSMemberAxisStart) As IJElements
   sMsg = "*Cutbacks(SPSMemberAxisStart)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Cutbacks(SPSMemberAxisStart)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Cutbacks(SPSMemberAxisEnd) As IJElements
   sMsg = "*Cutbacks(SPSMemberAxisEnd)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Cutbacks(SPSMemberAxisEnd)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Cutbacks(SPSMemberAxisAlong) As IJElements
   sMsg = "*Cutbacks(SPSMemberAxisAlong)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Cutbacks(SPSMemberAxisAlong)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,CutLength
   sMsg = "CutLength= "
   sMsg = sMsg & obj.CutLength
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetEndFacePositions,fun,dddddddddddd
   sMsg = "GetEndFacePositions= "
   Call obj.GetEndFacePositions(d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ", " & sDouble(d7) & ", " & sDouble(d8) & ", " & sDouble(d9) & ", " & sDouble(d10) & ", " & sDouble(d11) & ", " & sDouble(d12) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Loads As IJElements
   sMsg = "*Loads"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Loads
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MaterialDefinition As IJDMaterial
   sMsg = "*MaterialDefinition"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MaterialDefinition
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MemberReleases As ISPSMemberReleases
   sMsg = "*MemberReleases"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MemberReleases
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MemberSystem As ISPSMemberSystem
   sMsg = "*MemberSystem"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MemberSystem
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MemberType As ISPSMemberType
   sMsg = "*MemberType"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MemberType
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PointAtEnd(SPSMemberAxisStart) As IJPoint
   sMsg = "*PointAtEnd(SPSMemberAxisStart)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PointAtEnd(SPSMemberAxisStart)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PointAtEnd(SPSMemberAxisEnd) As IJPoint
   sMsg = "*PointAtEnd(SPSMemberAxisEnd)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PointAtEnd(SPSMemberAxisEnd)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PointAtEnd(SPSMemberAxisAlong) As IJPoint
   sMsg = "*PointAtEnd(SPSMemberAxisAlong)"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PointAtEnd(SPSMemberAxisAlong)
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Rotation As ISPSAxisRotation
   sMsg = "*Rotation"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Rotation
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSMemberPartPrismatic = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,ISPSMemberSystem
Public Function outputISPSMemberSystem(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSMemberSystem
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSMemberSystem = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Continuity As IJStructContinuity2
   sMsg = "*Continuity"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Continuity
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,DesignParent As IJDesignParent
   sMsg = "*DesignParent"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.DesignParent
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,DesignPartAtEnd,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "DesignPartAtEnd=... [ ]")
'#Property,DesignParts As IJElements
   sMsg = "*DesignParts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.DesignParts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,DesignSeams As IJElements
   sMsg = "*DesignSeams"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.DesignSeams
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,LogicalAxis As ISPSLogicalAxis
   sMsg = "*LogicalAxis"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.LogicalAxis
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MemberType As ISPSMemberType
   sMsg = "*MemberType"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MemberType
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PhysicalAxis As IJCurve
   sMsg = "*PhysicalAxis"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PhysicalAxis
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PointOnJoints As IJElements
   sMsg = "*PointOnJoints"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PointOnJoints
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Rotation As ISPSAxisRotation
   sMsg = "*Rotation"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Rotation
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,SplitConnections As IJElements
   sMsg = "*SplitConnections"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.SplitConnections
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSMemberSystem = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJCurve
Public Function outputIJCurve(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJCurve
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJCurve = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Area
   sMsg = "Area= "
   sMsg = sMsg & obj.Area
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Centroid,fun,ddd
   sMsg = "Centroid= "
   Call obj.Centroid(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,EndPoints,fun,dddddd
   sMsg = "EndPoints= "
   Call obj.EndPoints(d1, d2, d3, d4, d5, d6)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Form,enum,Geom3dCurveFormConstants
   sMsg = "Form= " & obj.Form & " [Geom3dCurveFormConstants]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,Length
   sMsg = "Length= "
   sMsg = sMsg & obj.Length
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Normal,fun,lddd
   sMsg = "Normal= "
   Call obj.Normal(l1, d2, d3, d4)
   sMsg = sMsg & "( " & l1 & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ParamRange,fun,dd
   sMsg = "ParamRange= "
   Call obj.ParamRange(d1, d2)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Scope,enum,Geom3dCurveScopeConstants
   sMsg = "Scope= " & obj.Scope & " [Geom3dCurveScopeConstants]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
     
  outputIJCurve = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJDObject
Public Function outputIJDObject(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDObject
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDObject = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,AccessControl,enum,AccessControlConstant
   sMsg = "AccessControl= " & obj.AccessControl & " [AccessControlConstant]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,ApprovalReason
   sMsg = "ApprovalReason= "
   sMsg = sMsg & obj.ApprovalReason
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ApprovalStatus,enum,ApprovalStatusValue
   sMsg = "ApprovalStatus= " & obj.ApprovalStatus & " [ApprovalStatusValue]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,DateCreated
   sMsg = "DateCreated= "
   sMsg = sMsg & obj.DateCreated
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DateLastModified
   sMsg = "DateLastModified= "
   sMsg = sMsg & obj.DateLastModified
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PermissionGroup
   sMsg = "PermissionGroup= "
   sMsg = sMsg & obj.PermissionGroup
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ProjectID
   sMsg = "ProjectID= "
   sMsg = sMsg & obj.ProjectID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,UserCreated
   sMsg = "UserCreated= "
   sMsg = sMsg & obj.UserCreated
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,UserLastModified
   sMsg = "UserLastModified= "
   sMsg = sMsg & obj.UserLastModified
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDObject = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJDOutfittingCrossSection
Public Function outputIJDOutfittingCrossSection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDOutfittingCrossSection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDOutfittingCrossSection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CornerRadius
   sMsg = "CornerRadius= "
   sMsg = sMsg & obj.CornerRadius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CrossSectionShape
   sMsg = "CrossSectionShape= "
   sMsg = sMsg & obj.CrossSectionShape
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Depth
   sMsg = "Depth= "
   sMsg = sMsg & obj.Depth
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DimensionBaseOuter
   sMsg = "DimensionBaseOuter= "
   sMsg = sMsg & obj.DimensionBaseOuter
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetShape
   sMsg = "GetShape= "
   sMsg = sMsg & obj.GetShape
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetSymbolDefinition
   sMsg = "GetSymbolDefinition= "
   sMsg = sMsg & obj.GetSymbolDefinition
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Width
   sMsg = "Width= "
   sMsg = sMsg & obj.Width
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDOutfittingCrossSection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJPort
Public Function outputIJPort(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJPort
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJPort = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Connectable As IJConnectable
   sMsg = "*Connectable"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Connectable
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Geometry As Object
   sMsg = "*Geometry"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Geometry
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Type
   sMsg = "Type= "
   sMsg = sMsg & obj.Type
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJPort = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRteCrossSectOccur
Public Function outputIJRteCrossSectOccur(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCrossSectOccur
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCrossSectOccur = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetOrientation,fun,dddddd
   sMsg = "GetOrientation= "
   Call obj.GetOrientation(d1, d2, d3, d4, d5, d6)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOutline() As IJCurve
   sMsg = "*GetOutline()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetOutline()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetParameters,fun,lddd
   sMsg = "GetParameters= "
   Call obj.GetParameters(l1, d2, d3, d4)
   sMsg = sMsg & "( " & l1 & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetRefDataCrossSect() As IJDOutfittingCrossSection
   sMsg = "*GetRefDataCrossSect()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetRefDataCrossSect()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsDimBaseOuter
   sMsg = "IsDimBaseOuter= "
   sMsg = sMsg & obj.IsDimBaseOuter
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,OrientationAngle
   sMsg = "OrientationAngle= "
   sMsg = sMsg & obj.OrientationAngle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
     
  outputIJRteCrossSectOccur = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJPartOcc
Public Function outputIJPartOcc(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJPartOcc
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJPartOcc = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetMatrix,fun,M
   sMsg = "GetMatrix= "
   Call obj.GetMatrix(M1)
   sMsg = sMsg & "( " & outputIJDT4x4(M1) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOrigin,fun,ddd
   sMsg = "GetOrigin= "
   Call obj.GetOrigin(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
    Dim oIJDPart As IJDPart
    sMsg = "*GetPart"
    Call obj.GetPart(oIJDPart)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = oIJDPart
    Node2.Text = sMsg
'#endspecial
     
  outputIJPartOcc = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJDPart
Public Function outputIJDPart(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDPart
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDPart = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetNozzles,ref
   sMsg = "*GetNozzles"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetNozzles
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPartCLSID
   sMsg = "GetPartCLSID= "
   sMsg = sMsg & obj.GetPartCLSID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPartIID
   sMsg = "GetPartIID= "
   sMsg = sMsg & obj.GetPartIID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPartOccCLSID
   sMsg = "GetPartOccCLSID= "
   sMsg = sMsg & obj.GetPartOccCLSID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPartOccIID
   sMsg = "GetPartOccIID= "
   sMsg = sMsg & obj.GetPartOccIID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetRelatedPartClassName
   sMsg = "GetRelatedPartClassName= "
   sMsg = sMsg & obj.GetRelatedPartClassName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetReplacementParts() As IJDCollection
   sMsg = "*GetReplacementParts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetReplacementParts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MirrorBehaviorOption
   sMsg = "MirrorBehaviorOption= "
   sMsg = sMsg & obj.MirrorBehaviorOption
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PartDescription
   sMsg = "PartDescription= "
   sMsg = sMsg & obj.PartDescription
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PartNumber
   sMsg = "PartNumber= "
   sMsg = sMsg & obj.PartNumber
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDPart = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJNamedItem
Public Function outputIJNamedItem(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJNamedItem
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJNamedItem = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Icon,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Icon=... [ ]")
'#Property,IconID
   sMsg = "IconID= "
   sMsg = sMsg & obj.IconID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IIDforTypeString,comment, As GUID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IIDforTypeString=... [  As GUID]")
'#Property,InternalTypeString
   sMsg = "InternalTypeString= "
   sMsg = sMsg & obj.InternalTypeString
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Name
   sMsg = "Name= "
   sMsg = sMsg & obj.Name
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TypeString
   sMsg = "TypeString= "
   sMsg = sMsg & obj.TypeString
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJNamedItem = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJSmartOccurrence
Public Function outputIJSmartOccurrence(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJSmartOccurrence
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJSmartOccurrence = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Item
   sMsg = "Item= "
   sMsg = sMsg & obj.Item
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ItemObject As Object
   sMsg = "*ItemObject"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ItemObject
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,RootSelection
   sMsg = "RootSelection= "
   sMsg = sMsg & obj.RootSelection
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,RootSelectionObject As Object
   sMsg = "*RootSelectionObject"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.RootSelectionObject
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJSmartOccurrence = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJSystem
Public Function outputIJSystem(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJSystem
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJSystem = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CountSystemsBelow,fun,lll
   sMsg = "CountSystemsBelow= "
   Call obj.CountSystemsBelow(l1, l2, l3)
   sMsg = sMsg & "( " & l1 & ", " & l2 & ", " & l3 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetChildren() As IJDTargetObjectCol
   sMsg = "*GetChildren()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetChildren()
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJSystem = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJHgrPart
Public Function outputIJHgrPart(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrPart
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrPart = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CrossSection,ref
   sMsg = "*CrossSection"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.CrossSection
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetMaterialGivenTypeAndGrade,fun,ss
   sMsg = "GetMaterialGivenTypeAndGrade= "
   Call obj.GetMaterialGivenTypeAndGrade(s1, s2)
   sMsg = sMsg & "( " & s1 & ", " & s2 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Material,ref
   sMsg = "*Material"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Material
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,PartType
   sMsg = "PartType= "
   sMsg = sMsg & obj.PartType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PipeStock,ref
   sMsg = "*PipeStock"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.PipeStock
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJHgrPart = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJDSymbol
Public Function outputIJDSymbol(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDSymbol
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDSymbol = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,IJDInputsArg,ref
   sMsg = "*IJDInputsArg"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.IJDInputsArg
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IJDReferencesArg,ref
   sMsg = "*IJDReferencesArg"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.IJDReferencesArg
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IJDSymbolDefinition,comment,(readWriteMode As Integer) As IJDSymbolDefinition
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "IJDSymbolDefinition=... [ (readWriteMode As Integer) As IJDSymbolDefinition]")
'#Property,IJDValuesArg,ref
   sMsg = "*IJDValuesArg"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.IJDValuesArg
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ReplaceDefinition,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ReplaceDefinition=... [ ]")
     
  outputIJDSymbol = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJHgrSupportComponent
Public Function outputIJHgrSupportComponent(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrSupportComponent
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrSupportComponent = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetComponentConnections,ref
   sMsg = "*GetComponentConnections"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetComponentConnections
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetConnectionPorts,ref
   sMsg = "*GetConnectionPorts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnectionPorts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetHgrConnectionPorts,ref
   sMsg = "*GetHgrConnectionPorts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetHgrConnectionPorts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetOccAssembly,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetOccAssembly=... [ ]")
'#Property,GetPartCrossSection,ref
   sMsg = "*GetPartCrossSection"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPartCrossSection
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPartPipeStock,ref
   sMsg = "*GetPartPipeStock"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPartPipeStock
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSymbolOutputByName,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetSymbolOutputByName=... [ ]")
'#Property,RouteIndex
   sMsg = "RouteIndex= "
   sMsg = sMsg & obj.RouteIndex
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,StructIndex
   sMsg = "StructIndex= "
   sMsg = sMsg & obj.StructIndex
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SupportDetailNumber
   sMsg = "SupportDetailNumber= "
   sMsg = sMsg & obj.SupportDetailNumber
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJHgrSupportComponent = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJHgrBOM
Public Function outputIJHgrBOM(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrBOM
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrBOM = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,BOMdescription
   sMsg = "BOMdescription= "
   sMsg = sMsg & obj.BOMdescription
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJHgrBOM = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJHgrConnComponent
Public Function outputIJHgrConnComponent(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrConnComponent
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrConnComponent = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#special
#If VERSION > 6 Then
    Dim i As Long
    Dim pIJSymbolUtilHngSup As SymbolUtilHngSup
    Set pIJSymbolUtilHngSup = CreateObject("SupportEntityUtil.SymbolUtilHngSup")
    Dim pIJDSymbol  As IJDSymbol
    Dim pPortElems  As IJElements
    Set pIJDSymbol = o
    Set pPortElems = pIJSymbolUtilHngSup.GetHgrSymbolPorts(pIJDSymbol)

    sMsg = "GetHgrSymbolPorts returns ports=" & pPortElems.Count
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)

    For i = 1 To pPortElems.Count
        sMsg = "*GetHgrSymbolPorts" & i
        Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
        Set Node2.Tag = pPortElems.Item(i)
    Next i
#End If
'#endspecial
     
  outputIJHgrConnComponent = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction





'#function,IJHgrPort
Public Function outputIJHgrPort(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrPort
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrPort = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Category,enum,HgrSymbolPortCategory
   sMsg = "Category= " & obj.Category & " [HgrSymbolPortCategory]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,ConnectionInfo
   sMsg = "ConnectionInfo= "
   sMsg = sMsg & obj.ConnectionInfo
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOrientation,fun,ddddddddd
   sMsg = "GetOrientation= "
   Call obj.GetOrientation(d1, d2, d3, d4, d5, d6, d7, d8, d9)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ", " & sDouble(d7) & ", " & sDouble(d8) & ", " & sDouble(d9) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#special
    sMsg = "*Port: " & obj.Name & " at: " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & _
    ", xaxis= " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & _
    ", yaxis= " & sDouble(d7) & ", " & sDouble(d8) & ", " & sDouble(d9)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#endspecial
'#Property,MatingType
   sMsg = "MatingType= "
   sMsg = sMsg & obj.MatingType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,MaxSize
   sMsg = "MaxSize= "
   sMsg = sMsg & obj.MaxSize
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,MinSize
   sMsg = "MinSize= "
   sMsg = sMsg & obj.MinSize
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Name
   sMsg = "Name= "
   sMsg = sMsg & obj.Name
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PortType
   sMsg = "PortType= "
   sMsg = sMsg & obj.PortType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Size
   sMsg = "Size= "
   sMsg = sMsg & obj.Size
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SupportComponent As Object
   sMsg = "*SupportComponent"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.SupportComponent
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Type,enum,HgrPortType
   sMsg = "Type= " & obj.Type & " [HgrPortType]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,UnitType
   sMsg = "UnitType= "
   sMsg = sMsg & obj.UnitType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,
'#Property,
'#Property,
'#Property,
     
  outputIJHgrPort = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,ISPSSlabsDefinition
Public Function outputISPSSlabsDefinition(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSSlabsDefinition
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSSlabsDefinition = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Contour As Object
   sMsg = "*Contour"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Contour
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#special
    Dim oIJElements As IJElements
    Dim dOverhang() As Double
    Dim ePortFacePosition() As PortFacePosition
    Dim i As Long
    Dim s As String
    
    sMsg = "*GetBoundaryInfo(ppBoundaryObject.."
    Call obj.GetBoundaryInfo(oIJElements, dOverhang, ePortFacePosition)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = oIJElements
    Node2.Text = sMsg
    
    sMsg = "GetBoundaryInfo(..dOverhang..=" & JoinDouble(dOverhang)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Node2.Text = sMsg
    
    For i = LBound(ePortFacePosition) To UBound(ePortFacePosition)
        s = s & ", " & ePortFacePosition(i)
    Next i
    
    sMsg = "GetBoundaryInfo(..ePortFacePosition)= (" & s & " )"
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Node2.Text = sMsg
    
'#endspecial
'#special
    Dim eSupportMethod As StructPlaneType
    Dim dSupportParameter As Double
    sMsg = "*GetSupportInfo() ="
    Call obj.GetSupportInfo(oIJElements, eSupportMethod, dSupportParameter)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    Set Node2.Tag = oIJElements
    sMsg = sMsg & " eSupportMethod=" & eSupportMethod & " dSupportParameter=" & dSupportParameter
    Node2.Text = sMsg
'#endspecial
'#Property,GetSupportInfo,comment,(ppSupportObject As IJElements, eSupportMethod As StructPlaneType, dSupportParameter As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetSupportInfo=... [ (ppSupportObject As IJElements, eSupportMethod As StructPlaneType, dSupportParameter As Double)]")
'#special
    Dim oSlabFacePosition As SlabFacePosition
    sMsg = "GetPositioningInfo ="
    Call obj.GetPositioningInfo(oSlabFacePosition)
    Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
    sMsg = sMsg & oSlabFacePosition
    Node2.Text = sMsg
'#endspecial
'#Property,SupportMethod,enum,StructPlaneType
   sMsg = "SupportMethod= " & obj.SupportMethod & " [StructPlaneType]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,SupportParameter
   sMsg = "SupportParameter= "
   sMsg = sMsg & obj.SupportParameter
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Supports As IJElements
   sMsg = "*Supports"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Supports
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSSlabsDefinition = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,ISPSSlabsComposition
Public Function outputISPSSlabsComposition(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSSlabsComposition
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSSlabsComposition = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,LayerCount
   sMsg = "LayerCount= "
   sMsg = sMsg & obj.LayerCount
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Layers As IJElements
   sMsg = "*Layers"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Layers
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ReferenceLayer
   sMsg = "ReferenceLayer= "
   sMsg = sMsg & obj.ReferenceLayer
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputISPSSlabsComposition = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,ISPSSlabProperties
Public Function outputISPSSlabProperties(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSSlabProperties
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSSlabProperties = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Angle
   sMsg = "Angle= "
   sMsg = sMsg & obj.Angle
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,BOC
   sMsg = "BOC= "
   sMsg = sMsg & obj.BOC
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CGX
   sMsg = "CGX= "
   sMsg = sMsg & obj.CGX
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CGY
   sMsg = "CGY= "
   sMsg = sMsg & obj.CGY
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CGZ
   sMsg = "CGZ= "
   sMsg = sMsg & obj.CGZ
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DeltaZ
   sMsg = "DeltaZ= "
   sMsg = sMsg & obj.DeltaZ
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetSlabProperties,comment,(TotalVolume As Double, NetVolume As Double, TotalSurface As Double, NetSurface As Double, TotalProjectedArea As Double, NetProjectedArea As Double, CGX As Double, CGY As Double, CGZ As Double, weight As Double, Openings As Long, Angle As Double, Slope As Double, LowPoint As Double, HighPoint As Double, DeltaZ As Double, BOC As Double, TOC As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetSlabProperties=... [ (TotalVolume As Double, NetVolume As Double, TotalSurface As Double, NetSurface As Double, TotalProjectedArea As Double, NetProjectedArea As Double, CGX As Double, CGY As Double, CGZ As Double, weight As Double, Openings As Long, Angle As Double, Slope As Double, LowPoint As Double, HighPoint As Double, DeltaZ As Double, BOC As Double, TOC As Double)]")
'#Property,GetSlabProperties,fun,ddddddddddlddddddd
   sMsg = "GetSlabProperties= "
   Call obj.GetSlabProperties(d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, l11, d12, d13, d14, d15, d16, d17, d18)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ", " & sDouble(d7) & ", " & sDouble(d8) & ", " & sDouble(d9) & ", " & sDouble(d10) & ", " & l11 & ", " & sDouble(d12) & ", " & sDouble(d13) & ", " & sDouble(d14) & ", " & sDouble(d15) & ", " & sDouble(d16) & ", " & sDouble(d17) & ", " & sDouble(d18) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,HighPoint
   sMsg = "HighPoint= "
   sMsg = sMsg & obj.HighPoint
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,LowPoint
   sMsg = "LowPoint= "
   sMsg = sMsg & obj.LowPoint
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,NetProjectedArea
   sMsg = "NetProjectedArea= "
   sMsg = sMsg & obj.NetProjectedArea
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,NetSurface
   sMsg = "NetSurface= "
   sMsg = sMsg & obj.NetSurface
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,NetVolume
   sMsg = "NetVolume= "
   sMsg = sMsg & obj.NetVolume
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Openings
   sMsg = "Openings= "
   sMsg = sMsg & obj.Openings
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Slope
   sMsg = "Slope= "
   sMsg = sMsg & obj.Slope
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TOC
   sMsg = "TOC= "
   sMsg = sMsg & obj.TOC
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TotalProjectedArea
   sMsg = "TotalProjectedArea= "
   sMsg = sMsg & obj.TotalProjectedArea
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TotalSurface
   sMsg = "TotalSurface= "
   sMsg = sMsg & obj.TotalSurface
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,TotalVolume
   sMsg = "TotalVolume= "
   sMsg = sMsg & obj.TotalVolume
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,weight
   sMsg = "weight= "
   sMsg = sMsg & obj.Weight
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputISPSSlabProperties = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,ISPSSlabEntity
Public Function outputISPSSlabEntity(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSSlabEntity
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSSlabEntity = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Boundaries As ISPSSlabBoundaries
   sMsg = "*Boundaries"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Boundaries
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,CompositionType As Unknown
   sMsg = "*CompositionType"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.CompositionType
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GeneralType As Unknown
   sMsg = "*GeneralType"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GeneralType
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSSlabEntity = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJEquipment
Public Function outputIJEquipment(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJEquipment
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJEquipment = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Description
   sMsg = "Description= "
   sMsg = sMsg & obj.Description
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetMatrix,fun,M
   sMsg = "GetMatrix= "
   Call obj.GetMatrix(M1)
   sMsg = sMsg & "( " & outputIJDT4x4(M1) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPosition,fun,ddd
   sMsg = "GetPosition= "
   Call obj.GetPosition(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SetMatrix,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetMatrix=... [ ]")
'#Property,SetPosition,comment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetPosition=... [ ]")
     
  outputIJEquipment = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJAssembly
Public Function outputIJAssembly(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJAssembly
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJAssembly = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,AddChild,comment,(pChild As IJAssemblyChild)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "AddChild=... [ (pChild As IJAssemblyChild)]")
'#Property,countChildren
   sMsg = "countChildren= "
   sMsg = sMsg & obj.CountChildren
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CountSubAssemblies
   sMsg = "CountSubAssemblies= "
   sMsg = sMsg & obj.CountSubAssemblies
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetChildren() As IJDTargetObjectCol
   sMsg = "*GetChildren()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetChildren()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,InsertChild,comment,(Child As IJAssemblyChild, index As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "InsertChild=... [ (Child As IJAssemblyChild, index As Long)]")
'#Property,ProcessAssignment,comment,As IJProcessAssignment
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ProcessAssignment=... [ As IJProcessAssignment]")
'#Property,RemoveChild,comment,(pChild As IJAssemblyChild)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RemoveChild=... [ (pChild As IJAssemblyChild)]")
     
  outputIJAssembly = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJStructGraphConnectable
Public Function outputIJStructGraphConnectable(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJStructGraphConnectable
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJStructGraphConnectable = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#special
  Dim vOperation As Variant
'#endspecial
'#Property,FindPortsByMonikerId,fun,o"PortCenterline, -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortCenterline, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortCenterline, -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,FindPortsByMonikerId,fun,o"PortEdge, -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortEdge, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortEdge, -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,FindPortsByMonikerId,fun,o"PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,FindPortsByMonikerId,fun,o"PortEnd , -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortEnd, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortEnd , -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,FindPortsByMonikerId,fun,o"PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortFace, -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,FindPortsByMonikerId,fun,o"PortNozzle , -1, -1, 512, -1, CurrentGeometry, vOperation"
   sMsg = "FindPortsByMonikerId= "
   Set o1 = Nothing
   Call obj.FindPortsByMonikerId(o1, PortNozzle, -1, -1, 512, -1, CurrentGeometry, vOperation)
   sMsg = sMsg & "( " & "Par1" & ", " & "PortNozzle , -1, -1, 512, -1, CurrentGeometry, vOperation" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,
     
  outputIJStructGraphConnectable = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJAppConnection
Public Function outputIJAppConnection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJAppConnection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJAppConnection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property, findPort,comment,(pObject As IJConnectable, ppPort As IJPort)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , " findPort=... [ (pObject As IJConnectable, ppPort As IJPort)]")
'#Property, findPort,fun,oo
   sMsg = " findPort= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.findPort(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
     
  outputIJAppConnection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJConnectable
Public Function outputIJConnectable(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJConnectable
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJConnectable = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,enumConnectablePorts,comment,(ppEnumPorts As IJElements, [filterType As PortType = PortEdge])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "enumConnectablePorts=... [ (ppEnumPorts As IJElements, [filterType As PortType = PortEdge])]")
'#Property,enumConnectablePorts,fun,o
   sMsg = "enumConnectablePorts= "
   Set o1 = Nothing
   Call obj.enumConnectablePorts(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,enumPorts,comment,(ppEnumPorts As IJElements, [filterType As PortType = PortEdge])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "enumPorts=... [ (ppEnumPorts As IJElements, [filterType As PortType = PortEdge])]")
'#special
'  enumPorts(*par, code)
'#Property,enumPorts,fun,o
    Dim iii As Long
    Dim ip As Long
    Dim sT As String
    For iii = 0 To 4
            sMsg = ""
            ip = 2 ^ iii
            Select Case ip
            Case 1
                sT = "PortEdge"
            Case 2
                sT = "PortEnd"
            Case 4
                sT = "PortFace"
            Case 8
                sT = "PortNozzle"
            Case 16
                sT = "PortCenterline"
            End Select
            Set o1 = Nothing
            Call obj.enumPorts(o1, ip)
            sMsg = "enumPorts= " & "( " & "Par1" & ", " & sT & ")" & sMsg
            Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
            Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
            Set Node3.Tag = o1
    Next iii
'#endspecial
'#Property,isConnectedTo,comment,(pObject As IJConnectable, pFlag As Boolean, ppEnumConnections As IJElements)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "isConnectedTo=... [ (pObject As IJConnectable, pFlag As Boolean, ppEnumConnections As IJElements)]")
'#Property,isConnectedTo,fun,obo
   sMsg = "isConnectedTo= "
   Set o1 = Nothing
   Set o3 = Nothing
   Call obj.isConnectedTo(o1, b2, o3)
   sMsg = sMsg & "( " & "Par1" & ", " & b2 & ", " & "Par3" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par3")
   Set Node3.Tag = o3
     
  outputIJConnectable = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJKeyPoint
Public Function outputIJKeyPoint(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJKeyPoint
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJKeyPoint = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetKeyPoint,comment,(nIndex As Long, x As Double, y As Double, z As Double, KeyPointType As KeyPointType, HandleType As HandleType)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetKeyPoint=... [ (nIndex As Long, x As Double, y As Double, z As Double, KeyPointType As KeyPointType, HandleType As HandleType)]")
'#Property,GetKeyPoint,fun,"1,"dddll
   sMsg = "GetKeyPoint= "
   Call obj.GetKeyPoint(1, d5, d6, d7, l8, l9)
   sMsg = sMsg & "( " & "1," & ", " & sDouble(d5) & ", " & sDouble(d6) & ", " & sDouble(d7) & ", " & l8 & ", " & l9 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,KeyPointCount
   sMsg = "KeyPointCount= "
   sMsg = sMsg & obj.KeyPointCount
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJKeyPoint = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJHgrInputObjectInfo
Public Function outputIJHgrInputObjectInfo(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrInputObjectInfo
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrInputObjectInfo = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetAttributeByRule,comment,(RuleName As String, [pInputContext As Object]) As Variant()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetAttributeByRule=... [ (RuleName As String, [pInputContext As Object]) As Variant()]")
'#Property,GetCommandType
   sMsg = "GetCommandType= "
   sMsg = sMsg & obj.GetCommandType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetInsulationData,comment,(index As Long, lInsulationPurpose As Long, lInsulationMaterial As Long, dInsulationThickness As Double, pbIsInsulated As Boolean)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetInsulationData=... [ (index As Long, lInsulationPurpose As Long, lInsulationMaterial As Long, dInsulationThickness As Double, pbIsInsulated As Boolean)]")
'#Property,GetInsulationData,fun,llldb
   sMsg = "GetInsulationData= "
   Call obj.GetInsulationData(l1, l2, l3, d4, b5)
   sMsg = sMsg & "( " & l1 & ", " & l2 & ", " & l3 & ", " & sDouble(d4) & ", " & b5 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetSupportDefinition() As Object
   sMsg = "*GetSupportDefinition()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSupportDefinition()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSupportedObjectPorts() As Object
   sMsg = "*GetSupportedObjectPorts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSupportedObjectPorts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSupportedObjects() As Object
   sMsg = "*GetSupportedObjects()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSupportedObjects()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSupportingObjectPorts() As Object
   sMsg = "*GetSupportingObjectPorts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSupportingObjectPorts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetSupportingObjects() As Object
   sMsg = "*GetSupportingObjects()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetSupportingObjects()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetTargetPoint() As IJDPosition
   sMsg = "*GetTargetPoint()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetTargetPoint()
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputIJHgrInputObjectInfo = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJHgrInputConfigHlpr
Public Function outputIJHgrInputConfigHlpr(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJHgrInputConfigHlpr
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJHgrInputConfigHlpr = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub AddAttribute(pAttribInfo As IJDAttributeInfo)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub AddAttribute(pAttribInfo As IJDAttributeInfo)")
'#Property,Function CalculateGenericReferencePorts(pEnumUnk_SupportPositions As IEnumUnknown, pEnumUnk_SupportingPorts As IEnumUnknown, pEnumUnk_SupportedPorts As IEnumUnknown) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function CalculateGenericReferencePorts(pEnumUnk_SupportPositions As IEnumUnknown, pEnumUnk_SupportingPorts As IEnumUnknown, pEnumUnk_SupportedPorts As IEnumUnknown) As Object")
'#Property,Function CalculateGenericRefPortsCollection() As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function CalculateGenericRefPortsCollection() As Object")
'#Property,Function CreateNote(NoteName As String) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function CreateNote(NoteName As String) As Object")
'#Property,Sub CreatePhysicalConnection(PartIndex_A As Long, PortName_A As String, PartIndex_B As Long, PortName_B As String, [ConnectionValue As Long = -1])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub CreatePhysicalConnection(PartIndex_A As Long, PortName_A As String, PartIndex_B As Long, PortName_B As String, [ConnectionValue As Long = -1])")
'#Property,Function DeleteNote(NoteName As String) As Boolean
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function DeleteNote(NoteName As String) As Boolean")
'#Property,Sub GetAttribute(bstrAttribName As String, ppOutAttribute As IJDAttribute)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetAttribute(bstrAttribName As String, ppOutAttribute As IJDAttribute)")
'#Property,Sub GetAttributeValue(bstrAttribName As String, [pInputContext As Object], varAttribValue)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetAttributeValue(bstrAttribName As String, [pInputContext As Object], varAttribValue)")
'#Property,Sub GetBendRadiusAndCenterOfRotation(pDispTurnFeature As Object, dBendRadius As Double, dCoRX As Double, dCoRY As Double, dCoRZ As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetBendRadiusAndCenterOfRotation(pDispTurnFeature As Object, dBendRadius As Double, dCoRX As Double, dCoRY As Double, dCoRZ As Double)")
'#Property,Function GetBoundingBoxInfo(bstrBBName As String) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetBoundingBoxInfo(bstrBBName As String) As Object")
'#Property,GetCableTray,fun,o
   sMsg = "GetCableTray= "
   Set o1 = Nothing
   Call obj.GetCableTray(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,Function GetDataByRule(RuleName As String, [pInputContext As Object]) As Variant()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetDataByRule(RuleName As String, [pInputContext As Object]) As Variant()")
'#Property,Sub GetDistanceBetweenPortCurves([eDistanceType As HgrPortDistanceType], dblMinDistance As Double, dblMaxDistance As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetDistanceBetweenPortCurves([eDistanceType As HgrPortDistanceType], dblMinDistance As Double, dblMaxDistance As Double)")
'#Property,Function GetDistanceBetweenPorts(strFirstPortName As String, strSecondPortName As String, [eDistanceType As HgrPortDistanceType]) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetDistanceBetweenPorts(strFirstPortName As String, strSecondPortName As String, [eDistanceType As HgrPortDistanceType]) As Double")
'#Property,GetDucts,fun,o
   sMsg = "GetDucts= "
   Set o1 = Nothing
   Call obj.GetDucts(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,Function GetErrorDescription(lErrorCode As Long) As String
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetErrorDescription(lErrorCode As Long) As String")
'#Property,Function GetExternalPipeDiameter(pDisp_IJPort_Pipe As Object) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetExternalPipeDiameter(pDisp_IJPort_Pipe As Object) As Double")
'#Property,GetHgrSupStatus,fun,l
   sMsg = "GetHgrSupStatus= "
   Call obj.GetHgrSupStatus(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function GetJointSet(pSupportedColl As Object, pSupportingColl As Object, pPartOccColl As Object, pInputPartColl As Object, AssmInfoRule As String, [JointParamColl As Object]) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetJointSet(pSupportedColl As Object, pSupportingColl As Object, pPartOccColl As Object, pInputPartColl As Object, AssmInfoRule As String, [JointParamColl As Object]) As Object")
'#Property,Function GetMinimumDistanceBetweenPorts(pDisp_Pipe As Object, pDisp_Struct As Object) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetMinimumDistanceBetweenPorts(pDisp_Pipe As Object, pDisp_Struct As Object) As Double")
'#Property,Function GetPartFromClass(strPartClassIID As String) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPartFromClass(strPartClassIID As String) As Object")
'#Property,Sub GetPartIndexes(pEnumUnkInpPartColl As IEnumUnknown, bstrInpPartName As String, pSAPartIndexes() As Long, bPartFound As Boolean)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetPartIndexes(pEnumUnkInpPartColl As IEnumUnknown, bstrInpPartName As String, pSAPartIndexes() As Long, bPartFound As Boolean)")
'#Property,Function GetPartProxyFromName(strObjectName As String, [strSelectionRule As String]) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPartProxyFromName(strObjectName As String, [strSelectionRule As String]) As Object")
'#Property,Function GetPipeDiameter(pDisp_IJPort_Pipe As Object, pstrUnitType As String) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPipeDiameter(pDisp_IJPort_Pipe As Object, pstrUnitType As String) As Double")
'#Property,Function GetPipeRelativeCenter(pDispTurnFeat As Object, [strObjectName As String]) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPipeRelativeCenter(pDispTurnFeat As Object, [strObjectName As String]) As Object")
'#Property,GetPipes,fun,o
   sMsg = "GetPipes= "
   Set o1 = Nothing
   Call obj.GetPipes(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetPoint,fun,o
   sMsg = "GetPoint= "
   Set o1 = Nothing
   Call obj.GetPoint(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetPortConfiguration
   sMsg = "GetPortConfiguration= "
   sMsg = sMsg & obj.GetPortConfiguration
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function GetPortOrientAngle([eOrientType As HgrPortOrientType], strFirstPortName As String, eFirstAxis As HgrPortAixsType, [strSecondPortName As String], [eSecondAxis As HgrPortAixsType]) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPortOrientAngle([eOrientType As HgrPortOrientType], strFirstPortName As String, eFirstAxis As HgrPortAixsType, [strSecondPortName As String], [eSecondAxis As HgrPortAixsType]) As Double")
'#Property,Function GetPortServiceObject(lStructureIndex As Long) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPortServiceObject(lStructureIndex As Long) As Object")
'#Property,Function GetPropertyFromSupporting(strPropertyName As String, [pDispSupportingPort As Object])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPropertyFromSupporting(strPropertyName As String, [pDispSupportingPort As Object])")
'#Property,Function GetReferenceInput(index As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetReferenceInput(index As Long)")
'#Property,GetRefPorts As Object
   sMsg = "*GetRefPorts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetRefPorts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetRouteConnectionValue
   sMsg = "GetRouteConnectionValue= "
   sMsg = sMsg & obj.GetRouteConnectionValue
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function GetRouteStructAngle(pdispRoute As Object, pDispStruct As Object) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetRouteStructAngle(pdispRoute As Object, pDispStruct As Object) As Double")
'#Property,Function GetRouteStructConfigAngle(RoutePortName As String, StructPortName As String, eAxis As HgrPortAixsType) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetRouteStructConfigAngle(RoutePortName As String, StructPortName As String, eAxis As HgrPortAixsType) As Double")
'#Property,Function GetRouteStructDistByType(enumDistType As HgrRouteStructDistType, LegOffset As Double) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetRouteStructDistByType(enumDistType As HgrRouteStructDistType, LegOffset As Double) As Double")
'#Property,Sub GetRteCrossSectParams(pDispRtePathFeat As Object, eShapeType As CrossSectionShapeTypes, pstrUnitType As String, pRadius As Double, pWidth As Double, pDepth As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetRteCrossSectParams(pDispRtePathFeat As Object, eShapeType As CrossSectionShapeTypes, pstrUnitType As String, pRadius As Double, pWidth As Double, pDepth As Double)")
'#Property,Sub GetRteOrientationAngle(pDispRtePathFeat As Object, pAngle As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetRteOrientationAngle(pDispRtePathFeat As Object, pAngle As Double)")
'#Property,Function GetRteSpec(pRteObject As Object) As String
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetRteSpec(pRteObject As Object) As String")
'#Property,Function Function GetRteSpecVersion(pRteObject As Object) As String
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function Function GetRteSpecVersion(pRteObject As Object) As String")
'#Property,GetStructure,fun,o
   sMsg = "GetStructure= "
   Set o1 = Nothing
   Call obj.GetStructure(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,Function GetStructureShape(pDispStruct As Object) As HgrPortShape
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetStructureShape(pDispStruct As Object) As HgrPortShape")
'#Property,GetSupportedCollection,fun,o
   sMsg = "GetSupportedCollection= "
   Set o1 = Nothing
   Call obj.GetSupportedCollection(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetSupportingCollection,fun,o
   sMsg = "GetSupportingCollection= "
   Set o1 = Nothing
   Call obj.GetSupportingCollection(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,Function GetSupportingProperty(bstrPropName As String, index As Long) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetSupportingProperty(bstrPropName As String, index As Long) As Double")
'#Property,Function GetSupportingShape(pDispSupporting As Object) As HgrPortShape
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetSupportingShape(pDispSupporting As Object) As HgrPortShape")
'#Property,Function GetSymbolReference(pDispPart As Object) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetSymbolReference(pDispPart As Object) As Object")
'#Property,Sub GetTurnFeatProperties([pDispTurnFeat As Object], FaceToCenter As Double, BendRadius As Double, BendAngle As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetTurnFeatProperties([pDispTurnFeat As Object], FaceToCenter As Double, BendRadius As Double, BendAngle As Double)")
'#Property,Sub HgrLogError(lErrorCode As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub HgrLogError(lErrorCode As Long)")
'#Property,IsModificationFromOutSide
   sMsg = "IsModificationFromOutSide= "
   sMsg = sMsg & obj.IsModificationFromOutSide
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsPlaceByStructure
   sMsg = "IsPlaceByStructure= "
   sMsg = sMsg & obj.IsPlaceByStructure
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsPlacement
   sMsg = "IsPlacement= "
   sMsg = sMsg & obj.IsPlacement
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function PrimaryPipeDiameter(pstrUnitType As String) As Double
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function PrimaryPipeDiameter(pstrUnitType As String) As Double")
'#Property,Sub ResetReferenceInput()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ResetReferenceInput()")
'#Property,RouteIndex
   sMsg = "RouteIndex= "
   sMsg = sMsg & obj.RouteIndex
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,RouteStructDistance
   sMsg = "RouteStructDistance= "
   sMsg = sMsg & obj.RouteStructDistance
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub SetAttributeValue(bstrAttribName As String, [pInputContext As Object], varAttribValue)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SetAttributeValue(bstrAttribName As String, [pInputContext As Object], varAttribValue)")
'#Property,...,comment,...
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "...=... [ ...]")
'#Property,Property SupportedParts(index As Long) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Property SupportedParts(index As Long) As Object")
'#Property,Property SupportedPartsCount(index As Long) As Long
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Property SupportedPartsCount(index As Long) As Long")
'#Property,Property SupportedSectionOrientation(index As Long) As HgrEnumSectionSide
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Property SupportedSectionOrientation(index As Long) As HgrEnumSectionSide")
     
  outputIJHgrInputConfigHlpr = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJRteConduitRun
Public Function outputIJRteConduitRun(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteConduitRun
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteConduitRun = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetDefaultBendRadius
   sMsg = "GetDefaultBendRadius= "
   sMsg = sMsg & obj.GetDefaultBendRadius
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetNominalDiameter,fun,s
   sMsg = "GetNominalDiameter= "
   Call obj.GetNominalDiameter(s1)
   sMsg = sMsg & "( " & s1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetTrueOD
   sMsg = "GetTrueOD= "
   sMsg = sMsg & obj.GetTrueOD
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetUsedSpec() As IJConduitSpec
   sMsg = "*GetUsedSpec()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetUsedSpec()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Ncd
   sMsg = "Ncd= "
   sMsg = sMsg & obj.Ncd
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,NcdUnitType
   sMsg = "NcdUnitType= "
   sMsg = sMsg & obj.NcdUnitType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PutUsedSpec,comment,(pNewSpec As IJConduitSpec)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "PutUsedSpec=... [ (pNewSpec As IJConduitSpec)]")
'#Property,SetNominalDiameter,comment,(dNomDiaSize As Double, strNomDiaType As String)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetNominalDiameter=... [ (dNomDiaSize As Double, strNomDiaType As String)]")
     
  outputIJRteConduitRun = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction





'#function,IJPlane
Public Function outputIJPlane(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJPlane
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJPlane = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,BoundaryCount
   sMsg = "BoundaryCount= "
   sMsg = sMsg & obj.BoundaryCount
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetBoundaries,fun,o
   sMsg = "GetBoundaries= "
   Set o1 = Nothing
   Call obj.GetBoundaries(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetNormal,fun,ddd
   sMsg = "GetNormal= "
   Call obj.GetNormal(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetRootPoint,fun,ddd
   sMsg = "GetRootPoint= "
   Call obj.GetRootPoint(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetUDirection,fun,ddd
   sMsg = "GetUDirection= "
   Call obj.GetUDirection(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetVDirection,fun,ddd
   sMsg = "GetVDirection= "
   Call obj.GetVDirection(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Reversed
   sMsg = "Reversed= "
   sMsg = sMsg & obj.Reversed
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJPlane = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction





'#function,IJComplexString
Public Function outputIJComplexString(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJComplexString
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJComplexString = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,CurveCount
   sMsg = "CurveCount= "
   sMsg = sMsg & obj.CurveCount
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetCurves,fun,o
   sMsg = "GetCurves= "
   Set o1 = Nothing
   Call obj.GetCurves(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
     
  outputIJComplexString = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction





'#function,IJDAttributes
Public Function outputIJDAttributes(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDAttributes
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDAttributes = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Property CollectionOfAttributes(InterfaceType) As IJDAttributesCol
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Property CollectionOfAttributes(InterfaceType) As IJDAttributesCol")
'#Property,Count
   sMsg = "Count= "
   sMsg = sMsg & obj.Count
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Property IsInterfacePublic(InterfacePublic) As Boolean
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Property IsInterfacePublic(InterfacePublic) As Boolean")
     
  outputIJDAttributes = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJFoulCheck
Public Function outputIJFoulCheck(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJFoulCheck
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJFoulCheck = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#special
'#Property,GetConnectedParts,fun,o
   sMsg = ""
   Set o1 = New JObjectCollection ' This is specific
   Call obj.GetConnectedParts(o1)
   sMsg = "GetConnectedParts= " & "( " & "Par1" & ")" & sMsg
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set o1 = Nothing ' this is specific
'#endspecial
'#Property,GetFoulInterfaceType,fun,l
   sMsg = "GetFoulInterfaceType= "
   Call obj.GetFoulInterfaceType(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJFoulCheck = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJRteCableRouter
Public Function outputIJRteCableRouter(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableRouter
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableRouter = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub ConfigureOutOfNetworkLeg(pUnkEntryExitFeat As Unknown)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ConfigureOutOfNetworkLeg(pUnkEntryExitFeat As Unknown)")
'#Property,Sub GetRouteLengths(dLength As Double, dSt1Length As Double, dSt2Length As Double, dTail1Length As Double, dTail2Length As Double, dCutLength As Double, dSpareLength As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetRouteLengths(dLength As Double, dSt1Length As Double, dSt2Length As Double, dTail1Length As Double, dTail2Length As Double, dCutLength As Double, dSpareLength As Double)")
'#Property,GetRouteLengths,fun,ddddddd
   sMsg = "GetRouteLengths= "
   Call obj.GetRouteLengths(d1, d2, d3, d4, d5, d6, d7)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ", " & sDouble(d7) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsPathValid
   sMsg = "IsPathValid= "
   sMsg = sMsg & obj.IsPathValid
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsRouted
   sMsg = "IsRouted= "
   sMsg = sMsg & obj.IsRouted
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function IsRouteSame(pRteCableRun As IJRtePathRun) As Boolean
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function IsRouteSame(pRteCableRun As IJRtePathRun) As Boolean")
'#Property,IsThisBadCable
   sMsg = "IsThisBadCable= "
   sMsg = sMsg & obj.IsThisBadCable
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub MergeLegs(pSegmentFeat1 As IJRtePathFeat, pSegmentFeat2 As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub MergeLegs(pSegmentFeat1 As IJRtePathFeat, pSegmentFeat2 As IJRtePathFeat)")
'#Property,Function ReportCable(rteType As RteCableReports) As IJDCollection
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function ReportCable(rteType As RteCableReports) As IJDCollection")
'#special
    Dim oIJDColl As IJDCollection
    Dim var As Variant
    Dim oCableFeat As IJRtePathFeat
    Dim oCol As IJDObjectCollection
 
    Dim i As Long
    Set oIJDColl = obj.ReportCable(RTE_FEATURE_REPORT)
    If Not oIJDColl Is Nothing Then
    For i = 1 To oIJDColl.Size Step 3
        var = oIJDColl.Item(i)
        Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , i & ": Distance from Start:" & var)
        Set oCableFeat = oIJDColl.Item(i + 1)
      
        Call Form.moMyObject.ShowObject(oCableFeat, Node3)
        Set oCol = oIJDColl.Item(i + 2)
  
        Call Form.moMyObject.ShowObject(oCol, Node3)
    Next i
    End If
'#endspecial
'#Property,RouteStatus
   sMsg = "RouteStatus= "
   sMsg = sMsg & obj.RouteStatus
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function SetViewForCable(pResourceMgr As Unknown, pCableRuns As IJDObjectCollection, ppLowPos As IJDPosition, ppHighPos As IJDPosition) As IJDCollection
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function SetViewForCable(pResourceMgr As Unknown, pCableRuns As IJDObjectCollection, ppLowPos As IJDPosition, ppHighPos As IJDPosition) As IJDCollection")
'#Property,SpareLength
   sMsg = "SpareLength= "
   sMsg = sMsg & obj.SpareLength
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub SplitTheLeg(pSegmentPathFeat As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SplitTheLeg(pSegmentPathFeat As IJRtePathFeat)")
'#Property,Sub SplitTheLegEx(pSegmentPathFeat As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SplitTheLegEx(pSegmentPathFeat As IJRtePathFeat)")
'#Property,Sub SubmitEntryExit(pTrunkPathFeat As IJRtePathFeat, x As Double, y As Double, z As Double, bEntry As Boolean, RteError As RteCableErrors, [nPortIndex As Long])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SubmitEntryExit(pTrunkPathFeat As IJRtePathFeat, x As Double, y As Double, z As Double, bEntry As Boolean, RteError As RteCableErrors, [nPortIndex As Long])")
'#Property,Sub SubmitPathToRoute(pTrunkPathFeat As IJRtePathFeat, x As Double, y As Double, z As Double, RteError As RteCableErrors, [bAutoroute As Boolean = False])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SubmitPathToRoute(pTrunkPathFeat As IJRtePathFeat, x As Double, y As Double, z As Double, RteError As RteCableErrors, [bAutoroute As Boolean = False])")
     
  outputIJRteCableRouter = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJRteCableTrayDistribConnection
Public Function outputIJRteCableTrayDistribConnection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRteCableTrayDistribConnection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRteCableTrayDistribConnection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GapWidth
   sMsg = "GapWidth= "
   sMsg = sMsg & obj.GapWidth
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRteCableTrayDistribConnection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJDistribPort
Public Function outputIJDistribPort(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDistribPort
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDistribPort = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,DistribPortStatus
   sMsg = "DistribPortStatus= "
   sMsg = sMsg & obj.DistribPortStatus
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DistribPortType
   sMsg = "DistribPortType= "
   sMsg = sMsg & obj.DistribPortType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetCollectionOfConnectionMonikers() As IJDObjectCollection
   sMsg = "*GetCollectionOfConnectionMonikers()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetCollectionOfConnectionMonikers()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetConnection() As IJDistribConnection
   sMsg = "*GetConnection()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnection()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetConnPartOccurs() As IJElements
   sMsg = "*GetConnPartOccurs()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnPartOccurs()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetConnPorts() As IJElements
   sMsg = "*GetConnPorts()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetConnPorts()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetDirectionVector() As IJDVector
   sMsg = "*GetDirectionVector()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetDirectionVector()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetDirectionVectorXYZ,fun,ddd
   sMsg = "GetDirectionVectorXYZ= "
   Call obj.GetDirectionVectorXYZ(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetFlowDir,fun,l
   sMsg = "GetFlowDir= "
   Call obj.GetFlowDir(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetInternalID,fun,s
   sMsg = "GetInternalID= "
   Call obj.GetInternalID(s1)
   sMsg = sMsg & "( " & s1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetLabel()
   sMsg = "GetLabel()= "
   sMsg = sMsg & obj.GetLabel()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOrientation,fun,oo
   sMsg = "GetOrientation= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetOrientation(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,GetOrientationXYZ,fun,dddddd
   sMsg = "GetOrientationXYZ= "
   Call obj.GetOrientationXYZ(d1, d2, d3, d4, d5, d6)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ", " & sDouble(d4) & ", " & sDouble(d5) & ", " & sDouble(d6) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetParentConnection() As IJDistribConnection
   sMsg = "*GetParentConnection()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetParentConnection()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPartOccur() As IJDistribPartOccur
   sMsg = "*GetPartOccur()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPartOccur()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPortLocation() As IJDPosition
   sMsg = "*GetPortLocation()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPortLocation()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetPortLocationXYZ,fun,ddd
   sMsg = "GetPortLocationXYZ= "
   Call obj.GetPortLocationXYZ(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetRadialOrient() As IJDVector
   sMsg = "*GetRadialOrient()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetRadialOrient()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetRadialOrientXYZ,fun,ddd
   sMsg = "GetRadialOrientXYZ= "
   Call obj.GetRadialOrientXYZ(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsBasePort,fun,l
   sMsg = "IsBasePort= "
   Call obj.IsBasePort(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsConnected,fun,l
   sMsg = "IsConnected= "
   Call obj.IsConnected(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsFreePort,fun,l
   sMsg = "IsFreePort= "
   Call obj.IsFreePort(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJDistribPort = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJRtePathFeatUtility
Public Function outputIJRtePathFeatUtility(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePathFeatUtility
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePathFeatUtility = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub AreFeaturesConnected(pFeat2 As IJRtePathFeat, pvbFeaturesAreConnected As Boolean)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub AreFeaturesConnected(pFeat2 As IJRtePathFeat, pvbFeaturesAreConnected As Boolean)")
'#Property,Function AreInlineFeaturesConnected(pOtherFeat As IJRtePathFeat, ppFeat1Port As IJDistribPort, ppFeat2Port As IJDistribPort) As Boolean
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function AreInlineFeaturesConnected(pOtherFeat As IJRtePathFeat, ppFeat1Port As IJDistribPort, ppFeat2Port As IJDistribPort) As Boolean")
'#Property,DoesFeatureHaveCS,fun,b
   sMsg = "DoesFeatureHaveCS= "
   Call obj.DoesFeatureHaveCS(b1)
   sMsg = sMsg & "( " & b1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DoesFeatureHaveSpecialBasePart
   sMsg = "DoesFeatureHaveSpecialBasePart= "
   sMsg = sMsg & obj.DoesFeatureHaveSpecialBasePart
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetAdjacentFeatures,fun,oo
   sMsg = "GetAdjacentFeatures= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetAdjacentFeatures(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Function GetAdjacentFeatureStartEndSideOnTurn(pAdjacentFeat As IJRtePathFeat, BaseFeatureLeg As IJRtePathLeg) As ePathFeatureSide
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetAdjacentFeatureStartEndSideOnTurn(pAdjacentFeat As IJRtePathFeat, BaseFeatureLeg As IJRtePathLeg) As ePathFeatureSide")
'#Property,Sub GetAdjacentFeaturesTypesAndRuns(ppPreviousFeature As IJRtePathFeat, PreviousFeatureType As PathFeatureObjectTypes, ppPreviousRun As IJRtePathRun, ppNextFeature As IJRtePathFeat, NextFeatureType As PathFeatureObjectTypes, ppNextRun As IJRtePathRun)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetAdjacentFeaturesTypesAndRuns(ppPreviousFeature As IJRtePathFeat, PreviousFeatureType As PathFeatureObjectTypes, ppPreviousRun As IJRtePathRun, ppNextFeature As IJRtePathFeat, NextFeatureType As PathFeatureObjectTypes, ppNextRun As IJRtePathRun)")
'#Property,GetAllParts,fun,lo
   sMsg = "GetAllParts= "
   Set o2 = Nothing
   Call obj.GetAllParts(l1, o2)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,GetBasePartIndices,fun,ll
   sMsg = "GetBasePartIndices= "
   Call obj.GetBasePartIndices(l1, l2)
   sMsg = sMsg & "( " & l1 & ", " & l2 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetBranchsAlongsBasePart,fun,oo
   sMsg = "GetBranchsAlongsBasePart= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetBranchsAlongsBasePart(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Function GetConnectionPosition(ConnectionDirection As eConnectionDirection, pLegWeAreOn As IJRtePathLeg) As IJDPosition
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetConnectionPosition(ConnectionDirection As eConnectionDirection, pLegWeAreOn As IJRtePathLeg) As IJDPosition")
'#Property,GetEndsConnections,fun,oo
   sMsg = "GetEndsConnections= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetEndsConnections(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Sub GetFeaturePortsByType(eType As RteFeatureTerminusPortTypes, ppPortPrevious As IJDistribPort, ppPortNext As IJDistribPort)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetFeaturePortsByType(eType As RteFeatureTerminusPortTypes, ppPortPrevious As IJDistribPort, ppPortNext As IJDistribPort)")
'#Property,Sub GetFeatureSpec(ppSpec As IJDSpec, pbSpecOverride As Boolean)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetFeatureSpec(ppSpec As IJDSpec, pbSpecOverride As Boolean)")
'#Property,GetFirstOfflineFeature() As IJRtePathFeat
   sMsg = "*GetFirstOfflineFeature()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetFirstOfflineFeature()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetFlowDirection´,fun,l
   sMsg = "GetFlowDirection´= "
   Call obj.GetFlowDirection´(l1)
   sMsg = sMsg & "( " & l1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetIgnoredBaseParts,fun,lo
   sMsg = "GetIgnoredBaseParts= "
   Set o2 = Nothing
   Call obj.GetIgnoredBaseParts(l1, o2)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Function GetIgnoredMatingParts(bBefore As Long, pCount As Long) As IJElements
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetIgnoredMatingParts(bBefore As Long, pCount As Long) As IJElements")
'#Property,GetIgnoredParts,fun,lo
   sMsg = "GetIgnoredParts= "
   Set o2 = Nothing
   Call obj.GetIgnoredParts(l1, o2)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,GetIgnoredParts,fun,lo
   sMsg = "GetIgnoredParts= "
   Set o2 = Nothing
   Call obj.GetIgnoredParts(l1, o2)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,GetLegDirection,fun,ddd
   sMsg = "GetLegDirection= "
   Call obj.GetLegDirection(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub GetLegSharedByFeatures(pOtherFeat As IJRtePathFeat, ppSharedLeg As IJRtePathLeg)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetLegSharedByFeatures(pOtherFeat As IJRtePathFeat, ppSharedLeg As IJRtePathLeg)")
'#Property,GetLogicalTermPort,fun,o
   sMsg = "GetLogicalTermPort= "
   Set o1 = Nothing
   Call obj.GetLogicalTermPort(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetMinimumStraightLength()
   sMsg = "GetMinimumStraightLength()= "
   sMsg = sMsg & obj.GetMinimumStraightLength()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOfflineCount()
   sMsg = "GetOfflineCount()= "
   sMsg = sMsg & obj.GetOfflineCount()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetOfflineLegs() As IJDObjectCollection
   sMsg = "*GetOfflineLegs()"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetOfflineLegs()
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetOfflinePortOfFeature,fun,o
   sMsg = "GetOfflinePortOfFeature= "
   Set o1 = Nothing
   Call obj.GetOfflinePortOfFeature(o1)
   sMsg = sMsg & "( " & "Par1" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetLegDirection,fun,ddd
   sMsg = "GetLegDirection= "
   Call obj.GetLegDirection(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Function GetPartAtPosition(pPosition As IJDPosition) As IJElements
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetPartAtPosition(pPosition As IJDPosition) As IJElements")
'#Property,GetRealAdjacentFeatures,fun,oo
   sMsg = "GetRealAdjacentFeatures= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetRealAdjacentFeatures(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,GetRealAdjacentFeaturesTypesAndRuns,fun,oloolo
   sMsg = "GetRealAdjacentFeaturesTypesAndRuns= "
   Set o1 = Nothing
   Set o3 = Nothing
   Set o4 = Nothing
   Set o6 = Nothing
   Call obj.GetRealAdjacentFeaturesTypesAndRuns(o1, l2, o3, o4, l5, o6)
   sMsg = sMsg & "( " & "Par1" & ", " & l2 & ", " & "Par3" & ", " & "Par4" & ", " & l5 & ", " & "Par6" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par3")
   Set Node3.Tag = o3
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par4")
   Set Node3.Tag = o4
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par6")
   Set Node3.Tag = o6
'#Property,Sub GetStartAndEndSideFeatures(ppStartSideFeature As IJRtePathFeat, ppEndSideFeature As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetStartAndEndSideFeatures(ppStartSideFeature As IJRtePathFeat, ppEndSideFeature As IJRtePathFeat)")
'#Property,GetStartAndEndSideFeatures,fun,oo
   sMsg = "GetStartAndEndSideFeatures= "
   Set o1 = Nothing
   Set o2 = Nothing
   Call obj.GetStartAndEndSideFeatures(o1, o2)
   sMsg = sMsg & "( " & "Par1" & ", " & "Par2" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Sub GetStartEndFeatureSide(pFeat2 As IJRtePathFeat, pFeat1Side As ePathFeatureSide, pFeat2Side As ePathFeatureSide)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetStartEndFeatureSide(pFeat2 As IJRtePathFeat, pFeat1Side As ePathFeatureSide, pFeat2Side As ePathFeatureSide)")
'#Property,Function GetTerminusPortOfFeature(eFeatSide As ePathFeatureSide) As IJDistribPort
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Function GetTerminusPortOfFeature(eFeatSide As ePathFeatureSide) As IJDistribPort")
'#Property,Sub GetTopologicallyAdjacentFeatures(ppPrevFeature As IJRtePathFeat, ppNextFeature As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetTopologicallyAdjacentFeatures(ppPrevFeature As IJRtePathFeat, ppNextFeature As IJRtePathFeat)")
'#Property,GetTrueOD()
   sMsg = "GetTrueOD()= "
   sMsg = sMsg & obj.GetTrueOD()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IgnoreBaseParts,fun,b
   sMsg = "IgnoreBaseParts= "
   Call obj.IgnoreBaseParts(b1)
   sMsg = sMsg & "( " & b1 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub IgnoreMatingParts(bBefore As Long, bIgnoreBaseParts As Boolean)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub IgnoreMatingParts(bBefore As Long, bIgnoreBaseParts As Boolean)")
'#Property,IsAdjacentAStraight()
   sMsg = "IsAdjacentAStraight()= "
   sMsg = sMsg & obj.IsAdjacentAStraight()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub IsFeatureWithCabletray(bIsCableTray As Boolean, [ppCableTrayPart As IJDPart])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub IsFeatureWithCabletray(bIsCableTray As Boolean, [ppCableTrayPart As IJDPart])")
'#Property,IsStraightParallelTransition()
   sMsg = "IsStraightParallelTransition()= "
   sMsg = sMsg & obj.IsStraightParallelTransition()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,IsZeroLengthStraight()
   sMsg = "IsZeroLengthStraight()= "
   sMsg = sMsg & obj.IsZeroLengthStraight()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub ResetConnection(pPOM As Unknown, pFromPort As IJDistribPort, pToPort As IJDistribPort, pGenPart As IJRtePathGenPart, [pNewRun As IJRtePathRun])
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ResetConnection(pPOM As Unknown, pFromPort As IJDistribPort, pToPort As IJDistribPort, pGenPart As IJRtePathGenPart, [pNewRun As IJRtePathRun])")
'#Property,Sub ReverseBasePartsOrder()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ReverseBasePartsOrder()")
'#Property,Sub TraverseToAdjacentFeatWithParts(pFirstAdjFeat As IJRtePathFeat, ppAdjFeatWithParts As IJRtePathFeat, ppAdjAdjFeat As IJRtePathFeat, ppPartsList As IJElements, pListCount As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub TraverseToAdjacentFeatWithParts(pFirstAdjFeat As IJRtePathFeat, ppAdjFeatWithParts As IJRtePathFeat, ppAdjAdjFeat As IJRtePathFeat, ppPartsList As IJElements, pListCount As Long)")
'#Property,Sub TraverseToNonRunChangeFeature(pFirstAdjFeat As IJRtePathFeat, doOneStep As Long, ppRun As IJRtePathRun)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub TraverseToNonRunChangeFeature(pFirstAdjFeat As IJRtePathFeat, doOneStep As Long, ppRun As IJRtePathRun)")
'#Property,Sub TraverseToRunChangeFeature(bDirection As Boolean, ppAdjRunChangeFeat As IJRtePathFeat, ppAdjRunRefFeat As IJRtePathFeat)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub TraverseToRunChangeFeature(bDirection As Boolean, ppAdjRunChangeFeat As IJRtePathFeat, ppAdjRunRefFeat As IJRtePathFeat)")
     
  outputIJRtePathFeatUtility = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,ISPSFrameConnection
Public Function outputISPSFrameConnection(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSFrameConnection
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSFrameConnection = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Definition,ref,Object
   sMsg = "*Definition"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Definition
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,DefinitionClassName
   sMsg = "DefinitionClassName= "
   sMsg = sMsg & obj.DefinitionClassName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DefinitionName
   sMsg = "DefinitionName= "
   sMsg = sMsg & obj.DefinitionName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,DesignPartEndPort As ISPSSplitAxisPort
   sMsg = "*DesignPartEndPort"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.DesignPartEndPort
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,InputHelper As ISPSFCInputHelper
   sMsg = "*InputHelper"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.InputHelper
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsPointOn,enum,StructPointOnCondition
   sMsg = "IsPointOn= " & obj.IsPointOn & " [StructPointOnCondition]"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Node2.Text = sMsg
'#Property,Joint As ISPSAxisJoint
   sMsg = "*Joint"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Joint
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,MemberSystem As ISPSMemberSystem
   sMsg = "*MemberSystem"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.MemberSystem
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,Services As ISPSMemberConnectionServices
   sMsg = "*Services"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.Services
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,WPO As ISPSAxisWPO
   sMsg = "*WPO"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.WPO
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSFrameConnection = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJDAssocRelation
Public Function outputIJDAssocRelation(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDAssocRelation
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDAssocRelation = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#property,CollectionRelations,comment,Property CollectionRelations(interfaceID, collectionName As String) As Object
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "CollectionRelations=... [ Property CollectionRelations(interfaceID, collectionName As String) As Object]")
     
  outputIJDAssocRelation = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

 
'#function,IJTransform
Public Function outputIJTransform(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJTransform
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJTransform = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#property,Transform,comment,Sub Transform(Trans4x4 As IJDT4x4)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Transform=... [ Sub Transform(Trans4x4 As IJDT4x4)]")
     
  outputIJTransform = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJRtePartData
Public Function outputIJRtePartData(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePartData
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePartData = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,IsOverriden
   sMsg = "IsOverriden= "
   sMsg = sMsg & obj.IsOverriden
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,OptionCode
   sMsg = "OptionCode= "
   sMsg = sMsg & obj.OptionCode
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,PartType
   sMsg = "PartType= "
   sMsg = sMsg & obj.PartType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ShortCode
   sMsg = "ShortCode= "
   sMsg = sMsg & obj.ShortCode
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJRtePartData = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,IJLogicalDistConn
Public Function outputIJLogicalDistConn(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJLogicalDistConn
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJLogicalDistConn = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetOtherPort,comment,Function GetOtherPort(pPort As IJLogicalDistPort) As IJLogicalDistPort
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "GetOtherPort=... [ Function GetOtherPort(pPort As IJLogicalDistPort) As IJLogicalDistPort]")
'#Property,GetPorts,ref,IJDTargetObjectCol
   sMsg = "*GetPorts"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetPorts
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,RemovePort,comment,Sub RemovePort(pPort As IJLogicalDistPort)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RemovePort=... [ Sub RemovePort(pPort As IJLogicalDistPort)]")
'#Property,SetPort,comment,Sub SetPort(pPort As IJLogicalDistPort)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetPort=... [ Sub SetPort(pPort As IJLogicalDistPort)]")
'#Property,SetPorts,comment,Sub SetPorts(pPort1 As IJLogicalDistPort, pPort2 As IJLogicalDistPort)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetPorts=... [ Sub SetPorts(pPort1 As IJLogicalDistPort, pPort2 As IJLogicalDistPort)]")
     
  outputIJLogicalDistConn = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,ISPSStair
Public Function outputISPSStair(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSStair
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSStair = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,BottomPlane As Object
   sMsg = "*BottomPlane"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.BottomPlane
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,DefineStair,comment,(pTopEdge As Object, pBottomPlane As Object, pRefEdge As Object, pIJDPart As IJDPart)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "DefineStair=... [ (pTopEdge As Object, pBottomPlane As Object, pRefEdge As Object, pIJDPart As IJDPart)]")
'#Property,GetMatrix,fun,M
   sMsg = "GetMatrix= "
   Call obj.GetMatrix(M1)
   sMsg = sMsg & "( " & outputIJDT4x4(M1) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,GetPosition,fun,ddd
   sMsg = "GetPosition= "
   Call obj.GetPosition(d1, d2, d3)
   sMsg = sMsg & "( " & sDouble(d1) & ", " & sDouble(d2) & ", " & sDouble(d3) & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,HorizVertOffset As ISPSHorizVertOffset
   sMsg = "*HorizVertOffset"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.HorizVertOffset
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ReferenceEdge As Object
   sMsg = "*ReferenceEdge"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ReferenceEdge
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,SetMatrix,comment,(Matrix As IJDT4x4)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetMatrix=... [ (Matrix As IJDT4x4)]")
'#Property,SetPosition,comment,(PosX As Double, PosY As Double, PosZ As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetPosition=... [ (PosX As Double, PosY As Double, PosZ As Double)]")
'#Property,TopEdge As Object
   sMsg = "*TopEdge"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.TopEdge
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSStair = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction



'#function,ISPSHandrail
Public Function outputISPSHandrail(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As ISPSHandrail
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputISPSHandrail = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub DefineHandrail(pSketchAide As Object, pIJDPart As IJDPart)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub DefineHandrail(pSketchAide As Object, pIJDPart As IJDPart)")
'#Property,SketchPath As Object
   sMsg = "*SketchPath"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.SketchPath
   Set Node2.Tag = o1
   Node2.Text = sMsg
     
  outputISPSHandrail = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJDSketch3d
Public Function outputIJDSketch3d(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJDSketch3d
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJDSketch3d = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub CacheTurnPoints(ppCachedPointsColl As IJElements)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub CacheTurnPoints(ppCachedPointsColl As IJElements)")
'#Property,ComplexStringCollection As IJElements
   sMsg = "*ComplexStringCollection"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ComplexStringCollection
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ComputeCurveSegments As IJElements
   sMsg = "*ComputeCurveSegments"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ComputeCurveSegments
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ConstructionType
   sMsg = "ConstructionType= "
   sMsg = sMsg & obj.ConstructionType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,CoordinateSystem As Object
   sMsg = "*CoordinateSystem"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.CoordinateSystem
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetComplexString As Object
   sMsg = "*GetComplexString"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetComplexString
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetCurveSegments As IJElements
   sMsg = "*GetCurveSegments"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetCurveSegments
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,GetGBspCurveFromSketch As Object
   sMsg = "*GetGBspCurveFromSketch"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetGBspCurveFromSketch
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsGeomPersistent
   sMsg = "IsGeomPersistent= "
   sMsg = sMsg & obj.IsGeomPersistent
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub ModifySketchingPlane(pOldPlane As Object, pNewPlane As Object)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ModifySketchingPlane(pOldPlane As Object, pNewPlane As Object)")
'#Property,Sub SetTurnPoints(pCachedPointsColl As IJElements)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SetTurnPoints(pCachedPointsColl As IJElements)")
     
  outputIJDSketch3d = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJRtePipeRunInsulation
Public Function outputIJRtePipeRunInsulation(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJRtePipeRunInsulation
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePipeRunInsulation = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,GetInsulationSpec As IJPipeInsulationSpec
   sMsg = "*GetInsulationSpec"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetInsulationSpec
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,IsInsulationUserDefined
   sMsg = "IsInsulationUserDefined= "
   sMsg = sMsg & obj.IsInsulationUserDefined
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)")
'#Property,Sub RemoveInsulationSpec()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub RemoveInsulationSpec()")
'#Property,Sub SetUserDefinedInsulation(lPurpose As Long, lMaterial As Long, dThickness As Double, dTemperature As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SetUserDefinedInsulation(lPurpose As Long, lMaterial As Long, dThickness As Double, dTemperature As Double)")
     
  outputIJRtePipeRunInsulation = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction


'#function,IJGeneralNote
Public Function outputIJGeneralNote(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJGeneralNote
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJGeneralNote = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Dimensioned
   sMsg = "Dimensioned= "
   sMsg = sMsg & obj.Dimensioned
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Name
   sMsg = "Name= "
   sMsg = sMsg & obj.Name
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub Position(pX As Double, pY As Double, pZ As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub Position(pX As Double, pY As Double, pZ As Double)")
'#Property,Purpose
   sMsg = "Purpose= "
   sMsg = sMsg & obj.Purpose
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Text
   sMsg = "Text= "
   sMsg = sMsg & obj.Text
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJGeneralNote = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction




'#function,IJToDoRecord
Public Function outputIJToDoRecord(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJToDoRecord
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJToDoRecord = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,ActiveEntity As Unknown
   sMsg = "*ActiveEntity"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ActiveEntity
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ActiveInterface As Variant
   sMsg = "*ActiveInterface"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.ActiveInterface
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ActiveInterface
   sMsg = "ActiveInterface= "
   sMsg = sMsg & obj.ActiveInterface
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ErrorCount
   sMsg = "ErrorCount= "
   sMsg = sMsg & obj.ErrorCount
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub ErrorItem(index As Long, pName As Unknown, pNote As String, pDeleteFlag As Boolean, pObjectToUpdate As Unknown)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ErrorItem(index As Long, pName As Unknown, pNote As String, pDeleteFlag As Boolean, pObjectToUpdate As Unknown)")
'#special
    l1 = 1 ' return the first error item
'#endspecial
'#Property,ErrorItem,fun,losbo
   sMsg = "ErrorItem= "
   Set o2 = Nothing
   Set o5 = Nothing
   Call obj.ErrorItem(l1, o2, s3, b4, o5)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ", " & s3 & ", " & b4 & ", " & "Par5" & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par5")
   Set Node3.Tag = o5
'#Property,SemanticCLSID
   sMsg = "SemanticCLSID= "
   sMsg = sMsg & obj.SemanticCLSID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,SemanticProgID
   sMsg = "SemanticProgID= "
   sMsg = sMsg & obj.SemanticProgID
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ToDoDate
   sMsg = "ToDoDate= "
   sMsg = sMsg & obj.ToDoDate
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ToDoType
   sMsg = "ToDoType= "
   sMsg = sMsg & obj.ToDoType
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,ToDoUser
   sMsg = "ToDoUser= "
   sMsg = sMsg & obj.ToDoUser
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
     
  outputIJToDoRecord = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction






'#function,IJSemanticErrorInfo
Public Function outputIJSemanticErrorInfo(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJSemanticErrorInfo
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJSemanticErrorInfo = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub AddErrorInfo(pObject As Unknown, errorNumber As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub AddErrorInfo(pObject As Unknown, errorNumber As Long)")
'#Property,Sub ClearAll()
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub ClearAll()")
'#Property,CodeListTableName
   sMsg = "CodeListTableName= "
   sMsg = sMsg & obj.CodeListTableName
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Count
   sMsg = "Count= "
   sMsg = sMsg & obj.Count
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,Sub GetErrorInfo(itemNumber As Long, pObject As Unknown, errorNumber As Long)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub GetErrorInfo(itemNumber As Long, pObject As Unknown, errorNumber As Long)")
'#special
    l1 = 1 ' return the first error item
'#endspecial
'#Property,GetErrorInfo,fun,lol
   sMsg = "GetErrorInfo= "
   Set o2 = Nothing
   Call obj.GetErrorInfo(l1, o2, l3)
   sMsg = sMsg & "( " & l1 & ", " & "Par2" & ", " & l3 & ")"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par2")
   Set Node3.Tag = o2
'#Property,Sub RemoveErrorInfo(pObject As Unknown)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub RemoveErrorInfo(pObject As Unknown)")
     
  outputIJSemanticErrorInfo = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction






'#function,IJSpaceAssociationAE
Public Function outputIJSpaceAssociationAE(Form As frmShowElement, Node1 As Node, o As Object) As Long
Dim obj As IJSpaceAssociationAE
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJSpaceAssociationAE = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,Sub AddAssociatedSpace(pSpaceObject As Object)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub AddAssociatedSpace(pSpaceObject As Object)")
'#Property,AssociatedObject,ref,Object
   sMsg = "*AssociatedObject"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.AssociatedObject
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,AssociatedSpaces,ref,IJElements
   sMsg = "*AssociatedSpaces"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.AssociatedSpaces
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#Property,ObjectMatrix,comment,IJDT4x4
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "ObjectMatrix=... [ IJDT4x4]")
'#special
   sMsg = "ObjectMatrix"
   sMsg = sMsg & "=( " & outputIJDT4x4(obj.ObjectMatrix) & ")"
   Node2.Text = sMsg
'#endspecial
'#Property,SetAssociation,comment,Sub SetAssociation(pEntity As Object, pSpaceEntityColl As IJElements, pDT4x4 As IJDT4x4)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "SetAssociation=... [ Sub SetAssociation(pEntity As Object, pSpaceEntityColl As IJElements, pDT4x4 As IJDT4x4)]")

  outputIJSpaceAssociationAE = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction





'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction







'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction






'#function,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#Property,
'#endfunction





Public Sub Publish(colActions As Collection)
Dim s As String
On Error GoTo Handler
'#colActions
     s = "IJRteCableway"
     colActions.Add Me, s
     s = "IJRteCableRun"
     colActions.Add Me, s
     s = "IJDSpec"
     colActions.Add Me, s
     s = "IJRtePathFeat"
     colActions.Add Me, s
     s = "IJRtePathRun"
     colActions.Add Me, s
     s = "IJRteEndPathFeat"
     colActions.Add Me, s
     s = "IJRteStraightPathFeat"
     colActions.Add Me, s
     s = "IJRteTurnPathFeat"
     colActions.Add Me, s
     s = "IJRteCableEnterExitPathFeat"
     colActions.Add Me, s
     s = "IJRteAlongLegPathFeat"
     colActions.Add Me, s
     s = "IJRteEntryExitTrunkPathFeat"
     colActions.Add Me, s
     s = "IJRteCableOccur"
     colActions.Add Me, s
     s = "IJDistribConnection"
     colActions.Add Me, s
     s = "IJRtePathLeg"
     colActions.Add Me, s
     s = "IJCablePart"
     colActions.Add Me, s
     s = "IJRtePathFeatInTrunk"
     colActions.Add Me, s
     s = "IJDPipeSpec"
     colActions.Add Me, s
     s = "IJLine"
     colActions.Add Me, s
     s = "IJArc"
     colActions.Add Me, s
     s = "IJRteCablewayPathFeat"
     colActions.Add Me, s
     s = "IJSystemChild"
     colActions.Add Me, s
     s = "IJDesignChild"
     colActions.Add Me, s
     s = "IJDesignParent"
     colActions.Add Me, s
     s = "IJAssemblyChild"
     colActions.Add Me, s
     s = "IJElements"
     colActions.Add Me, s
     s = "IJHgrSupport"
     colActions.Add Me, s
     s = "IJAnalysisChild"
     colActions.Add Me, s
     s = "ISPSCrossSection"
     colActions.Add Me, s
     s = "ISPSAxisRotation"
     colActions.Add Me, s
     s = "ISPSMemberPartPrismatic"
     colActions.Add Me, s
     s = "ISPSMemberSystem"
     colActions.Add Me, s
     s = "IJCurve"
     colActions.Add Me, s
     s = "IJDObject"
     colActions.Add Me, s
     s = "IJDOutfittingCrossSection"
     colActions.Add Me, s
     s = "IJPort"
     colActions.Add Me, s
     s = "IJRteCrossSectOccur"
     colActions.Add Me, s
     s = "IJPartOcc"
     colActions.Add Me, s
     s = "IJDPart"
     colActions.Add Me, s
     s = "IJNamedItem"
     colActions.Add Me, s
     s = "IJSmartOccurrence"
     colActions.Add Me, s
     s = "IJSystem"
     colActions.Add Me, s
     s = "IJHgrPart"
     colActions.Add Me, s
     s = "IJDSymbol"
     colActions.Add Me, s
     s = "IJHgrSupportComponent"
     colActions.Add Me, s
     s = "IJHgrBOM"
     colActions.Add Me, s
     s = "IJHgrConnComponent"
     colActions.Add Me, s
     s = "IJHgrPort"
     colActions.Add Me, s
     s = "ISPSSlabsDefinition"
     colActions.Add Me, s
     s = "ISPSSlabsComposition"
     colActions.Add Me, s
     s = "ISPSSlabProperties"
     colActions.Add Me, s
     s = "ISPSSlabEntity"
     colActions.Add Me, s
     s = "IJEquipment"
     colActions.Add Me, s
     s = "IJAssembly"
     colActions.Add Me, s
     s = "IJStructGraphConnectable"
     colActions.Add Me, s
     s = "IJAppConnection"
     colActions.Add Me, s
     s = "IJConnectable"
     colActions.Add Me, s
     s = "IJKeyPoint"
     colActions.Add Me, s
     s = "IJHgrInputObjectInfo"
     colActions.Add Me, s
     s = "IJHgrInputConfigHlpr"
     colActions.Add Me, s
     s = "IJRteConduitRun"
     colActions.Add Me, s
     s = "IJPlane"
     colActions.Add Me, s
     s = "IJComplexString"
     colActions.Add Me, s
     s = "IJDAttributes"
     colActions.Add Me, s
     s = "IJFoulCheck"
     colActions.Add Me, s
     s = "IJRteCableRouter"
     colActions.Add Me, s
     s = "IJRteCableTrayDistribConnection"
     colActions.Add Me, s
     s = "IJDistribPort"
     colActions.Add Me, s
     s = "IJRtePathFeatUtility"
     colActions.Add Me, s
     s = "ISPSFrameConnection"
     colActions.Add Me, s
     s = "IJDAssocRelation"
     colActions.Add Me, s
     s = "IJTransform"
     colActions.Add Me, s
     s = "IJRtePartData"
     colActions.Add Me, s
     s = "IJLogicalDistConn"
     colActions.Add Me, s
     s = "ISPSStair"
     colActions.Add Me, s
     s = "ISPSHandrail"
     colActions.Add Me, s
     s = "IJDSketch3d"
     colActions.Add Me, s
     s = "IJRtePipeRunInsulation"
     colActions.Add Me, s
     s = "IJGeneralNote"
     colActions.Add Me, s
     s = "IJToDoRecord"
     colActions.Add Me, s
     s = "IJSemanticErrorInfo"
     colActions.Add Me, s
     s = "IJSpaceAssociationAE"
     colActions.Add Me, s
'#endcolActions
Exit Sub
Handler:
    Call mylog("Duplicate Definition for Interface: " & s)
    Resume Next
End Sub

'''' The Display method is not used any more!!
'''Public Sub Display(Form As frmShowElement, Node1 As MSComctlLib.Node, o As Object, sIntName As String)
'''    Dim Node0 As Node
'''    Set Node0 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Interface Specific Output...")
'''
'''    Select Case sIntName
''''#case
'''
''''#endcase
'''    Case Else
'''
'''    End Select
'''
'''End Sub
 

