Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Middle
Imports System.Collections.ObjectModel

Public Class frmFiltersLab


    Private Sub btnFilterFolder_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFilterFolder.Click
        'demonstrates creating filter folders

        Dim oFolder As FilterFolder = Nothing
        Dim oChildFolder As FilterFolder

        Try
            oFolder = New FilterFolder("Filter Folder #1") ' --> gets created into "My Filters"
            ClientServiceProvider.TransactionMgr.Commit("")
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

        Try
            oChildFolder = New FilterFolder("Filter Sub Folder #2", oFolder) ' --> Expect to work. FAILS
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

        oChildFolder = New FilterFolder("Filter Folder #2", "My Filters") ' --> gets created into ""
        ClientServiceProvider.TransactionMgr.Commit("")
        oChildFolder = New FilterFolder("Filter Sub Folder #2 #1", "My Filters\Filter Folder #1") ' --> gets created into ""
        ClientServiceProvider.TransactionMgr.Commit("")
        oChildFolder = New FilterFolder("Filter Sub Folder #2.1 #1", "My Filters\Filter Folder #2") ' --> gets created into ""
        ClientServiceProvider.TransactionMgr.Commit("")

        MsgBox(oFolder.ChildFolders.Count)

        MsgBox(oFolder.ChildFolders.Contains(oChildFolder))

        oFolder.Name = "Change the Name"
        ClientServiceProvider.TransactionMgr.Commit("")

    End Sub

 

    Private Sub btnCompoundFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCompoundFilter.Click
        '' Demonstrates ObjectTypeFilter, CompoundFilters


        Try
            lvObjs.Items.Clear()

            Dim oFilter1 As New Filter("TestFilter1", "My Filters")
            Dim oFilter2 As New Filter("TestFilter2", "My Filters")
            Dim oCF As New CompoundFilter("TestCmpFilter", "My Filters")

            oFilter1.Definition.AddObjectType("Piping")
            oFilter2.Definition.AddObjectType("Equipment&Furnishing\EquipmentTypes")

            oCF.AddFilter(oFilter1)
            oCF.AddLogicalOperator(CompoundFilterOperators.Or)
            oCF.AddFilter(oFilter2)

            OutputResultFromFilterApply(oCF)

            ClientServiceProvider.TransactionMgr.Commit("Commit Compound Filter")
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub btnHierarchyFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnHierarchyFilter.Click


        Try
            '' Demonstrates ObjectType Filter, Hierarchy Filter

            lvObjs.Items.Clear()
            Dim oFilter As New Filter

            oFilter.Definition.AddObjectType("Systems\PipelineSystems")

            Dim oObjs As ReadOnlyCollection(Of BusinessObject)
            oObjs = oFilter.Apply()  '--> get all Pipeline systems

            Dim oHierFilter As New Filter
            oHierFilter.Definition.AddHierarchy(HierarchyTypes.System, oObjs, True) ' get all objects under those Pipeline Systems.

            OutputResultFromFilterApply(oHierFilter)

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

        'our filters are transient, so no need for commit
        'ClientServiceProvider.TransactionMgr.Commit("Commit HierarchyFilter")
    End Sub

    Private Sub btnPropertiesFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPropertiesFilter.Click
        '' Demonstrates PropertyValue handling, PropertiesFilter, GetAllProperties


        Try
            lvObjs.Items.Clear()

            ' Includes Example for PropertyValue handling.
            Dim oPV(1) As PropertyValueDouble

            oPV(0) = New PropertyValueDouble("IJProcessDataInfo", "DesignMaxTemp", 0)
            oPV(1) = New PropertyValueDouble("IJProcessDataInfo", "DesignMaxTemp", 400)

            Dim oFilter As New Filter
            oFilter.Definition.AddWherePropertyInRange(oPV(0), oPV(1), RangeValueComparisonOperators.Between)

            OutputResultFromFilterApply(oFilter)

            'our filter is transient, so no need for commit
            'ClientServiceProvider.TransactionMgr.Commit("Commit PropertiesFilter")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Private Sub btnPersistantFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPersistantFilter.Click
        ' It Creates 2Persistant Filters in "My Filters" and "Plant Filters"


        Try
            lvObjs.Items.Clear()
            Dim oFilter As New Filter("TestLabFilter", "My Filters")
            Dim oFilter1 As New Filter("TestLabPlantFilter", "Plant Filters")

            oFilter.Definition.AddObjectType("Systems\PipelineSystems")
            oFilter1.Definition.AddObjectType("Equipment&Furnishing\EquipmentTypes")
        Catch ex As Exception

        End Try

        ClientServiceProvider.TransactionMgr.Commit("Commit PersistantFilter")

    End Sub

    Private Sub btnSQLFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSQLFilter.Click

        Dim oFilter As SQLFilter
        Try

            oFilter = New SQLFilter("TestSQLFilter1", "My Filters")
            oFilter.SetSQLFilterString("Select OID from JLine")
            OutputResultFromFilterApply(oFilter)



        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

        ClientServiceProvider.TransactionMgr.Commit("Commit SQLFilter")
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Me.Close()
    End Sub

    Private Sub OutputResultFromFilterApply(ByVal oFilter As FilterBase)
        Dim oObjs As ReadOnlyCollection(Of BusinessObject)
        oObjs = oFilter.Apply()

        For Each oObj As BusinessObject In oObjs
            lvObjs.Items.Add(oObj.ClassInfo.Name & " - " & oObj.ToString())
        Next

    End Sub
End Class