Imports System.Collections.ObjectModel
Imports System.Text
Imports Ingr.SP3D.Common
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.route.middle


Public Class RelationshipsLab
    Inherits BaseModalCommand


    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        Dim oSelectSet = Client.Services.ClientServiceProvider.SelectSet

        If (oSelectSet.SelectedObjects.Count <> 1) Then GoTo ExitWithMessage
        If Not (TypeOf oSelectSet.SelectedObjects.Item(0) Is RouteFeature) Then GoTo ExitWithMessage

        Dim oFeature = oSelectSet.SelectedObjects.Item(0)
        Dim oRelationColl = oFeature.GetRelationship("PathGeneratedParts", "PathDefinedPart")

        Dim strMessage As New StringBuilder()


        oSelectSet.SelectedObjects.Clear()

        Dim I As Long, oBO As BusinessObject
        For I = 0 To oRelationColl.TargetObjects.Count - 1
            oSelectSet.SelectedObjects.Add(oRelationColl.TargetObjects.Item(I))
            oBO = oRelationColl.TargetObjects.Item(I)
            strMessage.Append(oBO.ToString & vbCrLf)
        Next I

        oRelationColl = oFeature.GetRelationship("PathSpecification", "thePathSystemInfo")

        Dim oBO2 = oRelationColl.TargetObjects.Item(0)
        'oBO2 should be the piperun
repeat:
        oRelationColl = oBO2.GetRelationship("SystemHierarchy", "SystemParent")
        If oRelationColl.TargetObjects.Count = 0 Then
            GoTo fin
        End If
        oBO2 = oRelationColl.TargetObjects.Item(0)

        Debug.Print(oBO2.ToString)

        If oBO2.SupportsInterface("IJUnitSystem") Then
            strMessage.Append("UNIT SYTEM: " & oBO2.ToString & vbCrLf)

            Dim oPropString As PropertyValueString
            oPropString = oBO2.GetPropertyValue("IJUnitSystem", "UnitCode")
            strMessage.Append(" Unitcode: " & oPropString.PropValue & vbCrLf)
            Debug.Print(oPropString.PropValue)
        Else
            GoTo repeat
        End If

fin:

        MsgBox(strMessage.ToString(), , "part on selected Feature")
        Exit Sub

ExitWithMessage:
        MsgBox("Select ONE route Feature and run this command")

    End Sub

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.NonEmptySelectSet
        End Get
    End Property


End Class
