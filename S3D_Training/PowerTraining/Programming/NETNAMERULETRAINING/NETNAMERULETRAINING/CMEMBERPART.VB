Option Explicit On
Imports Ingr.SP3D.Common.Middle
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Structure.Middle
Public Class CMemberPart
    Inherits NameRuleBase

    Public Overrides Sub ComputeName(oEntity As Ingr.SP3D.Common.Middle.BusinessObject, oParents As System.Collections.ObjectModel.ReadOnlyCollection(Of Ingr.SP3D.Common.Middle.BusinessObject), oActiveEntity As Ingr.SP3D.Common.Middle.BusinessObject)

        Dim strMemType As String
        Dim oCLPropValue As PropertyValueCodelist

        oCLPropValue = oEntity.GetPropertyValue("ISPSMemberType", "TypeCategory")
        strMemType = UCase(oCLPropValue.PropertyInfo.CodeListInfo.GetCodelistItem(oCLPropValue.PropValue).Name)

        Dim strSectionName As String
        Dim oBO As BusinessObject
        Dim oRelationCollection As RelationCollection
        Dim oStrPropValue As PropertyValueString

        oRelationCollection = oEntity.GetRelationship("SPSMemberToCrossSectionRln", "Generation6_DEST")
        oBO = oRelationCollection.TargetObjects.Item(0)

        oRelationCollection = oBO.GetRelationship("SPSDefinitionCrossSectionRln", "Definition_ORIG")
        oBO = oRelationCollection.TargetObjects.Item(0)

        oStrPropValue = oBO.GetPropertyValue("IStructCrossSection", "SectionName")
        strSectionName = UCase(oStrPropValue.PropValue)

        Dim strBaseName As String
        strBaseName = strMemType + "-" + strSectionName

        Dim lCount As Long
        Dim strLocation As String = vbNullString

        GetCountAndLocationID(strBaseName, lCount, strLocation)

        oEntity.SetPropertyValue(strBaseName + "-" + strLocation + "-" + Format(lCount, "0000"), "IJNamedItem", "Name")

    End Sub

    Public Overrides Function GetNamingParents(oEntity As Ingr.SP3D.Common.Middle.BusinessObject) As System.Collections.ObjectModel.Collection(Of Ingr.SP3D.Common.Middle.BusinessObject)

        GetNamingParents = Nothing

    End Function
End Class
