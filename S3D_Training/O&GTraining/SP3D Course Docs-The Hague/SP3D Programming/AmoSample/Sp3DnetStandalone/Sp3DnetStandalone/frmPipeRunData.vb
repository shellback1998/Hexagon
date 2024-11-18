Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Imports System.Reflection
Imports Microsoft.Win32

Public Class frmPipeRunData

    Private m_oUOM As UOMManager

    Private Sub frmPipeRunData_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        MiddleServiceProvider.TransactionMgr.Abort()
        MiddleServiceProvider.Cleanup()

        'Fading out the form when exiting
        For i As Integer = 100 To 1 Step -1
            Me.Opacity = i / 100
            Me.Refresh()
            Threading.Thread.Sleep(5)
        Next

    End Sub

    Private Sub frmPipeRunData_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            ' connect to default site It is also possible to specify site connection info
            'and connect to it
            Dim oSite As Site
            oSite = MiddleServiceProvider.SiteMgr.ConnectSite()
            'To connect to a different site then the default, use this:
            oSite = MiddleServiceProvider.SiteMgr.ConnectSite("SOLIDS1002", "SP3DTRAIN", SiteManager.eDBProviderTypes.MSSQL, "v91Site_SCHEMA")

            If oSite Is Nothing Then
                MsgBox("No Site Available")
            Else
                If oSite.Plants.Count > 0 Then
                    oSite.OpenPlant(oSite.Plants(0)) 'choose the first
                    'set permissiongroup
                    Dim oModel As Model = oSite.ActivePlant.PlantModel
                    oModel.ActivePermissionGroup = oModel.PermissionGroups(0)
                    MiddleServiceProvider.TransactionMgr.Commit("")
                Else
                    MsgBox("No Plants defined in default site")
                End If
            End If

            m_oUOM = MiddleServiceProvider.UOMMgr

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub


    Private Sub btnSetValues_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSetValues.Click
        Try
            'first step: get all the systems with the given name using a proprty filter
            Dim oPropertyFilter As New Filter, oProperty As PropertyValueString
            Dim oSystemsByName As ReadOnlyCollection(Of BusinessObject)

            oProperty = New PropertyValueString("IJnamedItem", "Name", txtSysName.Text)
            oPropertyFilter.Definition.AddWhereProperty(oProperty, PropertyComparisonOperators.LIKE)
            oPropertyFilter.Definition.AddObjectType("Systems") '"Classification Topnodes"(2e mapje) in the metadatabrowser
            oSystemsByName = oPropertyFilter.Apply()

            'second step: get all the piperuns under the filtered objects that we get in the first step.
            Dim oRunsFilter As New Filter, oRuns As ReadOnlyCollection(Of BusinessObject)
            oRunsFilter.Definition.AddHierarchy(HierarchyTypes.System, oSystemsByName, True)
            oRunsFilter.Definition.AddObjectType("Piping\PipingRuns")
            oRuns = oRunsFilter.Apply()

            If (oRuns.Count > 0) Then 'Go through each run and set the required values
                Dim dDsgMaxTemp As Double, dDsgmaxPressure As Double, oRun As BusinessObject
                'get the given temperature and pressure values in model units.
                dDsgmaxPressure = m_oUOM.ParseUnit(UnitType.ForcePerArea, txtDsgMaxPressure.Text)
                dDsgMaxTemp = m_oUOM.ParseUnit(UnitType.Temperature, txtDsgMaxTemp.Text)
                For Each oRun In oRuns
                    oRun.SetPropertyValue(dDsgMaxTemp, "IJProcessDataInfo", "DesignMaxTemp")
                    oRun.SetPropertyValue(dDsgmaxPressure, "IJProcessDataInfo", "DesignMaxPressure")
                    MiddleServiceProvider.TransactionMgr.Commit("Set Value")
                Next
            Else
                MsgBox("No Pipe Runs found")
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Shared Sub New()
        ' Establish a Assembly Load event handler to let us load CommonMiddle.DLL from product Location.
        AddHandler AppDomain.CurrentDomain.AssemblyResolve, AddressOf MyResolveEventHandler
    End Sub

    Shared Function MyResolveEventHandler(ByVal sender As Object, ByVal args As ResolveEventArgs) As [Assembly]
        'This handler is called only when the common language runtime tries to bind to the assembly and fails.        
        'Retrieve the list of referenced assemblies in an array of AssemblyName.
        Dim objExecutingAssemblies As [Assembly] = [Assembly].GetExecutingAssembly
        Dim arrReferencedAssmbNames() As AssemblyName = objExecutingAssemblies.GetReferencedAssemblies()

        'Loop through the array of referenced assembly names.
        For Each strAssmbName As AssemblyName In arrReferencedAssmbNames
            'Look for the assembly names that have raised the "AssemblyResolve" event.
            If (strAssmbName.Name.EndsWith("CommonMiddle") AndAlso _
            strAssmbName.FullName.Substring(0, strAssmbName.FullName.IndexOf(",")) = args.Name.Substring(0, args.Name.IndexOf(","))) Then

                'We only have this handler to deal with loading of CommonMiddle. Rest everything we dont bother.
                RemoveHandler AppDomain.CurrentDomain.AssemblyResolve, AddressOf MyResolveEventHandler

                'Build the path of the assembly from where it has to be loaded.
                'Check CurrentUser,LocalMachine, 64bit CurrentUser,LocalMachine
                Const ProductInstallationKey As String = "\Software\Intergraph\SP3D\Installation"
                Const Wow6432Path = "\Software\Wow6432Node\Intergraph\SP3D\Installation"
                Const InstallDirKey = "INSTALLDIR"
                Dim sInstallPath = CStr(Registry.GetValue(Registry.CurrentUser.ToString & ProductInstallationKey, InstallDirKey, ""))

                If sInstallPath = "" Then  'try Local Machine
                    sInstallPath = CStr(Registry.GetValue(Registry.LocalMachine.ToString & ProductInstallationKey, InstallDirKey, ""))
                End If

                If sInstallPath = "" Then   'try 64-bit CurrentUser
                    sInstallPath = CStr(Registry.GetValue(Registry.CurrentUser.ToString & Wow6432Path, InstallDirKey, ""))
                End If

                If sInstallPath = "" Then    'try 64-bit LocalMachine
                    sInstallPath = CStr(Registry.GetValue(Registry.LocalMachine.ToString & Wow6432Path, InstallDirKey, ""))
                End If

                If (Trim(sInstallPath) <> "") Then
                    If (sInstallPath.EndsWith("\") = False) Then sInstallPath += "\"
                    sInstallPath += "Core\Container\Bin\Assemblies\Release\"
                Else
                    Throw New Exception("Error Reading SmartPlant 3D Installation Directory from Registry !!! Exiting")
                End If

                'Load the assembly from the specified path and return it.
                Dim strTempAssmbPath As String = sInstallPath & args.Name.Substring(0, args.Name.IndexOf(",")) & ".dll"
                Return [Assembly].LoadFrom(strTempAssmbPath)
            End If
        Next
        Return Nothing ' shouldnt reach here.
    End Function
End Class
