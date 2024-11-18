Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports System.Collections.ObjectModel
Imports System.Reflection
Imports System.Windows.Forms

Public Class WBSAppForm

    Dim oSiteMgr As SiteManager, oSite As Site, oPlant As Plant, oModel As Model
    Dim oConn As SP3DConnection, oTxnMgr As TransactionManager

    Private Sub WBSAppForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        AddHandler AppDomain.CurrentDomain.AssemblyResolve, AddressOf MyResolveEventHandler

        ' When the Form loads, just connect to the Site and get available plants
        ConnectToSP3DSite()
        cboAssign.SelectedIndex = 0 ' Default to System
    End Sub

    ' Connects to Last used / configured Site (currently active in registry)
    Private Sub ConnectToSP3DSite()

        ' Get Site Manager
        oSiteMgr = MiddleServiceProvider.SiteMgr
        MiddleServiceProvider.SiteMgr.ConnectSite() 'connect to site

        'Get the first site (which is the only site)
        oSite = oSiteMgr.Sites(0)
        ' Populate the available Plants list
        PopulatePlants()

    End Sub

    ' Populates the available Plants list
    Private Sub PopulatePlants()

        Dim oPlant As Plant
        For Each oPlant In oSite.Plants
            cboPlants.Items.Add(oPlant)
        Next
    End Sub

    ' Handles user's selection of a Plant from the available Plants list
    ' Opens the Plant, 
    Private Sub cboPlants_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPlants.SelectedIndexChanged

        If (cboPlants.SelectedItem Is Nothing) Then Exit Sub

        ' Open the Plant
        oSite.OpenPlant(cboPlants.SelectedItem)

        ' Init our class variables.
        oPlant = oSiteMgr.ActiveSite.ActivePlant
        oModel = oPlant.PlantModel
        oConn = oModel
        oTxnMgr = MiddleServiceProvider.TransactionMgr

        'populate the list of permission groups available for this user.
        cboPGs.Items.Clear()
        For Each oPG As PermissionGroup In oModel.PermissionGroups
            cboPGs.Items.Add(oPG)
        Next

        ' Populate available WBS Projects
        PopulateWBSProjects()

    End Sub

    ' Handles PG selection by User
    Private Sub cboPGs_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPGs.SelectedIndexChanged

        'If (cboPGs.SelectedItem Is Nothing) Then Exit Sub
        If (cboPGs.SelectedIndex < 0) Then Exit Sub

        ' Set the Active Permission Group on the Active Connection, i.e. the Model.
        oModel.ActivePermissionGroup = cboPGs.SelectedItem

        'Need to commit after changing Active permission Group.
        'Without a commit, the active permissionGroup will not be set correctly
        oTxnMgr.Commit("")
        GroupBox1.Enabled = True
        GroupBox2.Enabled = True
    End Sub

    'Populates WBSProjects in the Plant into a Treeview.
    Private Sub PopulateWBSProjects()

        'Clears the Treeview
        tvWBSHier.Nodes.Clear()
        'Clears the current WBSParent Node's WBSChild objects
        lvInfo.Items.Clear()

        ' Find the available WBSProjects in the Plant.
        ' We use a ObjectType Filter to find them.
        Dim oFilter As New Filter, oObjs As ReadOnlyCollection(Of BusinessObject)
        oFilter.Definition.AddObjectType("CommonObjects\\WBSProjects")
        oObjs = oFilter.Apply()

        ' Now, add the resulting objects (WBSProjects) to the TreeView
        For Each oObj As BusinessObject In oObjs
            AddWBSProjectsToTreeview(oObj)
        Next oObj

    End Sub

    'Adds a WBSProject (and its WBSItems under it) to a TreeView, hierarchically.
    Private Sub AddWBSProjectsToTreeview(ByVal oObj As BusinessObject)

        ' Add a Node to the Treeview for each WBSProject
        Dim oNode As System.Windows.Forms.TreeNode
        Debug.Print("Adding Project - " & oObj.ObjectID & "=" & oObj.ToString())
        oNode = tvWBSHier.Nodes.Add(UCase(oObj.ObjectID), oObj.ToString())
        oNode.Tag = oObj.ObjectID
        tvWBSHier.ExpandAll()

        ' If the WBSProject has Children (WBSItems) add them to the TreeView.
        Dim oWBSParent As IWBSParent
        If (TypeOf oObj Is IWBSParent) Then
            oWBSParent = oObj
            If (oWBSParent.WBSChildren.Count > 0) Then
                For Each oWBSItem As IWBSItem In oWBSParent.WBSChildren
                    AddWBSItemToTreeview(oWBSItem, oWBSParent)
                Next
            End If
        End If
    End Sub

    'Adds a WBSItem to the TreeView
    Private Sub AddWBSItemToTreeview(ByVal oObj As BusinessObject, ByVal oParent As BusinessObject)

        Dim oNode As System.Windows.Forms.TreeNode, oParentNode As System.Windows.Forms.TreeNode

        Debug.Print("Adding Item - " & oParent.ToString() & "\\" & oObj.ObjectID & "=" & oObj.ToString())
        ' Get Parent Node to add
        oParentNode = tvWBSHier.Nodes(UCase(oParent.ObjectID))
        ' Add a Node for this WBSItem. Use its OID as key since we will need it while we add its children down below.
        oNode = oParentNode.Nodes.Add(UCase(oObj.ObjectID), oObj.ToString())
        oNode.Tag = oObj.ObjectID
        tvWBSHier.ExpandAll()

        ' If the WBSItem added above has children WBSItems, add them too recursively
        Dim oWBSParent As IWBSParent
        If (TypeOf oObj Is IWBSParent) Then
            oWBSParent = oObj
            If (oWBSParent.WBSChildren.Count > 0) Then
                For Each oWBSItem As IWBSItem In oWBSParent.WBSChildren
                    AddWBSItemToTreeview(oWBSItem, oWBSParent)
                Next
            End If
        End If

    End Sub

    Function MyResolveEventHandler(ByVal sender As Object, _
                                   ByVal args As ResolveEventArgs) As [Assembly]
        'This handler is called only when the common language runtime tries to bind to the assembly and fails.        

        'Retrieve the list of referenced assemblies in an array of AssemblyName.
        Dim objExecutingAssemblies As [Assembly] = [Assembly].GetExecutingAssembly
        Dim arrReferencedAssmbNames() As AssemblyName
        arrReferencedAssmbNames = objExecutingAssemblies.GetReferencedAssemblies()

        'Loop through the array of referenced assembly names.
        Dim strAssmbName As AssemblyName
        For Each strAssmbName In arrReferencedAssmbNames

            'Look for the assembly names that have raised the "AssemblyResolve" event.
            If (strAssmbName.Name.EndsWith("CommonMiddle") AndAlso _
                strAssmbName.FullName.Substring(0, strAssmbName.FullName.IndexOf(",")) = args.Name.Substring(0, args.Name.IndexOf(","))) Then

                'Build the path of the assembly from where it has to be loaded.
                Dim strTempAssmbPath As String
                strTempAssmbPath = "C:\SP3D\WS\Core\Container\Bin\Assemblies\Release\" & args.Name.Substring(0, args.Name.IndexOf(",")) & ".dll"

                Dim MyAssembly As [Assembly]

                'Load the assembly from the specified path. 
                MyAssembly = [Assembly].LoadFrom(strTempAssmbPath)

                'Return the loaded assembly.
                Return MyAssembly
            End If
        Next

    End Function

    Private Sub btnCreateWBSProject_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCreateWBSProject.Click
        Dim oWBSProject As New WBSProject
        oWBSProject.SetUserDefinedName(txtWBSProjName.Text)
        oTxnMgr.Commit("Create WBS Project - " & txtWBSProjName.Text)
        AddWBSProjectsToTreeview(oWBSProject)
    End Sub

    Private Sub btnCreateItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCreateItem.Click
        Dim oWBSParent As IWBSParent
        oWBSParent = oModel.WrapSP3DBO(oModel.GetBOMonikerFromDbIdentifier(tvWBSHier.SelectedNode.Tag))
        Dim oWBSItem As WBSItem
        oWBSItem = New WBSItem(oWBSParent, chkExclusive.Checked, cboAssign.SelectedIndex)
        oWBSItem.SetUserDefinedName(txtWBSItemName.Text)
        oTxnMgr.Commit("Create WBSItem - " & txtWBSItemName.Text)
        AddWBSItemToTreeview(oWBSItem, oWBSParent)
    End Sub

    Private Sub tvWBSHier_AfterSelect(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TreeViewEventArgs) Handles tvWBSHier.AfterSelect
        btnCreateItem.Enabled = (Trim(txtWBSItemName.Text) <> "" _
            AndAlso tvWBSHier.SelectedNode IsNot Nothing)

        lvInfo.Items.Clear()
        If (tvWBSHier.SelectedNode.Parent Is Nothing) Then
            Dim oWBSProject As IWBSProject, oWBSProjectChildren As ReadOnlyCollection(Of BusinessObject)

            oWBSProject = oModel.WrapSP3DBO(oModel.GetBOMonikerFromDbIdentifier(tvWBSHier.SelectedNode.Tag))
            oWBSProjectChildren = oWBSProject.ProjectChildren
            lvInfo.Items.Add(oWBSProjectChildren.Count & " Children")
            For Each oBO As BusinessObject In oWBSProjectChildren
                lvInfo.Items.Add(oBO.ToString())
            Next
        Else
            Dim oWBSItem As WBSItem, oWBSItemChildren As ReadOnlyCollection(Of IWBSItemChild)

            oWBSItem = oModel.WrapSP3DBO(oModel.GetBOMonikerFromDbIdentifier(tvWBSHier.SelectedNode.Tag))
            oWBSItemChildren = oWBSItem.WBSItemChildren
            lvInfo.Items.Add(oWBSItemChildren.Count & " Children")
            For Each oBO As BusinessObject In oWBSItemChildren
                lvInfo.Items.Add(oBO.ToString())
            Next
        End If
    End Sub

    Private Sub txtWBSProjName_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtWBSProjName.TextChanged
        btnCreateWBSProject.Enabled = (Trim(txtWBSProjName.Text) <> "")
    End Sub

    Private Sub txtWBSItemName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtWBSItemName.TextChanged
        btnCreateItem.Enabled = (Trim(txtWBSItemName.Text) <> "" _
                                 AndAlso tvWBSHier.SelectedNode IsNot Nothing)
    End Sub
End Class