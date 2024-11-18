Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Imports System.Collections.ObjectModel

'
'  This SP3D custom command will read a textfile containing:
'  the following informations:
'       ObjectType=Systems\PipelineSystems
'  or any other object path,e.g.:
'       ObjectType=Piping\PipingRuns
'  The names in the following lines, will be interpreted
'  as names of the above type
'
'
'       Like=True/False
'  if true, the lines containing names may contain wild-card-characters
'
'       Hierarchy=<number>
'  if specified, for each system, the children will be added to
'  the select set too. E.g. a PipingSystem will not be highlighted
'  in the graphic view, but its children, so specify Hierarchy=1
'  to select the Pipelines too, Hierarchy=2 will then also
'  select the Piperuns below the Pipelines
'
'
'       Name=<object name, probably with wild-card-characters>
'  one Name of an object of type as specified in last ObjectType= line
'  probably containg wild-card-characters.
'
'  All objects found will be set into the select set.
'
'       Stop=
'  When this line is encountered, the user is ask,
'  if he wants to continue.
'
'       writeall=
'  will write the names of all objects of the specified type
'  to a file.
'
'  This example will also use the following features:
'  (a) Preference service:
'      the file path specified will be stored in the session
'      and used the next time as default
'
'
Public Class HighLightByFile
    Inherits BaseModalCommand


    Dim sObjectType As String = "Systems\PipelineSystems"
    Dim bLikeOperator As Boolean = False
    Dim iHierarchy As Integer = 0



    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim s As String

        ' Get reference to Preference service
        ' we will store the last filename used for the next call.
        Dim oPM As Preferences = ClientServiceProvider.Preferences

        ' Get access to selectset and clear it
        Dim oSelectSet As SelectSet = ClientServiceProvider.SelectSet
        oSelectSet.SelectedObjects.Clear()

        ' Get the Path of the file from user:
        Dim sPath As String = "c:\temp\list.txt"

        ' The default for the path is retrieved from the session file.
        sPath = oPM.GetStringValue("NL_COURSE_PATH", sPath)

Repeat:
        sPath = InputBox("Enter Path of file", "Piping System List", sPath)
        If sPath = "" Then
            ' User abort
            Exit Sub
        End If


        ' Read file and process the commands in the file
        Dim oRead As System.IO.StreamReader
        Try
            oRead = System.IO.File.OpenText(sPath)
        Catch ex As Exception
            MsgBox("File not found")
            GoTo Repeat ' user should select another filepath
        End Try


        Dim LineIn As String
        Dim sArray() As String


        While oRead.Peek <> -1
            LineIn = Trim(oRead.ReadLine())
            sArray = Split(LineIn, "=")
            If UBound(sArray) >= 1 Then
                Select Case LCase(sArray(0))
                    Case "objecttype"
                        sObjectType = sArray(1)
                    Case "like"
                        bLikeOperator = StrComp(Left(sArray(1), 1), "T", CompareMethod.Text) = 0
                    Case "hierarchy"
                        iHierarchy = CInt(sArray(1))
                    Case "name"
                        HighLightObjects(sArray(1), oSelectSet)
                    Case "names"
                        HighLightMultiObjects(sArray(1), oSelectSet)

                    Case "stop"
                        s = sArray(1)
                        If s = "" Then s = "Do you want to continue?"
                        If MsgBox(s, MsgBoxStyle.YesNo, sObjectType) = MsgBoxResult.No Then
                            GoTo EndProgram
                        End If
                    Case "writeall"
                        WriteAll(sPath, sObjectType)
                    Case "clear"
                        oSelectSet.SelectedObjects.Clear()
                    Case Else
                        If Left(sArray(0), 1) <> "-" Then
                            ClientServiceProvider.ErrHandler.LogError("HighLightByFile", 0, "Unknown Line in File: " & LineIn)

                            'Debug.Assert(False)
                        End If

                End Select

            ElseIf LineIn <> "" Then
                ' assume Name=
                HighLightObjects(LineIn, oSelectSet)
            End If
        End While
EndProgram:
        oRead.Close()


        WriteStatusBarMsg(oSelectSet.SelectedObjects.Count & " in selectset.")


        ' Store the last used filename in the session:
        oPM.SetValue("NL_COURSE_PATH", sPath)



    End Sub

    '
    Private Sub HighLightObjects(ByVal sText As String, ByVal oSelectSet As SelectSet)
        ' Create filter for   sObjectType
        Dim oFilter As New Filter

        oFilter.Definition.AddObjectType(sObjectType)

        ' add check for property name
        Dim oProp As PropertyValueString = _
           New PropertyValueString("IJNamedItem", "Name", sText)

        If bLikeOperator Then
            oFilter.Definition.AddWhereProperty(oProp, PropertyComparisonOperators.LIKE)
        Else
            oFilter.Definition.AddWhereProperty(oProp, PropertyComparisonOperators.EQ)
        End If

        Dim oObs As ReadOnlyCollection(Of BusinessObject)

        oObs = oFilter.Apply()

        For Each oBo In oObs
            oSelectSet.SelectedObjects.Add(oBo)
            addChildren(oBo, iHierarchy, oSelectSet)
        Next

        WriteStatusBarMsg(sObjectType & ": " & oSelectSet.SelectedObjects.Count & " in selectset.")

    End Sub

    Private Sub HighLightMultiObjects(ByVal sText As String, ByVal oSelectSet As SelectSet)
        ' Create filter for  sObjectType
        Dim oFilter As New Filter
        Dim sNameArray() As String = Split(sText, ",")

        oFilter.Definition.AddObjectType(sObjectType)

        Dim oProp As PropertyValueString
        ' add check for list of names

        ' use OR for the different names
        oFilter.Definition.MatchAllProperties = False

        For i = LBound(sNameArray) To UBound(sNameArray)
            oProp = New PropertyValueString("IJNamedItem", "Name", sNameArray(i))
            If bLikeOperator Then
                oFilter.Definition.AddWhereProperty(oProp, PropertyComparisonOperators.LIKE)
            Else
                oFilter.Definition.AddWhereProperty(oProp, PropertyComparisonOperators.EQ)
            End If
        Next

        Dim oObs As ReadOnlyCollection(Of BusinessObject)

        oObs = oFilter.Apply()



        For Each oBo In oObs
            oSelectSet.SelectedObjects.Add(oBo)
            addChildren(oBo, iHierarchy, oSelectSet)
        Next


        WriteStatusBarMsg(sObjectType & ": " & oSelectSet.SelectedObjects.Count & " in selectset.")

    End Sub

    '  add all children to selectset, as long as iHierarchy>0
    '
    Private Sub addChildren(ByVal oBo As BusinessObject, _
                            ByVal iHierarchy As Long, _
                            ByVal oSelectSet As SelectSet)
        If iHierarchy = 0 Then
            Exit Sub
        End If

        If TypeOf oBo Is ISystem Then
            Dim oISystem As ISystem = oBo
            For Each oChild As BusinessObject In oISystem.SystemChildren

                oSelectSet.SelectedObjects.Add(oChild)
                addChildren(oChild, iHierarchy - 1, oSelectSet)
            Next
        End If
    End Sub


    Private Sub WriteAll(ByVal sPath As String, _
                         ByVal sObjectTypes As String)

        Dim sLocalPath As String
        ' Save a list of all object names of specified type:
        Dim oFilter As New Filter
        oFilter.Definition.AddObjectType(sObjectType)
        Dim oObjs As ReadOnlyCollection(Of BusinessObject)
        oObjs = oFilter.Apply

        ' The filename will be (if the original file name was  abc.txt:
        '    abc_<objecttype>.txt
        ' all \ in the objecttype path are replaced by _
        '
        sLocalPath = Left(sPath, Len(sPath) - 4) ' remove .txt
        sLocalPath = sLocalPath & "_" & _
            Replace(sObjectTypes, "\", "_") & ".txt"

        Dim oWriter As New System.IO.StreamWriter(sLocalPath)
        oWriter.WriteLine("ObjectType=" & sObjectType)
        For Each oBo In oObjs
            oWriter.WriteLine(oBo.ToString)
        Next

        oWriter.Close()
    End Sub
End Class
