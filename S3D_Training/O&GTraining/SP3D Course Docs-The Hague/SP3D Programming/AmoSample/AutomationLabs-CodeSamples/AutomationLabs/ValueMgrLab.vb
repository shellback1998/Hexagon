'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   ValueMgrLab.vb
'   ProgID:         SP3DNetAutomationLabs.ValueMgrLab
'   Author:         SivaKumar Kotha
'                   SP3DAutomationServices
'   Creation Date:  Monday, Sep 15, 2008
'   Description:    Class shows the form, sets and gets the preferences.     
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Option Strict Off
Option Explicit On

Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Client

Public Class ValueMgrLab
    Inherits BaseModalCommand

    Private WithEvents m_frmValMgr As frmValueMgrLab

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        m_frmValMgr = New frmValueMgrLab
        Try
            'Load m_frmValMgr
            m_frmValMgr.ShowDialog()
            Exit Sub
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()

        m_frmValMgr.Close()
        m_frmValMgr = Nothing
    End Sub

    Private Sub StatusBarMsgUpdate(ByVal strMsg As String) Handles m_frmValMgr.StatusBarMsg
        WriteStatusBarMsg("" & strMsg)
    End Sub

End Class