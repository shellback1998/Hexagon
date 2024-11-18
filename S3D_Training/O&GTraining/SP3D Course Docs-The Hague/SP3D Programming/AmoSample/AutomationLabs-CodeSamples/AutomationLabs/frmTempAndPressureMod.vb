Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services


Public Class frmTempAndPressureMod

    Private m_oPipeRun As BusinessObject
    Private m_UOM As UOMManager

    Private oTempVal As PropertyValueDouble
    Private oPressureVal As PropertyValueDouble

    Private Sub frmTempAndPressureMod_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_oPipeRun = ClientServiceProvider.SelectSet.SelectedObjects.Item(0)
        m_UOM = MiddleServiceProvider.UOMMgr

        'get the pipe runs temp and pressure
        oTempVal = m_oPipeRun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxTemp")
        oPressureVal = m_oPipeRun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxPressure")

        'format and display. Don't format if value is not yet set
        If Not oTempVal.PropValue Is Nothing Then
            txtTemp.Text = m_UOM.FormatUnit(oTempVal)
        End If

        If Not oPressureVal.PropValue Is Nothing Then
            txtPressure.Text = m_UOM.FormatUnit(oPressureVal)
        End If


    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClientServiceProvider.TransactionMgr.Abort()
        Me.Close()
    End Sub

    Private Sub btnOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOK.Click

        'parse the user entered value
        Try
            oTempVal.PropValue = m_UOM.ParseUnit(UnitType.Temperature, txtTemp.Text)
        Catch ex As Exception
            MsgBox("Please enter valid temperature")
            Exit Sub
        End Try

        Try
            oPressureVal.PropValue = m_UOM.ParseUnit(UnitType.ForcePerArea, txtPressure.Text)
        Catch ex As Exception
            MsgBox("Please enter a valid pressure")
            Exit Sub
        End Try

        m_oPipeRun.SetPropertyValue(oTempVal)
        m_oPipeRun.SetPropertyValue(oPressureVal.PropValue, "IJProcessDataInfo", "OperatingMaxPressure")

        'commit

        ClientServiceProvider.TransactionMgr.Commit("Modify Temperature and Pressure Command")

        MsgBox("Values set")

    End Sub
End Class