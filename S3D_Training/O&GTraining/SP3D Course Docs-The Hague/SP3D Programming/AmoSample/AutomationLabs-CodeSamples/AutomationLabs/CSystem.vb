'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'
'   Copyright 2008 Intergraph
'   All Rights Reserved
'
'   CSystem.vb
'   ProgID:         SP3DNetTestSystem.CSystem
'   Author:         SivaKumar Kotha
'   Creation Date:  Friday, Sep 19, 2008
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

Imports Ingr.SP3D.Common.Client

Public Class CSystem
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)
        Dim ofrmSystem As frmSystem
        ofrmSystem = New frmSystem
        ofrmSystem.ShowDialog()

    End Sub

    Public Overrides Sub OnStop()
        MyBase.OnStop()

    End Sub

End Class
