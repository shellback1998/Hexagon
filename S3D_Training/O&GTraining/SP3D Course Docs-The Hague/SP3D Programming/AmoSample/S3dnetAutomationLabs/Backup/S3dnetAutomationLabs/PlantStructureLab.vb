Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services
Imports Ingr.SP3D.Structure.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Grids.Middle
Imports Ingr.SP3D.Grids.Middle.Services



Public Class PlantStructureLab
    Inherits basemodalcommand

    Private m_frmProgressBar As frmProgressBar

    Dim m_oCS As CoordinateSystem
    Dim m_oZn1 As GridElevationPlane
    Dim m_oZ4 As GridElevationPlane
    Dim m_oZ0 As GridElevationPlane

    Dim m_oY0 As GridPlane
    Dim m_oY25 As GridPlane
    Dim m_oY5 As GridPlane

    Dim m_oX0 As GridPlane
    Dim m_oX5 As GridPlane
    Dim m_oX55 As GridPlane
    Dim m_oX105 As GridPlane

    Dim m_oZAxis As GridAxis
    Dim m_oXAxis As GridAxis
    Dim m_oYAxis As GridAxis

    Dim m_oZ0_X0 As GridLine
    Dim m_oZ0_X5 As GridLine
    Dim m_oZ0_X55 As GridLine
    Dim m_oZ0_X105 As GridLine
    Dim m_oZ4_X0 As GridLine
    Dim m_oZ4_X5 As GridLine
    Dim m_oZ4_X55 As GridLine
    Dim m_oZ4_X105 As GridLine
    Dim m_oZ0_Y0 As GridLine
    Dim m_oZ0_Y5 As GridLine
    Dim m_oZ4_Y0 As GridLine
    Dim m_oZ4_Y5 As GridLine

    ' creating the catalog connection, catalog helper, model connection and parent system
    Dim m_oCatConn As SP3DConnection
    Dim m_oModelConn As Model
    Dim m_oTxnMgr As TransactionManager
    Dim m_oCatStructhelper As CatalogStructHelper
    Dim m_oStructSystem As StructuralSystem

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Try
            Dim oMsgBoxResult As MsgBoxResult
            oMsgBoxResult = MsgBox("Do you want to start the messsagebox lab?", MsgBoxStyle.OkCancel)

            If oMsgBoxResult = MsgBoxResult.Cancel Then
                Exit Sub
            End If

            m_frmProgressBar = New frmProgressBar
            m_frmProgressBar.Show()


            InitializeCommonObjects()
            PlaceGrids()
            'PlaceMembers()
            'PlaceSlabs()
            'placeWalls()
            'PlaceFootings()
            'PlaceEquipmentFoundation()
            'PlaceLadders()
            'PlaceStairs()
            'PlaceHandrails()

        Catch ex As Exception
            MsgBox(ex.Message)

        End Try
    End Sub

    Private Sub initializeprogressbar(ByVal prgbarfrm As frmProgressBar, ByVal Labeltext As String)
        prgbarfrm.Label1.Text = Labeltext
        prgbarfrm.Progressbar.Value = 0

    End Sub

    Private Sub TerminateProgressbar(ByVal prgbarfrm As frmProgressBar, ByVal Labeltext As String)
        prgbarfrm.Label1.Text = labeltext
        prgbarfrm.Progressbar.Value = 100
        prgbarfrm.Close()

    End Sub

    Private Sub InitializeCommonObjects()
        'initialize the progressbar to know the status when the command is running
        m_frmProgressBar = New frmProgressBar
        'catalog database connection
        m_oCatConn = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantCatalog
        'model database connection
        m_oModelConn = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel
        'transaction manager
        m_oTxnMgr = MiddleServiceProvider.TransactionMgr
        'catalog helper for accessing structure( e.g. cross sections, plate thickness etc.)
        m_oCatStructhelper = New CatalogStructHelper(m_oCatConn)
        'root system
        Dim oRootSystem As ISystem = m_oModelConn.RootSystem
        'parent structural system under which the objects will be created
        m_oStructSystem = New StructuralSystem(DirectCast(oRootSystem, BusinessObject))
        m_oStructSystem.SetUserDefinedName("3DAPIStructureLab")
    End Sub

    Private Sub PlaceGrids()

        initializeprogressbar(m_frmProgressBar, "creating Coordinate System...")

        'create coordinate system
        Dim StepSize As Integer = 30
        m_oCS = New CoordinateSystem(m_oModelConn, CoordinateSystem.CoordinateSystemType.Grids)
        Dim oPos As New Position(0.0, 0.0, 0.0)
        m_oCS.Origin = oPos
        m_oCS.SetPropertyValue("CS_StructureLab", "IJNamedItem", "Name")
        m_oStructSystem.AddSystemChild(m_oCS)
        m_frmProgressBar.Progressbar.Increment(StepSize)

        'create the grid axis X,Y,Z
        m_frmProgressBar.Text = "Creating Grids..."
        m_oZAxis = New GridAxis(m_oCS, AxisType.Z)
        m_oXAxis = New GridAxis(m_oCS, AxisType.X)
        m_oYAxis = New GridAxis(m_oCS, AxisType.Y)
        'm_oZAxis.SetUserDefinedName("Elev")
        'm_oXAxis.SetUserDefinedName("NS")
        'm_oYAxis.SetUserDefinedName("EW")

        'Elevation Planes
        m_oZn1 = New GridElevationPlane(-1, m_oZAxis)
        m_oZ4 = New GridElevationPlane(4, m_oZAxis)
        m_oZ0 = New GridElevationPlane(0, m_oZAxis)
        m_oZn1.SetUserDefinedName("Elev-1m")
        m_oZ4.SetUserDefinedName("Elev4m")
        m_oZ0.SetUserDefinedName("Elev0m")

        'Y (North South) Planes
        m_oY0 = New GridPlane(0.0, m_oYAxis)
        m_oY25 = New GridPlane(2.5, m_oYAxis)
        m_oY5 = New GridPlane(5.0, m_oYAxis)
        m_oY0.SetUserDefinedName("NS0m")
        m_oY25.SetUserDefinedName("NS2.5m")
        m_oY5.SetUserDefinedName("NS5m")
        m_frmProgressBar.Progressbar.Increment(StepSize)

        'X ( East West) planes
        m_oX0 = New GridPlane(0.0, m_oXAxis)
        m_oX5 = New GridPlane(5.0, m_oXAxis)
        m_oX55 = New GridPlane(5.5, m_oXAxis)
        m_oX105 = New GridPlane(10.5, m_oXAxis)
        m_oX0.SetUserDefinedName("EWom")
        m_oX5.SetUserDefinedName("EW5m")
        m_oX55.SetUserDefinedName("EW5.5m")
        m_oX105.SetUserDefinedName("EW10.5m")

        'now create gridlines
        m_oZ0_X0 = m_oZ0.CreateGridLine(m_oX0)
        m_oZ0_X5 = m_oZ0.CreateGridLine(m_oX5)
        m_oZ0_X55 = m_oZ0.CreateGridLine(m_oX55)
        m_oZ0_X105 = m_oZ0.CreateGridLine(m_oX105)
        m_oZ4_X0 = m_oZ4.CreateGridLine(m_oX0)
        m_oZ4_X5 = m_oZ4.CreateGridLine(m_oX5)
        m_oZ4_X55 = m_oZ4.CreateGridLine(m_oX55)
        m_oZ4_X105 = m_oZ4.CreateGridLine(m_oX105)
        m_oZ0_Y0 = m_oZ0.CreateGridLine(m_oY0)
        m_oZ0_Y5 = m_oZ0.CreateGridLine(m_oY5)
        m_oZ4_Y0 = m_oZ4.CreateGridLine(m_oY0)
        m_oZ4_Y5 = m_oZ4.CreateGridLine(m_oY5)

        m_frmProgressBar.Progressbar.Increment(StepSize)
        m_oTxnMgr.Commit("committing CS and Grids")
        TerminateProgressbar(m_frmProgressBar, "CS and Grids completed")

    End Sub

    Private Sub PlaceMembers()
        Dim x As Integer
        For x = 0 To 17
            Dim m_oMemberSystems(x) As MemberSystem
        Next

        initializeprogressbar(m_frmProgressBar, "Placing Columns")

    End Sub

End Class
