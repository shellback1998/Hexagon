'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2009 Intergraph
'   All Rights Reserved
'
'   frmSystem.vb
'   ProgID:         SP3DNetTestSystem.CSystem
'   Author:         SivaKumar Kotha
'   Creation Date:  Friday, Jan 09, 2009
'   Description:
'       TODO - fill in header description information
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'        
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Option Strict Off
Option Explicit On

Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Equipment.Middle
Imports Ingr.SP3D.Systems.Middle
Imports System.Windows.Forms
Imports System.Collections.ObjectModel

Public Class frmSystem
    Private m_oTxnMgr As ClientTransactionManager
    Private m_oRoot As HierarchiesRoot

    Private Sub frmSystem_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        m_oRoot = Nothing
        m_oTxnMgr = Nothing
    End Sub

    Private Sub frmSystem_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_oTxnMgr = ClientServiceProvider.TransactionMgr
        'm_oRoot = MiddleServiceProvider.SiteMgr.ActiveSite.ActivePlant.PlantModel.RootSystem

        Dim oModel As Model = TryCast(ClientServiceProvider.WorkingSet.ActiveConnection, Model)
        m_oRoot = oModel.RootSystem
    End Sub

    '---------------------------------------------------------------------------------------
    ' Procedure : btnCreateSystem_Click
    ' DateTime  : Jan/09/2009
    ' Author    : skkotha
    ' Purpose   : This method Creates new Systems under Root as per User selection
    '---------------------------------------------------------------------------------------

    Private Sub btnCreateSystem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCreateSystem.Click
        Try

            If optAreaSys.Checked Then
                Dim oNewAreaSystem As New AreaSystem(m_oRoot)
                oNewAreaSystem.SetUserDefinedName("NewTestAreaSystem")

            ElseIf optConduitSys.Checked Then
                Dim oNewConduitSystem As New ConduitSystem(m_oRoot)
                oNewConduitSystem.SetUserDefinedName("NewTestConduitSystem")

            ElseIf optDuctingSys.Checked Then
                Dim oNewDuctingSystem As New DuctingSystem(m_oRoot)
                oNewDuctingSystem.SetUserDefinedName("NewTestDuctingSystem")

            ElseIf optEqpSys.Checked Then
                Dim oNewEqpSystem As New EquipmentSystem(m_oRoot)
                oNewEqpSystem.SetUserDefinedName("NewTestEqptSystem")

            ElseIf optElecSys.Checked Then
                Dim oNewElecSystem As New ElectricalSystem(m_oRoot)
                oNewElecSystem.SetUserDefinedName("NewTestElectricalSystem")

            ElseIf optPipingSys.Checked Then
                Dim oNewPipingSystem As New PipingSystem(m_oRoot)
                oNewPipingSystem.SetUserDefinedName("NewTestPipingSystem")

            ElseIf optPipeLineSys.Checked Then
                Dim oNewPipeLineSystem As New Pipeline(m_oRoot)
                oNewPipeLineSystem.SetUserDefinedName("NewTestPipeLineSystem")

            ElseIf optStructSys.Checked Then
                Dim oNewStructSystem As New StructuralSystem(m_oRoot)
                oNewStructSystem.SetUserDefinedName("NewTestStructuralSystem")

            ElseIf optUnitSystem.Checked Then
                Dim oNewUnitSystem As New UnitSystem(m_oRoot)
                oNewUnitSystem.SetUserDefinedName("NewTestUnitSystem")

            ElseIf optGenericSys.Checked Then
                Dim oNewGenericSystem As New GenericSystem(m_oRoot)
                oNewGenericSystem.SetUserDefinedName("NewTestGenericSystem")
            End If

            MessageBox.Show("Selected NewSystem is Created under root")
            m_oTxnMgr.Commit("System Commit")

        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub
    '---------------------------------------------------------------------------------------
    ' Procedure : btnChangeSys_Click
    ' DateTime  : 09/Jan/2009
    ' Author    : skkotha
    ' Purpose   : This method Changes Eqpt Hierarchy from one Parent to another.
    '---------------------------------------------------------------------------------------

    Private Sub btnChangeSys_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChangeSys.Click

        Try
            'Create EquipmentSystem
            Dim oEqptSystem1 As New EquipmentSystem(m_oRoot)
            'Setting UserDefined Name on Equipment System
            oEqptSystem1.SetUserDefinedName("TestEqptSys1")

            Dim oEqptSystem2 As New EquipmentSystem(m_oRoot)
            oEqptSystem2.SetUserDefinedName("TestEqptSys2")

            'Create Equipments
            Dim oEqpt1 As New Equipment("E240CompHorCylEqpAsm01-E", oEqptSystem1)
            Dim oEqpt2 As New Equipment("E205CompVerCylEqpSKAsm01-E", oEqptSystem2)

            oEqpt1.SetUserDefinedName("TestEqpt1")
            oEqpt2.SetUserDefinedName("TestEqpt2")

            'Changing SystemParent of Equipment
            oEqpt1.SystemParent = oEqptSystem2

            'Changing SystemParent of EquipmentSystem
            oEqptSystem2.SystemParent = oEqptSystem1
            m_oTxnMgr.Commit("System HierarchyChange Commit")

            MsgBox("TestEqpt1 is created Under TestEqptSys1" & vbCrLf _
                   & "TestEqpt2 is created Under TestEqptSys2" & vbCrLf _
                   & "TestEqp1 Parent changed And TestEqptSys2 moved under TestEqptSys1", , "Change EqptSystem Hierarchy")


            'Adding SystemChildren
            Dim oEqptSystem3 As New EquipmentSystem(m_oRoot)
            oEqptSystem3.SetUserDefinedName("TestEqptSys3")
            oEqptSystem1.AddSystemChild(oEqptSystem3)


            'Getting Children of Eqpt System
            Dim oEqpSysChilds As ReadOnlyCollection(Of ISystemChild)
            oEqpSysChilds = oEqptSystem1.SystemChildren
            MsgBox("No of Children Under TestEqptSys1 is - " & oEqpSysChilds.Count)

            m_oTxnMgr.Commit("System ChildrenChange Commit")

            'Following Commented code is to test the Assembly Children Hierarchy change Failure.
            'Dim oEqpChilds As ReadOnlyCollection(Of ISystemChild)
            'oEqpChilds = oEqpt1.SystemChildren
            'oEqpChilds.Item(0).SystemParent = oEqpt2

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try


    End Sub


    Private Sub btnAddRemoveAllowableSpecs_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddRemoveAllowableSpecs.Click
        '''''''''commented out because there is a bug in system.AllowableSpecs '''''''
        'Try

        '    Dim oNewPipingSystem As New PipingSystem(m_oRoot)
        '    oNewPipingSystem.SetUserDefinedName("NewTestPipingSystem-1")

        '    MsgBox("No Of Specs on NewTestPipingSystem-1 Created Under Root is-" & oNewPipingSystem.AllowableSpecs.Count)

        '    'Removing a Spec on New System
        '    Dim oRemovingSpec As BusinessObject, strRemovingSpec As String
        '    oRemovingSpec = oNewPipingSystem.AllowableSpecs.Item(0)
        '    strRemovingSpec = oRemovingSpec.GetType().Name
        '    oNewPipingSystem.RemoveAllowableSpec(oRemovingSpec)

        '    MsgBox("Spec Removed on NewTestPipingSystem-1 is-" & strRemovingSpec & vbCrLf _
        '          & "No of Specs = " & oNewPipingSystem.AllowableSpecs.Count, , "RemoveAllowableSpec")


        '    'Resetting to Parent Specs
        '    oNewPipingSystem.ResetToParentSpecs()
        '    MsgBox("Parent Specs are Resetted on NewTestPipingSystem-1" & vbCrLf _
        '          & "No of Specs = " & oNewPipingSystem.AllowableSpecs.Count, , "ResetToParentSpecs")


        '    'Replacing the System with new set of Specs
        '    Dim oSpecs As ReadOnlyCollection(Of BusinessObject)
        '    oSpecs = oNewPipingSystem.AllowableSpecs
        '    'Creating New Collection Of Specs
        '    Dim oSpecColl As New Collection(Of BusinessObject)
        '    For i = 0 To oSpecs.Count - 1
        '        oSpecColl.Add(oSpecs.Item(i))
        '    Next

        '    Dim oObj As BusinessObject
        '    oObj = oSpecColl.Item(0)

        '    oSpecColl.RemoveAt(0)
        '    oSpecColl.RemoveAt(1)
        '    oSpecColl.Add(m_oRoot.AllowableSpecs.Item(0))

        '    oSpecs = New ReadOnlyCollection(Of BusinessObject)(oSpecColl)
        '    oNewPipingSystem.ReplaceAllowableSpecs(oSpecs)   ' Replacing with new collection of Specs

        '    MsgBox("NewTestPipingSystem-1 is replaced with new Collection of specs:" & vbCrLf _
        '          & "No of Specs = " & oNewPipingSystem.AllowableSpecs.Count, , "ReplaceAllowableSpecs")


        '    'Adding a Spec To System
        '    oNewPipingSystem.AddAllowableSpec(oObj)
        '    MsgBox("Spec Added to " & oNewPipingSystem.Name & "is->" & oObj.GetType.Name & vbCrLf _
        '          & "No of Specs = " & oNewPipingSystem.AllowableSpecs.Count, , "AddAllowableSpec")

        'Catch ex As Exception
        '    MsgBox(ex.Message)
        'End Try
    End Sub



End Class