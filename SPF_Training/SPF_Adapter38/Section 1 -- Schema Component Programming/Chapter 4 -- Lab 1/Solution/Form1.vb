Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
		Dim oHelper As SchemaCompInterfaces.IContainerHelper
		Dim oHelper2 As SchemaCompInterfaces.IContainerHelper2
		Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
		Dim oSchemaContainer As SchemaCompInterfaces.IContainer
		Dim oDataContainer As SchemaCompInterfaces.IContainer
		Dim oObject As SchemaCompInterfaces.IObject
        Dim collInstruments As SchemaCompInterfaces.IObjectCollection
        oMetaCC = Nothing
        oSchemaContainer = Nothing
        oDataContainer = Nothing
		
		oHelper = New CompSchemaCont.Helper
		oHelper2 = oHelper
		
		'// Have the helper objects create the containers and load the schema and data
		'//
		Call oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")
		Call oSchemaContainer.ResolveUnresolvedRels()
		
		Debug.Print("Data Container contains this many objects : " & oDataContainer.ContainedObjects.Count)
		
		collInstruments = New IntfcProp.ObjectCollection
		
		Call oDataContainer.IContainerQuery.GetInstancesForClassDef("PIDInstrument", collInstruments)
		Debug.Print("Data Container contains this many Instruments : " & collInstruments.Count)
		
done: 
		'// Cleanup
		'//
		oDataContainer.ContainerComposition.ReleaseContents()
		oSchemaContainer.ContainerComposition.ReleaseContents()
		oMetaCC.ReleaseContents()
		'UPGRADE_NOTE: Object collInstruments may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		collInstruments = Nothing
		'UPGRADE_NOTE: Object oMetaCC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oMetaCC = Nothing
		'UPGRADE_NOTE: Object oSchemaContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oSchemaContainer = Nothing
		'UPGRADE_NOTE: Object oDataContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oDataContainer = Nothing
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