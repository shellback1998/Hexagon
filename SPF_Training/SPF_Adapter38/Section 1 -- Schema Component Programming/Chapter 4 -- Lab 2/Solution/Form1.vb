Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
		'// Dimension vars
		'//
		Dim oHelper As SchemaCompInterfaces.IContainerHelper
		Dim oHelper2 As SchemaCompInterfaces.IContainerHelper2
		Dim oMetaCC As SchemaCompInterfaces.IContainerComposition
		Dim oSchemaContainer As SchemaCompInterfaces.IContainer
		Dim oDataContainer As SchemaCompInterfaces.IContainer
		Dim oInstrumentDef As SchemaCompInterfaces.IObject
		Dim oClassDef As SchemaCompInterfaces.IClassDef
		Dim collInstruments As SchemaCompInterfaces.IObjectCollection
        Dim oInstrument As SchemaCompInterfaces.IObject
        oMetaCC = Nothing
        oSchemaContainer = Nothing
        oDataContainer = Nothing
		
		oHelper = New CompSchemaCont.Helper
		oHelper2 = oHelper
		
		'// Have the helper objects create the containers and load the schema and data
		'//
		Call oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchemaContainer, Nothing, oDataContainer, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")
		Call oSchemaContainer.ResolveUnresolvedRels()
		
		'// Get the definition of PIDInstrument from the schema container.
		'//
		oInstrumentDef = oSchemaContainer.IContainerQuery.GetIObjectForUID("PIDInstrument")
		
		'// Get the instances of PIDInstrument from the data container composition by using
		'// the IClassDef.Instances method.  You'll need to set an IClassDef var from the PIDInstrument
		'// definition IObject.
		'//
		'// TECH NOTE: Note that the collInstruments collection does *not* have to be
		'//            New'ed if it's a return value.
		'//
		oClassDef = oInstrumentDef
		collInstruments = oClassDef.Instances((oDataContainer.ContainerComposition))
		
		'// Loop through the Instances collection and print out the UID and Name for each PIDInstrument.
		'//
		For	Each oInstrument In collInstruments
			Debug.Print("Instrument UID: " & oInstrument.UID & ", Name: " & oInstrument.Name)
		Next oInstrument
		
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