Option Explicit On
Imports System.Math
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.ReferenceData.Middle
Imports Ingr.SP3D.Equipment.Middle


<SymbolVersion("2.0.0.0")> Public Class CCBallTy1
    Inherits CustomSymbolDefinition

#Region "Definition of Inputs"
    <InputCatalogPart(1)> Public m_oPartDef As InputCatalogPart
    <InputDouble(2, "FacetoFace", "FacetoFace", 0.3, True)> Public m_dFacetoFace As InputDouble
    <InputDouble(3, "Face1toCenter", "Face1toCenter", 0.3, True)> Public m_dFace1toCenter As InputDouble
    <InputDouble(4, "Face2toCenter", "Face2toCenter", 0.3, True)> Public m_dFace2toCenter As InputDouble
    <InputDouble(5, "CylHeight", "CylinderHeight", 0.2)> Public m_dCylHeight As InputDouble
    <InputDouble(6, "HandwheelAngle", "HandweheelAngle", 0.0)> Public m_dHandwheelAngle As InputDouble
    <InputDouble(7, "OffsetFrmValCen", "OffsetFrmValcen", 0.2)> Public m_dOffsetFrmValCen As InputDouble
    <InputDouble(8, "InsulationThickness", "Insulation Thickness", 0.025)> Public m_dInsulationThickness As InputDouble
#End Region

#Region "Definition of Aspects and their Outputs"
    'Physical Aspect
    <Aspect("Physical", "Physical Aspects", AspectID.SimplePhysical)> _
    <SymbolOutput("Body0", "Body0")> _
    <SymbolOutput("Body1", "Body1")> _
    <SymbolOutput("Body2", "Body2")> _
    <SymbolOutput("PipePort1", "PipePort1")> _
    <SymbolOutput("PipePort2", "PipePort2")> _
    <SymbolOutput("Body3", "Body3")> _
    <SymbolOutput("Operator", "Operator occurrence")> _
    Public m_oPhysicalAspect As AspectDefinition

    'Insulation Aspect
    <Aspect("Insulation", "Insulation Aspect", AspectID.Insulation)> _
    <SymbolOutput("Body1Insulation", "Body1Insulation")> _
    <SymbolOutput("Body2Insulation", "Body2Insulation")> _
    Public m_oInsulationAspect As AspectDefinition

#End Region

    Protected Overrides Sub ConstructOutputs()
        Dim oPart As Part = Nothing
        Dim oConnection As SP3DConnection = Nothing
        Dim dFacetoFace As Double = 0.0, dFace1toCenter As Double = 0.0, dFace2toCenter As Double = 0.0
        Dim dCylHeight As Double = 0.0

        oPart = m_oPartDef.Value
        dCylHeight = m_dCylHeight.Value

        oConnection = OccurrenceConnection

        Dim dPartDatabasis As Long
        Dim oPropertyValueCodelist As PropertyValueCodelist = Nothing
        oPropertyValueCodelist = oPart.GetPropertyValue("IJDPipeComponent", "PartDataBasis")
        dPartDatabasis = oPropertyValueCodelist.PropValue

        '=======================================================
        'Construction of Physical Aspect
        '=======================================================

        Dim oGeomHlpr As New SymbolGeometryHelper()
        Dim oXAxis As New Vector(1, 0, 0), oYAxis As New Vector(0, 1, 0), oZAxis As New Vector(0, 0, 1)
        Dim oNegXAxis As New Vector(-1, 0, 0), oNegYAxis As New Vector(0, -1, 0), oNegZAxis As New Vector(0, 0, -1)

        Dim oOrigin As New Position(0, 0, 0)
        oGeomHlpr.ActivePosition = oOrigin

        '==================Main Body Output===================================

        Select Case dPartDatabasis
            Case 1, 5
                dFacetoFace = m_dFacetoFace.Value

                m_oPhysicalAspect.Outputs("Body0") = oGeomHlpr.CreateSphere(oConnection, dFacetoFace / 3.0)
                oGeomHlpr.MoveToPoint(New Position(-0.5 * dFacetoFace, 0, 0))
                m_oPhysicalAspect.Outputs("Body1") = oGeomHlpr.CreateCylinder(oConnection, dCylHeight / 4, dFacetoFace / 2.0)
                m_oPhysicalAspect.Outputs("Body2") = oGeomHlpr.CreateCylinder(oConnection, dCylHeight / 4, dFacetoFace / 2.0)

            Case 10
                dFace1toCenter = m_dFace1toCenter.Value
                dFace2toCenter = m_dFace2toCenter.Value
                dFacetoFace = dFace1toCenter + dFace2toCenter

                m_oPhysicalAspect.Outputs("Body0") = oGeomHlpr.CreateSphere(oConnection, dFacetoFace / 3.0)
                oGeomHlpr.MoveToPoint(New Position(-dFace1toCenter, 0, 0))
                m_oPhysicalAspect.Outputs("Body1") = oGeomHlpr.CreateCylinder(oConnection, dCylHeight / 4, dFace1toCenter)
                m_oPhysicalAspect.Outputs("Body2") = oGeomHlpr.CreateCylinder(oConnection, dCylHeight / 4, dFace2toCenter)
        End Select

        '==Body3
        oGeomHlpr.MoveToPoint(oOrigin)
        oGeomHlpr.SetOrientation(oYAxis, oZAxis)
        'Define points for constructing the LineString3D for Body3
        Dim oPointColl As New List(Of Position)
        Dim dFactor As Double = dCylHeight / 1.5
        oPointColl.Add(New Position(oOrigin.X - 0.2 * dFactor, oOrigin.Y - 0.4 * dFactor, oOrigin.Z))
        oPointColl.Add(New Position(oOrigin.X + 0.2 * dFactor, oOrigin.Y - 0.4 * dFactor, oOrigin.Z))
        oPointColl.Add(New Position(oOrigin.X + 0.5 * dFactor, oOrigin.Y, oOrigin.Z))
        oPointColl.Add(New Position(oOrigin.X + 0.2 * dFactor, oOrigin.Y + 0.4 * dFactor, oOrigin.Z))
        oPointColl.Add(New Position(oOrigin.X - 0.2 * dFactor, oOrigin.Y + 0.4 * dFactor, oOrigin.Z))
        oPointColl.Add(New Position(oOrigin.X - 0.5 * dFactor, oOrigin.Y, oOrigin.Z))

        Dim oCrossSection As LineString3d
        oCrossSection = oGeomHlpr.CreateLineString(Nothing, oPointColl, True)

        'Body3
        Dim dOffsetFrmValCen As Double = 0.0
        dOffsetFrmValCen = m_dOffsetFrmValCen.Value
        m_oPhysicalAspect.Outputs("Body3") = _
            oGeomHlpr.CreateProjectedPolygonFromCrossSection(oConnection, oCrossSection, dOffsetFrmValCen, True)

        'Handwheel
        Dim dHandwheelAngle As Double = 0.0
        dHandwheelAngle = m_dHandwheelAngle.Value

        Dim oPipeComp As IPipeComponent
        Dim oOperator As ComponentOcc, oOperatorPart As IPart

        oPipeComp = oPart
        oOperatorPart = oPipeComp.ValveOperator
        oOperator = New ComponentOcc(oOperatorPart, oConnection)
        oOperator.Origin = New Position(0, dOffsetFrmValCen, 0)
        oOperator.SetOrientation(New Vector(Cos(dHandwheelAngle), 0, Sin(dHandwheelAngle)), New Vector(0, 1, 0))
        m_oPhysicalAspect.Outputs("Operator") = oOperator

        '==================================================
        'Construction of Insulation Aspect
        '==================================================

        Dim dPartInsulationThickness As Double
        dPartInsulationThickness = m_dInsulationThickness.Value

        oGeomHlpr.ActivePosition = oOrigin
        oGeomHlpr.SetOrientation(oXAxis, oYAxis)

        Select Case dPartDatabasis
            Case 1, 5
                dFacetoFace = m_dFacetoFace.Value
                oGeomHlpr.MoveToPoint(New Position(-0.5 * dFacetoFace, 0, 0))
                m_oInsulationAspect.Outputs("Body1Insulation") = _
                    oGeomHlpr.CreateCylinder(oConnection, dFacetoFace / 3.0 + 2 * dPartInsulationThickness, dFacetoFace / 2.0)
                m_oInsulationAspect.Outputs("Body2Insulation") = _
                    oGeomHlpr.CreateCylinder(oConnection, dFacetoFace / 3.0 + 2 * dPartInsulationThickness, dFacetoFace / 2.0)
            Case 10
                dFace1toCenter = m_dFace1toCenter.Value
                dFace2toCenter = m_dFace2toCenter.Value
                dFacetoFace = dFace1toCenter + dFace2toCenter

                oGeomHlpr.MoveToPoint(New Position(-dFace1toCenter, 0, 0))
                m_oInsulationAspect.Outputs("Body1Insulation") = _
                    oGeomHlpr.CreateCylinder(oConnection, dFacetoFace / 3.0 + 2 * dPartInsulationThickness, dFace1toCenter)
                m_oInsulationAspect.Outputs("Body2Insulation") = _
                    oGeomHlpr.CreateCylinder(oConnection, dFacetoFace / 3.0 + 2 * dPartInsulationThickness, dFace2toCenter)
        End Select


        '==============================Place the Ports=================================

        Dim oPipePortDef1 As PipePortDef, oPipePortDef2 As PipePortDef

        If (CType(oPart.PortDefinitions.Item(0), PipePortDef).PortIndex = 1) Then
            oPipePortDef1 = oPart.PortDefinitions.Item(0)
            oPipePortDef2 = oPart.PortDefinitions.Item(1)
        Else
            oPipePortDef1 = oPart.PortDefinitions.Item(1)
            oPipePortDef2 = oPart.PortDefinitions.Item(0)
        End If

        Select Case dPartDatabasis
            Case 1, 5
                Dim oPlacementPos As New Position(-0.5 * dFacetoFace _
                                                  + oPipePortDef1.SeatingOrGrooveOrSocketDepth _
                                                  - oPipePortDef1.FlangeProjectionOrSocketOffset, 0, 0)
                m_oPhysicalAspect.Outputs("PipePort1") = _
                    New PipeNozzle(oPart, oConnection, False, 1, oPlacementPos, oNegXAxis, 0.0, False)

                oPlacementPos.Set(0.5 * dFacetoFace _
                                                  - oPipePortDef2.SeatingOrGrooveOrSocketDepth _
                                                  + oPipePortDef2.FlangeProjectionOrSocketOffset, 0, 0)
                m_oPhysicalAspect.Outputs("PipePort2") = _
                    New PipeNozzle(oPart, oConnection, False, 2, oPlacementPos, oXAxis, 0.0, False)
            Case 10
                Dim oPlacementPos As New Position(-dFace1toCenter _
                                                  + oPipePortDef1.SeatingOrGrooveOrSocketDepth _
                                                  - oPipePortDef1.FlangeProjectionOrSocketOffset, 0, 0)
                m_oPhysicalAspect.Outputs("PipePort1") = _
                    New PipeNozzle(oPart, oConnection, False, 1, oPlacementPos, oNegXAxis, 0.0, False)

                oPlacementPos.Set(dFace2toCenter _
                                                  - oPipePortDef2.SeatingOrGrooveOrSocketDepth _
                                                  + oPipePortDef2.FlangeProjectionOrSocketOffset, 0, 0)
                m_oPhysicalAspect.Outputs("PipePort2") = _
                    New PipeNozzle(oPart, oConnection, False, 2, oPlacementPos, oXAxis, 0.0, False)
        End Select

    End Sub
End Class
