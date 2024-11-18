Option Strict Off
Option Explicit On
Imports CompSchemaCont
Imports ConstraintIntfcLib
Imports SchemaCompInterfaces
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
        '// Dimension variables for IContainerHelper, IContainerHelper2,
        Dim oHelper As IContainerHelper
        Dim oHelper2 As IContainerHelper2
        '// an IContainer for both schema and data containers, and an IContainerComposition
        Dim oData As IContainer
        Dim oSchema As IContainer
		'// for the Meta container composition.  Also an IObjectCollection variable.
		'//
        Dim oMettaCC As IContainerComposition
		'// Create the Container helpers.
		'//
        oData = Nothing
        oSchema = Nothing
        oMettaCC = Nothing

		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
		'//
        oHelper = New Helper
        oHelper2 = oHelper

        oHelper2.CreateAllContainersAndContainerCompositions(True, oMettaCC, oSchema, Nothing, oData, My.Application.Info.DirectoryPath & "\PIDComponent.xml", "", My.Application.Info.DirectoryPath & "\Data.xml")

		'// Print out # objects and # PIDInstrument types in the data container (use GetInstancesForClassDef).
        '//

        Debug.Print("Objects count " & oData.ContainedObjects.Count)

        Dim collInstruments As IObjectCollection
        collInstruments = New IntfcProp.ObjectCollection

        'Call oData.IContainerQuery.GetInstancesForClassDef("PIDInstrument", collInstruments)

        Dim oObject As IObject
        'For Each oObject In oData.ContainedObjects
        ' Example 4.9.1.A
        'Debug.Print("oObject " & oObject.Name)
        ' Example 4.9.1.B
        'If oObject.ClassDefIObj.UID = "PIDInstrumentLoop" Then
        ' Example 4.9.1.C
        '    Debug.Print("PIDInstrumentLoop = " & oObject.Name)
        'End If
        'Next


        'oObject = oData.IContainerQuery.GetIObjectForUID("573F431C6601454AB95733A3FEF6359C")
        'Debug.Print("Example 4.2.1.A = " & oObject.Name)


        'Debug.Print("# of PIDInstruments" & collInstruments.Count)
        ''Example 4.9.3
        'Call oSchema.IContainerQuery.GetInstancesForClassDef("PIDInstrumentLoop", collInstruments)
        ''Example 4.9.4
        'Call oSchema.IContainerQuery.GetInstancesForInterfaceDef("IInstrumentLoop", collInstruments)

        Call oData.IContainerQuery.FindObjects("PIDInstrument~PIDInlineInstrument~PIDInstrumentLoop", "", "T*", "", False, collInstruments)


        For Each oObject In collInstruments
            Debug.Print(oObject.Name)
        Next


        '// ReleaseContents for container compositions.
        '//
        oData.ContainerComposition.ReleaseContents()
        oSchema.ContainerComposition.ReleaseContents()
        oMettaCC.ReleaseContents()
        oData = Nothing
        oSchema = Nothing
        oMettaCC = Nothing
        oHelper = Nothing
        oHelper2 = Nothing
        oObject = Nothing
        collInstruments = Nothing
done:
        '// Cleanup by releasing variables
        '//
        Exit Sub

errorHandler:
        MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
        Resume done
    End Sub
End Class