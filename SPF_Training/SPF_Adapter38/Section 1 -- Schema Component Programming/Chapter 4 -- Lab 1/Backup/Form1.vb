Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdDoIt_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDoIt.Click
		
		On Error GoTo errorHandler
		
		'// Dimension variables for IContainerHelper, IContainerHelper2,
		'// an IContainer for both schema and data containers, and an IContainerComposition
		'// for the Meta container composition.  Also an IObjectCollection variable.
		'//
		
		'// Create the Container helpers.
		'//
		
		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
		'//
		
		'// Print out # objects and # PIDInstrument types in the data container (use GetInstancesForClassDef).
		'//
		
		'// ReleaseContents for container compositions.
		'//
		
done: 
		'// Cleanup by releasing variables
		'//
		Exit Sub
		
errorHandler: 
		MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
		Resume done
	End Sub
End Class