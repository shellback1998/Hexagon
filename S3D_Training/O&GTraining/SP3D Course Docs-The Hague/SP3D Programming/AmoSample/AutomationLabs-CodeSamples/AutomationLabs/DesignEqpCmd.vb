Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.ReferenceData.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services

Public Class DesignEqpCmd
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Dim oEqp As Equipment
        Dim oSys As ISystem
        Dim oPartClass As PartClass
        Dim oCatHlpr As New CatalogBaseHelper(MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantCatalog)
        Dim oShape As GenericShape
        Dim oNozzle As PipeNozzle
       
        'get part class
        oPartClass = oCatHlpr.GetPartClass("StorageTankAsm")

        'get system root
        oSys = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel.RootSystem

        'to create a Design equipment we must use the constructor that takes
        'Part Class, not Part
        oEqp = New Equipment(oPartClass, oSys)
        oEqp.SetUserDefinedName("Design Eqp - Storage Tank")
        oEqp.Origin = New Position(20, 20, 0)
        ClientServiceProvider.TransactionMgr.Compute()

        oShape = New GenericShape("RtCircularCylinder 001", oEqp)
        oShape.Origin = New Position(19, 19, 0)
        'diam = 1m
        oShape.SetPropertyValue(1.0, "IJUACylinder", "B")
        'length = 2 m
        oShape.SetPropertyValue(2.0, "IJUACylinder", "A")
        ClientServiceProvider.TransactionMgr.Compute()

        'create nozzle. The constructor creates a nozzle like a specific nozzle
        '(identified by the given index) of an existing catalog equipment.
        'Note that we are using a catalog equipment part ("PUMP 001A-E") that has nothing to do with
        'the equipment we have created previously
        oNozzle = New PipeNozzle("PUMP 001A-E", False, 2, oEqp)
        ClientServiceProvider.TransactionMgr.Compute()

        'TR-CP-165152  Constraint.ReferenceGeometry method does not update ref geom object for nozzle  
        'because of this bug ref geometry will still be the equipment itself, but
        'when it get's fixed this is how to relate it to the shape
        oNozzle.PortConstraint.ReferenceGeometry = oShape
        oNozzle.PortConstraint.PortPlacementType = PortPlacementType.Tangential
        oNozzle.PortConstraint.SetPropertyValue(0.8, "IJNozzleOrientation", "N2")

        'we can also do this
        'oNozzle.PortConstraint.PortPlacementType = PortPlacementType.Position_By_Point
        'oNozzle.Location = New Position(0, 0, 0.5)
        'oNozzle.NormalVector = New Vector(0, 0, 1)

        oNozzle.SetPropertyValue(100.0, "IJDPipePort", "Npd")
        oNozzle.Length = 0.3

        ClientServiceProvider.TransactionMgr.Commit("Design Eqp")

    End Sub

End Class
