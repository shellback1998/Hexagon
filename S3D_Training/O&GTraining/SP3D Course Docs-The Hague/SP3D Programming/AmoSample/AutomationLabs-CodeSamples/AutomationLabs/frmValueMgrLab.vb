'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   frmValueMgr.vb
'   ProgID:         SP3DNetAutomationLabs.frmValueMgr
'   Author:         SivaKumar Kotha
'                   SP3DAutomationServices
'   Creation Date:  Monday, Sep 15, 2008
'   Description: 
'       
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Option Strict Off
Option Explicit On
Imports Ingr.SP3D.Common.Client.Services
Imports System.Windows.Forms

Public Class frmValueMgrLab
    Private Const cString = 1
    Private Const cInteger = 2
    Private Const cBoolean = 3
    Private Const cDouble = 4

    Private WithEvents m_oEVValMgr As ValueManager
    Private m_bReplacing As Boolean
    Event StatusBarMsg(ByVal strMsg As String)

    Private Sub frmValueMgr_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_oEVValMgr = ClientServiceProvider.ValueMgr
    End Sub
    Private Sub Form_Unload(ByVal Cancel As Integer)
        m_oEVValMgr = Nothing
    End Sub
    '---------------------------------------------------------------------------------------
    ' Procedure : btnGetValue_Click
    ' Author    : SivaKumar Kotha
    ' Purpose   : Gets the saved Values by giving a keyName.
    '---------------------------------------------------------------------------------------

    Private Sub btnGetValue_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetValue.Click

        Try
            txtValue.Text = ""
            If txtKeyName.Text = "" Then
                MessageBox.Show("You must specify a Key", "GetValueMethod")
                Exit Sub
            Else
                If Not m_oEVValMgr.IsKeyValid(txtKeyName.Text) Then
                    MessageBox.Show("Invalid Key Name is Given", "GetValueMethod")
                    Exit Sub
                End If
            End If


            Select Case UsingOptionType()
                Case cString
                    Try
                        txtValue.Text = m_oEVValMgr.GetStringValue(txtKeyName.Text)
                    Catch
                        MessageBox.Show("Value Type with this key is not String", "GetValueMethod")
                    End Try
                Case cInteger
                    txtValue.Text = Str$(m_oEVValMgr.GetIntegerValue(txtKeyName.Text))

                Case cBoolean
                    txtValue.Text = Str$(m_oEVValMgr.GetBooleanValue(txtKeyName.Text))
                Case cDouble
                    txtValue.Text = Str$(m_oEVValMgr.GetDoubleValue(txtKeyName.Text))
            End Select
            Exit Sub

        Catch ex As Exception
            MessageBox.Show(ex.Message, "GetValueMethod")
        End Try

    End Sub
    '---------------------------------------------------------------------------------------
    ' Procedure : btnAddValue_Click
    ' Author    : SivaKumar Kotha
    ' Purpose   : Adds the Values given by user with a keyName & Value.
    '---------------------------------------------------------------------------------------

    Private Sub btnAddValue_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddValue.Click

        Try

            If txtKeyName.Text = "" Or txtValue.Text = "" Then
                MessageBox.Show("You must specify a Key and Value", "Value Manager")
                Exit Sub
            Else
                If m_oEVValMgr.IsKeyValid(txtKeyName.Text) And Not m_bReplacing Then
                    MessageBox.Show("This Key is already Exist. Choose Replace button If you want to replace", "Value Manager")
                    Exit Sub
                End If
            End If


            Select Case UsingOptionType()

                Case cString
                    If Not m_bReplacing Then
                        m_oEVValMgr.Add(txtKeyName.Text, txtValue.Text)
                    Else
                        m_oEVValMgr.Replace(txtKeyName.Text, txtValue.Text)
                    End If

                Case cInteger
                    If Not IsNumeric(txtValue.Text) Then
                        MsgBox("Entered keyValue is not Numeric")
                        Exit Sub
                    End If

                    Dim iVal As Integer
                    iVal = Val(txtValue.Text)
                    If Not m_bReplacing Then
                        m_oEVValMgr.Add(txtKeyName.Text, iVal)
                    Else
                        m_oEVValMgr.Replace(txtKeyName.Text, iVal)
                    End If

                Case cBoolean
                    Dim bVal As Boolean
                    If UCase$(txtValue.Text) = "TRUE" Or UCase$(txtValue.Text) = "T" Then
                        bVal = True
                    ElseIf UCase$(txtValue.Text) = "FALSE" Or UCase$(txtValue.Text) = "F" Then
                        bVal = False
                    Else
                        MessageBox.Show("Boolean must be True or False", "AddValue")
                        Exit Sub
                    End If

                    If Not m_bReplacing Then
                        m_oEVValMgr.Add(txtKeyName.Text, bVal)
                    Else
                        m_oEVValMgr.Replace(txtKeyName.Text, bVal)
                    End If

                Case cDouble
                    If Not IsNumeric(txtValue.Text) Then
                        MsgBox("Entered keyValue is not Numeric")
                        Exit Sub
                    End If

                    Dim dVal As Double
                    dVal = Val(txtValue.Text)
                    If Not m_bReplacing Then
                        m_oEVValMgr.Add(txtKeyName.Text, dVal)
                    Else
                        m_oEVValMgr.Replace(txtKeyName.Text, dVal)
                    End If

            End Select

            If Not m_bReplacing Then
                MessageBox.Show("Successfully Added the Value to Key", "AddValue")
            Else
                MessageBox.Show("Successfully Replaced the Value of key", "ReplaceValue")
                m_bReplacing = False
            End If

            Exit Sub

        Catch ex As Exception
            MessageBox.Show(ex.Message, "ValueManager")
        End Try
    End Sub
    '---------------------------------------------------------------------------------------
    ' Procedure : UsingOptionType
    ' Author    : SivaKumar Kotha
    ' Purpose   : Function gives the Selected OptionType
    '---------------------------------------------------------------------------------------

    Private Function UsingOptionType() As Integer
        If optStringType.Checked Then
            UsingOptionType = cString
        ElseIf optIntegerType.Checked Then
            UsingOptionType = cInteger
        ElseIf optBooleanType.Checked Then
            UsingOptionType = cBoolean
        Else
            UsingOptionType = cDouble
        End If
    End Function

    Private Sub btnRemoveKey_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveKey.Click
        Try
            If txtKeyName.Text = "" Then
                MessageBox.Show("You must specify a Key", "Remove Key Method")
                Exit Sub
            Else
                If Not m_oEVValMgr.IsKeyValid(txtKeyName.Text) Then
                    MessageBox.Show("Given Key doesnt exist", "Remove Key Method")
                    Exit Sub
                End If
            End If
            m_oEVValMgr.Remove(txtKeyName.Text)
            MsgBox("Key removed Succesfully")

        Catch ex As Exception
            MessageBox.Show(ex.Message, "ValueManager-RemoveKey")
        End Try
    End Sub

    Private Sub btnReplaceKey_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnReplaceKey.Click
        m_bReplacing = True
        btnAddValue_Click(sender, e)
    End Sub

    Private Sub btnIsKeyValid_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnIsKeyValid.Click
        txtValue.Text = ""
        If Not txtKeyName.Text = "" Then
            If Not m_oEVValMgr.IsKeyValid(txtKeyName.Text) Then
                MessageBox.Show("This is not a Valid key", "ValueManager")
            Else
                MessageBox.Show("Key is Valid", "ValueManager")
            End If
        End If
    End Sub

    Private Sub btnNoOfKeys_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNoOfKeys.Click
        Try
            MessageBox.Show("No of keys are - " & m_oEVValMgr.Count, "Keys Count")
        Catch ex As Exception
            MessageBox.Show(ex.Message, "Keys Count")
        End Try
    End Sub

    Private Sub btnListOfKeys_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnListOfKeys.Click
        Dim lvItem As ListViewItem, i As Long

        Me.lvKeyDetails.Items.Clear()
        For i = 1 To m_oEVValMgr.Count
            Try
                lvItem = Me.lvKeyDetails.Items.Add(m_oEVValMgr.GetKeyName(i))
                lvItem.SubItems.Add(m_oEVValMgr.GetKeyName(i))
            Catch ex As Exception
                MsgBox("error occured in getting key")
            End Try
        Next
    End Sub

    Private Sub m_oEVValMgr_KeyAdded() Handles m_oEVValMgr.KeyAdded
        RaiseEvent StatusBarMsg("Key is Added")
    End Sub

    Private Sub m_oEVValMgr_KeyRemoved() Handles m_oEVValMgr.KeyRemoved
        RaiseEvent StatusBarMsg("Key is Removed")
    End Sub

    Private Sub m_oEVValMgr_ValueChanged() Handles m_oEVValMgr.ValueChanged
        RaiseEvent StatusBarMsg("Key Value is Changed")
    End Sub

    Private Sub lvKeyDetails_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lvKeyDetails.SelectedIndexChanged

    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Me.Close()
    End Sub
End Class
