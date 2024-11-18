Attribute VB_Name = "modSpecial"
Option Explicit

' modSpecial

 
Public gcolUnknownInterfaces As New Collection



Public Sub outputIJDTargetObjectCol(Node1 As MSComctlLib.Node, o As IJDTargetObjectCol, gform As frmShowElement)
    Dim Node2 As MSComctlLib.Node
    Dim Node3 As MSComctlLib.Node
    Dim o2 As Object
    Dim i As Long
 
    Set Node2 = gform.TreeView1.Nodes.Add(Node1, tvwChild, , "IEnumMoniker=?")
    Set Node2 = gform.TreeView1.Nodes.Add(Node1, tvwChild, , "IJDTargetObjectCol  count=..." & o.Count)
    
    For i = 1 To o.Count
        Set o2 = o.Item(i)
        Set Node3 = gform.TreeView1.Nodes.Add(Node2, tvwChild, , "*Item(" & i & ")= Typename=" & TypeName(o2) & " " & getGuid(o2))
        Set Node3.Tag = o2
    Next i
 
 

End Sub

Public Function outputIJDT4x4(M1 As IJDT4x4) As String
 
    Dim i As Long
    Dim s As String
  
    For i = 0 To 15
        s = s & ", " & sDouble(M1.IndexValue(i))
    Next i
    outputIJDT4x4 = Mid(s, 2)

End Function

Public Sub showUnknownInterfaces()
        'List unknown interfaces
        Dim frm As frmShowElement
        Dim var As Variant
        
        Set frm = New frmShowElement
        frm.Caption = "Unimplemented Interfaces"
        Call frm.DisableCommands
        frm.cmdUnknown.Visible = True
        frm.cmdUnknown.Caption = "Create Code"
        Call frm.TreeView1.Nodes.Add(, , , "The following interfaces are not implemented:")
        For Each var In gcolUnknownInterfaces
            Call frm.TreeView1.Nodes.Add(, , , var)
        Next var
        frm.Show
End Sub


Public Function JoinDouble(d() As Double) As String
    Dim i As Long
    On Error GoTo Handler
    For i = LBound(d) To UBound(d)
        JoinDouble = JoinDouble & ", " & d(i)
    Next i
    JoinDouble = "(" & Mid(JoinDouble, 2) & ")"
    Exit Function
Handler:
    JoinDouble = "()"
End Function
Public Function JoinLong(d() As Long) As String
    Dim i As Long
    On Error GoTo Handler
    For i = LBound(d) To UBound(d)
        JoinLong = JoinLong & ", " & d(i)
    Next i
    JoinLong = "(" & Mid(JoinLong, 2) & ")"
    Exit Function
Handler:
    JoinLong = "()"
End Function








Public Sub TestSlabPositions(Form As frmShowElement, Node1 As Node, oHgrSupport As IJHgrSupport)
    Dim IJPort_Struct As IJPort
    Dim iConnObjHlpr As IJHgrConnectableObjHlpr
    Dim iPortHlpr As IJHgrPortHlpr
    Dim my_IJHgrInputConfigHlpr As IJHgrInputConfigHlpr
    Dim my_IJHgrInputObjectInfo As IJHgrInputObjectInfo
    Dim StructPortCollection As Object
    Dim PortCurveObj As Object
    Dim PortCurveSurf As Object
    Dim sMsg As String
    Dim o1 As Object
    Dim Node2 As Node
    
    Set my_IJHgrInputConfigHlpr = oHgrSupport
    Set my_IJHgrInputObjectInfo = oHgrSupport
    Set StructPortCollection = my_IJHgrInputObjectInfo.GetSupportingObjectPorts
    Set IJPort_Struct = StructPortCollection.Item(1)
    
    Set iConnObjHlpr = CreateObject("HgrSupFilterServices.HgrConnectableObjHlpr")
    Set iPortHlpr = iConnObjHlpr.GetConnectableObjPortService(IJPort_Struct.Connectable)
    If (Not (iPortHlpr Is Nothing)) Then
        Set PortCurveObj = iPortHlpr.GetPortCurve(IJPort_Struct, my_IJHgrInputConfigHlpr)
        Set PortCurveSurf = iPortHlpr.GetPortSurface(IJPort_Struct, my_IJHgrInputConfigHlpr)
        If Not PortCurveSurf Is Nothing Then
        
        
                sMsg = "*PortCurveSurf"
                Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
                Set o1 = Nothing
                Set o1 = PortCurveSurf
                Set Node2.Tag = o1
                Node2.Text = sMsg
                
                
        End If
        If Not PortCurveObj Is Nothing Then
        
        
                sMsg = "*PortCurveObj"
                Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)
                Set o1 = Nothing
                Set o1 = PortCurveObj
                Set Node2.Tag = o1
                Node2.Text = sMsg
                
                
        End If
    End If
    
    
    Set iConnObjHlpr = Nothing
    Set iPortHlpr = Nothing
End Sub



'@
'parCGetDouble
'
'  read out a double from a string
'
'Public Function parCGetDouble(strText As String) As Double
'
'  ARGUMENT             DATA TYPE       I/O    DESCRIPTION
'
'  trText               String           I     a string containing a double using decimal points
'
'RETURN VALUE:
'
'  the double value given
'
'GLOBAL REFERENCES:
'
'  VARIABLE               I/O    DESCRIPTION
'
'  <list of global variables used>
'
'NOTES:
'
'
'@
Public Function parCGetDouble(ByVal strText As String) As Double
Static blnFollow As Boolean
Static strDecSep As String
Static strDecAlt As String
Dim strDummy As String

        If blnFollow Then
        'skip
        Else
        'MS does a lot, but is unfortunately not able to recognize decimals independant of dec seperator settings
        ' so do it manually by:
        ' find actual decimal seperator and replace the alternate sign with this
            strDummy = CStr(1.5)
            strDecSep = Mid$(strDummy, 2, 1)
            If strDecSep = "," Then
                strDecAlt = "."
            Else
                strDecAlt = ","
            End If
            blnFollow = True 'do only once
        End If
        strText = Replace$(strText, strDecAlt, strDecSep)
        parCGetDouble = CDbl(strText)
End Function



