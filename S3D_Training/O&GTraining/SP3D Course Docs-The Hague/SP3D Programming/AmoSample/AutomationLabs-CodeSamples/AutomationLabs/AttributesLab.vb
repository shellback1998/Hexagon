'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   AttributesLab.vb
'   ProgID:         SP3DNetAutomationLabs.AttributesLab
'   Author:         SivaKumar Kotha
'   Creation Date:  Monday, Oct 06, 2008
'   Description:
'       Initializes frmAttributesLab Class
'
'   Change History:
'   dd.mmm.yyyy     who     change description
'   -----------     ---     ------------------
'         
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Imports Ingr.SP3D.Common.Client

Public Class AttributesLab
    Inherits BaseModalCommand
    Private m_ofrmAttsLab As frmAttributesLab

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)
        m_ofrmAttsLab = New frmAttributesLab
        m_ofrmAttsLab.ShowDialog()
    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()
        m_ofrmAttsLab.Close()
        m_ofrmAttsLab = Nothing
    End Sub
End Class
