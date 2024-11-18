Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Imports System.Collections.ObjectModel

'
'  This SP3D custom command will read a textfile containing:
'  Line 1:
'       ObjectType=Systems\PipelineSystems
'  or any other object path,e.g.:
'       ObjectType=Piping\PipingRuns
'
'  Line 2: (optional)
'       Like=True
'  if specified, the lines containing names may contain wild-card-characters
'
'  Line 3: (optional)
'       Hierarchy=2   (any number)
'  if specified, for each system, the children will be added to
'  the select set too. E.g. a PipingSystem will not be highlighted
'  in the graphic view, but its children, so specify Hierarchy=1
'  to select the Pipelines too, Hierarchy=2 will then also
'  select the Piperuns below the Pipelines
'
'
'  Line 4, following:
'  each line: one Name of an object of type as specified in line 1
'  probably containg wild-card-characters.
'
'  All objects found will be set into the select set.
'
'
'  This example will also use the following features:
'  (a) Preference service:
'      the file path specified will be stored in the session
'      and used the next time as default
'  (b) At the end, a file:    xxxx_All.txt will be written.
'      this file will contain the header:
'      ObjectType= as specified in the original file
'      and after this line a list of all objects of this
'      object type in the actual sp3d model.
'
'
Public Class HighLightPipingSystems
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim bLikeOperator As Boolean = False
        Dim iHierarchy As Integer = 0

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


        ' Read file and put all names into a dictionary
        Dim oDic As New Dictionary(Of String, String)
        Dim oRead As System.IO.StreamReader
        Try
            oRead = System.IO.File.OpenText(sPath)
        Catch ex As Exception
            MsgBox("File not found")
            GoTo Repeat
        End Try


        Dim LineIn As String
        Dim sArray() As String
        Dim sObjectType As String = "Systems\PipelineSystems"

        While oRead.Peek <> -1
            LineIn = Trim(oRead.ReadLine())
            sArray = Split(LineIn, "=")

            If UBound(sArray) = 1 Then
                Select Case LCase(sArray(0))
                    Case "objecttype"
                        sObjectType = sArray(1)
                    Case "like"
                        bLikeOperator = True
                    Case "hierarchy"
                        iHierarchy = CInt(sArray(1))
                    Case "name"
                        oDic.Add(sArray(1), sArray(1))
                End Select
 
            ElseIf LineIn <> "" Then
                oDic.Add(LineIn, LineIn)
            End If
        End While

        oRead.Close()

        ' Create filter for all pipelinesystems(or: sObjectType)
        Dim oFilter As New Filter

        oFilter.Definition.AddObjectType(sObjectType)

        Dim oObs As ReadOnlyCollection(Of BusinessObject)

        oObs = oFilter.Apply()

 

        ' Go through all objects, which path the filter
        ' and if the name is in
        ' the list (dictionary), put it into selectionset
        If bLikeOperator Then
            ' we have to loop through all objects in filter result
            ' and in all strings in dictionary
            For Each oBo In oObs
                For Each sText As String In oDic.Values
                    If oBo.ToString Like sText Then
                        ' add object to select list
                        oSelectSet.SelectedObjects.Add(oBo)
                        addChildren(oBo, iHierarchy, oSelectSet)
                        Exit For 'Stop search for names
                    End If

                Next
            Next
        Else
            ' For each object in filter's list,
            ' we check existence in dictionary
            For Each oBo In oObs
                If oDic.ContainsValue(oBo.ToString) Then
                    ' add object to selectset
                    oSelectSet.SelectedObjects.Add(oBo)

                    addChildren(oBo, iHierarchy, oSelectSet)

                End If
            Next
        End If

        WriteStatusBarMsg(oSelectSet.SelectedObjects.Count & " in selectset.")


        ' Store the last use filename in the session:
        oPM.SetValue("NL_COURSE_PATH", sPath)

        ' Save a list of all objects of specified type:
        ' in a file named:   xxxx_ALL.txt
        '
        Dim sPath2 As String
        sPath2 = Left(sPath, Len(sPath) - 4) & "_all.txt"
        Dim oWriter As New System.IO.StreamWriter(sPath2)
        oWriter.WriteLine("ObjectType=" & sObjectType)
        For Each oBo In oObs
            oWriter.WriteLine(oBo.ToString)
        Next

        oWriter.Close()



    End Sub

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
End Class
