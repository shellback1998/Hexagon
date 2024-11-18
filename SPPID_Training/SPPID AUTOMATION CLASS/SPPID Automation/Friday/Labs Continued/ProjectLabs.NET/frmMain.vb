Option Strict Off
Option Explicit On
Friend Class frmMain
	Inherits System.Windows.Forms.Form
	
	Private blnUsePIDDatasource As Boolean
	Private Const CONST_SPID_ModelItem As String = "D6BB4EF0C76F41DFA4116619258CC92F"
	Private Const CONST_SPID_ItemNote As String = "D0D9F38E9B9240B0933C86EBFA0F214F"
	Private Const CONST_SPID_OPC As String = "14B52777222C466CA3E8EB89ABCC7164"
	Private Const CONST_SPID_Vessel As String = "D6BB4EF0C76F41DFA4116619258CC92F"
	Private Const CONST_SPID_PipeRun As String = "770871FB53D747B5875D91A87D7356EB"
	Private Const CONST_SPID_PipingComp As String = "2E3F163537234E2E9539CF5B6762202E"
	Private Const CONST_SPID_OfflineInstrument As String = "765168BE51DE492995F6C605CFDDD89B"
	Private Const CONST_SPID_InlineInstrument As String = "0F7008C96715498BB300B57E02900F0E"
	Private Const CONST_SPID_LabelPersist As String = "3B1C747DD63E4271A4969178650E9965"
	Private Const CONST_SPID_OPC2 As String = "D5AECC6BCA8E46009BFCEA2FBAA5DDC2"
	
	
	
	Private Sub cmdLab51_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab51.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objFilter As Llama.LMAFilter
		Dim criterion As Llama.LMACriterion
		criterion = New Llama.LMACriterion
		objFilter = New Llama.LMAFilter
		
		criterion.SourceAttributeName = "Representation.Drawing.Name"
		criterion.ValueAttribute = "1001"
		criterion.Operator = "="
		objFilter.ItemType = "OPC"
		objFilter.Criteria.Add(criterion)
		
		Dim objOPC As Llama.LMOPC
		Dim objOPCs As Llama.LMOPCs
		Dim objpairOPC As Llama.LMOPC
		Dim objRep As Llama.LMRepresentation
		Dim objPiperun As Llama.LMPipeRun
		Dim objSym As Llama.LMSymbol
		Dim objConnector As Llama.LMConnector
		
		objOPCs = New Llama.LMOPCs
		objOPCs.Collect(datasource, Filter:=objFilter)
		
		Debug.Print("Total OPCs were found: " & objOPCs.Count)
		
		For	Each objOPC In objOPCs
			objpairOPC = objOPC.pairedWithOPCObject
			For	Each objRep In objpairOPC.Representations
				If objRep.DrawingID > 0 Then
					Debug.Print("pairOPC is on drawing: " & objRep.DrawingObject.Attributes("Name").Value)
				End If
				objSym = datasource.GetSymbol((objRep.ID))
				For	Each objConnector In objSym.Connect1Connectors
					objPiperun = datasource.GetPipeRun((objConnector.ModelItemID))
					Debug.Print("pairOPC is connected to Piperun: " & objPiperun.Attributes("ItemTag").Value)
				Next objConnector
				For	Each objConnector In objSym.Connect2Connectors
					objPiperun = datasource.GetPipeRun((objConnector.ModelItemID))
					Debug.Print(objPiperun.Attributes("ItemTag").Value)
				Next objConnector
			Next objRep
		Next objOPC
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objOPCs may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOPCs = Nothing
		'UPGRADE_NOTE: Object objOPC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOPC = Nothing
		'UPGRADE_NOTE: Object objpairOPC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objpairOPC = Nothing
		'UPGRADE_NOTE: Object objRep may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRep = Nothing
		'UPGRADE_NOTE: Object objSym may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSym = Nothing
		'UPGRADE_NOTE: Object objPiperun may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPiperun = Nothing
		'UPGRADE_NOTE: Object objConnector may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objConnector = Nothing
		
	End Sub
	
	Private Sub cmdLab52_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab52.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objPipingComp As Llama.LMPipingComp
		Dim objRepresentation As Llama.LMRepresentation
		Dim objRelationships As Llama.LMRelationships
		Dim objRelationship As Llama.LMRelationship
		Dim objAttribute As Llama.LMAAttribute
		
		objPipingComp = datasource.GetPipingComp(CONST_SPID_PipingComp)
		objRepresentation = objPipingComp.Representations.Nth(1)
		objRelationships = objRepresentation.Relation1Relationships
		For	Each objRelationship In objRelationships
			If Not objRelationship.Item1RepresentationObject Is Nothing Then
				Debug.Print(objRelationship.Item1RepresentationObject.ModelItemObject.AsLMAItem.ItemType)
			End If
			If Not objRelationship.Item2RepresentationObject Is Nothing Then
				Debug.Print(objRelationship.Item2RepresentationObject.ModelItemObject.AsLMAItem.ItemType)
			End If
			For	Each objAttribute In objRelationship.Attributes
				Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
			Next objAttribute
		Next objRelationship
		
		objRelationships = objRepresentation.Relation2Relationships
		For	Each objRelationship In objRelationships
			If Not objRelationship.Item1RepresentationObject Is Nothing Then
				Debug.Print(objRelationship.Item1RepresentationObject.ModelItemObject.AsLMAItem.ItemType)
			End If
			If Not objRelationship.Item2RepresentationObject Is Nothing Then
				Debug.Print(objRelationship.Item2RepresentationObject.ModelItemObject.AsLMAItem.ItemType)
			End If
			For	Each objAttribute In objRelationship.Attributes
				Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
			Next objAttribute
		Next objRelationship
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objPipingComp may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPipingComp = Nothing
		'UPGRADE_NOTE: Object objRepresentation may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRepresentation = Nothing
		'UPGRADE_NOTE: Object objRelationships may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationships = Nothing
		'UPGRADE_NOTE: Object objRelationship may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationship = Nothing
		'UPGRADE_NOTE: Object objAttribute may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objAttribute = Nothing
		
		
	End Sub
	
	Private Sub cmdLab53_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab53.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objFilter As Llama.LMAFilter
		Dim criterion As Llama.LMACriterion
		
		criterion = New Llama.LMACriterion
		objFilter = New Llama.LMAFilter
		
		criterion.SourceAttributeName = "Name"
		criterion.ValueAttribute = txtBox1.Text
		criterion.Operator = "="
		objFilter.ItemType = "Drawing"
		objFilter.Criteria.Add(criterion)
		
		Dim objDrawing As Llama.LMDrawing
		Dim objDrawings As Llama.LMDrawings
		objDrawings = New Llama.LMDrawings
		objDrawings.Collect(datasource, Filter:=objFilter)
		
		Dim objRelationships As Llama.LMRelationships
		Dim objRelationship As Llama.LMRelationship
		Dim objInconsistencies As Llama.LMInconsistencies
		Dim objInconsistency As Llama.LMInconsistency
		Dim objAttribute As Llama.LMAAttribute
		
		For	Each objDrawing In objDrawings
			objRelationships = objDrawing.Relationships
			For	Each objRelationship In objRelationships
				objInconsistencies = objRelationship.Inconsistencies
				For	Each objInconsistency In objInconsistencies
					For	Each objAttribute In objInconsistency.Attributes
						Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
					Next objAttribute
				Next objInconsistency
			Next objRelationship
		Next objDrawing
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objDrawings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawings = Nothing
		'UPGRADE_NOTE: Object objDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawing = Nothing
		'UPGRADE_NOTE: Object objRelationships may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationships = Nothing
		'UPGRADE_NOTE: Object objRelationship may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationship = Nothing
		'UPGRADE_NOTE: Object objInconsistencies may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objInconsistencies = Nothing
		'UPGRADE_NOTE: Object objInconsistency may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objInconsistency = Nothing
		
		
	End Sub
	
	Private Sub cmdLab54_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab54.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objFilter As Llama.LMAFilter
		Dim criterion As Llama.LMACriterion
		
		criterion = New Llama.LMACriterion
		objFilter = New Llama.LMAFilter
		
		criterion.SourceAttributeName = "Name"
		criterion.ValueAttribute = "1001"
		criterion.Operator = "="
		objFilter.ItemType = "Drawing"
		objFilter.Criteria.Add(criterion)
		
		Dim objDrawing As Llama.LMDrawing
		Dim objDrawings As Llama.LMDrawings
		objDrawings = New Llama.LMDrawings
		objDrawings.Collect(datasource, Filter:=objFilter)
		
		Dim objRelationships As Llama.LMRelationships
		Dim objRelationship As Llama.LMRelationship
		Dim objRuleReferences As Llama.LMRuleReferences
		Dim objRuleReference As Llama.LMRuleReference
		Dim objAttribute As Llama.LMAAttribute
		
		For	Each objDrawing In objDrawings
			objRelationships = objDrawing.Relationships
			For	Each objRelationship In objRelationships
				objRuleReferences = objRelationship.RuleReferences
				For	Each objRuleReference In objRuleReferences
					For	Each objAttribute In objRuleReference.Attributes
						Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
					Next objAttribute
				Next objRuleReference
			Next objRelationship
		Next objDrawing
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objDrawings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawings = Nothing
		'UPGRADE_NOTE: Object objDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawing = Nothing
		'UPGRADE_NOTE: Object objRelationships may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationships = Nothing
		'UPGRADE_NOTE: Object objRelationship may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRelationship = Nothing
		'UPGRADE_NOTE: Object objRuleReferences may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRuleReferences = Nothing
		'UPGRADE_NOTE: Object objRuleReference may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRuleReference = Nothing
		
		
	End Sub
	
	Private Sub cmdLab55_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab55.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel)
		
		Dim objPlantGroup As Llama.LMPlantGroup
		
		'get the plantgroup just above the drawing, in our case, should be unit
		objPlantGroup = objVessel.PlantGroupObject
		Debug.Print("PlantGroup Name = " & objPlantGroup.Attributes("Name").Value)
		
		Dim strParentID As String
		'UPGRADE_WARNING: Couldn't resolve default property of object objPlantGroup.Attributes().Value. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		strParentID = objPlantGroup.Attributes("ParentID").Value
		
		Dim objParentPlantGroup As Llama.LMPlantGroup
		objParentPlantGroup = datasource.GetPlantGroup(strParentID)
		Debug.Print("Parent PlantGroup Name = " & objParentPlantGroup.Attributes("Name").Value)
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		'UPGRADE_NOTE: Object objPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantGroup = Nothing
		'UPGRADE_NOTE: Object objParentPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objParentPlantGroup = Nothing
		
		
	End Sub
	
	Private Sub cmdLab56_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab56.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel)
		
		Dim objPlantGroup As Llama.LMPlantGroup
		
		'get the plantgroup just above the drawing, in our case, should be unit
		objPlantGroup = objVessel.Representations.Nth(1).DrawingObject.PlantGroupObject
		Debug.Print("PlantGroup Name = " & objPlantGroup.Attributes("Name").Value)
		
		Dim strParentID As String
		'UPGRADE_WARNING: Couldn't resolve default property of object objPlantGroup.Attributes().Value. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		strParentID = objPlantGroup.Attributes("ParentID").Value
		
		Dim objParentPlantGroup As Llama.LMPlantGroup
		objParentPlantGroup = datasource.GetPlantGroup(strParentID)
		Debug.Print("Parent PlantGroup Name = " & objParentPlantGroup.Attributes("Name").Value)
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		'UPGRADE_NOTE: Object objPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantGroup = Nothing
		'UPGRADE_NOTE: Object objParentPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objParentPlantGroup = Nothing
		
	End Sub
	
	Private Sub cmdLab57_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab57.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel) 'get objVessel by id
		Debug.Print(objVessel.PlantGroupObject.Attributes("T1").Value)
		Debug.Print(datasource.GetItem("SPMSubArea", (objVessel.PlantGroupID)).Attributes("T1").Value)
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		
	End Sub
	
	Private Sub cmdLab58_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab58.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel)
		
		Dim objDrawing As Llama.LMDrawing
		objDrawing = datasource.GetDrawing((objVessel.Representations.Nth(1).DrawingID))
		
		Dim objPlantGroup As Llama.LMPlantGroup
		'get the plantgroup just above the drawing, in our case, should be unit
		objPlantGroup = objDrawing.PlantGroupObject
		
		Dim objWSSite As Llama.LMWSSite
		
		objWSSite = objPlantGroup.WSSiteObject
		
		Dim objAttr As Llama.LMAAttribute
		Debug.Print("How many attributes? " & objWSSite.Attributes.Count)
		For	Each objAttr In objWSSite.Attributes
			Debug.Print("Attribute Name: " & objAttr.Name & "     Attribute Value: " & objAttr.Value)
		Next objAttr
		
		Dim objOPC As Llama.LMOPC
		Debug.Print("Total OPCs in WS Site: " & objWSSite.OPCs.Count)
		For	Each objOPC In objWSSite.OPCs
			Debug.Print(objOPC.Attributes("OPCTag").Value)
			Debug.Print(objOPC.WSSiteObject.Attributes("Name").Value)
		Next objOPC
		
		Dim objPlantItemGroup As Llama.LMPlantItemGroup
		Debug.Print("Total PlantItemGroups in WS Site: " & objWSSite.PlantItemGroups.Count)
		For	Each objPlantItemGroup In objWSSite.PlantItemGroups
			Debug.Print(objPlantItemGroup.Attributes("PlantItemGroupType").Value)
			Debug.Print(objPlantItemGroup.WSSiteObject.Attributes("Name").Value)
		Next objPlantItemGroup
		
		
		Debug.Print("Total PlantGroups in WS Site: " & objWSSite.PlantGroups.Count)
		For	Each objPlantGroup In objWSSite.PlantGroups
			Debug.Print(objPlantGroup.Attributes("PlantGroupType").Value)
			Debug.Print(objPlantGroup.Attributes("Name").Value)
			Debug.Print(objPlantGroup.WSSiteObject.Attributes("Name").Value)
		Next objPlantGroup
		
		Dim objDrawingSite As Llama.LMDrawingSite
		Debug.Print("Total DrawingSites in WS Site: " & objWSSite.DrawingSites.Count)
		For	Each objDrawingSite In objWSSite.DrawingSites
			Debug.Print(objDrawingSite.Attributes("Name").Value)
			Debug.Print(objDrawingSite.WSSiteObject.Attributes("Name").Value)
		Next objDrawingSite
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		'UPGRADE_NOTE: Object objDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawing = Nothing
		'UPGRADE_NOTE: Object objPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantGroup = Nothing
		'UPGRADE_NOTE: Object objAttr may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objAttr = Nothing
		'UPGRADE_NOTE: Object objOPC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOPC = Nothing
		'UPGRADE_NOTE: Object objPlantItemGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantItemGroup = Nothing
		'UPGRADE_NOTE: Object objDrawingSite may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawingSite = Nothing
		
	End Sub
	
	Private Sub cmdLab59_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab59.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel)
		
		Dim objDrawing As Llama.LMDrawing
		objDrawing = datasource.GetDrawing((objVessel.Representations.Nth(1).DrawingID))
		
		Dim objDrawingSite As Llama.LMDrawingSite
		objDrawingSite = objDrawing.DrawingSites.Nth(1)
		
		Dim objAttr As Llama.LMAAttribute
		Debug.Print("How many attributes? " & objDrawingSite.Attributes.Count)
		For	Each objAttr In objDrawingSite.Attributes
			Debug.Print("Attribute Name: " & objAttr.Name & "     Attribute Value: " & objAttr.Value)
		Next objAttr
		
		Dim objDrawingSubscriber As Llama.LMDrawingSubscriber
		Debug.Print("Total drawing subscriber: " & objDrawingSite.DrawingSubscribers.Count)
		For	Each objDrawingSubscriber In objDrawingSite.DrawingSubscribers
			Debug.Print(objDrawingSubscriber.DrawingSiteObject.Attributes("Name").Value)
			Debug.Print(objDrawingSubscriber.WSSiteObject.Attributes("Name").Value)
		Next objDrawingSubscriber
		
		Debug.Print(objDrawingSite.DrawingObject.Attributes("Name").Value)
		Debug.Print(objDrawingSite.WSSiteObject.Attributes("Name").Value)
		If Not objDrawingSite.ToWSSiteWSSiteObject Is Nothing Then
			Debug.Print(objDrawingSite.ToWSSiteWSSiteObject.Attributes("Name").Value)
		End If
		Debug.Print(objDrawingSite.PlantGroupObject.Attributes("Name").Value)
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		'UPGRADE_NOTE: Object objDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawing = Nothing
		'UPGRADE_NOTE: Object objDrawingSite may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawingSite = Nothing
		'UPGRADE_NOTE: Object objDrawingSubscriber may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawingSubscriber = Nothing
		'UPGRADE_NOTE: Object objAttr may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objAttr = Nothing
		
	End Sub
	
	Private Sub cmdLab60_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab60.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		datasource.BeginTransaction()
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel)
		Debug.Print(objVessel.Attributes("Name").Value)
		'expects error in following code, "Read Only attribute"
		objVessel.Attributes("Name").Value = "InWorkshare"
		objVessel.Commit()
		
		datasource.CommitTransaction()
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		
	End Sub
	
	Private Sub cmdLab61_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab61.Click
		Dim datasource As Llama.LMADataSource
		Dim objActiveProject As Llama.LMActiveProject
		Dim objAttribute As Llama.LMAAttribute
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		objActiveProject = datasource.GetActiveProject
		For	Each objAttribute In objActiveProject.Attributes
			Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
		Next objAttribute
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objActiveProject may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objActiveProject = Nothing
		'UPGRADE_NOTE: Object objAttribute may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objAttribute = Nothing
		
	End Sub
	
	Private Sub cmdLab62_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab62.Click
		Dim datasource As Llama.LMADataSource
		Dim objPlantGroups As Llama.LMPlantGroups
		Dim objPlantGroup As Llama.LMPlantGroup
		Dim objAttribute As Llama.LMAAttribute
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		objPlantGroups = New Llama.LMPlantGroups
		objPlantGroups.Collect(datasource)
		
		Debug.Print("Total PlantGroups: " & objPlantGroups.Count)
		
		For	Each objPlantGroup In objPlantGroups
			For	Each objAttribute In objPlantGroup.Attributes
				Debug.Print("Name: " & objAttribute.Name & Space(20 - Len(objAttribute.Name)) & "Value: " & objAttribute.Value)
				If objAttribute.Name = "Depth" And objAttribute.Value = "0" Then
					MsgBox("ThePlant is: " & objPlantGroup.Attributes("Name").Value)
				End If
			Next objAttribute
		Next objPlantGroup
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objPlantGroups may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantGroups = Nothing
		'UPGRADE_NOTE: Object objPlantGroup may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlantGroup = Nothing
		'UPGRADE_NOTE: Object objAttribute may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objAttribute = Nothing
		
	End Sub
	
	Private Sub cmdLab63_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab63.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel(CONST_SPID_Vessel) 'get objVessel by id
		
		'check Claim status
		Debug.Print(datasource.GetModelItemClaimStatus(objVessel.AsLMAItem))
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		
	End Sub
	
	Private Sub cmdLab64_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab64.Click
		
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objFilter As Llama.LMAFilter
		Dim criterion As Llama.LMACriterion
		criterion = New Llama.LMACriterion
		objFilter = New Llama.LMAFilter
		
		criterion.SourceAttributeName = "Name"
		criterion.ValueAttribute = "Default Assembly Path"
		criterion.Operator = "="
		
		objFilter.ItemType = "OptionSetting"
		objFilter.Criteria.Add(criterion)
		
		Dim objOptionSettings As Llama.LMOptionSettings
		Dim objOptionSetting As Llama.LMOptionSetting
		objOptionSettings = New Llama.LMOptionSettings
		'get "Default Assembly Path" from OptionSettings by filter
		objOptionSettings.Collect(datasource, Filter:=objFilter)
		
		objOptionSetting = objOptionSettings.Nth(1)
		Debug.Print("Name = " & objOptionSetting.Attributes("Name").Value)
		Debug.Print("Value = " & objOptionSetting.Attributes("Value").Value)
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objFilter may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objFilter = Nothing
		'UPGRADE_NOTE: Object criterion may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		criterion = Nothing
		'UPGRADE_NOTE: Object objOptionSettings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOptionSettings = Nothing
		'UPGRADE_NOTE: Object objOptionSetting may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOptionSetting = Nothing
		
	End Sub
	
	Private Sub cmdLab64a_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab64a.Click
		Dim datasource As Llama.LMADataSource
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		Dim objFilter As Llama.LMAFilter
		Dim criterion As Llama.LMACriterion
		criterion = New Llama.LMACriterion
		objFilter = New Llama.LMAFilter
		
		'criterion.SourceAttributeName = "Name"
		'criterion.ValueAttribute = "Default Assembly Path"
		'criterion.Operator = "="
		
		objFilter.ItemType = "OptionSetting"
		objFilter.Criteria.Add(criterion)
		
		Dim objOptionSettings As Llama.LMOptionSettings
		Dim objOptionSetting As Llama.LMOptionSetting
		objOptionSettings = New Llama.LMOptionSettings
		'get "Default Assembly Path" from OptionSettings by filter
		objOptionSettings.Collect(datasource) ', Filter: =objFilter
		
		For	Each objOptionSetting In objOptionSettings
			WriteToErrorLog("Name = " & objOptionSetting.Attributes("Name").Value & "    Value = " & objOptionSetting.Attributes("Value").Value)
			Debug.Print("Name = " & objOptionSetting.Attributes("Name").Value & "    Value = " & objOptionSetting.Attributes("Value").Value)
			'Debug.Print "Value = " & objOptionSetting.Attributes("Value").Value
		Next objOptionSetting
		
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		'UPGRADE_NOTE: Object objFilter may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objFilter = Nothing
		'UPGRADE_NOTE: Object criterion may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		criterion = Nothing
		'UPGRADE_NOTE: Object objOptionSettings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOptionSettings = Nothing
		'UPGRADE_NOTE: Object objOptionSetting may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOptionSetting = Nothing
		
		
	End Sub
	
	Private Sub cmdLab65_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab65.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim Item As Llama.LMAItem
		Dim dirpath As String
		
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Horizontal Drums\Horz Surge w-Horiz Dea.sym"
		'create a vessel into stockpile
		Item = objPlacement.PIDCreateItem(VesselLocation)
		If Item Is Nothing Then
			MsgBox("unsuccessful placement")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object Item may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		Item = Nothing
		
	End Sub
	
	Private Sub cmdLab66_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab66.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim dirpath As String
		
		Dim symbol As Llama.LMSymbol
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Horizontal Drums\Horz Surge w-Horiz Dea.sym"
		
		'place a vessle into active drawing
		symbol = objPlacement.PIDPlaceSymbol(VesselLocation, 0.3, 0.2)
		
		If symbol Is Nothing Then
			MsgBox("unsuccessful placement")
		Else
			MsgBox(" Successful Placement")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object symbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol = Nothing
		
	End Sub
	
	Private Sub cmdLab67_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab67.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim strdirpath As String
		Dim nozzleName As String
		Dim trayName As String
		
		Dim xvessel As Double
		Dim yvessel As Double
		xvessel = 0.5
		yvessel = 0.3
		Dim symVessel As Llama.LMSymbol
		Dim symbol2 As Llama.LMSymbol
		Dim symbol3 As Llama.LMSymbol
		Dim symbol4 As Llama.LMSymbol
		Dim symbol5 As Llama.LMSymbol
		Dim vesselName As String
		Dim symbol21 As Llama.LMSymbol
		Dim symbol31 As Llama.LMSymbol
		
		vesselName = "\Equipment\Vessels\Vertical Drums\1D 1C 2to1.sym"
		nozzleName = "\Equipment Components\Nozzles\Flanged Nozzle with blind.sym"
		trayName = "\Equipment Components\Trays\Bubble Cap Trays\2-Pass Bubl Side.sym"
		
		'place a vessel
		symVessel = objPlacement.PIDPlaceSymbol(vesselName, xvessel, yvessel)
		'set Cleaning Requirement for the Vessel
		Dim objVessel As Llama.LMVessel
		objVessel = objPlacement.PIDDataSource.GetVessel((symVessel.ModelItemID))
		objVessel.Attributes("CleaningReqmts").Value = "CC1"
		'place two nozzles on vessel
		symbol2 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel - 0.2, yvessel + 0.05, TargetItem:=symVessel.AsLMRepresentation)
		symbol3 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel + 0.2, yvessel + 0.07, TargetItem:=symVessel.AsLMRepresentation)
		'place two trays on vessel
		symbol4 = objPlacement.PIDPlaceSymbol(trayName, xvessel - 0.05, yvessel + 0.05, TargetItem:=symVessel.AsLMRepresentation)
		symbol5 = objPlacement.PIDPlaceSymbol(trayName, xvessel + 0.05, yvessel + 0.1, TargetItem:=symVessel.AsLMRepresentation)
		
		'''''    'place nozzles again use same X, Y coordinates, but this time set PIDSnapToTarget=false
		'''''    objPlacement.PIDSnapToTarget = False
		'''''    Set symbol21 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel - 0.2, yvessel + 0.05, _
		''''''                TargetItem:=symVessel.AsLMRepresentation)
		'''''    Set symbol31 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel + 0.2, yvessel + 0.07, _
		''''''                TargetItem:=symVessel.AsLMRepresentation)
		'''''    objPlacement.PIDSnapToTarget = True
		
		'''''    'place nozzles again use new X, Y coordinates, but this time set PIDSetCopyPropertiesFlag=false
		'''''    objPlacement.PIDSetCopyPropertiesFlag False
		'''''    Set symbol21 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel - 0.2, yvessel + 0.05, _
		''''''                TargetItem:=symVessel.AsLMRepresentation)
		'''''    Set symbol31 = objPlacement.PIDPlaceSymbol(nozzleName, xvessel + 0.2, yvessel + 0.07, _
		''''''                TargetItem:=symVessel.AsLMRepresentation)
		'''''    objPlacement.PIDSetCopyPropertiesFlag True
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object symVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symVessel = Nothing
		'UPGRADE_NOTE: Object symbol2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol2 = Nothing
		'UPGRADE_NOTE: Object symbol3 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol3 = Nothing
		'UPGRADE_NOTE: Object symbol4 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol4 = Nothing
		'UPGRADE_NOTE: Object symbol5 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol5 = Nothing
		'''''    Set symbol21 = Nothing
		'''''    Set symbol31 = Nothing
		
	End Sub
	
	Private Sub cmdLab68_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab68.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim strdirpath As String
		Dim nozzleName As String
		Dim trayName As String
		Dim labelName1 As String
		Dim labelName2 As String
		Dim labelName3 As String
		Dim vessel As Llama.LMVessel
		Dim labelpersist As Llama.LMLabelPersist
		
		Dim xvessel As Double
		Dim yvessel As Double
		xvessel = 0.2
		yvessel = 0.2
		
		Dim symVessel As Llama.LMSymbol
		Dim vesselName As String
		'UPGRADE_WARNING: Lower bound of array points was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim points(4) As Double
		'UPGRADE_WARNING: Lower bound of array twopoints was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim twopoints(2) As Double
		
		vesselName = "\Equipment\Vessels\Vertical Drums\1D 1C 2to1.sym"
		labelName1 = "\Equipment\Labels - Equipment\Equipment Name.sym"
		labelName2 = "\Equipment\Labels - Equipment\Insulation Purpose.sym"
		labelName3 = "\Equipment\Labels - Equipment\Heat Tracing.sym"
		
		'place vessel
		symVessel = objPlacement.PIDPlaceSymbol(vesselName, xvessel, yvessel)
		'get placed vessel and set some properties' value
		vessel = objPlacement.PIDDataSource.GetVessel((symVessel.ModelItemID))
		vessel.Name = "Vessel for Label Placement"
		vessel.InsulPurpose = "R15"
		vessel.HTraceMedium = "SS"
		vessel.HTraceMediumTemp = "300 F"
		vessel.HTraceReqmt = "ET"
		
		'place three different labels for the vessel
		twopoints(1) = xvessel + 0.02
		twopoints(2) = yvessel + 0.1
		labelpersist = objPlacement.PIDPlaceLabel(labelName1, twopoints, Labeleditem:=symVessel.AsLMRepresentation)
		points(1) = xvessel
		points(2) = yvessel
		points(3) = xvessel - 0.05
		points(4) = yvessel + 0.1
		labelpersist = objPlacement.PIDPlaceLabel(labelName2, points, Labeleditem:=symVessel.AsLMRepresentation, IsLeaderVisible:=True)
		
		points(1) = xvessel
		points(2) = yvessel
		points(3) = xvessel + 0.05
		points(4) = yvessel + 0.1
		labelpersist = objPlacement.PIDPlaceLabel(labelName3, points, Labeleditem:=symVessel.AsLMRepresentation, IsLeaderVisible:=True)
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object symVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symVessel = Nothing
		'UPGRADE_NOTE: Object labelpersist may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		labelpersist = Nothing
		
	End Sub
	
	Private Sub cmdLab69_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab69.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim OPClocation As String
		OPClocation = "\Piping\Piping OPC's\Off-Drawing.sym"
		
		'place a vessle into active drawing
		Dim symbol As Llama.LMSymbol
		symbol = objPlacement.PIDPlaceSymbol(OPClocation, 0.1, 0.1)
		
		If symbol Is Nothing Then
			MsgBox("unsuccessful placement")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object symbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol = Nothing
		
	End Sub
	
	Private Sub cmdLab70_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab70.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim OPClocation As String
		OPClocation = "\Piping\Piping OPC's\Off-Drawing.sym"
		
		Dim objOPC As Llama.LMOPC
		Dim objpairOPC As Llama.LMOPC
		
		objOPC = objPlacement.PIDDataSource.GetOPC(CONST_SPID_OPC)
		objpairOPC = objOPC.pairedWithOPCObject
		
		Dim objConnector As Llama.LMConnector
		Dim objPiperun As Llama.LMPipeRun
		Dim objRep As Llama.LMRepresentation
		
		objPiperun = objPlacement.PIDDataSource.GetPipeRun(CONST_SPID_PipeRun)
		For	Each objRep In objPiperun.Representations
			If objRep.Attributes("RepresentationType").Value = "Connector" Then
				objConnector = objPlacement.PIDDataSource.GetConnector((objRep.ID))
				Exit For
			End If
		Next objRep
		
		Dim x As Double
		Dim Y As Double
		
		'UPGRADE_WARNING: Couldn't resolve default property of object objConnector.ConnectorVertices.Nth().Attributes().Value. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		x = objConnector.ConnectorVertices.Nth(1).Attributes("XCoordinate").Value
		'UPGRADE_WARNING: Couldn't resolve default property of object objConnector.ConnectorVertices.Nth().Attributes().Value. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Y = objConnector.ConnectorVertices.Nth(1).Attributes("YCoordinate").Value
		'place the OPC from stockpile into active drawing
		Dim symbol As Llama.LMSymbol
		symbol = objPlacement.PIDPlaceSymbol(OPClocation, x, Y,  ,  , objpairOPC.AsLMAItem)
		
		If symbol Is Nothing Then
			MsgBox("unsuccessful placement")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object symbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		symbol = Nothing
		
	End Sub
	
	Private Sub cmdLab71_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab71.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim PipeRunLocation As String
		Dim objItem As Llama.LMAItem
		Dim objConnector As Llama.LMConnector
		Dim objInputs As Plaice.PlaceRunInputs
		Dim objSymbol As Llama.LMSymbol
		Dim ValveLocation As String
		
		PipeRunLocation = "\Piping\Routing\Process Lines\Primary Piping.sym"
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddPoint(0.1, 0.1)
		objInputs.AddPoint(0.2, 0.1)
		
		objItem = objPlacement.PIDCreateItem(PipeRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		
		ValveLocation = "\Piping\Valves\2 Way Common\Ball Valve.sym"
		objSymbol = objPlacement.PIDPlaceSymbol(ValveLocation, 0.15, 0.3,  , 1.57)
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddConnectorTarget(objConnector, 0.15, 0.1)
		objInputs.AddPoint(0.15, 0.15)
		objInputs.AddPoint(0.12, 0.15)
		objInputs.AddPoint(0.12, 0.2)
		objInputs.AddPoint(0.15, 0.2)
		objInputs.AddSymbolTarget(objSymbol, 0.15, 0.3)
		
		objItem = objPlacement.PIDCreateItem(PipeRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		'clean up
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objItem may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objItem = Nothing
		'UPGRADE_NOTE: Object objConnector may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objConnector = Nothing
		'UPGRADE_NOTE: Object objSymbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol = Nothing
		'UPGRADE_NOTE: Object objInputs may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objInputs = Nothing
		
	End Sub
	
	Private Sub cmdLab72_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab72.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim PipeRunLocation As String
		Dim objItem As Llama.LMAItem
		Dim objConnector As Llama.LMConnector
		Dim objInputs As Plaice.PlaceRunInputs
		Dim objSymbol As Llama.LMSymbol
		Dim VesselLocation As String
		Dim NozzleLocation As String
		Dim objPiperuns As Llama.LMPipeRuns
		Dim objPiperun As Llama.LMPipeRun
		Dim objSurvivorItem As Llama.LMAItem
		
		objPiperuns = New Llama.LMPipeRuns
		
		PipeRunLocation = "\Piping\Routing\Process Lines\Primary Piping.sym"
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddPoint(0.1, 0.1)
		objInputs.AddPoint(0.2, 0.1)
		
		'first piperun
		objItem = objPlacement.PIDCreateItem(PipeRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddLocatedTarget(0.15, 0.1)
		objInputs.AddPoint(0.15, 0.3)
		
		'second piperun
		objItem = objPlacement.PIDCreateItem(PipeRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		objPiperuns.Add(objPlacement.PIDDataSource.GetPipeRun((objConnector.ModelItemID)).Id)
		
		VesselLocation = "\Equipment\Vessels\Vertical Drums\1D 1C 2to1.sym"
		NozzleLocation = "\Equipment Components\Nozzles\Flanged Nozzle with blind.sym"
		
		objSymbol = objPlacement.PIDPlaceSymbol(VesselLocation, 0.15, 0.5)
		objSymbol = objPlacement.PIDPlaceSymbol(NozzleLocation, 0.15, 0.5 - 0.1, TargetItem:=objSymbol.AsLMRepresentation)
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddConnectorTarget(objConnector, 0.15, 0.3)
		objInputs.AddSymbolTarget(objSymbol, objSymbol.Attributes("XCoordinate").Value, objSymbol.Attributes("YCoordinate").Value)
		
		'third piperun
		objItem = objPlacement.PIDCreateItem(PipeRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		objPiperuns.Add(objPlacement.PIDDataSource.GetPipeRun((objConnector.ModelItemID)).Id)
		
		'AutoJoin
		For	Each objPiperun In objPiperuns
			objPlacement.PIDAutoJoin(objPiperun.AsLMAItem, Plaice.AutoJoinEndConstants.autoJoin_Both, objSurvivorItem)
		Next objPiperun
		
		MsgBox("Done!")
		'clean up
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objItem may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objItem = Nothing
		'UPGRADE_NOTE: Object objConnector may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objConnector = Nothing
		'UPGRADE_NOTE: Object objSymbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol = Nothing
		'UPGRADE_NOTE: Object objInputs may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objInputs = Nothing
		
	End Sub
	
	Private Sub cmdLab73_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab73.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim PipeRunLocation As String
		PipeRunLocation = "\Piping\Routing\Process Lines\Primary Piping.sym"
		
		'UPGRADE_WARNING: Lower bound of array twopoints was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim twopoints(4) As Double
		twopoints(1) = 0.2
		twopoints(2) = 0.2
		twopoints(3) = 0.4
		twopoints(4) = 0.2
		
		Dim objConnector As Llama.LMConnector
		objConnector = objPlacement.PIDPlaceConnector(PipeRunLocation, twopoints)
		
		
		Dim gaplocation As String
		gaplocation = "\Piping\Gaps\gap-lines.sym"
		Dim objSymbol As Llama.LMSymbol
		objSymbol = objPlacement.PIDPlaceGap(gaplocation, 0.3, 0.2, 0.02, 0.02, objConnector, -1.57)
		
		'UPGRADE_NOTE: Object objConnector may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objConnector = Nothing
		'UPGRADE_NOTE: Object objSymbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol = Nothing
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		
	End Sub
	
	Private Sub cmdLab74_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab74.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim datasource As Llama.LMADataSource
		datasource = objPlacement.PIDDataSource
		
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Vertical Drums\1D 1C 2to1.sym"
		
		'place a vessel
		Dim objSymbol1 As Llama.LMSymbol
		objSymbol1 = objPlacement.PIDPlaceSymbol(VesselLocation, 0.25, 0.25)
		
		'place a nozzle on the vessel
		Dim NozzleLocation As String
		NozzleLocation = "\Equipment Components\Nozzles\Flanged Nozzle with blind.sym"
		Dim objSymbol2 As Llama.LMSymbol
		objSymbol2 = objPlacement.PIDPlaceSymbol(NozzleLocation, 0#, 0#,  ,  ,  , objSymbol1.AsLMRepresentation)
		
		'UPGRADE_WARNING: Lower bound of array points was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim points(10) As Double
		points(1) = 0.1
		points(2) = 0.1
		points(3) = 0.4
		points(4) = 0.1
		points(5) = 0.4
		points(6) = 0.4
		points(7) = 0.1
		points(8) = 0.4
		points(9) = 0.1
		points(10) = 0.1
		
		'place BoundedShape(it is a AreaBreak)
		Dim boundedshapelocation As String
		boundedshapelocation = "\Design\Area Break.sym"
		Dim objBoundedShaped As Llama.LMBoundedShape
		objBoundedShaped = objPlacement.PIDPlaceBoundedShape(boundedshapelocation, points)
		
		'get the placed vessel
		Dim objVessel As Llama.LMVessel
		objVessel = datasource.GetVessel((objSymbol1.ModelItemID))
		
		'get the BoundedShpae(AreaBreak) as PlantItemGroup
		Dim objPlantItemGroup As Llama.LMPlantItemGroup
		objPlantItemGroup = datasource.GetPlantItemGroup((objBoundedShaped.ModelItemID))
		
		Debug.Print("The vessel belongs to how many plantitemgroups? = " & objVessel.PlantItemGroups.Count)
		
		'add the vessel to the PlantItemGroup
		objVessel.PlantItemGroups.Add(objPlantItemGroup.Id)
		'objVessel.Commit
		Debug.Print("The vessel belongs to how many plantitemgroups? = " & objVessel.PlantItemGroups.Count)
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object datasource may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		datasource = Nothing
		
	End Sub
	
	Private Sub cmdLab75_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab75.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim AssemblyLocation As String
		AssemblyLocation = "\Assemblies\test.pid"
		
		Dim objItems As Llama.LMAItems
		'place assembly
		objItems = objPlacement.PIDPlaceAssembly(AssemblyLocation, 0.3, 0.3) 'It was 0#, 0#
		If objItems.Count <> 0 Then
			MsgBox("Place Assembly Completed")
		Else
			MsgBox("Not a blank Drawing")
			
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objItems may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objItems = Nothing
		
	End Sub
	
	Private Sub cmdLab76_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab76.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim objRep As Llama.LMRepresentation
		Dim objVessel As Llama.LMVessel
		Dim objSym As Llama.LMSymbol
		Dim VesselLocation As String
		
		VesselLocation = "\Equipment\Vessels\Horizontal Drums\Horz Surge w-Horiz Dea.sym"
		'place a vessel into drawing
		objSym = objPlacement.PIDPlaceSymbol(VesselLocation, 0.2, 0.2)
		
		objVessel = objPlacement.PIDDataSource.GetVessel((objSym.ModelItemID))
		objRep = objVessel.Representations.Nth(1)
		'remove the vessel from drawing into stockpile
		Dim success As Boolean
		success = objPlacement.PIDRemovePlacement(objRep)
		If success Then
			MsgBox("Symbol removed successfully")
		Else
			MsgBox("RemovePlacement unsuccessful")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objVessel may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objVessel = Nothing
		'UPGRADE_NOTE: Object objRep may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objRep = Nothing
		
		
	End Sub
	
	Private Sub cmdLab77_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab77.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim objItem As Llama.LMAItem
		Dim success As Boolean
		Dim objSym As Llama.LMSymbol
		Dim VesselLocation As String
		
		VesselLocation = "\Equipment\Vessels\Horizontal Drums\Horz Surge w-Horiz Dea.sym"
		'place a vessel into drawing
		objSym = objPlacement.PIDPlaceSymbol(VesselLocation, 0.2, 0.2)
		
		objItem = objPlacement.PIDDataSource.GetVessel((objSym.ModelItemID)).AsLMAItem
		success = False
		success = objPlacement.PIDDeleteItem(objItem)
		If success Then
			MsgBox("deletion from drawing successfully")
		Else
			MsgBox("deletion from drawing unsuccessful")
		End If
		
		Dim Item As Llama.LMAItem
		Item = objPlacement.PIDCreateItem(VesselLocation)
		objItem = objPlacement.PIDDataSource.GetVessel((Item.ID)).AsLMAItem
		success = False
		success = objPlacement.PIDDeleteItem(objItem)
		If success Then
			MsgBox("deletion from stockpile successfully")
			
		Else
			MsgBox("deletion from stockpile unsuccessful")
		End If
		
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objItem may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objItem = Nothing
		
	End Sub
	
	Private Sub cmdLab78_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab78.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Vertical Drums\1D 1C 2to1.sym"
		'place a vessel
		Dim objSymbol1 As Llama.LMSymbol
		objSymbol1 = objPlacement.PIDPlaceSymbol(VesselLocation, 0.2, 0.2)
		
		Dim NozzleLocation As String
		NozzleLocation = "\Equipment Components\Nozzles\Flanged Nozzle with blind.sym"
		'place a nozzle on the vessel
		Dim objSymbol2 As Llama.LMSymbol
		objSymbol2 = objPlacement.PIDPlaceSymbol(NozzleLocation, 0.3, 0.2,  ,  ,  , objSymbol1.AsLMRepresentation)
		
		'replace the vessel, note nozzle is still on the new vessel
		Dim replacevesselname As String
		replacevesselname = "\Equipment\Vessels\Vertical Drums\2to1Parametric V Drum.sym"
		
		Dim objSymbol3 As Llama.LMSymbol
		objSymbol3 = objPlacement.PIDReplaceSymbol(replacevesselname, objSymbol1)
		
		
		'UPGRADE_NOTE: Object objSymbol1 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol1 = Nothing
		'UPGRADE_NOTE: Object objSymbol2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol2 = Nothing
		'UPGRADE_NOTE: Object objSymbol3 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol3 = Nothing
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		
	End Sub
	
	Private Sub cmdLab79_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab79.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Vertical Drums\2to1Parametric V Drum.sym"
		'place a vessel
		Dim objSymbol1 As Llama.LMSymbol
		objSymbol1 = objPlacement.PIDPlaceSymbol(VesselLocation, 0.2, 0.2)
		
		'get the vessel and set some properties' value
		Dim objVessel As Llama.LMVessel
		objVessel = objPlacement.PIDDataSource.GetVessel((objSymbol1.ModelItemID))
		objVessel.Attributes("Name").Value = "V1"
		objVessel.Attributes("TagPrefix").Value = "T"
		objVessel.Commit()
		
		Dim labelName1 As String
		labelName1 = "\Equipment\Labels - Equipment\Equipment Name.sym"
		'UPGRADE_WARNING: Lower bound of array twopoints was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim twopoints(4) As Double
		twopoints(1) = 0.21
		twopoints(2) = 0.25
		twopoints(3) = 0.1
		twopoints(4) = 0.1
		
		'place a label on the vessel
		Dim objLabelPersist1 As Llama.LMLabelPersist
		objLabelPersist1 = objPlacement.PIDPlaceLabel(labelName1, twopoints,  ,  , objSymbol1.AsLMRepresentation, True)
		
		Dim replacelabelname As String
		replacelabelname = "\Equipment\Labels - Equipment\Equipment ID.sym"
		
		'replace the label with new label
		Dim objLabelPersist2 As Llama.LMLabelPersist
		objLabelPersist2 = objPlacement.PIDReplaceLabel(replacelabelname, objLabelPersist1)
		
		'UPGRADE_NOTE: Object objSymbol1 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol1 = Nothing
		'UPGRADE_NOTE: Object objLabelPersist1 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objLabelPersist1 = Nothing
		'UPGRADE_NOTE: Object objLabelPersist2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objLabelPersist2 = Nothing
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		
	End Sub
	
	Private Sub cmdLab80_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab80.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim OPClocation As String
		OPClocation = "\Piping\Piping OPC's\Off-Drawing-New.sym"
		
		Dim objOPC As Llama.LMOPC
		
		objOPC = objPlacement.PIDDataSource.GetOPC(CONST_SPID_OPC2)
		
		Dim objSymbol As Llama.LMSymbol
		objSymbol = objPlacement.PIDDataSource.GetSymbol((objOPC.Representations.Nth(1).ID))
		
		Dim objSymbol1 As Llama.LMSymbol
		objSymbol1 = objPlacement.PIDReplaceSymbol(OPClocation, objSymbol)
		
		'UPGRADE_NOTE: Object objSymbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol = Nothing
		'UPGRADE_NOTE: Object objSymbol1 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol1 = Nothing
		'UPGRADE_NOTE: Object objOPC may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objOPC = Nothing
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		
	End Sub
	
	
	
	Private Sub cmdLab81_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab81.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim VesselLocation As String
		VesselLocation = "\Equipment\Vessels\Vertical Drums\2to1Parametric V Drum.sym"
		Dim objSymbol1 As Llama.LMSymbol
		objSymbol1 = objPlacement.PIDPlaceSymbol(VesselLocation, 0.2, 0.2, True, 1.57)
		
		Dim NozzleLocation As String
		NozzleLocation = "\Equipment Components\Nozzles\Flanged Nozzle with blind.sym"
		Dim objSymbol2 As Llama.LMSymbol
		objSymbol2 = objPlacement.PIDPlaceSymbol(NozzleLocation, 0.22, 0.4,  ,  ,  , objSymbol1.AsLMRepresentation)
		
		'UPGRADE_WARNING: Lower bound of array names was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim names(2) As String
		'UPGRADE_WARNING: Lower bound of array values was changed from 1 to 0. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
		Dim values(2) As String
		names(1) = "Top"
		names(2) = "Right"
		values(1) = "0.38"
		values(2) = "0.2"
		
		objPlacement.PIDApplyParameters(objSymbol1.AsLMRepresentation, names, values)
		
		'UPGRADE_NOTE: Object objSymbol1 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol1 = Nothing
		'UPGRADE_NOTE: Object objSymbol2 may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol2 = Nothing
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		
	End Sub
	
	Private Sub cmdLab82_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab82.Click
		Dim objPlacement As Plaice.Placement
		objPlacement = New Plaice.Placement
		
		Dim SignalRunLocation As String
		Dim objItem As Llama.LMAItem
		Dim objConnector As Llama.LMConnector
		Dim objInputs As Plaice.PlaceRunInputs
		Dim objSymbol As Llama.LMSymbol
		Dim InstrLocation As String
		Dim blnSuccess As Boolean
		Dim x, Y As Double
		
		SignalRunLocation = "\Instrumentation\Signal Line\Electric Binary.sym"
		
		
		InstrLocation = "\Instrumentation\Off-Line\With Implied Components\Level\Discr Field Mounted LC.sym"
		objSymbol = objPlacement.PIDPlaceSymbol(InstrLocation, 0.3, 0.3)
		
		blnSuccess = objPlacement.PIDConnectPointLocation(objSymbol, 3, x, Y)
		
		objInputs = New Plaice.PlaceRunInputs
		objInputs.AddPoint(0.2, 0.3)
		objInputs.AddSymbolTarget(objSymbol, x, Y)
		
		objItem = objPlacement.PIDCreateItem(SignalRunLocation)
		objConnector = objPlacement.PIDPlaceRun(objItem, objInputs)
		
		'clean up
		'UPGRADE_NOTE: Object objPlacement may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPlacement = Nothing
		'UPGRADE_NOTE: Object objItem may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objItem = Nothing
		'UPGRADE_NOTE: Object objConnector may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objConnector = Nothing
		'UPGRADE_NOTE: Object objSymbol may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objSymbol = Nothing
		'UPGRADE_NOTE: Object objInputs may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objInputs = Nothing
		
	End Sub
	
	Private Sub cmdLab85_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab85.Click
		Dim datasource As Llama.LMADataSource
		Dim objPIDAutoApp As PIDAutomation.Application
		Dim objPIDADrawing As PIDAutomation.Drawing
		Dim objDrawing As Llama.LMDrawing
		Dim objDrawings As Llama.LMDrawings
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		objDrawings = New Llama.LMDrawings
		objDrawings.Collect(datasource)
		
		objPIDAutoApp = CreateObject("PIDAutomation.Application")
		
		For	Each objDrawing In objDrawings
			If objDrawing.Attributes("ItemStatus").Index = 1 Then '1 stands for Active
				objPIDADrawing = objPIDAutoApp.Drawings.OpenDrawing(objDrawing.Attributes("Name").Value)
				If Not objPIDADrawing Is Nothing Then
					MsgBox("Drawing " & objDrawing.Attributes("Name").Value & " is opened!")
					objPIDADrawing.CloseDrawing(True)
				End If
			End If
		Next objDrawing
		
		objPIDAutoApp.Quit()
		'UPGRADE_NOTE: Object objPIDAutoApp may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDAutoApp = Nothing
		'UPGRADE_NOTE: Object objPIDADrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDADrawing = Nothing
		'UPGRADE_NOTE: Object objDrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawing = Nothing
		'UPGRADE_NOTE: Object objDrawings may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objDrawings = Nothing
		
	End Sub
	
	Private Sub cmdLab86_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab86.Click
		Dim datasource As Llama.LMADataSource
		Dim objPIDAutoApp As PIDAutomation.Application
		Dim objPIDADrawing As PIDAutomation.Drawing
		Dim PlantGroupName As String
		Dim TemplateFileName As String
		Dim DrawingNumber As String
		Dim DrawingName As String
		
		If Not blnUsePIDDatasource Then
			datasource = New Llama.LMADataSource
		Else
			datasource = PlaicePlacement_definst.PIDDataSource
		End If
		
		objPIDAutoApp = CreateObject("PIDAutomation.Application")
		
		PlantGroupName = "Unit01"
		'considering accessing T_OptinSetting to read the template files path, which will be more flexible
		TemplateFileName = "\\102a-3\hostsite\TrainingPlant1\P&ID Reference Data\template files\C-Size.pid"
		DrawingNumber = "TestCreateNewDrawing1"
		DrawingName = "TestCreateNewDrawing1"
		objPIDADrawing = objPIDAutoApp.Drawings.Add(PlantGroupName, TemplateFileName, DrawingNumber, DrawingName)
		If Not objPIDADrawing Is Nothing Then
			MsgBox("Drawing " & objPIDADrawing.Name & " is opened!")
			objPIDADrawing.CloseDrawing(True)
		End If
		
		objPIDAutoApp.Quit()
		'UPGRADE_NOTE: Object objPIDAutoApp may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDAutoApp = Nothing
		'UPGRADE_NOTE: Object objPIDADrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDADrawing = Nothing
		
	End Sub
	
	Private Sub cmdLab87_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab87.Click
		Dim datasource As Llama.LMADataSource
		Dim objPIDAutoApp As PIDAutomation.Application
		Dim objPIDADrawing As PIDAutomation.Drawing
		Dim PlantGroupName As String
		Dim TemplateFileName As String
		Dim DrawingNumber As String
		Dim DrawingName As String
		Dim objPlacement As Plaice.Placement
		Dim AssemblyLocation As String
		Dim objItems As Llama.LMAItems
		Dim objItem As Llama.LMAItem
		Dim objConnector As Llama.LMConnector
		Dim objPiperun As Llama.LMPipeRun
		Dim i As Integer
		
		objPIDAutoApp = CreateObject("PIDAutomation.Application")
		
		PlantGroupName = "Unit01"
		'considering accessing T_OptinSetting to read the template files path, which will be more flexible
		TemplateFileName = "\\102a-3\hostsite\TrainingPlant1\P&ID Reference Data\template files\E-Size.pid"
		For i = 3 To 6
			
			DrawingNumber = "TestCreateNewDrawing" & i
			DrawingName = "TestCreateNewDrawing" & i
			objPIDADrawing = objPIDAutoApp.Drawings.Add(PlantGroupName, TemplateFileName, DrawingNumber, DrawingName)
		Next 
		
		If Not objPIDADrawing Is Nothing Then
			objPlacement = New Plaice.Placement
			datasource = objPlacement.PIDDataSource
			AssemblyLocation = "\Assemblies\Automation.pid"
			'place assembly
			objItems = objPlacement.PIDPlaceAssembly(AssemblyLocation, 0.2, 0.2)
			'change TagSequenceNo
			For	Each objItem In objItems
				If objItem.ItemType = "Connector" Then
					objConnector = datasource.GetConnector((objItem.ID))
					If objConnector.ModelItemObject.AsLMAItem.ItemType = "PipeRun" Then
						objPiperun = datasource.GetPipeRun((objConnector.ModelItemID))
						objPiperun.Attributes("TagSequenceNo").Value = 100
						objPiperun.Commit()
					End If
				End If
			Next objItem
			objPIDADrawing.CloseDrawing(True)
		End If
		
		objPIDAutoApp.Quit()
		'UPGRADE_NOTE: Object objPIDAutoApp may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDAutoApp = Nothing
		'UPGRADE_NOTE: Object objPIDADrawing may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		objPIDADrawing = Nothing
		
	End Sub
	
	Private Sub cmdLab87a_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdLab87a.Click
		
		
	End Sub
	
	Private Sub cmdLab88_Click()
		
	End Sub
	
	Private Sub frmMain_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		If Option1.Checked Then
			blnUsePIDDatasource = False
		Else
			blnUsePIDDatasource = True
		End If
	End Sub
	
	'UPGRADE_WARNING: Event Option1.CheckedChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub Option1_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Option1.CheckedChanged
		If eventSender.Checked Then
			
			blnUsePIDDatasource = False
			
		End If
	End Sub
	
	'UPGRADE_WARNING: Event Option2.CheckedChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSExpressCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub Option2_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Option2.CheckedChanged
		If eventSender.Checked Then
			
			blnUsePIDDatasource = True
			
		End If
	End Sub
	
	Private Sub cmdExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdExit.Click
		Me.Close()
	End Sub
	
	'this function write a line of string to log file
	Private Sub WriteToErrorLog(ByRef strMessage As String)
		Dim intFileNumber As Short
		
		
		'write message to error log file
		intFileNumber = FreeFile
		FileOpen(intFileNumber, Environ("TEMP") & "\SPATraining.log", OpenMode.Append) 'or you could just write over it using "for append as
		PrintLine(intFileNumber, Today & " " & TimeOfDay & "   " & strMessage)
		FileClose(intFileNumber)
	End Sub
End Class