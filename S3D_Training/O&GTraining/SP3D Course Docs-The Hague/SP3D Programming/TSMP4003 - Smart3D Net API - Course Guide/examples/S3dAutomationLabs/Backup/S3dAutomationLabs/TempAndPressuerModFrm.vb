Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services


Public Class TempAndPressuerModFrm

    Private m_oUOM As UOMManager
    Private m_oPiperun As BusinessObject

    Private Sub TempAndPressuerModFrm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        ClientServiceProvider.TransactionMgr.Abort()
    End Sub


    Private Sub TempAndPressuerModFrm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim oTempVal As PropertyValueDouble
        Dim oPressureVal As PropertyValueDouble

        m_oUOM = MiddleServiceProvider.UOMMgr

        Dim oSelect As SelectSet = ClientServiceProvider.SelectSet

        m_oPiperun = oSelect.SelectedObjects.Item(0)

        oTempVal = m_oPiperun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxTemp")
        oPressureVal = m_oPiperun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxPressure")

        If Not oTempVal.PropValue Is Nothing Then
            txtTemp.Text = m_oUOM.FormatUnit(UnitType.Temperature, _
                oTempVal.PropValue, UnitName.TEMPERATURE_FAHRENHEIT, _
                UnitName.UNIT_NOT_SET, UnitName.UNIT_NOT_SET)
        End If

        If Not oPressureVal Is Nothing Then
            txtPressure.Text = m_oUOM.FormatUnit(UnitType.ForcePerArea, oPressureVal.PropValue)
        End If


    End Sub


    Private Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOK.Click
        Dim dTemp As Double
        Dim dPressure As Double

        Try
            dTemp = m_oUOM.ParseUnit(UnitType.Temperature, txtTemp.Text)
        Catch ex As Exception
            MsgBox("Enter a valid Temperature value!")
            Exit Sub
        End Try

        Try
            dPressure = m_oUOM.ParseUnit(UnitType.ForcePerArea, txtPressure.Text)
        Catch ex As Exception
            MsgBox("Enter a valid Pressure value!")
            Exit Sub
        End Try

        m_oPiperun.SetPropertyValue(dTemp, "IJProcessDataInfo", "OperatingMaxTemp")
        m_oPiperun.SetPropertyValue(dPressure, "IJProcessDataInfo", "OperatingMaxPressure")

        ClientServiceProvider.TransactionMgr.Commit("Modify Temperature and Pressure")

        Me.Close()

    End Sub



    Private Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Close()

    End Sub
End Class