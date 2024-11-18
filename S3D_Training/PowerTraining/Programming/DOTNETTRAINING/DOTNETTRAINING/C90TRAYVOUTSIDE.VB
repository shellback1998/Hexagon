Option Explicit On
Imports System.Math
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.ReferenceData.Middle

<SymbolVersion("1.0.0.0")> <VariableOutputs()> _
Public Class C90TrayVOutside
    Inherits CustomSymbolDefinition

#Region "Definition of Inputs"

    <InputCatalogPart(1)> Public m_oPart As InputCatalogPart
    <InputDouble(2, "FrameRadius", "Frame Radius", 0.015)> Public m_dFrameRadius As InputDouble

#End Region

#Region "Definitions of Aspects and tehir outputs"

    'Physical Aspect
    <Aspect("Physical", "Physical Aspect", AspectID.SimplePhysical)> _
    <SymbolOutput("TrayPort1", "Tray Port 1")> _
    <SymbolOutput("TrayPort2", "Tray Port 2")> _
    Public m_oPhysicalAspect As AspectDefinition

#End Region

#Region "Construction of Outputs of all aspects"
    Protected Overrides Sub ConstructOutputs()
        Dim oTrayPart As Part, oConnection As SP3DConnection
        Dim oTrayPort1 As CableTrayPortDef, oTrayPort2 As CableTrayPortDef

        Dim dFrameRadius As Double
        Dim dWidth As Double, dDepth As Double, dBendRad As Double

        '=============================Get Input Values===========================
        oConnection = OccurrenceConnection
        dFrameRadius = m_dFrameRadius.Value

        oTrayPart = m_oPart.Value
        If (CType(oTrayPart.PortDefinitions.Item(0), CableTrayPortDef).PortIndex = 1) Then
            oTrayPort1 = oTrayPart.PortDefinitions.Item(0)
            oTrayPort2 = oTrayPart.PortDefinitions.Item(1)
        Else
            oTrayPort1 = oTrayPart.PortDefinitions.Item(1)
            oTrayPort2 = oTrayPart.PortDefinitions.Item(0)
        End If

        Dim oPropertyValueDouble As PropertyValueDouble
        'Get Property Values from the part and port1
        oPropertyValueDouble = oTrayPart.GetPropertyValue("IJCableTrayPart", "Bend Radius")
        dBendRad = oPropertyValueDouble.PropValue
        oPropertyValueDouble = oTrayPort1.GetPropertyValue("IJCableTrayPort", "Actual Width")
        dWidth = oPropertyValueDouble.PropValue
        oPropertyValueDouble = oTrayPort1.GetPropertyValue("IJCableTrayPort", "Actual Depth")
        dDepth = oPropertyValueDouble.PropValue

        '==========================================================================
        'Construction of Physical Aspect
        '==========================================================================

        Dim dHDepth As Double, dHWidth As Double, dAngle As Double
        Dim dFacetoCenter As Double, dTubeLenght As Double

        dHDepth = dDepth / 2
        dHWidth = dWidth / 2
        dFacetoCenter = (dBendRad + dHDepth)
        dTubeLenght = (dBendRad + dDepth)
        dAngle = Math.PI / 2.0

        Dim oXAxis As New Vector(1, 0, 0), oYAxis As New Vector(0, 1, 0), oZAxis As New Vector(0, 0, 1)
        Dim oNegXAxis As New Vector(-1, 0, 0), oNegYAxis As New Vector(0, -1, 0), oNegZAxis As New Vector(0, 0, -1)

        '=====================================Place the Ports============================================
        'Define the port positions
        Dim oPort1location As New Position(-dFacetoCenter, 0, 0)
        Dim oPort2location As New Position(0, 0, -dFacetoCenter)

        'Place Nozzle 1
        Dim oCableTrayPort = New CableTrayPort(oTrayPart, oConnection, 1, oPort1location, oNegXAxis)
        oCableTrayPort.RadialVector = oZAxis
        m_oPhysicalAspect.Outputs("TrayPort1") = oCableTrayPort

        'Place Nozzle 2
        oCableTrayPort = New CableTrayPort(oTrayPart, oConnection, 2, oPort2location, oNegZAxis)
        oCableTrayPort.RadialVector = oXAxis
        m_oPhysicalAspect.Outputs("TrayPort2") = oCableTrayPort

        '=================================Main Body Output===============================================

        Dim oGeomHlpr As New SymbolGeometryHelper()
        'Define point and axis revolution
        oGeomHlpr.ActivePosition = New Position(-dFacetoCenter, 0, -dBendRad - dHDepth)
        oGeomHlpr.SetOrientation(oYAxis, oZAxis)

        'Define U Shape Cross Section
        Dim oPointsColl As New Collection(Of Position)
        oPointsColl.Add(New Position(oPort1location.X, oPort1location.Y + dHWidth, oPort1location.Z + dHDepth))
        oPointsColl.Add(New Position(oPort1location.X, oPort1location.Y + dHWidth, oPort1location.Z - dHDepth))
        oPointsColl.Add(New Position(oPort1location.X, oPort1location.Y - dHWidth, oPort1location.Z - dHDepth))
        oPointsColl.Add(New Position(oPort1location.X, oPort1location.Y - dHWidth, oPort1location.Z + dHDepth))
        Dim oLineStr = New LineString3d(oPointsColl)
        Dim oElbow = oGeomHlpr.CreateSurfaceofRevolution(oConnection, oLineStr, dAngle)
        m_oPhysicalAspect.Outputs("Body1") = oElbow
        oPointsColl.Clear()

        '=============================Rails Outputs====================

        'reset current position to the left top side of port1
        oGeomHlpr.ActivePosition = New Position(-dFacetoCenter, dHWidth, dHDepth)
        'Save current position as point1
        oGeomHlpr.DefinePlacePoint(New Matrix4X4(oGeomHlpr.GetActiveMatrix()), 1)
        oGeomHlpr.SetOrientation(oXAxis, oZAxis)
        m_oPhysicalAspect.Outputs("LeftHube") = oGeomHlpr.CreateCylinder(oConnection, dFrameRadius, dTubeLenght)
        'Save current position as Point2
        oGeomHlpr.DefinePlacePoint(New Matrix4X4(oGeomHlpr.GetActiveMatrix()), 2)

        oGeomHlpr.SetOrientation(oNegZAxis, oNegXAxis)
        m_oPhysicalAspect.Outputs("LeftVtube") = oGeomHlpr.CreateCylinder(oConnection, dFrameRadius, dTubeLenght)

        'Move back current position to point1
        oGeomHlpr.MoveToPlacePoint(1)
        oGeomHlpr.MoveAlongAxis(-dWidth, SymbolGeometryHelper.AxisDirection.Secondary)
        oGeomHlpr.SetOrientation(oXAxis, oZAxis)
        m_oPhysicalAspect.Outputs("RightHtube") = oGeomHlpr.CreateCylinder(oConnection, dFrameRadius, dTubeLenght)

        'Set the orientation vector
        oGeomHlpr.SetOrientation(oNegZAxis, oXAxis)
        m_oPhysicalAspect.Outputs("RightVTube") = oGeomHlpr.CreateCylinder(oConnection, dFrameRadius, dTubeLenght)

        'Move Back current position to point2
        oGeomHlpr.MoveToPlacePoint(2)
        oGeomHlpr.MoveAlongAxis(dFrameRadius, SymbolGeometryHelper.AxisDirection.Secondary)
        oGeomHlpr.SetOrientation(oNegYAxis, oZAxis)
        m_oPhysicalAspect.Outputs("Midtube") = _
            oGeomHlpr.CreateCylinder(oConnection, dFrameRadius, dWidth + 2 * dFrameRadius)

    End Sub
#End Region

End Class
