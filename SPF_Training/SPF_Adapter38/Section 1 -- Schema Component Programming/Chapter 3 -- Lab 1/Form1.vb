Option Strict Off
Option Explicit On
Imports CompSchemaCont
Imports SchemaCompInterfaces

Friend Class Form1
	Inherits System.Windows.Forms.Form
	Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
		
		On Error GoTo errorHandler
		
        '// Dimension variables for IContainerHelper, IContainerHelper2,
        Dim oHelper As IContainerHelper
        Dim oHelper2 As IContainerHelper2
        '// an IContainer for both schema and data containers, and an IContainerComposition
        Dim oSchema As IContainer
        Dim oData As IContainer

        oSchema = Nothing
        oData = Nothing


		'// for the Meta container composition.
		'//
        Dim oMeta As IContainerComposition

        oMeta = Nothing
		'// Create the Container helpers.
        '//
        oHelper = New Helper
        oHelper2 = oHelper

		
		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
        '//
        oHelper2.CreateAllContainersAndContainerCompositions(True, oMeta, oSchema, Nothing, oData, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")
		'// Print out # objects in schema container and data container.
		'//
        Debug.Print("Number of Objext in the data container " & oData.ContainedObjects.Count)
        Debug.Print("Number of Object in the Schema container " & oSchema.ContainedObjects.Count)
		'// ReleaseContents for container compositions.
		'//
        oData.ContainerComposition.ReleaseContents()
        oSchema.ContainerComposition.ReleaseContents()
        oMeta.ReleaseContents()

        oSchema = Nothing
        oData = Nothing
        oMeta = Nothing
        oHelper = Nothing
        oHelper2 = Nothing

done: 
		Exit Sub
		
errorHandler: 
		MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
		Resume done
	End Sub
End Class