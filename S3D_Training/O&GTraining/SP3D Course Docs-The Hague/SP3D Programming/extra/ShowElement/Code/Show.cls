VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Show"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit


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
Private o6 As Object
 

' public class Show



' and interface specific routines:
'    output<Interface>

'#nomethod,IJAppConnectionNotification
Public Function outputIJAppConnectionNotification(Form As Object, Node1 As Node, o As Object) As Long
End Function

'#endnomethod




   

'#function,IJMfgChild
Public Function outputIJMfgChild(Form As Object, Node1 As Node, o As Object) As Long
Dim obj As IJMfgChild
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJMfgChild = -1
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
'#Property,RelationType,comment, As Guid
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RelationType=... [  As Guid]")
     
  outputIJMfgChild = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction

'#function,IJMfgParent
Public Function outputIJMfgParent(Form As Object, Node1 As Node, o As Object) As Long
Dim obj As IJMfgParent
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJMfgParent = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,AddChild(pChildUnk,comment, As Unknown)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "AddChild(pChildUnk=... [  As Unknown)]")
'#Property,GetChildren,fun,os
   sMsg = ""
   Set o1 = Nothing
   Call obj.GetChildren(o1, s2)
   sMsg = "GetChildren= " & "( " & "Par1" & ", " & s2 & ")" & sMsg
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetChildrenMonikers,fun,os
   sMsg = ""
   Set o1 = Nothing
   Call obj.GetChildrenMonikers(o1, s2)
   sMsg = "GetChildrenMonikers= " & "( " & "Par1" & ", " & s2 & ")" & sMsg
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , "*Par1")
   Set Node3.Tag = o1
'#Property,GetCount,fun,ls
   sMsg = ""
   Call obj.GetCount(l1, s2)
   sMsg = "GetCount= " & "( " & l1 & ", " & s2 & ")" & sMsg
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#Property,RemoveChild,comment,(pChildUnk As Unknown)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "RemoveChild=... [ (pChildUnk As Unknown)]")
     
  outputIJMfgParent = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
 
 
'#function,IJPartOccAssembly
Public Function outputIJPartOccAssembly(Form As Object, Node1 As Node, o As Object) As Long
Dim obj As IJPartOccAssembly
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJPartOccAssembly = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#Property,,comment,Implementation missing
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "=... [ Implementation missing]")
     
  outputIJPartOccAssembly = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
 
 
'#function,IJRtePipeRunInsulation
Public Function outputIJRtePipeRunInsulation(Form As Object, Node1 As Node, o As Object) As Long
Dim obj As IJRtePipeRunInsulation
Dim Node2 As MSComctlLib.Node
Dim Node3 As MSComctlLib.Node
Dim sMsg As String
  outputIJRtePipeRunInsulation = -1
  On Error GoTo Handler
  Set obj = o
  If obj Is Nothing Then Exit Function
'#property,GetInsulationSpec As IJPipeInsulationSpec
   sMsg = "*GetInsulationSpec"
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
   Set o1 = Nothing
   Set o1 = obj.GetInsulationSpec
   Set Node2.Tag = o1
   Node2.Text = sMsg
'#property,IsInsulationUserDefined
   sMsg = "IsInsulationUserDefined= "
   sMsg = sMsg & obj.IsInsulationUserDefined
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)
'#property,Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)" )
'#property,Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub PutInsulationSpec(pInsulationSpec As IJPipeInsulationSpec)" )
'#property,Sub SetUserDefinedInsulation(lPurpose As Long, lMaterial As Long, dThickness As Double, dTemperature As Double)
   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , "Sub SetUserDefinedInsulation(lPurpose As Long, lMaterial As Long, dThickness As Double, dTemperature As Double)" )
     
  outputIJRtePipeRunInsulation = 0
  Exit Function
Handler:
  sMsg = sMsg & "[Error: " & Err.Description & "]"
  Resume Next
End Function
'#endfunction
 
 

 
 

' Implements
Public Sub Publish(colActions As Collection)
    Dim s As String
On Error GoTo Handler
'#colActions
     s = "IJAppConnectionNotification"
     colActions.Add Me, s
     s = "IJMfgChild"
     colActions.Add Me, s
     s = "IJMfgParent"
     colActions.Add Me, s
     s = "IJPartOccAssembly"
     colActions.Add Me, s
     s = "IJRtePipeRunInsulation"
     colActions.Add Me, s
'#endcolActions
Exit Sub
Handler:
    Call mylog("Duplicate Definition for Interface: " & s)
    Resume Next
End Sub


Private Sub Class_Initialize()
   InitLog
End Sub
