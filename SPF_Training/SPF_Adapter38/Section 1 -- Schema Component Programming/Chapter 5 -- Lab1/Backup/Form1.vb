Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		'// Dim needed variables
		'//
        Dim oContainerHelper As SchemaCompInterfaces.IContainerHelper
        Dim oContainerHelper2 As SchemaCompInterfaces.IContainerHelper2
        Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
        Dim oSchemaContainer As SchemaCompInterfaces.IContainer
        Dim oDataContainer As SchemaCompInterfaces.IContainer
        Dim oDrawing As SchemaCompInterfaces.IObject
        Dim collDrawings As SchemaCompInterfaces.IObjectCollection
        Dim oRel As SchemaCompInterfaces.IRel
        'Dim ii As Integer
        oMetaCC = Nothing
        oDataContainer = Nothing
        oSchemaContainer = Nothing
		
		'// Initialize some helper objects
		'//
        oContainerHelper = New CompSchemaCont.Helper
        oContainerHelper2 = oContainerHelper
		
		'// Have the helper objects create the containers and load the schema and data
		'//
        Call oContainerHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\data.xml")
        ''                                                                                                          
		'// ResolveUnresolvedRels for Schema and data containers
		'//
        Call oSchemaContainer.ResolveUnresolvedRels()
        Call oDataContainer.ResolveUnresolvedRels()
		
		'// Use IContainerQuery.GetInstancesForClassDef() to get PIDDrawing objects from data container.
		'// Use the first object in the collection...
        '//
        collDrawings = New IntfcProp.ObjectCollection
        Call oDataContainer.IContainerQuery.GetInstancesForClassDef("PIDDrawing", collDrawings)
        oDrawing = collDrawings.Item(1)
		
		'// Enumerate the IRel objects in oDrawing.End1IRelCollection().
		'// Print out the UID of the object at End2 and the name of the relationship.
        '//
        For Each oRel In oDrawing.End1IRelCollection
            WriteLn(" " & oRel.DefUIDIObj.Name & " " & oRel.UID2)

        Next

        '// Try the same enumeration for oDrawing.End2RelCollection().
        '//
        For Each oRel In oDrawing.End2IRelCollection
            WriteLn("" & oRel.DefUIDIObj.Name & " " & oRel.UID1)

        Next
        '// Cleanup--ContainerComposition.ReleaseContents and set all object vars = Nothing
        '//
        'UPGRADE_NOTE: Object oRel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
        oRel = Nothing
        'UPGRADE_NOTE: Object collDrawings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
        collDrawings = Nothing
        'UPGRADE_NOTE: Object oDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
        oDrawing = Nothing
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
End Class