Imports System
Imports System.Collections
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Reports.Middle
Imports Ingr.SP3D.Route.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.ReferenceData.Middle
Imports Ingr.SP3D.ReferenceData.Middle.Services
Imports Ingr.SP3D.Equipment.Middle


Public Class SampleDotNetReport : Inherits QueryInterpreter

    Dim m_DataTable As DataTable

    'This is the main method that will get called from the Runtime framework.
    '</summary>
    '<param name="Command"></param>
    '<param name="Argument"></param>

    Public Overrides Function Execute(ByVal action As String, ByVal argument As String) As System.Data.DataTable

        'Create a record DataColumn list that will contain all the Columns(DataColumns)
        Dim DataColumnList As New List(Of Column)
        DataColumnList.Add(New Column("EqpName", GetType(System.String)))
        DataColumnList.Add(New Column("NozzleName", GetType(System.String)))
        DataColumnList.Add(New Column("NozzleNPD", GetType(System.String)))
        DataColumnList.Add(New Column("CoordX", GetType(System.Double)))
        DataColumnList.Add(New Column("CoordY", GetType(System.Double)))
        DataColumnList.Add(New Column("CoordZ", GetType(System.Double)))

        'create and initialize the Data Table with the Columns 
        m_DataTable = InitializeDataTable(DataColumnList)

        ' if the Evaluate property is set to true, only columns names of the data table will be returned to the designer
        ' so that the control can display the column names at the design time
        If (EvaluateOnly) Then Return m_DataTable

        'Label, InputObjects count = 1 
        'Reports, InputObjects count >= 1 

        For Each oBO In InputObjects
            'Check if oBO Is Equipment, if yes, get its Piping Ports
            If (TypeOf oBO Is Equipment) Then

                Dim oEqp As Equipment = oBO
                Dim oPorts As ReadOnlyCollection(Of IPort) = oEqp.GetPorts(PortType.Piping)

                'Get Type Required Data for Each Port
                For Each oPipePort As IPipePort In oPorts

                    Dim sNozName As String = oPipePort.ToString() 'Get Name of Nozzle
                    Dim oNozNPD As NominalDiameter = oPipePort.NPD 'Get Nozzle NPD
                    'Location of Nozzle by Typecasting to IDistributionPort
                    Dim oDistribPort As IDistributionPort = CType(oPipePort, IDistributionPort)
                    Dim dX = oDistribPort.Location.X
                    Dim dY = oDistribPort.Location.Y
                    Dim dZ = oDistribPort.Location.Z

                    'data row to hold the data for current object
                    Dim currentRow As DataRow = m_DataTable.NewRow()
                    currentRow.SetField("EqpName", oEqp.ToString)
                    currentRow.SetField("NozzleName", sNozName)
                    currentRow.SetField("NozzleNPD", oNozNPD.Size.ToString & " " & oNozNPD.Units)
                    currentRow.SetField("CoordX", dX)
                    currentRow.SetField("CoordY", dY)
                    currentRow.SetField("CoordZ", dZ)

                    'Execute the Delegated Query.
                    Dim DelegatedDataTable As System.Data.DataTable = ExecuteDelegatedQuery(CType(oPipePort, BusinessObject))
                    '(user added columns and returned properties from the Delegated Query)
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

                Next ' For each oPipePort
            End If

        Next ' next object in InputObjects

        Return m_DataTable

    End Function
End Class
