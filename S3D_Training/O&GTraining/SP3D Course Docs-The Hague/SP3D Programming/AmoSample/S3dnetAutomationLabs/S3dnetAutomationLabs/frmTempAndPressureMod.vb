Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services


Public Class frmTempAndPressureMod
    Private m_oUOM As UOMManager
    Private m_oPipeRun As BusinessObject

    Private Sub frmTempAndPressureMod_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        ClientServiceProvider.TransactionMgr.Abort()
    End Sub

    Private Sub frmTempAndPressureMod_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim oTempVal As PropertyValueDouble
        Dim oPressureVal As PropertyValueDouble


        m_oUOM = MiddleServiceProvider.UOMMgr
        Dim oSelSet As SelectSet = ClientServiceProvider.SelectSet
        m_oPipeRun = oSelSet.SelectedObjects.Item(0)
        oTempVal = m_oPipeRun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxTemp")
        oPressureVal = m_oPipeRun.GetPropertyValue("IJProcessDataInfo", "OperatingMaxPressure")

        If (Not oTempVal.PropValue Is Nothing) Then
            txtTemp.Text = m_oUOM.FormatUnit(UnitType.Temperature, oTempVal.PropValue)
        End If

        If (Not oPressureVal.PropValue Is Nothing) Then
            txtPressure.Text = m_oUOM.FormatUnit(UnitType.ForcePerArea, oPressureVal.PropValue)

        End If

    End Sub

    Private Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOK.Click
        Dim dTemp As Double
        Dim dPressure As Double

        Try
            dTemp = m_oUOM.ParseUnit(UnitType.Temperature, txtTemp.Text)
        Catch
            MsgBox("Please enter valid temperature")
            Exit Sub
        End Try

        Try
            dPressure = m_oUOM.ParseUnit(UnitType.ForcePerArea, txtPressure.Text)
        Catch
            MsgBox("Please enter valid pressure")
            Exit Sub
        End Try

        m_oPipeRun.SetPropertyValue(dTemp, "IJProcessDataInfo", "OperatingMaxTemp")
        m_oPipeRun.SetPropertyValue(dPressure, "IJProcessDataInfo", "OperatingMaxPressure")

        ClientServiceProvider.TransactionMgr.Commit("Modify Temperature and Pressure Command")
        Me.Close()
    End Sub


    Private Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClientServiceProvider.TransactionMgr.Abort()
        Me.Close()
    End Sub



    'Private Sub txtName_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtName.KeyDown
    '    If e.KeyCode = Windows.Forms.Keys.Enter Then
    '        RaiseEvent onNameChanged()
    '    End If
    'End Sub

    Private Sub txtTemp_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtTemp.KeyDown
        Dim dTemp As Double

        If e.KeyCode = Windows.Forms.Keys.Enter Then
            dTemp = m_oUOM.ParseUnit(UnitType.Temperature, txtTemp.Text)
            txtTemp.Text = m_oUOM.FormatUnit(UnitType.Temperature, dTemp, UnitName.TEMPERATURE_CELCIUS, UnitName.UNIT_NOT_SET, UnitName.UNIT_NOT_SET)
        End If
    End Sub

    ' TODO: Do this too on the "lastfocus" event, to get this change on the "TAB" key
End Class