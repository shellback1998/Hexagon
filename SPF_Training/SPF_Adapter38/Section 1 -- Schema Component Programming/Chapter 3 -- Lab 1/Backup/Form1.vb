Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
		
		On Error GoTo errorHandler
		
		'// Dimension variables for IContainerHelper, IContainerHelper2,
		'// an IContainer for both schema and data containers, and an IContainerComposition
		'// for the Meta container composition.
		'//
		
		'// Create the Container helpers.
		'//
		
		'// Use the Helper2 to CreateAllContainersAndContainerCompositions().
		'//
		
		'// Print out # objects in schema container and data container.
		'//
		
		'// ReleaseContents for container compositions.
		'//
		
done: 
		Exit Sub
		
errorHandler: 
		MsgBox("Error Number : " & Err.Number & ", " & Err.Description)
		Resume done
	End Sub
End Class