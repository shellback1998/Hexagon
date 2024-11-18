Option Explicit On
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.ReferenceData.Middle
Imports Ingr.SP3D.Equipment.Middle

Public Class CPlugType1
    Inherits CustomSymbolDefinition

#Region "Definition of Inputs"
    <InputCatalogPart(1)> Public m_oPartDef As InputCatalogPart
    <InputDouble(2, "FacetoEnd", "Face to End", 0.15)> Public m_dFacetoEnd As InputDouble
#End Region

#Region "Definition of Aspects and their Outputs"
    'Physical Aspect
    <Aspect("Physical", "Physical Aspects", AspectID.SimplePhysical)> <SymbolOutput("PipePort1", "PipePort1")> <SymbolOutput("Body1", "Body1")> <SymbolOutput("Body2", "Body2")> Public m_oPhysicalAspect As AspectDefinition
#End Region

#Region "Construction of Outputs of all Aspects"
   
    Protected Overrides Sub ConstructOutputs()

        Dim oPart As Part = Nothing
        Dim oConnection As SP3DConnection = Nothing
        Dim dFacetoEnd As Double = 0.0

        'Get Input Values
        oPart = m_oPartDef.Value
        dFacetoEnd = m_dFacetoEnd.Value

        oConnection = OccurrenceConnection

        Dim oPipePortDef1 As PipePortDef
        oPipePortDef1 = oPart.PortDefinitions.Item(0)

        Dim oGeomHlpr As New SymbolGeometryHelper()
        Dim oXAxis As New Vector(1, 0, 0), oYAxis As New Vector(0, 1, 0), oZAxis As New Vector(0, 0, 1)
        Dim oNegXAxis As New Vector(-1, 0, 0)
        Dim oLocation1 As New Position(-dFacetoEnd, 0, 0)

        m_oPhysicalAspect.Outputs("PipePort1") = New PipeNozzle(oPart, oConnection, False, 1, oLocation1, oNegXAxis, 0.0, False)

        oGeomHlpr.SetOrientation(oXAxis, oYAxis)
        oGeomHlpr.MoveToPoint(oLocation1)

        m_oPhysicalAspect.Outputs("Body1") = oGeomHlpr.CreateCylinder(oConnection, oPipePortDef1.PipingOutsideDiameter / 2.0, dFacetoEnd)

        Dim oList As New List(Of Position)
        Dim dsize1 As Double = oPipePortDef1.PipingOutsideDiameter / 2.0
        Dim dsize2 As Double = 0.04
        Dim dradius As Double = 0.15

        oList.Add(New Position(-dsize1, -dsize2, 0))
        oList.Add(New Position(dsize1, -dsize2, 0))
        oList.Add(New Position(1.5 * dsize1, 0, 0))
        oList.Add(New Position(dsize1, dsize2, 0))
        oList.Add(New Position(-dsize1, dsize2, 0))
        oList.Add(New Position(-1.5 * dsize1, 0, 0))

        m_oPhysicalAspect.Outputs("Body2") = oGeomHlpr.CreateNEdgePrismaticTorus(oConnection, oList, dradius, 10 * Math.PI / 180.0)

    End Sub
#End Region
End Class
