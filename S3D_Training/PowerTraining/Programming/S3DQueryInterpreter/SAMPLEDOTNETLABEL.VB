Option Explicit On

Imports System
Imports System.Collections
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Reports.Middle
Imports Ingr.SP3D.Route.Middle
Imports Ingr.SP3D.Systems.Middle

Public Class SampleDotNetLabel : Inherits QueryInterpreter

    Dim m_DataTable As DataTable

    'This is the main method that will get called from the Runtime framework.
    '</summary>
    '<param name="Command"></param>
    '<param name="Argument"></param>

    Public Overrides Function Execute(ByVal action As String, ByVal argument As String) As System.Data.DataTable

        'Create a record DataColumn list that will contain all the Columns(DataColumns)
        Dim FieldColumnList As New List(Of Column)

        Dim recFieldNPD As New Column("NPD", GetType(System.String))
        FieldColumnList.Add(recFieldNPD)

        'create and initialize the Data Table with the Columns 
        '(user added columns and returned properties from the Delegated Query)
        m_DataTable = InitializeDataTable(FieldColumnList)

        ' if the Evaluate property is set to true, only columns names of the data table will be returned to the designer
        ' so that the control can display the column names at the design time
        If (EvaluateOnly) Then Return m_DataTable

        'Label, InputObjects count is 1 
        'Reports, InputObjects count is >= 1 

        For Each oBO In InputObjects
            Dim dMaxNPD As Double = -1, dNPDInMM As Double, strMaxNPD As String = ""
            Dim oUOMMgr As UOMManager = MiddleServiceProvider.UOMMgr

            'Given a Pipeline as Input, Return Largest NPD, iterating all Runs within the Pipeline
            If (TypeOf oBO Is Pipeline) Then

                Dim oPipeline As Pipeline = oBO

                'Pipeline might have 0 runs, if there are no runs found, return nothing
                If (oPipeline.SystemChildren.Count < 1) Then Return Nothing

                Dim oNPD As NominalDiameter, oPipeRun As PipeRun, oMaxNPDPipeRun As PipeRun

                For Each oSysChild As ISystemChild In oPipeline.SystemChildren
                    If (TypeOf (oSysChild) Is PipeRun) Then

                        oPipeRun = oSysChild
                        oNPD = oPipeRun.NPD

                        'Runs of Pipeline can have NPD of different units (in or mm), 

                        'Below we are first parsing NPD Size and NPD Unit as Text expression in context of UnitType.NPD,
                        'which returns NPDUnit value in DBU (Database Units) - meters
                        'Then we are converting the DBU value to Millimeter

                        dNPDInMM = oUOMMgr.ConvertDBUtoUnit(UnitType.Distance, _
                                  oUOMMgr.ParseUnit(UnitType.Npd, oNPD.Size.ToString & oNPD.Units), UnitName.DISTANCE_MILLIMETER)

                        If (dNPDInMM > dMaxNPD) Then
                            dMaxNPD = dNPDInMM
                            oMaxNPDPipeRun = oPipeRun
                        End If
                    End If
                Next


                'In this label we are providing facility to return Max NPD in a specific unit that a user may want.
                'Label RQE file has an Argument element, 
                ' If Argument = "in" or "" - Max NPD returned should be in inches
                ' If Argument = "mm"  - Max NPD returned should be in millimeters

                If ((argument.ToLower = "") Or (argument.ToLower = "in")) Then _
                    strMaxNPD = oUOMMgr.ConvertDBUtoUnit(UnitType.Npd, (dMaxNPD * 0.001), UnitName.NPD_INCH).ToString & " in"

                If (argument.ToLower = "mm") Then strMaxNPD = oUOMMgr.ConvertDBUtoUnit(UnitType.Npd, (dMaxNPD * 0.001), UnitName.NPD_MILLIMETER) & " mm"

                'data row to hold the data for current object
                Dim currentRow As DataRow = m_DataTable.NewRow()
                currentRow.SetField("NPD", strMaxNPD)

                'Execute the Delegated Query.
                If (oMaxNPDPipeRun IsNot Nothing) Then
                    Dim DelegatedDataTable As System.Data.DataTable = ExecuteDelegatedQuery(oMaxNPDPipeRun)

                    If (DelegatedDataTable IsNot Nothing) Then
                        If (DelegatedDataTable.Rows.Count >= 1) Then
                            Dim row As DataRow = DelegatedDataTable.Rows.Item(0)
                            'merge the column value pair to data table, excluding the oid column
                            For Each col As DataColumn In row.Table.Columns
                                If (col.ColumnName.ToLower() <> "oid") Then
                                    currentRow.SetField(col.ColumnName, row(col.ColumnName))
                                End If
                            Next
                        End If
                    End If

                    'Add the new rows to the master data table
                    m_DataTable.Rows.Add(currentRow)
                End If
            End If
        Next

        Return m_DataTable

    End Function
End Class
