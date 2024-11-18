Option Explicit On
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Route.Middle
Imports System.Collections.ObjectModel


Public Class CPipeRun
    Inherits NameRuleBase

    Public Overrides Sub ComputeName(oEntity As Ingr.SP3D.Common.Middle.BusinessObject, oParents As System.Collections.ObjectModel.ReadOnlyCollection(Of Ingr.SP3D.Common.Middle.BusinessObject), oActiveEntity As Ingr.SP3D.Common.Middle.BusinessObject)

        Dim strNPD As String
        Dim strNPDUnit As String
        Dim strSpecName As String
        Dim StrParentName As String

        Dim oPipeRun As PipeRun

        oPipeRun = oEntity
        strNPD = CStr(oPipeRun.NPD.Size)
        strNPDUnit = oEntity.GetPropertyValue("IJRtePipeRun", "NPDUnitType").ToString

        If LCase(strNPDUnit) = "in" Then
            strNPDUnit = Chr(34)
        End If

        Dim oRelationCollection As RelationCollection
        Dim oSpec As BusinessObject

        oRelationCollection = oEntity.GetRelationship("PathRunUsesSpec", "Spec")
        oSpec = oRelationCollection.TargetObjects.Item(0)

        strSpecName = oSpec.GetPropertyValue("IJDPipeSpec", "SpecName").ToString

        StrParentName = oParents.Item(0).GetPropertyValue("IJNamedItem", "Name").ToString

        oEntity.SetPropertyValue(StrParentName & "-" & strNPD & strNPDUnit & "-" & strSpecName, "IJNamedItem", "Name")

    End Sub

    Public Overrides Function GetNamingParents(oEntity As Ingr.SP3D.Common.Middle.BusinessObject) As System.Collections.ObjectModel.Collection(Of Ingr.SP3D.Common.Middle.BusinessObject)

        Dim oParent As BusinessObject
        Dim oParentColl As New Collection(Of BusinessObject)

        GetNamingParents = Nothing

        oParent = GetParent(HierarchyTypes.System, oEntity)
        oParentColl.Add(oParent)
        GetNamingParents = oParentColl

    End Function
End Class
