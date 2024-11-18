Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.ReferenceData.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Structure.Middle
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Grids.Middle
Imports Ingr.SP3D.Equipment.Middle

Public Class frmStructCmd2

    'position from which we'll build the structure
    Private m_vec As New Vector(50, 50, 0)
    Private m_bInputValid As Boolean = True
    Private m_oTxnMgr As TransactionManager


    Private Sub btmOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btmOK.Click

        'check if we have entered a valid location
        If m_bInputValid = False Then
            MsgBox("Please enter valid coordinates")
            Exit Sub
        End If

        Dim oStructSystem As StructuralSystem
        Dim oCatStructHelper As CatalogStructHelper
        Dim oModelConn As Model

        Try
            '''''''''''''''''''''''''''''''''''''''''''
            'INITIALIZE
            '''''''''''''''''''''''''''''''''''''''''''
            'get transaction Mgr
            m_oTxnMgr = MiddleServiceProvider.TransactionMgr

            'get Model conection
            oModelConn = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel
            'get root system
            Dim oRootSystem As ISystem = oModelConn.RootSystem

            'create a structural system
            oStructSystem = New StructuralSystem(DirectCast(oRootSystem, BusinessObject))
            oStructSystem.SetUserDefinedName("SP3DAPIStructureLab")

            'initalize catalog helper with the CATALOG connection
            oCatStructHelper = New CatalogStructHelper(MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantCatalog)

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'CREATE COORDINATE SYSTEM
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oCS As CoordinateSystem

            Dim oXAxis As GridAxis
            Dim oYAxis As GridAxis
            Dim oZAxis As GridAxis


            Dim oElevPlane_Z_0 As GridElevationPlane  'elevation plane at 0 m
            Dim oElevPlane_Z_5 As GridElevationPlane  'elevation plane at 5 m

            Dim oGridPlane_X_0 As GridPlane     'grid plane at X = 0 (YZ plane)
            Dim oGridPlane_X_10 As GridPlane     'grid plane at X = 10 (YZ plane)

            Dim oGridPlane_Y_0 As GridPlane     'grid plane at Y = 0 (XZ plane)
            Dim oGridPlane_Y_10 As GridPlane     'grid plane at Y = 10 (XZ plane)

            Dim oGridLine_Z0_X0 As GridLine  'parallel to Y axis
            Dim oGridLine_Z0_X10 As GridLine  'parallel to Y axis
            Dim oGridLine_Z5_X0 As GridLine  'parallel to Y axis
            Dim oGridLine_Z5_X10 As GridLine  'parallel to Y axis

            Dim oGridLine_Z0_Y0 As GridLine  'parallel to X axis
            Dim oGridLine_Z0_Y10 As GridLine  'parallel to X axis
            Dim oGridLine_Z5_Y0 As GridLine  'parallel to X axis
            Dim oGridLine_Z5_Y10 As GridLine  'parallel to X axis



            'coord system
            oCS = New CoordinateSystem(oModelConn, CoordinateSystem.CoordinateSystemType.Grids)
            oCS.Origin = New Position(m_vec.X, m_vec.Y, m_vec.Z)
            oCS.SetPropertyValue("CS_StructureLab", "IJNamedItem", "Name")
            oStructSystem.AddSystemChild(oCS)



            'create the grid axis X,Y,Z
            oXAxis = New GridAxis(oCS, AxisType.X)
            oYAxis = New GridAxis(oCS, AxisType.Y)
            oZAxis = New GridAxis(oCS, AxisType.Z)

            'create elevation planes
            oElevPlane_Z_0 = New GridElevationPlane(0.0, oZAxis)
            oElevPlane_Z_0.SetUserDefinedName("Elev0")

            oElevPlane_Z_5 = New GridElevationPlane(5.0, oZAxis)
            oElevPlane_Z_5.SetUserDefinedName("Elev5")

            'X (YZ) planes
            oGridPlane_X_0 = New GridPlane(0.0, oXAxis)
            oGridPlane_X_0.SetUserDefinedName("X0")

            oGridPlane_X_10 = New GridPlane(10.0, oXAxis)
            oGridPlane_X_10.SetUserDefinedName("X10")

            'Y (XZ) planes
            oGridPlane_Y_0 = New GridPlane(0.0, oYAxis)
            oGridPlane_Y_0.SetUserDefinedName("Y0")

            oGridPlane_Y_10 = New GridPlane(10.0, oYAxis)
            oGridPlane_Y_10.SetUserDefinedName("Y10")

            'grid lines - those are created from the intersection of 
            'GridPlanes
            oGridLine_Z0_X0 = oElevPlane_Z_0.CreateGridLine(oGridPlane_X_0)
            oGridLine_Z0_X10 = oElevPlane_Z_0.CreateGridLine(oGridPlane_X_10)
            oGridLine_Z5_X0 = oElevPlane_Z_5.CreateGridLine(oGridPlane_X_0)
            oGridLine_Z5_X10 = oElevPlane_Z_5.CreateGridLine(oGridPlane_X_10)

            oGridLine_Z0_Y0 = oElevPlane_Z_0.CreateGridLine(oGridPlane_Y_0)
            oGridLine_Z0_Y10 = oElevPlane_Z_0.CreateGridLine(oGridPlane_Y_10)
            oGridLine_Z5_Y0 = oElevPlane_Z_5.CreateGridLine(oGridPlane_Y_0)
            oGridLine_Z5_Y10 = oElevPlane_Z_5.CreateGridLine(oGridPlane_Y_10)

            m_oTxnMgr.Commit("CS and Grids")

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE COLUMNS
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oColumns(4) As MemberSystem
            

            'initialize data for Columns
            Dim oCrossSection As CrossSection = oCatStructHelper.GetCrossSection("AISC-LRFD-3.1", "W", "W10x100")
            Dim oMaterial As Material = oCatStructHelper.GetMaterial("Steel - Carbon", "A")
            Dim iTypeCategory As Integer = MemberHelper.GetMemberCategoryCodeListValue("Column")
            Dim iMemberType As Integer = MemberHelper.GetMemberTypeCodeListValue("Column")
            Dim iCardinalPoint As Integer = 5 'Center
            Dim dRotationAngle As Double = 0.0
            Dim bIsMirror As Boolean = False

            'place an unconnected column
            Dim oStartPos As New Position(0.0, 0.0, 0.0)
            Dim oEndPos As New Position(0.0, 0.0, 5.0)

            oStartPos = oStartPos.Offset(m_vec)
            oEndPos = oEndPos.Offset(m_vec)

            oColumns(0) = New MemberSystem(oStructSystem, oStartPos, oEndPos, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'place the rest of the columns at the grid intersections
            Dim oRelObjsAtStart As New Collection(Of BusinessObject)
            Dim oRelObjsAtEnd As New Collection(Of BusinessObject)

            'Member System from (10, 0, 0) to (10, 0, 5)
            oRelObjsAtStart.Add(oGridLine_Z0_X10)
            oRelObjsAtStart.Add(oGridLine_Z0_Y0)

            oRelObjsAtEnd.Add(oGridLine_Z5_X10)
            oRelObjsAtEnd.Add(oGridLine_Z5_Y0)

            oColumns(1) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'Member System from (10, 10, 0) to (10, 10, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oGridLine_Z0_X10)
            oRelObjsAtStart.Add(oGridLine_Z0_Y10)

            oRelObjsAtEnd.Add(oGridLine_Z5_X10)
            oRelObjsAtEnd.Add(oGridLine_Z5_Y10)

            oColumns(2) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'Member System from (0, 10, 0) to (0, 10, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oGridLine_Z0_X0)
            oRelObjsAtStart.Add(oGridLine_Z0_Y10)

            oRelObjsAtEnd.Add(oGridLine_Z5_X0)
            oRelObjsAtEnd.Add(oGridLine_Z5_Y10)

            oColumns(3) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Commit("Columns")


            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE BEAMS
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oBeams(4) As MemberSystem

            'initialize data for Beams
            oCrossSection = oCatStructHelper.GetCrossSection("AISC-LRFD-3.1", "W", "W18x35")
            iTypeCategory = MemberHelper.GetMemberCategoryCodeListValue("Beam")
            iMemberType = MemberHelper.GetMemberTypeCodeListValue("Beam")
            iCardinalPoint = 8 'Top Center

            'create beams connecting the ends (frame connections) of each column

            'Member System from (0, 0, 5) to (10, 0, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oColumns(0).FrameConnection(MemberAxisEnd.End))
            oRelObjsAtEnd.Add(oColumns(1).FrameConnection(MemberAxisEnd.End))

            oBeams(0) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'Member System from (10, 0, 5) to (10, 10, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oColumns(1).FrameConnection(MemberAxisEnd.End))
            oRelObjsAtEnd.Add(oColumns(2).FrameConnection(MemberAxisEnd.End))

            oBeams(1) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'Member System from (10, 10, 5) to (0, 0, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oColumns(2).FrameConnection(MemberAxisEnd.End))
            oRelObjsAtEnd.Add(oColumns(3).FrameConnection(MemberAxisEnd.End))

            oBeams(2) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Compute()

            'Member System from (0, 10, 5) to (0, 0, 5)
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            oRelObjsAtStart.Add(oColumns(3).FrameConnection(MemberAxisEnd.End))
            oRelObjsAtEnd.Add(oColumns(0).FrameConnection(MemberAxisEnd.End))

            oBeams(3) = New MemberSystem(oStructSystem, oRelObjsAtStart, oRelObjsAtEnd, oCrossSection, _
                oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            m_oTxnMgr.Commit("Beams")

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE MIDDLE BRACE
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oBrace As MemberSystem

            'initialize data for Brace
            iTypeCategory = MemberHelper.GetMemberCategoryCodeListValue("Brace")
            iMemberType = MemberHelper.GetMemberTypeCodeListValue("Brace")

            Dim oBracePointStart As Position = Nothing
            Dim oBracePointEnd As Position = Nothing

            'get midpoints of beam(1) and beam(3)
            Dim oPtStart As Position = Nothing
            Dim oPtEnd As Position = Nothing

            oBeams(1).GetEndPoints(oPtStart, oPtEnd)
            oBracePointStart = New Position((oPtStart.X + oPtEnd.X) / 2.0, (oPtStart.Y + oPtEnd.Y) / 2.0, (oPtStart.Z + oPtEnd.Z) / 2.0)

            oBeams(3).GetEndPoints(oPtStart, oPtEnd)
            oBracePointEnd = New Position((oPtStart.X + oPtEnd.X) / 2.0, (oPtStart.Y + oPtEnd.Y) / 2.0, (oPtStart.Z + oPtEnd.Z) / 2.0)

            'create unconnected brace
            oBrace = New MemberSystem(oStructSystem, oBracePointStart, oBracePointEnd, oCrossSection, _
                                      oMaterial, iMemberType, iTypeCategory, iCardinalPoint, dRotationAngle, bIsMirror)
            'create the collection of connected objects at each end. Since we are not connecting to the ends of the supporting beams but to the midpoints, 
            'we need to pass in both the supporting beams and connection point
            oRelObjsAtStart.Clear()
            oRelObjsAtEnd.Clear()

            'start
            oRelObjsAtStart.Add(oBeams(1))
            oRelObjsAtStart.Add(New Point3d(oBracePointStart))

            oBrace.SetRelatedObjects(oRelObjsAtStart, MemberAxisEnd.Start)

            'end
            oRelObjsAtEnd.Add(oBeams(3))
            oRelObjsAtEnd.Add(New Point3d(oBracePointEnd))

            oBrace.FrameConnection(MemberAxisEnd.End).SetRelatedObjects(oRelObjsAtEnd)
            m_oTxnMgr.Commit("Brace")


            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE SLAB
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oSlab As Slab

            Dim oCatalogPart As Part = Nothing
            Dim oComposition As Part = Nothing
            Dim dThickness As Double


            oCatalogPart = oCatStructHelper.GetPart("4"" Cast in Place CIP_4""_Fc3")
            oComposition = oCatStructHelper.GetPart("CIP_4""_Fc3")
            dThickness = 0.25
            Dim dBoundaryOffset As Double = 0.0

            Dim oPlaneDefinition As New PlaneDefinition(oElevPlane_Z_5)
            Dim oBndryDefList As New List(Of BoundaryDefinition)

            'create the boundary definition - use the 4 beams, and boundary offset 0
            Dim oBndryDef(0 To 3) As BoundaryDefinition

            For i As Integer = 0 To 3
                oBndryDef(i) = New BoundaryDefinition(oBeams(i).GetPart(MemberAxisEnd.End), PortFacePosition.Inner, dBoundaryOffset)
                oBndryDefList.Add(oBndryDef(i))
            Next i

            'create Slab
            oSlab = New Slab(oStructSystem, oPlaneDefinition, oElevPlane_Z_5, oBndryDefList, oCatalogPart, oComposition, dThickness)
            m_oTxnMgr.Commit("Slab")

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE WALLS
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oWallSystem As WallSystem

            Dim dHeight As Double = 5

            dThickness = 0.1
            oCrossSection = oCatStructHelper.GetCrossSection("Wall Cross-Sections", "Rect", "Rect19""x3.5""")
            oCatalogPart = oCatStructHelper.GetPart("Clading C_Siding_Steel - Carbon_4""_Steel_Framing_2""_Siding_Steel - Carbon_4""")
            oComposition = oCatStructHelper.GetPart("P_Stone_Granite_6""")
            iCardinalPoint = 3 'bottom center

            'sketch path 
            Dim oSketch3D As New Sketch3D(oModelConn)
            Dim oSketchColl As New Collection(Of SketchPoint)()
            Dim oSketchPt(0 To 3) As SketchPoint

            'get points
            oColumns(1).GetEndPoints(oPtStart, oPtEnd)
            oSketchPt(0) = New SketchPoint(oPtStart.X, oPtStart.Y, oPtStart.Z)

            oColumns(0).GetEndPoints(oPtStart, oPtEnd)
            oSketchPt(1) = New SketchPoint(oPtStart.X, oPtStart.Y, oPtStart.Z)

            oColumns(3).GetEndPoints(oPtStart, oPtEnd)
            oSketchPt(2) = New SketchPoint(oPtStart.X, oPtStart.Y, oPtStart.Z)

            oColumns(2).GetEndPoints(oPtStart, oPtEnd)
            oSketchPt(3) = New SketchPoint(oPtStart.X, oPtStart.Y, oPtStart.Z)

            'create line relationships
            oSketchPt(0).CreateLineFeature(oSketchPt(1))
            oSketchPt(1).CreateLineFeature(oSketchPt(2))
            oSketchPt(2).CreateLineFeature(oSketchPt(3))

            'set sketch points for Sketch3D
            For Each oSkPt As SketchPoint In oSketchPt
                oSketchColl.Add(oSkPt)
            Next

            oSketch3D.SetSketchPoints(oSketchColl)

            'create wall
            oWallSystem = New WallSystem(oStructSystem, oCrossSection, oCatalogPart, _
                                         oComposition, oElevPlane_Z_0, oSketch3D, iCardinalPoint, bIsMirror, dHeight, dThickness)
            m_oTxnMgr.Commit("Wall")

            

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE HANDRAIL
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oHandrail As HandRail

            Dim oSketch3DHandrail As New Sketch3D(oModelConn)
            Dim oSketchCollHandrail As New Collection(Of SketchPoint)()

            oCatalogPart = oCatStructHelper.GetPart("TMTHandrail")

            'create path - place handrail along beam (1)
            oBeams(1).GetEndPoints(oPtStart, oPtEnd)


            Dim oSkPoint1 As New SketchPoint(oPtStart.X, oPtStart.Y, oPtStart.Z)
            Dim oSkPoint2 = New SketchPoint(oPtEnd.X, oPtEnd.Y, oPtEnd.Z)

            'create line relation
            oSkPoint1.CreateLineFeature(oSkPoint2)

            oSketchCollHandrail.Add(oSkPoint1)
            oSketchCollHandrail.Add(oSkPoint2)

            oSketch3DHandrail.SetSketchPoints(oSketchCollHandrail)

            'create 
            oHandrail = New HandRail(oStructSystem, oCatalogPart, oSketch3DHandrail)
            m_oTxnMgr.Commit("Handrail")

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE LADDER
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oLadder As Ladder

            oCatalogPart = oCatStructHelper.GetPart("LadderA1")

            'create a ladder. Top reference is beam(2), bottom is eleveation plane at Z=0, 
            'side Reference is column 3
            oLadder = New Ladder(oStructSystem, oCatalogPart, oBeams(2), oElevPlane_Z_0, oColumns(3))

            'set horizontal offset from side reference to 1.5 m
            oLadder.SetPropertyValue(1.5, "ISPSHorizVertOffset", "HorizontalOffset")

            'set width
            oLadder.SetPropertyValue(0.61, "IJSPSCommonStairLadderProps", "Width")

            'set Side
            'oLadder.SetPropertyValue(True, "IJSPSCommonStairLadderProps", "TopSupportSide")
            m_oTxnMgr.Commit("Ladder")



            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'PLACE EQUIPMENT FOUNDATION
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim oEqpFoundation As EquipmentFoundation
            'place equipment
            Dim oEqpuipment As New Ingr.SP3D.Equipment.Middle.Equipment("Pump 001A-E", oStructSystem)

            'position in middle of brace, 25 cm above slab, 
            oBrace.GetEndPoints(oPtStart, oPtEnd)
            oEqpuipment.Origin = New Position((oPtStart.X + oPtEnd.X) / 2.0, (oPtStart.Y + oPtEnd.Y) / 2.0, (oPtStart.Z + oPtEnd.Z) / 2.0 + 0.25)
            m_oTxnMgr.Compute()

            'get foundation part
            oCatalogPart = oCatStructHelper.GetPart("BlockEqpFndnAsmWithOptionalPlane")
            
            'create            
            oEqpFoundation = New EquipmentFoundation(oStructSystem, oCatalogPart, oEqpuipment, oElevPlane_Z_5)

            ' ''alternative way-----------------------

            'Dim oSupportingColl As New Collection(Of BusinessObject)
            'oSupportingColl.Add(DirectCast(oElevPlane_Z_5, BusinessObject))

            'Dim oSupportedFndPortColl As New Collection(Of BusinessObject)()

            ''get the collection of supported equipment foundation ports
            'Dim oFndPortColl As ReadOnlyCollection(Of IPort)
            'oFndPortColl = oEqpuipment.GetPorts(PortType.Foundation)

            'If oFndPortColl IsNot Nothing Then
            '    For i As Integer = 0 To (oFndPortColl.Count) - 1
            '        oSupportedFndPortColl.Add(DirectCast(oFndPortColl(i), BusinessObject))
            '    Next
            'End If

            'oEqpFoundation = New EquipmentFoundation(oStructSystem, oCatalogPart, oSupportedFndPortColl, oSupportingColl)
            '''''''''''''''''

            m_oTxnMgr.Compute()
            Dim oEqpFoundationCompColl As ReadOnlyCollection(Of ISystemChild) = oEqpFoundation.SystemChildren
            Dim oBlockComponent As FoundationComponent = DirectCast(oEqpFoundationCompColl(0), FoundationComponent)
            Dim bIsRuleDriven As PropertyValueBoolean = oBlockComponent.GetPropertyValue("IJUASPSBlockFndn", "IsBlockSizeDrivenByRule")
            If bIsRuleDriven.PropValue = True Then
                oBlockComponent.SetPropertyValue(False, "IJUASPSBlockFndn", "IsBlockSizeDrivenByRule")
                m_oTxnMgr.Compute()
            End If
            oBlockComponent.SetPropertyValue(2.0, "IJUASPSBlockFndn", "BlockLength")
            oBlockComponent.SetPropertyValue(1.0, "IJUASPSBlockFndn", "BlockWidth")

            'cannot set Block Height

            m_oTxnMgr.Commit("EquipmentFoundation")

            MsgBox("Command Completed")


        Catch ex As Exception
            MsgBox(ex.Message)
        End Try



    End Sub

    'handles LostFocus for all coordinate input boxes
    Private Sub txtXYZ_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtX.Leave, txtY.Leave, txtZ.Leave
        Dim dValue As Double

        If CheckCoordinate(sender, dValue) Then
            If (sender Is txtX) Then m_vec.X = dValue
            If (sender Is txtY) Then m_vec.Y = dValue
            If (sender Is txtZ) Then m_vec.Z = dValue
            ComputePosition()
        Else
            m_bInputValid = False
            MsgBox("Please Enter a valid coordinate")
        End If
    End Sub

    
    'handles KeyDown for all coordinate input boxes
    Private Sub txtXYZ_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtX.KeyDown, txtY.KeyDown, txtZ.KeyDown
        'first change the color to black since we are entering a value
        Dim oTextBox As Windows.Forms.TextBox = sender

        oTextBox.ForeColor = Drawing.Color.Black

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            Dim dValue As Double

            If CheckCoordinate(sender, dValue) Then
                If (sender Is txtX) Then m_vec.X = dValue
                If (sender Is txtY) Then m_vec.Y = dValue
                If (sender Is txtZ) Then m_vec.Z = dValue
                ComputePosition()
            Else
                m_bInputValid = False
                MsgBox("Please Enter a valid coordinate")
            End If
        End If
    End Sub
    Private Sub ComputePosition()
        'only raise event if all 3 coordinates are valid

        If txtX.ForeColor = Drawing.Color.Black AndAlso _
        txtY.ForeColor = Drawing.Color.Black AndAlso _
        txtZ.ForeColor = Drawing.Color.Black Then
            m_bInputValid = True
        End If
    End Sub
    'called whenever a coordinate value is changed.
    'It will try to parse the value, and if it fails,
    'it will show the value in RED
    Private Function CheckCoordinate(ByVal sender As Object, ByRef dValue As Double) As Boolean

        Dim oTextBox As Windows.Forms.TextBox = sender
        Dim bResult As Boolean = True

        Try
            dValue = MiddleServiceProvider.UOMMgr.ParseUnit(UnitType.Distance, oTextBox.Text)

        Catch ex As Exception
            bResult = False
            oTextBox.ForeColor = Drawing.Color.Red
        End Try

        Return bResult

    End Function

    Private Sub frmStructCmd2_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'set tose to black (meaning we have valid coordinates)
        txtX.ForeColor = Drawing.Color.Black
        txtY.ForeColor = Drawing.Color.Black
        txtZ.ForeColor = Drawing.Color.Black
    End Sub
End Class