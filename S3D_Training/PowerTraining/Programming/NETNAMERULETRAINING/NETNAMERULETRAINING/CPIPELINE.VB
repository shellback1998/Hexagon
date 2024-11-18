Option Explicit On
Imports Ingr.SP3D.Common.Middle
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Systems.Middle

Public Class CPipeline
    Inherits NameRuleBase

    Public Overrides Sub ComputeName(oEntity As Ingr.SP3D.Common.Middle.BusinessObject, oParents As System.Collections.ObjectModel.ReadOnlyCollection(Of Ingr.SP3D.Common.Middle.BusinessObject), oActiveEntity As Ingr.SP3D.Common.Middle.BusinessObject)
        Dim strSeqNumber As String
        Dim strFluidCode As String
        Dim oStrPropValue As PropertyValueString
        Dim oCLPropValue As PropertyValueCodelist
        Dim strUnitName As String

        If TypeOf oParents.Item(0) Is UnitSystem Then
            oStrPropValue = oParents.Item(0).GetPropertyValue("IJNamedItem", "Name")
            strUnitName = oStrPropValue.PropValue
        Else
            strUnitName = "NoValue"
        End If

        oCLPropValue = oEntity.GetPropertyValue("IJPipelineSystem", "FluidCode")
        strFluidCode = oCLPropValue.PropertyInfo.CodeListInfo.GetCodelistItem(oCLPropValue.PropValue).Name

        oStrPropValue = oEntity.GetPropertyValue("IJPipelineSystem", "SequenceNumber")
        strSeqNumber = oStrPropValue.PropValue

        Dim strPipelineName As String = strUnitName & "-" & strFluidCode & "-" & strSeqNumber
        oEntity.SetPropertyValue(strPipelineName, "IJNamedItem", "Name")

    End Sub

    Public Overrides Function GetNamingParents(oEntity As Ingr.SP3D.Common.Middle.BusinessObject) As System.Collections.ObjectModel.Collection(Of Ingr.SP3D.Common.Middle.BusinessObject)

        GetNamingParents = Nothing

        Dim oChild As BusinessObject
        Dim oParent As BusinessObject
        Dim oParentColl As New Collection(Of BusinessObject)

        oChild = oEntity
        Do
            oParent = GetParent(HierarchyTypes.System, oChild)
            oChild = oParent
        Loop Until TypeOf oChild Is UnitSystem Or Not TypeOf oParent Is ISystemChild

        If oChild Is Nothing Then
            GetNamingParents = Nothing
        Else
            oParentColl.Add(oChild)
            GetNamingParents = oParentColl
        End If

    End Function
End Class
