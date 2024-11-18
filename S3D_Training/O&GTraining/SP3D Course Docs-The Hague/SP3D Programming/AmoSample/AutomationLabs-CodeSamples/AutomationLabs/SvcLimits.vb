

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports System.Text
Imports System.Collections.ObjectModel

Public Class SvcLimits
    Inherits BaseModalCommand

    Public Overrides ReadOnly Property EnableUIFlags() As Integer
        Get
            Return EnableUIFlagSettings.NonEmptySelectSet
        End Get
    End Property

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)
        MyBase.OnStart(commandID, argument)

        Dim oSelSet As SelectSet
        Dim oBO As BusinessObject
        Dim oSpec As BusinessObject
        Dim oRelCol As RelationCollection
        Dim strMsg As New StringBuilder

        Dim strSQL As String = ""

        Dim oTemp As PropertyValueDouble
        Dim oPress As PropertyValueDouble

        Dim oSpecName As PropertyValueString


        oSelSet = ClientServiceProvider.SelectSet

        If oSelSet.SelectedObjects.Count = 1 AndAlso oSelSet.SelectedObjects.Item(0).SupportsInterface("IJRtePipeRun") Then
            oBO = oSelSet.SelectedObjects.Item(0)

            'get Run Spec
            oRelCol = oBO.GetRelationship("PathRunUsesSpec", "Spec")

            oSpec = oRelCol.TargetObjects(0)

            'get spec name
            oSpecName = oSpec.GetPropertyValue("IJDPipeSpec", "SpecName")

            strMsg.Append("Spec Name: " & oSpecName.PropValue & vbCrLf)

            Dim oServiceLimits As ReadOnlyCollection(Of BusinessObject)

            strSQL = "select sr.oid from JServiceLimitsRule sr "
            strSQL += "JOIN XSpecDefinesServiceLimits x on x.oidDestination = sr.oid "
            strSQL += "JOIN JDPipeSpec ps on ps.oid =  x.oidOrigin "
            strSQL += "WHERE ps.SpecName = '" & oSpecName.PropValue & "'"


            Dim oSQLFilter As New SQLFilter("ServiceLimits", "My Filters")
            oSQLFilter.SetSQLFilterString(strSQL)

            oServiceLimits = oSQLFilter.Apply()
            'oBO = oRelCol.TargetObjects(0)
            'oRelCol = oBO.GetRelationship("SpecDefinesServiceLimits", "ServiceLimits")


            For Each oBO In oServiceLimits
                oTemp = oBO.GetPropertyValue("IJServiceLimitsRule", "Temperature")
                oPress = oBO.GetPropertyValue("IJServiceLimitsRule", "Pressure")

                strMsg.Append(MiddleServiceProvider.UOMMgr.FormatUnit(oTemp) & "   " & MiddleServiceProvider.UOMMgr.FormatUnit(oPress) & vbCrLf)
            Next

            oSQLFilter.Delete()

            MsgBox(strMsg.ToString)


           
        Else
            MsgBox("Select a single route feature before running the command")
        End If
    End Sub

End Class

