Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports System.Text

Public Class RelationshipsLab
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
        Dim oRelCol As RelationCollection
        Dim strMsg As New StringBuilder

        oSelSet = ClientServiceProvider.SelectSet

        If oSelSet.SelectedObjects.Count = 1 AndAlso oSelSet.SelectedObjects.Item(0).SupportsInterface("IJRtePipePathFeat") Then
            oBO = oSelSet.SelectedObjects.Item(0)

            oRelCol = oBO.GetRelationship("PathGeneratedParts", "PathDefinedPart")
            strMsg.Append("Total number of parts: " & oRelCol.TargetObjects.Count & vbCrLf)
            oSelSet.SelectedObjects.Clear()

            For Each oObj As BusinessObject In oRelCol.TargetObjects
                strMsg.Append(oObj.ToString & vbCrLf)
                oSelSet.SelectedObjects.Add(oObj)
            Next

            MsgBox(strMsg.ToString())



            ' ''-------------------------------------------------------------
            ''this demonstrates traversal of 2 relationships
            ''from feature to Run, and then from Run to Pipeline
            'Dim oFeature As BusinessObject = oBO
            'Dim oLineCol As RelationCollection

            'oRelCol = oFeature.GetRelationship("PathSpecification", "thePathSystemInfo")

            'Dim oPipeRun As BusinessObject

            'For Each oPipeRun In oRelCol.TargetObjects
            '    oLineCol = oPipeRun.GetRelationship("SystemHierarchy", "SystemParent")

            '    For Each oLine As BusinessObject In oLineCol.TargetObjects
            '        strMsg.Append(oLine.ToString & vbCrLf)
            '    Next

            'Next

            'MsgBox(strMsg.ToString())
            ' ''-------------------------------------------------------------
        Else
            MsgBox("Select a single route feature before running the command")
        End If
    End Sub

End Class
