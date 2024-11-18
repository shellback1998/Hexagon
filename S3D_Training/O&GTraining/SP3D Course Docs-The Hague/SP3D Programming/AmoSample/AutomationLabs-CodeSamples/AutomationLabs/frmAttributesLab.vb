'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   frmAttributesLab.vb
'   ProgID:         SP3DNetAutomationLabs.frmAttributesLab
'   Author:         SivaKumar Kotha
'   Creation Date:  Monday, Oct 06, 2008
'   Description:
'       It Sets/gets the Attribute Values on object with Interface Name and Attribute Name
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'         
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class frmAttributesLab

    Private m_oSelectSet As SelectSet
    Private m_oObj As BusinessObject
    Private m_oIntfInfo As InterfaceInformation
    Private m_oPropInfo As PropertyInformation

       Private Sub frmAttributesLab_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            m_oSelectSet = ClientServiceProvider.SelectSet
            If m_oSelectSet.SelectedObjects.Count = 0 Then
                MsgBox("Select any Element and run the command")
                Me.Close()
                Exit Sub
            End If
            m_oObj = m_oSelectSet.SelectedObjects(0)
        Catch ex As Exception
            MsgBox("" & ex.Message, , "Form Load")
        End Try
    End Sub

    Private Sub txtInterface_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtInterface.KeyDown
        If e.KeyCode = Windows.Forms.Keys.Return Then
            txtAttribute.Focus()
        End If
    End Sub

    Private Sub txtAttribute_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtAttribute.KeyDown
        If e.KeyCode = Windows.Forms.Keys.Return Then
            cmdGet.Focus()
        End If
    End Sub

    '---------------------------------------------------------------------------------------
    ' Procedure : cmdGet_Click
    ' Author    : SivaKumar Kotha
    ' Purpose   : Gets the Values and displays the result in txtValue
    '---------------------------------------------------------------------------------------

    Private Sub cmdGet_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdGet.Click
        Try
            txtValue.Text = ""
            If ValidateInterfaceAndAttributes() Then
                Dim oPropType As SP3DPropType, oPropValue As PropertyValue
                oPropValue = m_oObj.GetPropertyValue(m_oPropInfo)
                cmdSet.Enabled = (oPropValue.ReadOnly = False)
                oPropType = m_oPropInfo.PropertyType

                If Not oPropValue Is Nothing Then

                    Select Case oPropType
                        Case SP3DPropType.PTUndefined

                        Case SP3DPropType.PTInteger
                            Dim oPropValInt As PropertyValueInt
                            oPropValInt = oPropValue
                            txtValue.Text = CStr(oPropValInt.PropValue)

                        Case SP3DPropType.PTString
                            Dim oPropValString As PropertyValueString
                            oPropValString = oPropValue
                            txtValue.Text = oPropValString.PropValue

                        Case SP3DPropType.PTBool
                            Dim oPropValBoolean As PropertyValueBoolean
                            oPropValBoolean = oPropValue
                            txtValue.Text = CStr(oPropValBoolean.PropValue)

                        Case SP3DPropType.PTDate
                            Dim oPropValDateTime As PropertyValueDateTime
                            oPropValDateTime = oPropValue
                            txtValue.Text = CStr(oPropValDateTime.PropValue)

                        Case SP3DPropType.PTDouble
                            Dim oPropValDouble As PropertyValueDouble
                            oPropValDouble = oPropValue

                            Dim oUOMMgr As UOMManager, oUnitType As UnitType
                            oUOMMgr = MiddleServiceProvider.UOMMgr
                            oUnitType = m_oPropInfo.UOMType
                            If oUnitType <> UnitType.Undefined And ((oPropValDouble.PropValue.HasValue) <> False) Then
                                txtValue.Text = oUOMMgr.FormatUnit(oPropValDouble)
                            Else
                                txtValue.Text = "<Null>"
                            End If

                        Case SP3DPropType.PTCodelist
                            Dim oPropValCodelist As PropertyValueCodelist
                            oPropValCodelist = oPropValue
                            txtValue.Text = ""

                            If Not oPropValCodelist.PropValue < 0 Then
                                txtValue.Text = oPropValue.PropertyInfo.CodeListInfo.GetCodelistItem(oPropValCodelist.PropValue).Name
                            Else
                                txtValue.Text = "<Invalid Codelist Value>"
                            End If

                        Case SP3DPropType.PTShort
                            Dim oPropValShort As PropertyValueShort
                            oPropValShort = oPropValue
                            txtValue.Text = oPropValShort.PropValue

                        Case SP3DPropType.PTFloat
                            Dim oPropValFloat As PropertyValueFloat
                            oPropValFloat = oPropValue
                            txtValue.Text = oPropValFloat.PropValue
                    End Select
                End If
            End If

        Catch ex As Exception
            MsgBox("" & ex.Message, , "GetValue")
        End Try
    End Sub

    '---------------------------------------------------------------------------------------
    ' Procedure : cmdSet_Click
    ' Author    : SivaKumar Kotha
    ' Purpose   : Sets the Values on the attributes
    '---------------------------------------------------------------------------------------

    Private Sub cmdSet_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSet.Click
        Try
            If ValidateInterfaceAndAttributes() And Not txtValue.Text = "" Then
                Dim oPropType As SP3DPropType, oPropValue As PropertyValue
                oPropValue = m_oObj.GetPropertyValue(m_oPropInfo)
                oPropType = m_oPropInfo.PropertyType

                txtValue.ForeColor = Drawing.Color.Red
                If Not oPropValue Is Nothing Then

                    Select Case oPropType
                        Case SP3DPropType.PTUndefined

                        Case SP3DPropType.PTInteger
                            Dim oPropValInt As PropertyValueInt
                            oPropValInt = CType(oPropValue, PropertyValueInt)
                            oPropValInt.PropValue = CInt(txtValue.Text)
                            m_oObj.SetPropertyValue(oPropValInt.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTString
                            Dim oPropValString As PropertyValueString
                            oPropValString = oPropValue
                            oPropValString.PropValue = txtValue.Text
                            m_oObj.SetPropertyValue(oPropValString.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTBool
                            Dim oPropValBoolean As PropertyValueBoolean
                            oPropValBoolean = CType(oPropValue, PropertyValueBoolean)
                            oPropValBoolean.PropValue = CBool(txtValue.Text)
                            m_oObj.SetPropertyValue(oPropValBoolean.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTDate
                            Dim oPropValDateTime As PropertyValueDateTime
                            oPropValDateTime = CType(oPropValue, PropertyValueDateTime)

                            oPropValDateTime.PropValue = CDate(txtValue.Text)
                            m_oObj.SetPropertyValue(oPropValDateTime.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTDouble
                            Dim oPropValDouble As PropertyValueDouble
                            oPropValDouble = CType(oPropValue, PropertyValueDouble)

                            Dim oUOMMgr As UOMManager, oUnitType As UnitType
                            oUOMMgr = MiddleServiceProvider.UOMMgr
                            oUnitType = m_oPropInfo.UOMType
                            If oUnitType <> UnitType.Undefined And ((oPropValDouble.PropValue.HasValue) <> False) Then
                                oPropValDouble.PropValue = oUOMMgr.ParseUnit(oUnitType, txtValue.Text)
                            Else
                                oPropValDouble.PropValue = CDbl(txtValue.Text)
                            End If
                            m_oObj.SetPropertyValue(oPropValDouble.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTCodelist
                            Dim oPropValCodelist As PropertyValueCodelist, oCodelistItem As CodelistItem
                            oPropValCodelist = CType(oPropValue, PropertyValueCodelist)
                            oPropValCodelist.PropValue = CInt(txtValue.Text)
                            oCodelistItem = oPropValCodelist.PropertyInfo.CodeListInfo.GetCodelistItem(txtValue.Text)
                            m_oObj.SetPropertyValue(oCodelistItem, oPropValue.PropertyInfo)


                        Case SP3DPropType.PTShort
                            Dim oPropValShort As PropertyValueShort
                            oPropValShort = oPropValue
                            oPropValShort.PropValue = CShort(txtValue.Text)
                            m_oObj.SetPropertyValue(oPropValShort.PropValue, oPropValue.PropertyInfo)

                        Case SP3DPropType.PTFloat
                            Dim oPropValFloat As PropertyValueFloat
                            oPropValFloat = oPropValue
                            oPropValFloat.PropValue = CShort(txtValue.Text)
                            m_oObj.SetPropertyValue(oPropValFloat.PropValue, oPropValue.PropertyInfo)
                    End Select
                    txtValue.ForeColor = Drawing.Color.Black
                End If
            End If

        Catch ex As Exception
            MsgBox("" & ex.Message, , "SetValue")
        End Try

    End Sub
    '---------------------------------------------------------------------------------------
    ' Procedure : ValidateInterfaceAndAttributes
    ' Author    : SivaKumar Kotha
    ' Purpose   : Gets the Values and displays the result in txtValue
    '---------------------------------------------------------------------------------------


    Private Function ValidateInterfaceAndAttributes() As Boolean
        Try
            txtInterface.ForeColor = Drawing.Color.Red
            txtAttribute.ForeColor = Drawing.Color.Red
            cmdSet.Enabled = False

            m_oIntfInfo = m_oObj.UserClassInfo.GetInterfaceInfo(txtInterface.Text)
            If m_oIntfInfo Is Nothing Then
                m_oIntfInfo = m_oObj.ClassInfo.GetInterfaceInfo(txtInterface.Text)
            End If

            If Not m_oIntfInfo Is Nothing Then
                txtInterface.ForeColor = Drawing.Color.Black
            End If

            m_oPropInfo = m_oIntfInfo.GetPropertyInfo(txtAttribute.Text)

            If Not m_oPropInfo Is Nothing Then
                txtAttribute.ForeColor = Drawing.Color.Black
                ValidateInterfaceAndAttributes = True
            End If

        Catch ex As Exception
            MsgBox("" & ex.Message & vbCrLf & "Check the entered Inputs and Object Selected")
        End Try
    End Function

    '---------------------------------------------------------------------------------------
    ' Procedure : ComputeOrCommitOrAbort
    ' Author    : SivaKumar Kotha
    ' Purpose   : Compute/Commit/Aborts the command
    '---------------------------------------------------------------------------------------

    Private Sub ComputeOrCommitOrAbort(ByVal strOpt As String)
        Dim oTxnMgr As ClientTransactionManager
        oTxnMgr = ClientServiceProvider.TransactionMgr()

        If (strOpt = "Compute") Then
            oTxnMgr.Compute()
            Exit Sub
        ElseIf (strOpt = "Abort") Then
            m_oObj = Nothing
            oTxnMgr.Abort()
            m_oObj = m_oSelectSet.SelectedObjects(0)
            Exit Sub
        Else
            m_oObj = Nothing
            oTxnMgr.Commit(strOpt)
            m_oObj = m_oSelectSet.SelectedObjects(0)
        End If
    End Sub

    Private Sub cmdCompute_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCompute.Click
        ComputeOrCommitOrAbort("Compute")
    End Sub

    Private Sub cmdCommit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCommit.Click
        ComputeOrCommitOrAbort("Commit")
        Me.Close()
    End Sub

    Private Sub cmdAbort_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdAbort.Click
        ComputeOrCommitOrAbort("Abort")
        Me.Close()
    End Sub
End Class