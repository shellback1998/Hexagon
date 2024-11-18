Option Strict Off
Option Explicit On
Imports CompSchemaCont
Imports ConstraintIntfcLib
Imports IntfcProp
Imports SchemaCompInterfaces

Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
        '// Dimension variables for IContainerHelper, IContainerHelper2,
        Dim oHelper As IContainerHelper
        Dim oHelper2 As IContainerHelper2
        '// an IContainer for both schema and data containers, and an IContainerComposition
        Dim oSchema As IContainer
        Dim oData As IContainer
        Dim oMetaCC As IContainerComposition
        Dim oInstrumentdef As IObject
        Dim oClassDef As IClassDef
		'// for the Meta container composition.  Also an IObjectCollection variable.
		'//
        Dim collObject As IObjectCollection
        oSchema = Nothing
        oData = Nothing
        oMetaCC = Nothing

		'// Create the Container helpers.
		'//
        oHelper = New Helper
        oHelper2 = oHelper
		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
		'//
        oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchema, Nothing, oData, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")
        Call oSchema.ResolveUnresolvedRels()
		'// Get the definition of PIDInstrument from the schema container; use GetIObjectForUID.
		'//
        oInstrumentdef = oSchema.IContainerQuery.GetIObjectForUID("PIDInstrument")

		'// Get the instances of PIDInstrument from the data container composition by using
		'// the IClassDef.Instances method.  You'll need to set an IClassDef var from the PIDInstrument
		'// definition IObject
		'//
        oClassDef = oInstrumentdef

        collObject = oClassDef.Instances((oData.ContainerComposition))
		'// Loop through the Instances collection and print out the UID and Name for each PIDInstrument.
		'//
        For Each oInstrumentdef In collObject
            Debug.Print("Instrument UID: " & oInstrumentdef.UID & ", Name: " & oInstrumentdef.Name)
        Next
		'// ReleaseContents for container compositions.
        '//

        oData.ContainerComposition.ReleaseContents()
        oSchema.ContainerComposition.ReleaseContents()
        oMetaCC.ReleaseContents()
        oData = Nothing
        oSchema = Nothing
        oMetaCC = Nothing
        collObject = Nothing
        oInstrumentdef = Nothing

done: 
		'// Cleanup by releasing variables
		'//
		Exit Sub
		
errorHandler: 
		MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
		Resume done
	End Sub
End Class