Option Strict Off
Option Explicit On
Friend Class Ex7F
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		'// Initialize some helper objects
		'//
		Dim oContainerHelper As SchemaCompInterfaces.IContainerHelper
		Dim oContainerHelper2 As SchemaCompInterfaces.IContainerHelper2
		Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
		Dim oSchemaContainer As SchemaCompInterfaces.IContainer
		Dim oDataContainer As SchemaCompInterfaces.IContainer
		Dim oPIDDrawing As SchemaCompInterfaces.IObject
		Dim oRel As SchemaCompInterfaces.IRel
		Dim collEquipment As SchemaCompInterfaces.IObjectCollection
        Dim oEquipment As SchemaCompInterfaces.IObject
        oMetaCC = Nothing
        oSchemaContainer = Nothing
        oDataContainer = Nothing
		
		oContainerHelper = New CompSchemaCont.Helper
		oContainerHelper2 = oContainerHelper
		
		'// Have the helper objects create the containers and load the schema and data
		'//
        Call oContainerHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\data.xml")
		Call oSchemaContainer.ResolveUnresolvedRels()
		Call oDataContainer.ResolveUnresolvedRels()
		
		
		'// PIDDrawing Realizes interfaces : PIDDrawing----(1)Realizes(2)----IInterface
		'// Use the collection of relationships where PIDDrawing is End1 (End1IRelCollection),
		'// filter out the "Realizes" relations, then print out the name of the End2 object (UID2IObj.Name)
		'// to display the Interfaces realized by PIDDrawing.
		'//
		WriteLn("1. Display names of interfaces that PIDDrawing Realizes.")
		
		oPIDDrawing = oSchemaContainer.IContainerQuery.GetIObjectForUID("PIDDrawing")
		For	Each oRel In oPIDDrawing.End1IRelCollection
			If oRel.DefUIDIObj.Name = "Realizes" Then
				WriteLn("PIDDrawing Realizes : " & oRel.UID2IObj.Name)
			End If
		Next oRel
		WriteLn()
		
		'// PIDProcessEquipment is related to PIDNozzle via EquipmentComponentComposition :
		'// PIDProcessEquipment----(2)EquipmentComponentComposition(1)----PIDNozzle
		'// Use the collection of relationships where PIDProcessEquipment is End2 (End2IRelCollection),
		'// filter out the "EquipmentComponentComposition" relations, then print out the type
		'// (UID1IObj.ClassDefIObj.Name) and name of the End1 object (UID1IObj.Name)
		'//
		WriteLn("2. Example navigating the relationships in data (Equipment to nozzle).")
		collEquipment = New IntfcProp.ObjectCollection
		
		Call oDataContainer.IContainerQuery.GetInstancesForClassDef("PIDProcessEquipment", collEquipment)
		If collEquipment.Count > 0 Then
			oEquipment = collEquipment.Item(1)
			
			For	Each oRel In oEquipment.End2IRelCollection
				If oRel.DefUIDIObj.Name = "EquipmentComponentComposition" Then
					WriteLn("PIDProcessEquipment related via EquipmentComponentComposition to : " & oRel.UID1IObj.ClassDefIObj.Name & ", " & oRel.UID1IObj.Name)
				End If
			Next oRel
		End If
		WriteLn()
		
		' Cleanup
		oDataContainer.ContainerComposition.ReleaseContents()
		oSchemaContainer.ContainerComposition.ReleaseContents()
		oMetaCC.ReleaseContents()
		
		'UPGRADE_NOTE: Object oPIDDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oPIDDrawing = Nothing
		'UPGRADE_NOTE: Object oRel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oRel = Nothing
		'UPGRADE_NOTE: Object collEquipment may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		collEquipment = Nothing
		'UPGRADE_NOTE: Object oEquipment may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oEquipment = Nothing
		'UPGRADE_NOTE: Object oMetaCC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oMetaCC = Nothing
		'UPGRADE_NOTE: Object oSchemaContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oSchemaContainer = Nothing
		'UPGRADE_NOTE: Object oDataContainer may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oDataContainer = Nothing
		'UPGRADE_NOTE: Object oContainerHelper2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oContainerHelper2 = Nothing
		'UPGRADE_NOTE: Object oContainerHelper may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		oContainerHelper = Nothing
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