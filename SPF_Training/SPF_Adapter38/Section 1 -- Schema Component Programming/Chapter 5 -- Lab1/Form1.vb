Option Strict Off
Option Explicit On
Imports CompSchemaCont
Imports ConstraintIntfcLib
Imports IntfcProp
Imports SchemaCompInterfaces
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		'// Dim needed variables
		'//
        Dim oData As IContainer
        Dim oSchema As IContainer
        Dim oMetaCC As IContainerComposition
        Dim oHelper As IContainerHelper
        Dim oHelper2 As IContainerHelper2
        Dim collObject As IObjectCollection
        Dim oObject As IObject
        Dim oRel As IRel

        oData = Nothing
        oSchema = Nothing
        oMetaCC = Nothing

        collObject = Nothing
        oObject = Nothing



		'// Initialize some helper objects
		'//
        oHelper = New Helper
        oHelper2 = oHelper
		
		'// Have the helper objects create the containers and load the schema and data
        '//
        Call oHelper2.CreateAllContainersAndContainerCompositions(True, oMetaCC, oSchema, Nothing, oData, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")

        ''                                                                                                          
		'// ResolveUnresolvedRels for Schema and data containers
		'//
        Call oSchema.ResolveUnresolvedRels()
        Call oData.ResolveUnresolvedRels()
		
		'// Use IContainerQuery.GetInstancesForClassDef() to get PIDDrawing objects from data container.
		'// Use the first object in the collection...
        '//
        collObject = New ObjectCollection
        Call oData.IContainerQuery.GetInstancesForInterfaceDef("PIDDrawing", collObject)
        oObject = collObject.Item(1)

		
		'// Enumerate the IRel objects in oDrawing.End1IRelCollection().
		'// Print out the UID of the object at End2 and the name of the relationship.
        '//
        'For Each oRel In oObject.End1IRelCollection
        '    Debug.Print("PIDDrawing as End1 related to End2 object : " & oRel.UID2 & "via relationship : " & oRel.DefUIDIObj.Name)
        'Next oRel


        '// Try the same enumeration for oDrawing.End2RelCollection().
        '//
        For Each oRel In oObject.End2IRelCollection
            Debug.Print("PIDDrawing as End2 related to End1 object : " & oRel.UID1 & "via relationship : " & oRel.DefUIDIObj.Name)
        Next oRel
        '// Cleanup--ContainerComposition.ReleaseContents and set all object vars = Nothing
        '//
        oData.ContainerComposition.ReleaseContents()
        oSchema.ContainerComposition.ReleaseContents()
        oMetaCC.ReleaseContents()
        oData = Nothing
        oSchema = Nothing
        oMetaCC = Nothing
        collObject = Nothing

	End Sub
	
	Private Sub WriteLn(Optional ByRef sText As String = "")
		txtMessage.Text = txtMessage.Text & sText & vbCrLf
	End Sub
End Class