' File : PlaceEqpAndPiping.vb
' Description : SP3D .Net API based Custom Command
' Functional Description : Custom Command to Demonstrate SP3D .net API
'   Create Systems, Place Eqp, Pipelines & Piping, Space Folders & Spaces, Supports
' Written By : Prasad Mantraratnam, SmartPlant 3D Automation Group, Intergraph Corporation
' 
' Change History :
' 01-Nov-2008 : Created
' 01-Mar-2009 : Creating Space Folders, Spaces
' 01-May-2009 : Creating Supports

Option Explicit On

' Imports Section to define commonly used namespaces.
Imports Ingr.SP3D.Common.Client

'PlaceEqpAndPiping Class, a SP3D .Net API based CustomCommand
Public Class PlaceEqpAndPiping
    Inherits BaseModalCommand
    '--> Implementing BaseModalCommand Makes this a Modal type CustomCommand.
    '--> Other types are BaseGraphicCommand / BaseStepCommand 
    '    used for Commands with Graphic/Step Processing

    ' Below is the OnStart() Method which you add logic to execute on Command Start, 
    ' Typically Initialization code, show form etc. For Modal commands, it contains 
    ' all the executed code, or may delegate it all to a Modal form. 
    Public Overloads Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        ' Create and show our form
        Dim myForm As New PlaceEqpAndPipingForm '--> The Form for this command. User Defineable.
        myForm.ShowDialog()
    End Sub

    'To override other Command related methods/properties, just write a new Sub/Property by
    ' typing out the below, and pick from the available methods/properties which you can override.
    ' Public Overloads Overrides
    ' For example, this implementation allows this command to be only
    ' Startable when An ActiveView exists, and ActiveConnection exists.
    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.ActiveView + EnableUIFlagSettings.ActiveConnection
        End Get
    End Property

End Class

