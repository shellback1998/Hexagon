' File : PlaceEqpAndPipingForm.vb
' Description : SP3D .Net API based Custom Command, Form Implementation
' Functional Description : Custom Command to place Eqp and Piping
'   Create Systems, Place Eqp, Pipelines & Piping, Space Folders & Spaces, Supports
' Written By : Prasad Mantraratnam, SmartPlant 3D Automation Group, Intergraph Corporation
' 
' Change History :
' 01-Nov-2008 : Created
' 01-Mar-2009 : Creating Space Folders, Spaces
' 01-May-2009 : Creating Supports

Option Explicit On
Option Strict Off

Imports System.Windows.Forms
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Route.Middle
Imports Ingr.SP3D.Space.Middle
Imports Ingr.SP3D.Support.Middle
Imports Ingr.SP3D.Support.Middle.Services
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Route.Middle.PathFeatureObjectTypes
Imports Ingr.SP3D.Route.Middle.PathFeatureFunctions

Public Class PlaceEqpAndPipingForm
  ' Define Parameters used for Placement.
  Private m_dSpacing As Double ' -> Spacing between pumps.
  Private m_dHeaderLength As Double ' -> Length of Header
  Private m_dHeight As Double ' -> Height Of Header above Pump Discharge.
  Private m_strSpec As String ' -> The Spec to Use
  Private m_dX, m_dY, m_dZ As Double ' -> The Location of the 1st Pump

  Private Sub PlaceEqpAndPipingForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    ' Initialize the values to the default values on the form.
    m_dX = 50
    m_dY = 50
    m_dZ = 0
    m_dSpacing = 4
    m_dHeaderLength = 8
    m_dHeight = 2
    m_strSpec = "1C0031"
  End Sub

  Private Sub OK_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OK_Button.Click
    Me.DialogResult = System.Windows.Forms.DialogResult.OK

    ' Get the active plant's Model.
    Dim oModel As Model
        'oModel = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel

        Dim oPlantConn As PlantConnection
        oPlantConn = ClientServiceProvider.WorkingSet.ActiveConnection
        oModel = oPlantConn.ParentPlant.PlantModel

    ' Get Plant's Root System 
    Dim oRootSys As BusinessObject
        oRootSys = oModel.RootSystem

    ' Create a Generic System under Plant Root System
    Dim oGenericSys As New GenericSystem(oRootSys)
    oGenericSys.SetUserDefinedName("New Generic System")
    ' The below statement will save changes to database.
    ' i.e. a New Generic System will be saved to database.
    ClientServiceProvider.TransactionMgr.Commit("Create New Generic System")

    'Create a new Pipeline under the newly created Generic System, and set its Properties
    Dim oPipeLine As Pipeline = New Pipeline(oGenericSys)
    oPipeLine.SetUserDefinedName("New Pipeline")
    oPipeLine.SetPropertyValue("0101", "IJPipelineSystem", "SequenceNumber")

    ' Let's set FluidCode to 'OH' --> Hydraulic Oil
    Dim oCLI As CodelistItem
    oCLI = oModel.MetadataMgr.GetCodelistInfo("FluidCode", "CMNSCH").GetCodelistItem("OH")
    oPipeLine.SetPropertyValue(oCLI, "IJPipelineSystem", "FluidCode")

    ' Another way to set FluidCode to "OH" is to use its 
    ' Integer value (=503, see MetadataBrowser), as done below
    'oPipeLine.SetPropertyValue(503, "IJPipelineSystem", "FluidCode")

    ' The below statement will save changes since previous save to database.
    ' The created Pipeline will be saved to database.
    ClientServiceProvider.TransactionMgr.Commit("Create New Pipeline")

    ' Create TWO pumps, first one created right below
    '      _____________________
    '      |           |
    '      |           |
    '    __|__       __|__     
    '  ____|___    ____|___     
    '  |      |    |      |            
    '  |   A  |    |   B  |            
    '  |______|    |______|        
    ' 
    Dim oPump1 As Equipment, oPump2 As Equipment, oMtx As New Matrix4X4
    oPump1 = New Equipment("HCPump05 8""x4""-E", oGenericSys)
    oMtx.SetIdentity()
    oPump1.Matrix = oMtx ' --> Control Orientation with Matrix
    oPump1.Origin = New Position(m_dX, m_dY, m_dZ) '--> Position specified on Form

    'Create and attach a Note to the Pump created above.
    Dim oNote As Note
    oNote = New Note(oPump1) '--> Create Note on Pump1
    oNote.SetPropertyValue(5, "IJGeneralNote", "Purpose") ' Maintenance
    oNote.SetPropertyValue("This is MAIN Pump", "IJGeneralNote", "Text")
    oNote.SetPropertyValue("Operation Information", "IJGeneralNote", "Name")
    oNote = New Note(oPump1) '--> Create Another Note on Pump1
    oNote.SetPropertyValue(6, "IJGeneralNote", "Purpose") ' Inspection
    oNote.SetPropertyValue("Inspect Every Month", "IJGeneralNote", "Text")
    oNote.SetPropertyValue("Inspection Information", "IJGeneralNote", "Name")

    'Create another pump, our Backup pump.
    oPump2 = New Equipment("HCPump05 8""x4""-E", oGenericSys)
    oPump2.Matrix = oMtx
    oPump2.Origin = New Position(m_dX + m_dSpacing, m_dY, m_dZ)

    oNote = New Note(oPump2) '--> Create Note on Pump2
    oNote.SetPropertyValue(5, "IJGeneralNote", "Purpose") ' Maintenance
    oNote.SetPropertyValue("This is STANDBY/BACKUP Pump", "IJGeneralNote", "Text")
    oNote.SetPropertyValue("Operation Information", "IJGeneralNote", "Name")
    oNote = New Note(oPump2) '--> Create Another Note on Pump2
    oNote.SetPropertyValue(6, "IJGeneralNote", "Purpose") ' Inspection
    oNote.SetPropertyValue("Inspect Every 3 Months", "IJGeneralNote", "Text")
    oNote.SetPropertyValue("Inspection Information", "IJGeneralNote", "Name")
    ' Compute shows Dynamics (all modified objects in rubberband hilite.). Commit saves
    ' the objects (two pumps, notes, with relation to pumps) and modifications to database.
    ClientServiceProvider.TransactionMgr.Compute()
    ClientServiceProvider.TransactionMgr.Commit("Place Two Pumps")

    'Lets find available Name Rules for Equipment class and pick 'UniqueNameRule' if it exists.
    ' For this, we use CatalogHelper to find out available Name rules on an object Class type.
    ' See GenericNameRules sheet. 
    Dim oCatalogHelper As New CatalogBaseHelper, oUniqNameRule As BusinessObject = Nothing
    For Each oNameRule As BusinessObject In oCatalogHelper.GetNamingRules("CPEquipment")
      'If we got our name rule of interest, then we exit this loop
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

    ' The compute here evaluates the changes since last compute/commit i.e. the name rule assignment.
    ' Here the Name Rule runs, generates and assigns a name.
    ClientServiceProvider.TransactionMgr.Compute()
    ' Commit saves the changes i.e. name rule assignment to the two pumps.
    ClientServiceProvider.TransactionMgr.Commit("Assign Unique NameRule to Pumps")




    ' Create a SpaceFolder, in which we will create ZoneSpaces around the Pumps
    Dim oSpaceFolder As FolderSpace
    oSpaceFolder = CreateSpaceFolder("Space Folder for Spaces around Pumps")
    ClientServiceProvider.TransactionMgr.Commit("Create Pumps Space Folder")




    ' Now lets create ZoneSpaces
    CreateSpace(oPump1, oSpaceFolder, "ZONETYPE", SpaceConstructionType.SpaceBy2Points)
    CreateSpace(oPump2, oSpaceFolder, "ZONETYPE", SpaceConstructionType.SpaceBy2Points)
    ClientServiceProvider.TransactionMgr.Commit("Create Spaces for Pumps")




    ' Route out from Pump1's Nozzle #1
    ' Create a PipeRun, 8in, of given spec
    Dim oPipeRun1 As PipeRun = New PipeRun(oPipeLine, 8.0, "in", m_strSpec)

    ' Set Temperatures and Pressures on PipeRun and Flow Direction 
    ' The SetPropertyValue has several overloads to deal with different attribute types
    oPipeRun1.SetPropertyValue(500.0, "IJProcessDataInfo", "DesignMaxTemp")
    oPipeRun1.SetPropertyValue(7500.0, "IJProcessDataInfo", "DesignMaxPressure")
    oPipeRun1.SetUserDefinedName("Run - 01") ' -> Set Name on PipeRun
    ' Set Flow Direction. Could have also done the CodelistItem way
    oPipeRun1.SetPropertyValue(1, "IJRtePipeRun", "FlowDirection")
    ClientServiceProvider.TransactionMgr.Compute()
    ' -> Note, Run is still temporary, not yet saved to Database.

    ' Clone another run with same properties, for the 2nd Pump.
    Dim oPipeRun2 As PipeRun
    oPipeRun2 = New PipeRun(oPipeRun1) '-> Create a new Run from an existing run
    oPipeRun2.SetUserDefinedName("Run - 02")




    ' Route dHeight distance outward from Pump1 Discharge
    '    Get the Discharge port of Pump1
    Dim oDischargeOfPump1 As IDistributionPort
    oDischargeOfPump1 = GetPortByName(oPump1, "Discharge")

        Dim oPos1 As Position
        Dim oFeat As IRoutePathFeature = Nothing
    ' Calculate the Point at a distance of dHeight from the Nozzle Location
    ' to do this, we Initialize a vector with appropriate values, and 
    ' use it to offset the Nozzle Location Point
    oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0, 0, m_dHeight))

    'Route from Pump Discharge to that point dHeight above.
    'Below method returns the resulting end feature for route continuation.
    oPipeRun1.RouteBetweenPortAndPoint(oDischargeOfPump1, oPos1, oFeat)

    ' The below Compute statement triggers evaluation logic in SP3D for the 
    ' changes done so far to objects. It will generate 
    '  Connection to nozzle with Mating Flange, bolts & gaskets, reducer if required,
    '  weld for the Reducer, plus the pipe upto the location specified.
    '  all of the parts/connection items will be picked up based on the spec and its rules.
    ClientServiceProvider.TransactionMgr.Compute()

    ' Route 'dHeaderLength' in East Direction from Current End Position.
    ' We offset the current point with a vector (direction & length) to move.
    Dim oPos2 As Position
    oPos1 = New Position(oFeat.Location)
    oPos2 = oPos1.Offset(New Vector(m_dHeaderLength, 0, 0))
    ' Now we route from the EndFeature to that Point
    oPipeRun1.RouteBetweenEndFeatureAndPoint(oFeat, oPos2, oFeat)

    ' In the Compute Call below, the elbow plus the pipe and welds get generated.
    ClientServiceProvider.TransactionMgr.Compute()





    ' We now place a terminal Flange at the end of this pipe. The oFeat we have with 
    ' us from above call is the current end feature till the last routed point.
        Dim oPF As RouteFeature = Nothing
    oPipeRun1.InsertFeatureByShortCodeOnFeature("Flange", 1, "", oFeat, oFeat.Location, Nothing, oPF)
    ' In the Compute Call below, the inserted feature is evaluted for placement as per the spec rules.
    ClientServiceProvider.TransactionMgr.Compute()

    ' The below statement will save changes since the previous save to database.
    ' i.e. the Mating Flanges, Bolts, Gaskets, Welds will be saved to database.
    ClientServiceProvider.TransactionMgr.Commit("Place 1st Run")





    'Now, lets Route out of 2nd Pump Discharge to branch in into the already placed header (run1)
    Dim oDischargeOfPump2 As IDistributionPort
    oDischargeOfPump2 = GetPortByName(oPump2, "Discharge")
    'Arrive at the required position on Header, i.e. dHeight from the Nozzle Location
    oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0, 0, m_dHeight)) ' move dHeight in Z direction
    ' Below call is to 
    '  Locate the Feature representing the Straight Pipe
    '  At position (oPos1) [could be approximate position within a tolerance]
    '  Returns accurate branching point (oPos2) and the Feature (oFeat)
    oPipeRun1.GetFeatureAtLocation(PathFeatureType_STRAIGHT, PathFeatureFunction_ROUTE, oPos1, oPos2, oFeat)

    ' Now, Branch in into the Header (Run1) from the Discharge Nozzle of Pump2.
    oPipeRun2.RouteBetweenPortAndBranch(oDischargeOfPump2, oFeat, oPos2)

    ' The below compute statement generates Mating Flange, Bolts, Gaskets, 
    ' Reducer (if required), welds, plus Tee on the header, splits header 
    ' pipe into two, and connects the Tee's 3rd port to Branch Run.
    ClientServiceProvider.TransactionMgr.Compute()
    ' Save changes to database.
    ClientServiceProvider.TransactionMgr.Commit("Place 2nd Run")




    ' Now lets place Check Valves on the vertical Pipes connected to the Main and Standby Pumps
        Dim oValveFeat As IRoutePathFeature = Nothing
    ' Arrive at the Point where you want to place the valve.
    oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0, 0, 0.5 * m_dHeight))
    ' Get the Straight feature on the run at that location, we need it to insert the valve.
    oPipeRun1.GetFeatureAtLocation(PathFeatureType_STRAIGHT, PathFeatureFunction_ROUTE, _
                                oPos1, oPos2, oFeat)
    ' Below method inserts a feature by "ShortCode & Option" on straight feature at a given position.
        oPipeRun1.InsertFeatureByShortCodeOnFeature("Check Valve", 1, "", oFeat, oPos2, Nothing, oValveFeat)

    ' Now do the same on the 2nd vertical pipe connected to the standby Pump.
    oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0, 0, 0.5 * m_dHeight))
    oPipeRun2.GetFeatureAtLocation(PathFeatureType_STRAIGHT, PathFeatureFunction_ROUTE, _
                                oPos1, oPos2, oFeat)
    oPipeRun2.InsertFeatureByShortCodeOnFeature("Check Valve", 1, "", oFeat, oPos2, Nothing, oValveFeat)

    ' The below compute statement will place Check Valves, generate Mating Flanges, 
    ' associated Bolts/Gaskets, welds ... Shows dynamics and gets ready for Commit.
    ClientServiceProvider.TransactionMgr.Compute()
    ' Save changes to database.
    ClientServiceProvider.TransactionMgr.Commit("Place Check Valves")




    ' Lets place supports on the two Horizontal Pipes of the main header.
    ' Get the position where we will look for the Straight Pipe.
    oPos1 = oDischargeOfPump1.Location.Offset(New Vector(0.25 * m_dHeaderLength, 0, m_dHeight))
    ' Get the Straight Pipe
    oPipeRun1.GetFeatureAtLocation(PathFeatureType_STRAIGHT, PathFeatureFunction_ROUTE, _
                                oPos1, oPos2, oFeat)
    'Now we create a Support at that point. Prepare a Supported Objects Collection.
    Dim oSupportedCol As New Collection(Of RouteFeature) '-> Supported Collection --> Feature(s)
    oSupportedCol.Add(oFeat)
    ' Create the Support with required inputs - owning Pipeline, SupportedFeatures, 
    '   SupportingFeatures (structure - not applicable for design support we are using)
    Dim oSupp As DesignSupport
    oSupp = New DesignSupport(oPipeLine, oSupportedCol, Nothing, oFeat.Location)
    ' Specify the Designed Pipe Support Catalog Part to use for this Design Support.
    oSupp.SupportDefinition = oCatalogHelper.GetPart("DesignPipeH_1")

    ' Now for the 2nd Pipe. Locate it by Going UP dHeight from Pump2's Discharge and 
    ' then 25% of headerlength to the East
    oPos1 = oDischargeOfPump2.Location.Offset(New Vector(0.25 * m_dHeaderLength, 0, m_dHeight))
    oPipeRun1.GetFeatureAtLocation(PathFeatureType_STRAIGHT, PathFeatureFunction_ROUTE, _
                                oPos1, oPos2, oFeat)
    'Clear existing SupportedFeature and add the 2nd Pipe alone.
    oSupportedCol.Clear()
    oSupportedCol.Add(oFeat)
        oSupp = New DesignSupport(oPipeLine, oSupportedCol, Nothing, oFeat.Location)
    oSupp.SupportDefinition = oCatalogHelper.GetPart("DesignPipeH_1")

    ' Compute - evaluates changes/ Objects created so far and shows dynamics.
    ' Supports associated to Pipe Features and Pipeline owns the supports.
    ClientServiceProvider.TransactionMgr.Compute()
    ' Save changes to database.
    ClientServiceProvider.TransactionMgr.Commit("Place Supports")

    MsgBox("Placement Complete", , "Place Equipment and Piping")
    Me.Close()
  End Sub

  ' The below routine returns a Port by Name on a Part
  Private Function GetPortByName(ByVal oPart As IConnectable, ByVal strName As String) As IPort
    Dim oPort As IPort
    GetPortByName = Nothing ' -> Initialize
    For Each oPort In oPart.GetPorts(PortType.All) ' Search in All Ports 
      If oPort.ToString = strName Then ' For given portName
        GetPortByName = oPort ' Return if found
        Exit Function
      End If
    Next
  End Function

  Private Sub Cancel_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel_Button.Click
    Me.DialogResult = System.Windows.Forms.DialogResult.Cancel
    ClientServiceProvider.TransactionMgr.Abort()
    Me.Close()
  End Sub
  'The below methods are event handlers on the TextBoxes to handle 
  ' Enter key and LostFocus events. 
  Private Sub txtX_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtX.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtX.Text, txtX, m_dX)
  End Sub

  Private Sub txtY_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtY.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtY.Text, txtY, m_dY)
  End Sub

  Private Sub txtZ_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtZ.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtZ.Text, txtZ, m_dZ)
  End Sub

  Private Sub txtSpacing_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtSpacing.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtSpacing.Text, txtSpacing, m_dSpacing)
  End Sub

  Private Sub txtHeaderLength_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHeaderLength.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtHeaderLength.Text, txtHeaderLength, m_dHeaderLength)
  End Sub

  Private Sub txtHeight_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHeight.KeyDown
    If (e.KeyCode = Keys.Enter) Then ParseDistance(txtHeight.Text, txtHeight, m_dHeight)
  End Sub

  Private Sub txtX_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtX.LostFocus
    ParseDistance(txtX.Text, txtX, m_dX)
  End Sub

  Private Sub txtY_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtY.LostFocus
    ParseDistance(txtY.Text, txtY, m_dY)
  End Sub

  Private Sub txtZ_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtZ.LostFocus
    ParseDistance(txtZ.Text, txtZ, m_dZ)
  End Sub

  Private Sub txtSpacing_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSpacing.LostFocus
    ParseDistance(txtSpacing.Text, txtSpacing, m_dSpacing)
  End Sub

  Private Sub txtHeaderLength_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHeaderLength.LostFocus
    ParseDistance(txtHeaderLength.Text, txtHeaderLength, m_dHeaderLength)
  End Sub

  Private Sub txtHeight_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHeight.LostFocus
    ParseDistance(txtHeight.Text, txtHeight, m_dHeight)
  End Sub

  Private Sub txtSpec_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSpec.LostFocus
    m_strSpec = Trim(txtSpec.Text)
  End Sub
  ' This method parses distance keyin and returns distance
  ' visually indicates if it is in error.
  Private Function ParseDistance(ByVal txt As String, ByVal ctrl As TextBox, ByRef dValue As Double) As Double
    Dim dVal As Double
    Try
      dVal = MiddleServiceProvider.UOMMgr.ParseUnit(UnitType.Distance, txt)
      dValue = dVal
      ctrl.ForeColor = Drawing.Color.Black
    Catch e As Exception
      ctrl.ForeColor = Drawing.Color.Red
    End Try
  End Function

  'This function creates Space for a given Object given its IRange Interface
  Private Function CreateSpace(ByVal objRange As IRange, ByVal oParent As FolderSpace, ByVal strSpaceType As String, ByVal oCType As SpaceConstructionType) As SpaceBase

    'Create the Space Range as 10% extra on each edge
    ' Arrive at diagonal ends of such expanded range
    Dim oPtLow, oPtHigh, oPtCtr As Position, oVec As Vector
    oPtLow = New Position(objRange.Range.Low)
    oPtHigh = New Position(objRange.Range.High)
    oPtCtr = New Position(0.5 * (oPtLow.X + oPtHigh.X), _
                         0.5 * (oPtLow.Y + oPtHigh.Y), _
                          0.5 * (oPtLow.Z + oPtHigh.Z))

    oVec = oPtCtr.Subtract(oPtLow) ' Get vector from center to Low Point
        oVec.Length = 1.1 * oVec.Length ' elongate the vector by 10% in magnitude
    oPtLow = oPtCtr.Offset(oVec) ' arrive at the expanded range end point
    oVec = oPtCtr.Subtract(oPtHigh) ' Get vector from center to High Point
        oVec.Length = 1.1 * oVec.Length ' elongate the vector by 10% in magnitude
    oPtHigh = oPtCtr.Offset(oVec) ' arrive at the expanded range end point

    ' Create Space by 2 points
    Dim oCatBaseHelper As New CatalogBaseHelper, oSpaceBase As SpaceBase
    Dim oSpaceInputs(1) As SpaceInputs, oInputsColl As New Collection(Of SpaceInputs)

    ' Prepare SpaceInputs for creation
    oSpaceInputs(0) = New SpaceInputs
    oSpaceInputs(1) = New SpaceInputs
    oSpaceInputs(0).InputObject = New Point3d(ClientServiceProvider.WorkingSet.ActiveConnection, oPtHigh)
    oSpaceInputs(1).InputObject = New Point3d(ClientServiceProvider.WorkingSet.ActiveConnection, oPtLow)
    oInputsColl.Add(oSpaceInputs(0))
    oInputsColl.Add(oSpaceInputs(1))

    ' Create appropriate Space object : Area / Interference / Zone
    Select Case strSpaceType
      Case "AREATYPE"
        oSpaceBase = New AreaSpace(oCatBaseHelper.GetPart("SPACE_DEF_SA01"), _
                            oCType, oParent, oInputsColl)

      Case "INTERFERENCETYPE"
        oSpaceBase = New InterferenceSpace(oCatBaseHelper.GetPart("SPACE_DEF_IV01"), _
                            oCType, oParent, oInputsColl)

      Case "ZONETYPE"
        oSpaceBase = New ZoneSpace(oCatBaseHelper.GetPart("SPACE_DEF_HZ01"), _
                            oCType, oParent, oInputsColl)

      Case Else
        Return Nothing ' Error
    End Select

    ' associate the object with this space
    oSpaceBase.AssociatedObject = objRange
    oSpaceBase.SetUserDefinedName(oCType.ToString & "-" & strSpaceType)
    ClientServiceProvider.TransactionMgr.Compute()
    Return oSpaceBase

  End Function

  'This function creates a Space Folder with given name
  Private Function CreateSpaceFolder(ByVal strName As String) As FolderSpace
    Dim oSpaceRoot As BusinessObject, oSpaceFolder As FolderSpace
    ' Get Space Root of ActivePlant
    oSpaceRoot = (MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel.RootSystem)
    ' Create a Space Folder with given name
    oSpaceFolder = New FolderSpace(oSpaceRoot)
    oSpaceFolder.SetUserDefinedName(strName)
    Return oSpaceFolder
  End Function
End Class

