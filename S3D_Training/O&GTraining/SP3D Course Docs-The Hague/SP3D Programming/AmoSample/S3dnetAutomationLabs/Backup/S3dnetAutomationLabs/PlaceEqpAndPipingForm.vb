Imports System.Windows.Forms
Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Space.Middle
Imports Ingr.SP3D.Route.Middle
Imports Ingr.SP3D.Support.Middle
Imports Ingr.SP3D.Route.Middle.Services
Imports System.Collections.ObjectModel


Public Class PlaceEqpAndPipingForm
    Private m_dSpacing As Double 'Spacing between pumps
    Private m_dHeaderLenght As Double 'Lenght of Header
    Private m_dHeight As Double ' Height of header above pump discharge
    Private m_strSpec As String ' the spec to use
    Private m_dX, m_dY, m_dz As Double ' the location of the first pump

    Private Sub PlaceEqpAndPipingForm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' initiate the value to the default values on the form
        m_dX = 50
        m_dY = 50
        m_dz = 0
        m_dSpacing = 4
        m_dHeaderLenght = 8
        m_dHeight = 2
        m_strSpec = "1C0031"
    End Sub

    Private Sub txtX_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtX.KeyDown
        If (e.KeyCode = Keys.Enter) Then ParseDistance(txtX.Text, txtX, m_dX)
    End Sub


    Private Sub txtX_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtX.LostFocus
        ParseDistance(txtX.Text, txtX, m_dX)
    End Sub

    'this method parses distance keyin and returns distance
    'vissually indicates if it is in error
    Private Function ParseDistance(ByVal txt As String, ByVal ctrl As TextBox, ByRef dValue As Double) As Double
        Dim dVal As Double
        Try
            dVal = MiddleServiceProvider.UOMMgr.ParseUnit(UnitType.Distance, txt)
            dValue = dVal
            ctrl.ForeColor = Drawing.Color.Black

        Catch ex As Exception
            ctrl.ForeColor = Drawing.Color.Red

        End Try
    End Function


    Private Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOK.Click

        ProgressBar1.Value = 20

        Me.DialogResult = DialogResult.OK

        ' get the active plant's model.
        Dim oModel As Model
        oModel = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel

        ' get plants root system
        Dim oRootSys As BusinessObject
        oRootSys = oModel.RootSystem

        ' create a generic system under plant root system
        Dim oGenericSys As New GenericSystem(oRootSys)
        oGenericSys.SetUserDefinedName("New Generic System")
        ClientServiceProvider.TransactionMgr.Commit("create new generic system")

        'create a new pipeline under the newly created generic system, and set its properties
        Dim oPipeline As Pipeline = New Pipeline(oGenericSys)
        oPipeline.SetUserDefinedName("New Pipeline")
        oPipeline.SetPropertyValue("0101", "IJPipelineSystem", "SequenceNumber")

        'Lets set fluidcode to "OH"--> Hydrolic oil
        Dim oCLI As CodelistItem
        oCLI = oModel.MetadataMgr.GetCodelistInfo("FluidCode", "CMNSCH").GetCodelistItem("OH")
        oPipeline.SetPropertyValue(oCLI, "IJPipelineSystem", "FluidCode")

        ' Another way to set the fluidcode to "OH" is to use its
        ' integervalue (=503, see metadatabrowser), as done below
        'oPipeline.SetPropertyValue(503, "IJPipelineSystem", FluidCode")

        ' The below statement will save the changes since previous save to database.
        ' The created pipeline will be saved to database
        ClientServiceProvider.TransactionMgr.Commit("create new pipeline")


        ' create two pumps, the first one created here
        Dim oPump1 As Equipment, oPump2 As Equipment, oMtx As New Matrix4X4
        oPump1 = New Equipment("HCPump05 8""x4""-E", oGenericSys)
        oMtx.SetIdentity()
        oPump1.Matrix = oMtx ' --> control orientation with matrix
        oPump1.Origin = New Position(m_dX, m_dY, m_dz) '--> Position specified on form

        ' create and attach a note to the pump created above
        Dim oNote As Note
        oNote = New Note(oPump1) 'create note on pump1
        oNote.SetPropertyValue(5, "IJGeneralNote", "Purpose") 'maintenance
        oNote.SetPropertyValue("This is MAIN pump", "IJGeneralNote", "Text")
        oNote.SetPropertyValue("Operation Information", "IJGeneralNote", "Name")
        oNote = New Note(oPump1) ' creates another note on pump1
        oNote.SetPropertyValue(6, "IJGeneralNote", "Purpose") ' Inspection
        oNote.SetPropertyValue("Inspect every month", "IJGeneralNote", "Text")
        oNote.SetPropertyValue("Inspection Information", "IJGeneralNote", "Name")


        ProgressBar1.Value = 40

        ' create another pump, our backup pump
        oPump2 = New Equipment("HCPump05 8""x4""-E", oGenericSys)
        oPump2.Matrix = oMtx
        oPump2.Origin = New Position(m_dX + m_dSpacing, m_dY, m_dz)

        oNote = New Note(oPump2) 'create note on pump2
        oNote.SetPropertyValue(5, "IJGeneralNote", "Purpose") 'maintenance
        oNote.SetPropertyValue("This is MAIN pump", "IJGeneralNote", "Text")
        oNote.SetPropertyValue("Operation Information", "IJGeneralNote", "Name")
        oNote = New Note(oPump2) ' creates another note on pump2
        oNote.SetPropertyValue(6, "IJGeneralNote", "Purpose") ' Inspection
        oNote.SetPropertyValue("Inspect every month", "IJGeneralNote", "Text")
        oNote.SetPropertyValue("Inspection Information", "IJGeneralNote", "Name")

        ' Compute shows Dynamics (All modified objects in rubberband hilite). Commit saves
        ' the objects (two pumps, notes, with rlation to pump) and modifications to database.
        ClientServiceProvider.TransactionMgr.Compute()
        ClientServiceProvider.TransactionMgr.Commit("Place two pumps")

        ProgressBar1.Value = 60
        ' Lets find available namerules for equipment class and pick 'UniqueNamerule' if it exists.
        ' for this, we need Cataloghelper to find out available name rules on an object class type.
        ' see GenericNameRules sheet.
        Dim oCatalogHelper As New CatalogBaseHelper, oUniqNameRule As BusinessObject = Nothing
        For Each oNameRule As BusinessObject In oCatalogHelper.GetNamingRules("CPEquipment")
            ' if we got our name rule of interest, then we exit this loop
            Dim oPVS As PropertyValueString = oNameRule.GetPropertyValue("IJDNameRuleHolder", "Name")
            If oPVS.PropValue = "UniqueNameRule" Then
                oUniqNameRule = oNameRule
                Exit For
            End If
        Next oNameRule
        If (oUniqNameRule IsNot Nothing) Then
            oPump1.ActiveNameRule = oUniqNameRule
            oPump2.ActiveNameRule = oUniqNameRule
        End If

        ' the compute here evaluates the changes since last compute/commit. i.e. the name rule assignment
        ' Here the name rule runs, generates and assigns a name
        ClientServiceProvider.TransactionMgr.Compute()
        ' commit saves the changes. i.e. name rule assignment to the two pumps.
        ClientServiceProvider.TransactionMgr.Commit("assign unigue spaces for Pumps")

        'create a space folder in which we will create zonespaces around the pumps
        Dim oSpaceFolder As FolderSpace
        oSpaceFolder = CreateSpaceFolder("SpaceFolder for spaces around pumps")
        ClientServiceProvider.TransactionMgr.Commit("create space for pumps")

        ' now lets create Zonespaces
        CreateSpace(oPump1, oSpaceFolder, "ZONETYPE", SpaceConstructionType.SpaceBy2Points)
        CreateSpace(oPump2, oSpaceFolder, "ZONETYPE", SpaceConstructionType.SpaceBy2Points)
        ClientServiceProvider.TransactionMgr.Commit("create Spaces for Pumps")

        ProgressBar1.Value = 80
        ' Route out from Pump1's Nozzle #1
        ' create a piperun, 8in, of given spec
        Dim oPipeRun1 As PipeRun = New PipeRun(oPipeline, 8.0, "in", m_strSpec)

        ' set the temperatures and pressures on piperun and flowdirection
        ' the setpropertyvalue has several overloads to deal with different attribute types
        oPipeRun1.SetPropertyValue(500.0, "IJProcessDataInfo", "DesignMaxTemp")
        oPipeRun1.SetPropertyValue(7500.0, "IJProcessDataInfo", "DesignMaxPressure")
        oPipeRun1.SetUserDefinedName("Run - 01") ' --> set Name on piperun
        ' Set Flow direction, could have also done the codelist way
        oPipeRun1.SetPropertyValue(1, "IJRtePipeRun", "FlowDirection")
        ClientServiceProvider.TransactionMgr.Compute()
        ' --> note, Run is still temporary, not yet saved to the database.

        ' clone another run with same properties, for the second pump.
        Dim oPipeRun2 As PipeRun
        oPipeRun2 = New PipeRun(oPipeRun1) ' --> crete a new piperun from an existing run
        oPipeRun2.SetUserDefinedName("Run - 02")

        ' route dheight distance outward from pump1 discharge
        ' get the discharge port of pump1
        Dim oDischargeOfPump1 As IDistributionPort
        oDischargeOfPump1 = GetPortByName(oPump1, "Discharge")

        Dim oPos1 As Position, oFeat As IRoutePathFeature = Nothing
        'Calculate the point at a distance of dHeight from the nozzle location
        ' to do this, we initialize a vector with appropriate values, and
        ' use it to offset the nozzle location point
        oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0, 0, m_dHeight))

        'Route from Pump discharge to that point dheight above.
        ' below methd returns the resulting end feature for the route continueation.
        oPipeRun1.RouteBetweenPortAndPoint(oDischargeOfPump1, oPos1, oFeat)

        ' the below compute statement triggers evaluation logic in sp3d for the
        ' changes done so far to objects, it will generate
        ' connection to nozzle with mating flange, bolts & gasket, reducer if required,
        ' weld for the reduce, plus the pipe upto the location specified.
        ' all of the part/connection items will picked up based on the spec and its rules
        ClientServiceProvider.TransactionMgr.Compute()

        'route 'dHeaderLenght' in east direction from current end position.
        ' we offset the current point with a vector ( different & length ) to move
        Dim oPos2 As Position
        oPos1 = New Position(oFeat.Location)
        oPos2 = oPos1.Offset(New Vector(m_dHeaderLenght, 0, 0))
        ' now we route from endfeature to that point
        oPipeRun1.RouteBetweenEndFeatureAndPoint(oFeat, oPos2, oFeat)

        ' In the compute call below, the elbow plus the pipe and welds get generated.
        ClientServiceProvider.TransactionMgr.Compute()


        ProgressBar1.Value = 90

        ' We now place a terminal flange at the end of this pipe. theoFeat we have with
        ' us from abovecall is the current end feature til the last riuted point.
        Dim oPF As RouteFeature = Nothing
        oPipeRun1.InsertFeatureByShortCodeOnFeature("Flange", 1, "", oFeat, oFeat.Location, Nothing, oPF)
        ' in the compute call below, the inserted feature is evaluated for placement as per the spec rules.
        ClientServiceProvider.TransactionMgr.Compute()

        ' The below statement will save the changes since previous save to database.
        ' i.e. the mating flange, bolts, gaskets, welds will be saved to database.
        ClientServiceProvider.TransactionMgr.Commit("place 1st run")


        'Now, lets route out of 2nd pump discharge to branch in into the already placed header (run1)
        Dim oDischargeOfPump2 As IDistributionPort
        oDischargeOfPump2 = getPortByname(oPump2, "Discharge")
        ' Arrive at th erequired position on header, i.e. dHeight from the nozzle location
        oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0, 0, m_dHeight)) 'move dHeight in 2 direction
        ' Below call is to locate the feature representing the straight pipe
        ' at position (oPos1) (could be approx. position within a tolerance)
        ' returns accurate branching point (oPos2) and the feature (oFeat)
        oPipeRun1.GetFeatureAtLocation(PathFeatureObjectTypes.PathFeatureType_STRAIGHT, PathFeatureFunctions.PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)

        ' now, branch in into the header (run1) from the discharge nozzle of pump2.
        oPipeRun2.RouteBetweenPortAndBranch(oDischargeOfPump2, oFeat, oPos2)

        'The below compute statement generates mating flange, bolts, gaskets,reducer ( if required), welds, plus tee on the 
        ' header, and cnnects the tee's 3rd point to branch run.
        ClientServiceProvider.TransactionMgr.Compute()
        ' save the changes to database.
        ClientServiceProvider.TransactionMgr.Commit("place 2nd Run")

        'now lets place check valves on the vertical pipes conneected to the main standby pumps
        Dim oValveFeat As IRoutePathFeature = Nothing
        ' arrive to the point where you want to place the valve.
        oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0, 0, 0.5 * m_dHeight))
        ' get the straightfeature on the run at that location, we need to insert the valve.
        oPipeRun1.GetFeatureAtLocation(PathFeatureObjectTypes.PathFeatureType_STRAIGHT, PathFeatureFunctions.PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)
        ' below method insert a fature by "shortcode & option" on straight feature at a given position.
        oPipeRun1.InsertFeatureByShortCodeOnFeature("Check Valve", 1, "", oFeat, oPos2, Nothing, oValveFeat)

        ' now do the same on the 2nd vertical pipe connected to the standby pump.
        oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0, 0, 0.5 * m_dHeight))
        oPipeRun2.GetFeatureAtLocation(PathFeatureObjectTypes.PathFeatureType_STRAIGHT, PathFeatureFunctions.PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)
        oPipeRun2.InsertFeatureByShortCodeOnFeature("Check Valve", 1, "", oFeat, oPos2, Nothing, oValveFeat)

        'The below compute statement wil place check valves, generate mating flange,
        ' associated bolts/gaskets, welds .... shows dynamics and gets ready for commit
        ClientServiceProvider.TransactionMgr.Compute()
        ' save the changes to database.
        ClientServiceProvider.TransactionMgr.Commit("place check valve")


        ProgressBar1.Value = 95

        ' lets place supports on the two horizontal pipes of the main header.
        ' get the position where we will look for the staright pipe
        oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0.25 * m_dHeaderLenght, 0, m_dHeight))
        ' get the straight pipe
        oPipeRun1.GetFeatureAtLocation(PathFeatureObjectTypes.PathFeatureType_STRAIGHT, PathFeatureFunctions.PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)
        ' now we create a support at that point. prepare a supported object collection.
        Dim oSupportedColl As New Collection(Of RouteFeature) ' --> supported collection --> feature(s)
        oSupportedColl.add(oFeat)
        ' create the support with required inputes - owning pipeline, supported features, 
        ' supporting features ( structure - not applicable for design support we are using)
        Dim oSupp As DesignSupport
        oSupp = New DesignSupport(oPipeline, oSupportedColl, Nothing, oFeat.Location)
        ' specify the designed pipe support catalog part to use for this designsupport.
        oSupp.SupportDefinition = oCatalogHelper.GetPart("DesignPipeH_1")

        ' now for the second pipe. locate it by going up dheight from pump2's discharge and
        ' then 25% of headerlenght to the east
        oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0.25 * m_dHeaderLenght, 0, m_dHeight))
        oPipeRun1.GetFeatureAtLocation(PathFeatureObjectTypes.PathFeatureType_STRAIGHT, PathFeatureFunctions.PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)

        'clear existing Supportedfeature and add the 2nd pipe alone
        oSupportedColl.clear()
        oSupportedColl.add(oFeat)
        oSupp = New DesignSupport(oPipeline, oSupportedColl, Nothing, oFeat.Location)
        oSupp.SupportDefinition = oCatalogHelper.GetPart("DesignPipeH_1")

        ' compute - evaluate changes/ objects created so far and shows dynamics.
        ' supports associated to pipe feature and pipeline owns the support.
        ClientServiceProvider.TransactionMgr.Compute()
        ' save the changes to database.
        ClientServiceProvider.TransactionMgr.Commit("Place supports")

        ProgressBar1.Value = 100

        MsgBox("Placement complete", , "Place Equipment and piping")
        Me.Close()

    End Sub

    'the below routine returns a port by name on a part
    Private Function GetPortByname(ByVal oPart As IConnectable, ByVal strName As String) As IPort
        Dim oPort As IPort
        GetPortByname = Nothing ' --> initialize
        For Each oPort In oPart.GetPorts(PortType.All) ' search in all ports
            If oPort.ToString = strName Then ' for given portname
                GetPortByname = oPort 'return if found
                Exit Function
            End If
        Next
    End Function

    Private Function CreateSpace(ByVal objRange As IRange, ByVal oParent As FolderSpace, ByVal strSpaceType As String, ByVal oCType As SpaceConstructionType) As SpaceBase

        'create the space range as 10% extra on each edge - arrive at diagonal end of such expanded range
        Dim oPtLow, oPthigh, oPtCtr As Position, oVec As Vector
        oPtLow = New Position(objRange.Range.Low)
        oPthigh = New Position(objRange.Range.High)
        oPtCtr = New Position(0.5 * (oPtLow.X + oPthigh.X), 0.5 * (oPtLow.Y + oPthigh.Y), 0.5 * (oPtLow.Z + oPthigh.Z))

        oVec = oPtCtr.Subtract(oPtLow) ' get vector from center to low point
        oVec.Length = 1.1 'elongate the vector by 10 % in magnitude
        oPtLow = oPtCtr.Offset(oVec) ' arrive at the expande range end point
        oVec = oPtCtr.Subtract(oPthigh) ' get vector from center to heigh point
        oVec.Length = 1.1 ' elongate the vector by 10% in magnitude
        oPthigh = oPtCtr.Offset(oVec) ' arrive at the expanded range end point

        ' create space by 2 points
        Dim oCatBasehelper As New CatalogBaseHelper, oSpaceBase As SpaceBase
        Dim oSpaceInputs(1) As SpaceInputs, oInputsColl As New collection(Of SpaceInputs)

        ' Prepare spaceiputs for creation
        oSpaceInputs(0) = New SpaceInputs
        oSpaceInputs(1) = New SpaceInputs
        oSpaceInputs(0).InputObject = New Point3d(ClientServiceProvider.WorkingSet.ActiveConnection, oPthigh)
        oSpaceInputs(1).InputObject = New Point3d(ClientServiceProvider.WorkingSet.ActiveConnection, oPtLow)
        oInputsColl.add(oSpaceInputs(0))
        oInputsColl.add(oSpaceInputs(1))

        'create appropriate Space objects: area / interference / zone
        Select Case strSpaceType
            Case "AREATYPE" : oSpaceBase = New AreaSpace(oCatBasehelper.GetPart("SPACE_DEF_SA01"), oCType, oParent, oInputsColl)
            Case "INTERFERENCETYPE" : oSpaceBase = New InterferenceSpace(oCatBasehelper.GetPart("SPACE_DEF_IV01"), oCType, oParent, oInputsColl)
            Case "ZONETYPE" : oSpaceBase = New ZoneSpace(oCatBasehelper.GetPart("SPACE_DEF_HZ01"), oCType, oParent, oInputsColl)
            Case Else : Return Nothing ' error
        End Select

        oSpaceBase.AssociatedObject = objRange ' associate the object with the space
        oSpaceBase.SetUserDefinedName(oCType.ToString & "-" & strSpaceType)
        ClientServiceProvider.TransactionMgr.Compute()
        Return oSpaceBase

    End Function

    'this function creates a space folder with given name
    Private Function CreateSpaceFolder(ByVal strname As String) As FolderSpace
        Dim oSpaceRoot As BusinessObject, oSpaceFolder As FolderSpace
        ' get space root of activeplant
        oSpaceRoot = (MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel.RootSystem)
        ' create spacefolder with given name
        oSpaceFolder = New FolderSpace(oSpaceRoot)
        oSpaceFolder.SetUserDefinedName(strname)
        Return oSpaceFolder

    End Function
End Class