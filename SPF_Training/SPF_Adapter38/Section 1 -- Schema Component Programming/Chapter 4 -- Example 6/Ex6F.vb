Option Strict Off
Option Explicit On
Friend Class Ex6F
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
		Dim oHelper As SchemaCompInterfaces.IContainerHelper
		Dim oHelper2 As SchemaCompInterfaces.IContainerHelper2
		Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
		Dim oSchemaContainer As SchemaCompInterfaces.IContainer
		Dim oDataContainer As SchemaCompInterfaces.IContainer
		Dim oObject As SchemaCompInterfaces.IObject
		Dim collObjects As SchemaCompInterfaces.IObjectCollection
		Dim oClassDef As SchemaCompInterfaces.IClassDef
		Dim oRel As SchemaCompInterfaces.IRel
        Dim oRelDef As SchemaCompInterfaces.IRelDef
        oMetaCC = Nothing
        oSchemaContainer = Nothing
        oDataContainer = Nothing
		
		oHelper = New CompSchemaCont.Helper
		oHelper2 = oHelper
		
		'// Have the helper objects create the containers and load the schema and data
		'//
        Call oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\data.xml")
		Call oSchemaContainer.ResolveUnresolvedRels()
		
		
		' =============================================================================================================================================
        WriteLn("Example navigating the Realizes relationship via Software relations (InterfaceDefs realized by PIDPipeline).")
        oObject = oSchemaContainer.IContainerQuery.GetIObjectForUID("PIDPipeline")
		oClassDef = oObject
		
		For	Each oRel In oClassDef.RealizedInterfaceDefs
            WriteLnIObject((oRel.UID2IObj))
		Next oRel
		WriteLn()
		
		' =============================================================================================================================================
		WriteLn("Example navigating the End1 and End2 Relations between RelDef and InterfaceDef (InterfaceDefs related through InstrumentLoopAssembly).")
		oObject = oSchemaContainer.IContainerQuery.GetIObjectForUID("InstrumentLoopAssembly")
		
		oRelDef = oObject
		
		WriteLnIObject(oRelDef.IRel.UID1IObj)
		WriteLnIObject(oRelDef.IRel.UID2IObj)
		
		WriteLn()
		
done: 
		'// Cleanup
		'//
		oDataContainer.ContainerComposition.ReleaseContents()
		oSchemaContainer.ContainerComposition.ReleaseContents()
		oMetaCC.ReleaseContents()
		'UPGRADE_NOTE: Object collObjects may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		collObjects = Nothing
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
	
	Private Sub WriteLn(Optional ByRef sText As String = "")
		txtMessage.Text = txtMessage.Text & sText & vbCrLf
	End Sub
	
	Private Sub WriteLnIObject(ByRef oIObject As SchemaCompInterfaces.IObject)
		If oIObject Is Nothing Then
			WriteLn("Nothing found.")
		Else
			WriteLn("ClassDef=" & oIObject.ClassDefIObj.Name & ", Name=" & oIObject.Name & ", Uid=" & oIObject.UID)
		End If
	End Sub
	
	Private Sub WriteLnIObjectCollection(ByRef oIObjectCollection As SchemaCompInterfaces.IObjectCollection)
		WriteLn("Object collection, count=" & oIObjectCollection.Count)
		Dim oIObject As SchemaCompInterfaces.IObject
		For	Each oIObject In oIObjectCollection
			WriteLnIObject(oIObject)
		Next oIObject
		WriteLn()
	End Sub
End Class