Imports System.Collections.ObjectModel
Imports System.Text
Imports Ingr.SP3D.Common
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Route.Middle


Public Class RelationShipLab
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)

        Dim oSelectSet As SelectSet = ClientServiceProvider.SelectSet

        If oSelectSet.SelectedObjects.Count <> 1 Then GoTo ExitWithMEssage
        If Not (TypeOf oSelectSet.SelectedObjects.Item(0) Is RouteFeature) Then GoTo ExitWithMessage

        Dim oFeature As BusinessObject
        Dim oRelationColl As RelationCollection
        Dim oRelationColl2 As RelationCollection
        Dim oBo2 As BusinessObject

        oFeature = oSelectSet.SelectedObjects.Item(0)
        oRelationColl = oFeature.GetRelationship("PathGeneratedParts", "PathDefinedPart")
        Dim strMessage As New StringBuilder
        Dim oPropString As PropertyValueString


        strMessage.Append(oRelationColl.TargetObjects.Count & " Parts related to selected feature: " & oFeature.ToString & vbCrLf)

        oSelectSet.SelectedObjects.Clear()

        For Each oBo As BusinessObject In oRelationColl.TargetObjects
            oSelectSet.SelectedObjects.Add(oBo)

            oRelationColl2 = oBo.GetRelationship("madeFrom", "part")

            strMessage.Append(oBo.ToString)

            If oRelationColl2.TargetObjects.Count > 0 Then
                oBo2 = oRelationColl2.TargetObjects.Item(0)
                oPropString = oBo2.GetPropertyValue("IJDPart", "PartNumber")
                strMessage.Append(" " & oPropString.PropValue & vbCrLf)
 
            End If

            oRelationColl2 = oBo.GetRelationship("DistribPorts", "DistribPort")
            If oRelationColl2.TargetObjects.Count > 0 Then
                For Each obo3 As BusinessObject In oRelationColl2.TargetObjects
                    strMessage.Append(vbCrLf & "   Port: " & obo3.ToString())
                Next
    

            End If
            strMessage.Append(vbCrLf)
        Next

        ' Traverse to the piperun of the feature:
        oRelationColl = oFeature.GetRelationship( _
                   "PathSpecification", "thePathSystemInfo")

        oBo2 = oRelationColl.TargetObjects.Item(0)
        ' obo2 should be the piperun

        ' traverse through the system hierarchy to find a unit system
        ' If there is no unit system, stop
        Do While True

            oRelationColl = oBo2.GetRelationship("SystemHierarchy ", "SystemParent")
            If oRelationColl.TargetObjects.Count = 0 Then
                ' No parent in the hierarchy, stop loop
                Exit Do
            End If
            oBo2 = oRelationColl.TargetObjects.Item(0)

            ' IF object supports the defining interface IJUnitSystem,
            ' then it is a unit system
            If oBo2.SupportsInterface("IJUnitSystem") Then
                ' Add name and Unitcode to the output:
                strMessage.Append("UNIT SYSTEM: " & oBo2.ToString)

                Dim oPropString1 As PropertyValueString
                oPropString1 = oBo2.GetPropertyValue("IJUnitSystem", "UnitCode")

                strMessage.Append(" UnitCode: " & oPropString1.PropValue & vbCrLf)

                Exit Do
            End If

        Loop

        MsgBox(strMessage.ToString, , "Parts on Selected Feature")
        Exit Sub
ExitWithMessage:
        MsgBox("Select ONE route feature before calling the command.")

    End Sub
End Class
