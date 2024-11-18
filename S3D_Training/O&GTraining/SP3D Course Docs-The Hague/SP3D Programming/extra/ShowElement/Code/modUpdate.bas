Attribute VB_Name = "modUpdate"
Option Explicit

' modUpdate


Public gstrFin As String
Public gstrFout As String

Private mFrm As String


'@
'UpdateSourceFile
'
'  Read this file and automatically insert new code
'
'<full definition>
'
'  ARGUMENT             DATA TYPE       I/O    DESCRIPTION
'
'  none
'
'RETURN VALUE:
'
'  none
'
'GLOBAL REFERENCES:
'
'  VARIABLE               I/O    DESCRIPTION
'
'  <list of global variables used>
'
'NOTES:
'
' This routine should be called from the debugger.
' Then stop the program and add/replace the code
'
' It recognizes the following lines:
'
'
'       '#InterfaceList,<interface1>,<interface2>,....
'       '#EndInterfaceList
'
'       '#colActions
'               ... will insert some code here
'       '#endcolActions
'
'       '#case
'              ... will insert case statements here
'       '#endcase
'
'
'       '#Function,<objectname>
'             ... automatically insert some code here
'       '#Property,<attributename>,                   - the attribute is a simple long, double or string
'       '#Property,<attributename>,comment            - the attribute cannot be expanded, will only be listed
'       '#Property,<attributename>,sub,<interface>    - attribute is of class interface
'       '#Property,<attributename>,ref,<interface>    - attribute is of class interface
'       '#Property,<attributename>,fun,<parameters>   - Method returning parameters (diMo)
'       '#Property,<attributename> As <interface>     - attribute is of class interface
'       '#Property,<attributename>,code,<plain VB code>
'       '#Property,Sub <name>(xyxx)
'       '#Property,Property <name>(xyxx)
'       '#Property,function <name>(xyxx)
'       ...
'
'       '#special
'                 ... here code, which will not be changed automatically
'       '#endspecial
'              ... automatically insert some code here
'       '#EndFunction
'
'  We check, if all #function are found, missing functions are added at the end with empty #special
'
'@
Public Function UpdateSourceFile(strFin As String, strFout As String, _
                        lUseObject As Long) As String
    Dim lngFnr As Long
    Dim lngFnrNew As Long
    Dim lngP As Long
    Dim sText As String
    Dim strLine As String
'    Dim lngL As Long
    Dim strArr() As String
 
    Dim sInterfaces() As String
'    Dim sProps() As String
  
    Dim oI As clsInterface
    Dim colInterfaces As New Collection
    Dim i As Long
    
    On Error GoTo Handler
    
    
    If lUseObject = 1 Then
        mFrm = "Object"
    Else
        mFrm = "frmShowElement"
    End If
    
    gstrFin = ""
    gstrFout = ""
    
    If Len(strFin) <= 0 Then
        strFin = App.Path & "\" & "clsShow.cls"
    End If
    
    lngFnr = FreeFile
    On Error Resume Next
    Open strFin For Input As lngFnr
    If Err Then
        MsgBox "Cannot find file: " & strFin
        Exit Function
    End If
    gstrFin = strFin
    lngP = InStrRev(strFin, "\")
    If Len(strFout) > 0 Then
        ' File given
    ElseIf lngP > 0 Then
        strFout = Left(strFin, lngP) & "updated.cls"
    Else
        strFout = "Updated.cls"
    End If
    UpdateSourceFile = strFout
    lngFnrNew = FreeFile
    Open strFout For Output As lngFnrNew
    If Err Then
        MsgBox "Cannot open file: " & strFout
        Exit Function
    End If
    On Error GoTo 0
    
    gstrFout = strFout
    
 
    
    While Not EOF(lngFnr)
        Line Input #lngFnr, strLine
        If StrComp(Left(strLine, 15), "'#InterfaceList", vbTextCompare) = 0 Then
            sInterfaces = Split(strLine, ",")
            
            For i = 1 To UBound(sInterfaces)
                Set oI = New clsInterface
                oI.Name = sInterfaces(i)
                colInterfaces.Add oI, oI.Name
            Next i
            Print #lngFnrNew, strLine
            Do
                Line Input #lngFnr, strLine
            Loop Until StrComp(Left(strLine, 18), "'#EndInterfaceList", vbTextCompare) = 0
            Print #lngFnrNew, "Private const gsInterfaceList= """ & Join(sInterfaces, ",") & """"
            Print #lngFnrNew, strLine
        ElseIf StrComp(Left(strLine, 10), "'#nomethod", vbTextCompare) = 0 Then
            sText = ""
            Do
                If StrComp(Left(strLine, 10), "'#nomethod", vbTextCompare) = 0 Then
                    Print #lngFnrNew, strLine
                    sInterfaces = Split(strLine, ",")
                    For i = 1 To UBound(sInterfaces)
                        Set oI = New clsInterface
                        oI.Name = sInterfaces(i)
                        oI.bohneMethods = True
                        colInterfaces.Add oI, oI.Name
                
                        sText = sText & "Public Function output" & sInterfaces(i) & "(Form As " & mFrm & ", Node1 As Node, o As Object) As Long" & vbCrLf
                        sText = sText & "End Function" & vbCrLf
                    Next i
                End If
                Line Input #lngFnr, strLine
            Loop Until StrComp(Left(strLine, 13), "'#endnomethod", vbTextCompare) = 0
            Print #lngFnrNew, sText
            Print #lngFnrNew, "'#endnomethod"
            
        ElseIf StrComp(Left(strLine, 6), "'#case", vbTextCompare) = 0 Then
            Print #lngFnrNew, strLine
            Do
                Line Input #lngFnr, strLine
            Loop Until StrComp(Left(strLine, 9), "'#endcase", vbTextCompare) = 0
            ' Print all lines
            For Each oI In colInterfaces
                 Print #lngFnrNew, "     Case """ & oI.Name & """"
                 If Not oI.bohneMethods Then
                    Print #lngFnrNew, "        Call output" & oI.Name & "(Form, Node0, o)"
                 End If
            Next
            Print #lngFnrNew, strLine
             
        ElseIf StrComp(Left(strLine, 12), "'#colActions", vbTextCompare) = 0 Then
            Print #lngFnrNew, strLine
            Do
                Line Input #lngFnr, strLine
            Loop Until StrComp(Left(strLine, 15), "'#endcolActions", vbTextCompare) = 0
            ' Print all lines
            For Each oI In colInterfaces
            
                 Print #lngFnrNew, "     s = """ & oI.Name & """"
                 Print #lngFnrNew, "     colActions.Add Me, s"
                 
            Next
            Print #lngFnrNew, strLine
            
        ElseIf StrComp(Left(strLine, 10), "'#function", vbTextCompare) = 0 Then
            Print #lngFnrNew, strLine
            strArr = Split(strLine, ",")
            ReDim Preserve strArr(1)
            If Len(strArr(1)) <= 0 Then
                ' No function name, ignore the line
                GoTo NextLine
            End If
            
            Set oI = Nothing
            On Error Resume Next
            Set oI = colInterfaces.Item(strArr(1))
            On Error GoTo Handler
            If oI Is Nothing Then
                Set oI = New clsInterface
                oI.Name = strArr(1)
                colInterfaces.Add oI, oI.Name
            End If
            oI.lCount = oI.lCount + 1
   
            
            Call processFunction(strArr(1), lngFnr, lngFnrNew)
            
            
   
        Else
            Print #lngFnrNew, strLine
        End If
NextLine:
    Wend
    
    ' add functions for those interfaces, which are not yet in the file
 
    For Each oI In colInterfaces
        If oI.lCount = 0 And Not oI.bohneMethods Then
            
            Call PrintFunctionPart(lngFnrNew, oI.Name, 1)
            Call PrintFunctionPart(lngFnrNew, oI.Name, 2)
        End If
    Next
     
    
wrapup:
    On Error Resume Next
    Close lngFnrNew
    Close lngFnr
    Exit Function
Handler:
    MsgBox Err.Description, vbOKOnly
    Debug.Assert False
    Exit Function
    Resume
End Function

Private Sub processFunction(sName As String, lngFnr As Long, lngFnrNew As Long)
    Dim sLine As String
    Dim sProps() As String
    
    Call PrintFunctionPart(lngFnrNew, sName, 1)
    
    Do
        Line Input #lngFnr, sLine
        If StrComp(Left(sLine, 13), "'#endfunction", vbTextCompare) = 0 Then
            
            Exit Do
        ElseIf StrComp(Left(sLine, 9), "'#special", vbTextCompare) = 0 Then
            Print #lngFnrNew, sLine
            Do
                Line Input #lngFnr, sLine
                Print #lngFnrNew, sLine
                If StrComp(Left(sLine, 12), "'#endspecial", vbTextCompare) = 0 Then Exit Do
            Loop
        ElseIf StrComp(Left(sLine, 10), "'#Property", vbTextCompare) = 0 Then
            Print #lngFnrNew, sLine
            sProps = Split(sLine, ",")
    
            Call printProperty(lngFnrNew, sName, sProps)
        End If
        
    Loop
    
    Call PrintFunctionPart(lngFnrNew, sName, 2)
    Print #lngFnrNew, sLine
End Sub
Private Sub printProperty(lngFnrNew As Long, sName As String, sProps() As String)
        Dim sp2() As String
        Dim sp3() As String
        Dim i As Long
        Dim sAdditional As String
        Dim sVarlist As String
        
        If UBound(sProps) < 1 Then
            ReDim Preserve sProps(1)
        End If
        
        If sProps(1) <> "" Then
        sp3 = Split(sProps(1), " ")
        If StrComp(sp3(0), "Sub", vbTextCompare) = 0 Or _
            StrComp(sp3(0), "Function", vbTextCompare) = 0 Or _
            StrComp(sp3(0), "Property", vbTextCompare) = 0 Then
                ReDim sp2(UBound(sProps) - 1)
                For i = 0 To UBound(sp2)
                    sp2(i) = sProps(1 + i)
                Next i
                sAdditional = Join(sp2, ",")
                Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , """ & sAdditional & """ )"
                Exit Sub
        End If
        End If
        
        If UBound(sProps) < 3 Then
            ReDim Preserve sProps(3)
        End If
        
        ReDim sp2(UBound(sProps) - 3)
        For i = 0 To UBound(sp2)
            sp2(i) = sProps(3 + i)
        Next i
        sProps(3) = Join(sp2, ",")
        
   
        If InStr(1, sProps(1), " As ", vbTextCompare) > 0 Then
                sp2 = Split(sProps(1), " ")
                ReDim Preserve sp2(2)
                sProps(1) = sp2(0)
                sProps(2) = "ref"
                sProps(3) = sp2(2)
      

        End If
        
        If StrComp(sProps(2), "sub", vbTextCompare) = 0 Then ' not used
            Print #lngFnrNew, "   Call output" & sProps(3) & "(Form, Node1,obj." & sProps(1) & ")"
        ElseIf StrComp(sProps(2), "ref", vbTextCompare) = 0 Then
            Print #lngFnrNew, "   sMsg = ""*" & sProps(1) & """"
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)"
            Print #lngFnrNew, "   Set o1 = Nothing"
            Print #lngFnrNew, "   Set o1 = obj." & sProps(1)
            Print #lngFnrNew, "   Set Node2.Tag = o1"
            Print #lngFnrNew, "   Node2.Text = sMsg"

        ElseIf StrComp(sProps(2), "comment", vbTextCompare) = 0 Then
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , """ & sProps(1) & "=... [ " & sProps(3) & "]"")"
        
        ElseIf StrComp(sProps(2), "enum", vbTextCompare) = 0 Then
            Print #lngFnrNew, "   sMsg = """ & sProps(1) & "= "" & obj." & sProps(1) & " & "" [" & sProps(3) & "]"""
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild)"
            Print #lngFnrNew, "   Node2.Text = sMsg"
            
        ElseIf StrComp(sProps(2), "fun", vbTextCompare) = 0 Then
            Print #lngFnrNew, "   sMsg = """ & sProps(1) & "= """
            sVarlist = getVarList(sProps(3), 1, sAdditional)
            If sAdditional <> "" Then
                Print #lngFnrNew, Mid(sAdditional, 3) ' omit the first crlf
            End If
            Print #lngFnrNew, "   Call obj." & sProps(1) & sVarlist
            ' add  sMsg & at front in case of failure.
            Print #lngFnrNew, "   sMsg = sMsg & " & getVarList(sProps(3), 2, sAdditional)
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)"
            If sAdditional <> "" Then
                Print #lngFnrNew, Mid(sAdditional, 3) ' omit the first crlf
            End If
            
        ElseIf Len(sProps(1)) <= 0 Then
            ' do nothing
        ElseIf Len(sProps(2)) <= 0 Then
            Print #lngFnrNew, "   sMsg = """ & sProps(1) & "= """
            Print #lngFnrNew, "   sMsg = sMsg & obj." & sProps(1)
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)"
        Else
            Debug.Print sProps(1) & "," & sProps(2)
            Debug.Assert False
            Print #lngFnrNew, "' - unknown code: " & sProps(2)
            Print #lngFnrNew, "   sMsg = """ & sProps(1) & "= "
            Print #lngFnrNew, "   sMsg = sMsg & obj." & sProps(1)
            Print #lngFnrNew, "   Set Node2 = Form.TreeView1.Nodes.Add(Node1, tvwChild, , sMsg)"
        End If
End Sub
Private Function PrintFunctionPart(lngFnrNew As Long, _
        strType As String, lngPart As Long)
'Dim var As Variant
'Dim sProps() As String

If lngPart = 1 Then

    Print #lngFnrNew, "Public Function output" & strType & "(Form As " & mFrm & ", Node1 As Node, o As Object) As Long"
    Print #lngFnrNew, "Dim obj As " & strType
    Print #lngFnrNew, "Dim Node2 As MSComctlLib.Node"
    Print #lngFnrNew, "Dim Node3 As MSComctlLib.Node"
    Print #lngFnrNew, "Dim sMsg As String"
    Print #lngFnrNew, "  output" & strType & " = -1"
    Print #lngFnrNew, "  On Error GoTo Handler"
    Print #lngFnrNew, "  Set obj = o"
    Print #lngFnrNew, "  If obj Is Nothing Then Exit Function"
     
    
ElseIf lngPart = 2 Then
 
    Print #lngFnrNew, "     "
 
    Print #lngFnrNew, "  output" & strType & " = 0"
    Print #lngFnrNew, "  Exit Function"
    Print #lngFnrNew, "Handler:"
    Print #lngFnrNew, "  sMsg = sMsg & ""[Error: "" & Err.Description & ""]"""
    Print #lngFnrNew, "  Resume Next"
 
    Print #lngFnrNew, "End Function"
 
End If
End Function

'Private Function getFromIndex(sArr() As String, i As Long, delim As String) As String
'    Dim j As Long
'    getFromIndex = sArr(i)
'    For j = i + 1 To UBound(sArr)
'        getFromIndex = getFromIndex & delim & sArr(j)
'    Next j
'End Function


Private Function getVarList(ByVal sP As String, typ As Long, sAdditional As String) As String
    Dim ch As String
    Dim i As Long
    Dim bCopyMode As Boolean
    
    sAdditional = ""
    bCopyMode = False
    
    If typ = 1 Then
        getVarList = "("
        For i = 1 To Len(sP)
            ch = Mid(sP, i, 1)
            
            If bCopyMode Then
                If ch = """" Then
                    bCopyMode = False
                Else
                    getVarList = getVarList & ch
                End If
            ElseIf ch = """" Then
                bCopyMode = True
                 
            Else
                getVarList = getVarList & ch & i
 
                If i < Len(sP) Then
                    getVarList = getVarList & ", "
                End If
                
                If ch = "o" Then
                    sAdditional = sAdditional & vbCrLf & _
                        "   Set " & ch & i & " = Nothing"
                End If
            End If
        Next i
        getVarList = getVarList & ")"
    Else
        getVarList = """( "" & "
        For i = 1 To Len(sP)
            ch = Mid(sP, i, 1)
            
            If bCopyMode Then
                If ch = """" Then
                    bCopyMode = False
                End If
                getVarList = getVarList & ch
                
            ElseIf ch = """" Then
                bCopyMode = True
                getVarList = getVarList & ch
            ElseIf ch = "d" Then
                getVarList = getVarList & "sDouble(" & ch & i & ")"
            ElseIf ch = "M" Then
                getVarList = getVarList & "outputIJDT4x4(" & ch & i & ")"
            ElseIf StrComp(ch, "o", vbTextCompare) = 0 Then
                sAdditional = sAdditional & vbCrLf & _
                    "   Set Node3 = Form.TreeView1.Nodes.Add(Node2, tvwChild, , ""*Par" & i & """)" & vbCrLf & _
                    "   Set Node3.Tag = o" & i
                getVarList = getVarList & """" & "Par" & i & """"
            Else
                getVarList = getVarList & ch & i
            End If
            If Not bCopyMode Then
                If i < Len(sP) Then
                        getVarList = getVarList & " & "", """
                End If
                getVarList = getVarList & " & "
            End If
        Next i
        getVarList = getVarList & """)"""
        
    End If
    
End Function

