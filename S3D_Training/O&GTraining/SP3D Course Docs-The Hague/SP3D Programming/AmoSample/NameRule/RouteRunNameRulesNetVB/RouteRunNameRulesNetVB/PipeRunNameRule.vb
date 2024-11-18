'***************************************************************************************
'  Copyright (C) 2008-2009, Intergraph Corporation.  All rights reserved.
'
'  Project  : K:\CommonRoute\Rules\RouteRunNameRulesNet\RouteRunNameRulesNetVB
'
'  Class    : PipeRunNameRule
'
'  Abstract : The file contains implementation of the naming rules for PipeRuns.
'
'***************************************************************************************
Imports System.Collections.ObjectModel
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Route.Middle
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.ReferenceData.Middle

Public Class PipeRunNameRule
    Inherits NameRuleBase
    Private Const strCountFormat = "0000"

    ''' <summary>
    '''  Creates a name for the object passed in. The name is based on the parents
    '''  name and object name.The Naming Parents are added in AddNamingParents().
    '''  Both these methods are called from naming rule semantic.
    ''' </summary>
    ''' <param name="oEntity">Child object that needs to have the naming rule naming.</param>
    ''' <param name="oParents">Naming parents collection.</param>
    ''' <param name="oActiveEntity">Naming rules active entity on which the NamingParentsString is stored.</param>

    Public Overrides Sub ComputeName(ByVal oEntity As Ingr.SP3D.Common.Middle.BusinessObject, ByVal oParents As ReadOnlyCollection(Of Ingr.SP3D.Common.Middle.BusinessObject), ByVal oActiveEntity As Ingr.SP3D.Common.Middle.BusinessObject)

        Dim strPipelineName As String = vbNullString, strRunName As String = vbNullString
        Dim oPipeline As Pipeline, strFluidCode As String, oCLPropValue As PropertyValueCodelist
        Dim oPipeRun As PipeRun, oPipeSpec As PipeSpec, strPipeSpec As String, strNPD As String
        Dim oStrPropValue As PropertyValueString

        Try

            Dim strUnitSystem As String = vbNullString
            Dim strAreaSystem As String = vbNullString
            If oParents.Count >= 2 Then
                Dim oSys As Ingr.SP3D.Systems.Middle.System

                For i As Integer = 0 To (oParents.Count - 1)
                    oSys = oParents.Item(i)
                    oStrPropValue = oSys.GetPropertyValue("IJNamedItem", "Name")
                    If oSys.GetType.Name = "AreaSystem" Then
                        strAreaSystem = oStrPropValue.PropValue
                    ElseIf oSys.GetType.Name = "UnitSystem" Then
                        strUnitSystem = oStrPropValue.PropValue
                    ElseIf oSys.GetType.Name = "PipingSystem" Then
                    ElseIf oSys.GetType.Name = "Pipeline" Then
                        oPipeline = oParents.Item(i)
                        strPipelineName = oPipeline.Name
                    End If
                Next
            Else
                'Get the Parent of the PipeRun
                oPipeline = oParents.Item(0)
                strPipelineName = oPipeline.Name
            End If


            'Get the name of the PipeRun
            oPipeRun = oEntity
            strRunName = oPipeRun.Name

            'Get NPD from PipeRun
            strNPD = CStr(oPipeRun.NPD.Size)

            'Get Pipe Spec from PipeRun
            oPipeSpec = oPipeRun.Specification
            oStrPropValue = oPipeSpec.GetPropertyValue("IJDPipeSpec", "SpecName")
            strPipeSpec = oStrPropValue.PropValue

            'Get the Fluid Code from the PipeLine
            oCLPropValue = oPipeline.GetPropertyValue("IJPipelineSystem", "FluidCode")
            strFluidCode = oCLPropValue.PropertyInfo.CodeListInfo.GetCodelistItem(oCLPropValue.PropValue).Name

            'get the insulation code
            Dim strInsulation As String = Nothing
            If oPipeRun.InsulationSpec IsNot Nothing Then
                strInsulation = "-" & oPipeRun.InsulationSpec.DisplayName
            End If

            Dim strvalidatename As String
            strvalidatename = strUnitSystem & "-" & strNPD & "-" & strFluidCode & "-" & strPipeSpec & strInsulation

            'get the name of the active entitity
            Dim strOldNaming As String
            strOldNaming = GetNamingParentsString(oActiveEntity)

            If strvalidatename <> strOldNaming Then
                Dim strNewName As String
                Dim lCount As Integer
                Dim strSeqNo As String
                Dim strlocation As String = vbNullString

                GetCountAndLocationID(strPipelineName, lCount, strlocation)
                strSeqNo = Format(lCount, strCountFormat)

                If strUnitSystem = "" Then
                    strNewName = strNPD & "-" & strFluidCode & "-" & strSeqNo & "-" & strPipeSpec & strInsulation
                Else
                    strNewName = strUnitSystem & "-" & strNPD & "-" & strFluidCode & "-" & strSeqNo & "-" & strPipeSpec & strInsulation
                End If


                SetNamingParentsString(oActiveEntity, strValidateName)
                oEntity.SetPropertyValue(strNewName, "IJNamedItem", "Name")
            End If
            
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' All the Naming Parents that need to participate in an objects naming are added here to the
    ''' Collection(Of BusinessObject). The parents added here are used in computing the name of the object in
    ''' ComputeName(). Both these methods are called from naming rule semantic.
    ''' </summary>
    ''' <param name="oEntity">Child object that needs to have the naming rule naming.</param>
    ''' <returns> Collection of parents that participate </returns>

    Public Overrides Function GetNamingParents(ByVal oEntity As Ingr.SP3D.Common.Middle.BusinessObject) As Collection(Of Ingr.SP3D.Common.Middle.BusinessObject)

        Dim oParentsColl As New Collection(Of Ingr.SP3D.Common.Middle.BusinessObject)
        Dim oParent As BusinessObject

        GetNamingParents = Nothing
        Try
            oParent = GetParent(HierarchyTypes.System, oEntity) ' Get the System Parent
            If (Not oParent Is Nothing) Then
                oParentsColl.Add(oParent) 'Add the Parent to the ParentColl
            End If

            'To get the UnitSystem

            Dim oParentSystem As ISystem
            Dim oSysChild As ISystemChild
            Dim oCol2 As New Collection(Of BusinessObject)

            oParentSystem = oParent
            Do While TypeOf oParentSystem Is ISystemChild
                'If TypeOf oParentSystem Is UnitSystem Then
                If TypeOf oParentSystem Is AreaSystem Then
                    oParentsColl.Add(oParentSystem)
                    Exit Do
                Else
                    oSysChild = oParentSystem
                    oCol2.Add(oSysChild)
                    oParentSystem = oSysChild.SystemParent
                End If
            Loop

            For Each o As BusinessObject In oCol2
                oParentsColl.Add(o)
            Next

            GetNamingParents = oParentsColl
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Function

End Class
