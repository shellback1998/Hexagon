Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
		
		On Error GoTo errorHandler
		
		Dim oHelper As SchemaCompInterfaces.IContainerHelper
		Dim oHelper2 As SchemaCompInterfaces.IContainerHelper2
		Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
		Dim oSchemaContainer As SchemaCompInterfaces.IContainer
        Dim oDataContainer As SchemaCompInterfaces.IContainer
        oDataContainer = Nothing
        oSchemaContainer = Nothing
        oMetaCC = Nothing
		
		'// Create the Container helpers.
		'//
		oHelper = New CompSchemaCont.Helper
		oHelper2 = oHelper
		
		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
		'//
		oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")
		
		'// Print out # objects in schema container and data container.
		'//
		Debug.Print("Schema container contains this many objects : " & oSchemaContainer.ContainedObjects.Count)
		Debug.Print("Data container contains this many objects : " & oDataContainer.ContainedObjects.Count)
		
		'// ReleaseContents for container compositions.
		'//
		oDataContainer.ContainerComposition.ReleaseContents()
		oSchemaContainer.ContainerComposition.ReleaseContents()
		oMetaCC.ReleaseContents()
		
done: 
		'UPGRADE_NOTE: Object oDataContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oDataContainer = Nothing
		'UPGRADE_NOTE: Object oSchemaContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oSchemaContainer = Nothing
		'UPGRADE_NOTE: Object oMetaCC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oMetaCC = Nothing
		'UPGRADE_NOTE: Object oHelper2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oHelper2 = Nothing
		'UPGRADE_NOTE: Object oHelper may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oHelper = Nothing
		Exit Sub
		
errorHandler: 
		MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
		Resume done
	End Sub
End Class