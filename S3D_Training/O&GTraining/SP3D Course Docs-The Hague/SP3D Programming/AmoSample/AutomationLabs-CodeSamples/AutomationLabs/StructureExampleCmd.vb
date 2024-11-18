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

Public Class StructureExampleCmd
    Inherits BaseModalCommand

    Private oPos1 As New Position(40, -30, -5) 'change those to place at a different location


    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        ' Get the plant. 
        Dim oModel As Model = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel

        ' Get the root system. 
        Dim oRootSystem As ISystem = oModel.RootSystem

        Dim oParent As BusinessObject = DirectCast(oRootSystem, BusinessObject)
        If oParent Is Nothing Then
            GoTo errorhandler
        End If

        'create Structural System
        Dim oStrSys As StructuralSystem = New StructuralSystem(oParent)
        oStrSys.SetUserDefinedName("STRUCTURAL Parent")


        ' Create a cross section to use 
        ' Get the catalog Helper 
        Dim oCatStruHlpr As New CatalogStructHelper(oModel.PlantCatalog)

        Dim oCrossSection As CrossSection = Nothing
        Dim sRefStdName As String = "AISC-LRFD-3.1"
        Dim sSecType As String = "W"
        Dim sSecName As String = "W8x10"

        ' To get the CrossSection object based on RefStdName, SecType, SecName 
        oCrossSection = oCatStruHlpr.GetCrossSection(sRefStdName, sSecType, sSecName)
        If oCrossSection Is Nothing Then
            GoTo errorhandler
        End If

        ' Create a material for the beam 
        Dim oMaterial As Material = Nothing
        Dim sMatType As String = "Steel - Carbon"
        Dim sMatGrade As String = "A"

        ' To get the Material Object based on Material Type and Material Grade 
        oMaterial = oCatStruHlpr.GetMaterial(sMatType, sMatGrade)
        If oMaterial Is Nothing Then
            GoTo errorhandler
        End If

        'Catagory type Beam=1, Column=2, brace=3 


        Dim strMemberCatergory As String = "Column"
        Dim lTypeCategory As Integer = MemberHelper.GetMemberCategoryCodeListValue(strMemberCatergory)
        Dim lType As Integer = MemberHelper.GetMemberTypeCodeListValue(strMemberCatergory) 'here Assumed Same string is taken for MemberCategory and type

        'cardinal point
        Dim lCard As Long = CLng(8)
        'rotation angle 
        Dim dRotAngle As Double = Math.PI
        'mirror
        Dim bMir As Boolean = False

        Dim oSP As Position
        Dim oEP As Position


        oSP = oPos1.Offset(New Vector(-1, 0, 0))
        oEP = oPos1.Offset(New Vector(-1, 0, 3))

        ' Create a vertival MemberSystem1   
        Dim oMemSys1 As New MemberSystem(oStrSys, oSP, oEP, oCrossSection, oMaterial, _
        lType, lTypeCategory, lCard, dRotAngle, bMir)
        If oMemSys1 Is Nothing Then
            GoTo errorhandler
        End If

        ' Create a vertical MemberSystem2
        dRotAngle = 0

        oSP = oPos1.Offset(New Vector(1, 0, 0))
        oEP = oPos1.Offset(New Vector(1, 0, 3))

        Dim oMemSys2 As New MemberSystem(oStrSys, oSP, oEP, oCrossSection, oMaterial, _
        lType, lTypeCategory, lCard, dRotAngle, bMir)
        If oMemSys2 Is Nothing Then
            GoTo errorhandler
        End If



        'create a MemberSystem from FrameConn to FrameConn connecting
        'the 2 vertical columns. This method will create the relationship between the
        'members and the frame connections
        Dim cBOS As New Collection(Of BusinessObject)()
        Dim cBOE As New Collection(Of BusinessObject)()

        'Catagory 
        strMemberCatergory = "Beam"
        lTypeCategory = MemberHelper.GetMemberCategoryCodeListValue(strMemberCatergory)
        lType = MemberHelper.GetMemberTypeCodeListValue(strMemberCatergory) 'here Assumed Same string is taken for MemberCategory and type


        Dim oFC1End As FrameConnection = oMemSys1.FrameConnection(MemberAxisEnd.End)
        cBOS.Add(oFC1End)

        Dim oFC3End As FrameConnection = oMemSys2.FrameConnection(MemberAxisEnd.End)
        cBOE.Add(oFC3End)

        Dim oMemSysHorz As New MemberSystem(oStrSys, cBOS, cBOE, oCrossSection, oMaterial, _
       lType, lTypeCategory, lCard, dRotAngle, bMir)
        If oMemSysHorz Is Nothing Then
            GoTo errorhandler
        End If

        'create curved member  
        Dim oColSk As New Collection(Of SketchPoint)()

        Dim oP1 = oPos1.Offset(New Vector(-1.3, 0, 3.7))
        Dim oP2 = oPos1.Offset(New Vector(0, 0, 3.3))
        Dim oP3 = oPos1.Offset(New Vector(1.3, 0, 3.7))

        Dim oSP1 As New SketchPoint(oP1.X, oP1.Y, oP1.Z)
        Dim oSP2 As New SketchPoint(oP2.X, oP2.Y, oP2.Z)
        Dim oSP3 As New SketchPoint(oP3.X, oP3.Y, oP3.Z)

        Dim oAF As ArcBy3PointsFeature = oSP1.CreateArcBy3PointsFeature(oSP2, oSP3)
        oColSk.Clear()
        ' add all the sketch points into a collection 
        oColSk.Add(oSP1)
        oColSk.Add(oSP2)
        oColSk.Add(oSP3)

        Dim oSketch As New Sketch3D(oModel)

        ' set the points into the sketch 
        oSketch.SetSketchPoints(oColSk)

        ClientServiceProvider.TransactionMgr.Compute()

        lTypeCategory = MemberHelper.GetMemberCategoryCodeListValue("Brace")
        lType = MemberHelper.GetMemberTypeCodeListValue("Vertical Brace") 'here Assumed Same string is taken for MemberCategory and type


        Dim oMemSysArc As New MemberSystem(oStrSys, oSketch, oCrossSection, oMaterial, _
       lType, lTypeCategory, lCard, dRotAngle, bMir)

        ClientServiceProvider.TransactionMgr.Compute()

        'get arc geometry of curved memeber

        Dim oArc As Arc3d = Nothing

        'this will get the arc geometry
        If oAF.ComputeGeometry(oArc) = False Then
            GoTo errorhandler
            ''you can get geometry this way too
            'Dim oAcrCurve As ICurve
            'oAcrCurve = oAF.Geometry()
        End If

        Dim oIntersectCol As Collection(Of Position) = Nothing
        Dim oOverlapCol As Collection(Of Position) = Nothing
        Dim oIntersectPos As Position

        oSP = oPos1.Offset(New Vector(-0.5, 0, 3))
        oEP = oPos1.Offset(New Vector(-0.5, 0, 3.7))

        Dim oLine1 As New Line3d(oSP, oEP)

        Dim oIntersectCode As GeometryIntersectionType
        oArc.Intersect(oLine1, oIntersectCol, oOverlapCol, oIntersectCode)

        oIntersectPos = oIntersectCol.Item(0)

        '1st arc support
        dRotAngle = Math.PI

        lTypeCategory = MemberHelper.GetMemberCategoryCodeListValue("Column")
        lType = MemberHelper.GetMemberTypeCodeListValue("Column") 'here Assumed Same string is taken for MemberCategory and type

        Dim oMemSysArcSup1 As New MemberSystem(oStrSys, oSP, oIntersectPos, oCrossSection, oMaterial, _
        lType, lTypeCategory, lCard, dRotAngle, bMir)


        '2nd arc support
        oIntersectCol = Nothing
        oOverlapCol = Nothing
        oIntersectPos = Nothing

        oSP = oPos1.Offset(New Vector(0.5, 0, 3))
        oEP = oPos1.Offset(New Vector(0.5, 0, 3.7))

        Dim oLine2 As New Line3d(oSP, oEP)


        oArc.Intersect(oLine2, oIntersectCol, oOverlapCol, oIntersectCode)

        oIntersectPos = oIntersectCol.Item(0)

        '1st arc support
        dRotAngle = 0

        Dim oMemSysArcSup2 As New MemberSystem(oStrSys, oSP, oIntersectPos, oCrossSection, oMaterial, _
        lType, lTypeCategory, lCard, dRotAngle, bMir)


        '' 'connect the end frame connection to the curved beam
        Dim oRelatedMemSys As New Collection(Of BusinessObject)

        oRelatedMemSys.Add(oMemSysArc)
        oRelatedMemSys.Add(New Point3d(ClientServiceProvider.WorkingSet.ActiveConnection, oIntersectPos))
        oMemSysArcSup2.SetRelatedObjects(oRelatedMemSys, MemberAxisEnd.End)

        
        Try
            MiddleServiceProvider.TransactionMgr.Commit("MemberSystems have been placed")
        Catch
            GoTo errorhandler
        End Try

        Exit Sub

     
errorhandler:
        MiddleServiceProvider.ErrorLogger.Log("Error")

    End Sub

End Class
