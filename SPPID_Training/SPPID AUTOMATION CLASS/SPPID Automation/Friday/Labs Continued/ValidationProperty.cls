VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Func"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Implements ILMForeignCalc

Private Function ILMForeignCalc_DoCalculate(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateItem(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, Context As LMForeignCalc.ENUM_LMAValidateContext) As Boolean

End Function

Private Function ILMForeignCalc_DoValidateProperty(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean
    
    ILMForeignCalc_DoValidateProperty = AddActuator(DataSource, Items, PropertyName, Value)
    
End Function

'add actuator when property actuator type is changed on instrument
Private Function AddActuator(DataSource As Llama.LMADataSource, _
    Items As Llama.LMAItems, PropertyName As String, Value As Variant) As Boolean
'
On Error GoTo ErrHandler
'
    Dim Item As LMAItem
    Dim objPlacement As Placement
    Dim strFilePath As String
    Dim x As Double
    Dim y As Double
    Dim objSym As LMSymbol
    Dim objSymbol As LMSymbol

    Dim objInstr As LMInstrument
    Dim objPlantItem As LMPlantItem
    Dim objInstrActuator As LMInstrument
    Dim blnDelete As Boolean
    Dim blnNeedAdd As Boolean
    
    
    Set objPlacement = New Placement
    AddActuator = False
    For Each Item In Items
        If Item.ItemType = "Instrument" And PropertyName = "ActuatorType" Then
           If Item.Attributes("InstrumentClass").Value = "Control valves and regulators" Then
                'get the instrument
                Set objInstr = DataSource.GetInstrument(Item.Id)
                If objInstr.ChildPlantItemPlantItems.Count = 0 Then
                    blnNeedAdd = True
                Else
                    If objInstr.ChildPlantItemPlantItems.Count = 1 Then
                        blnDelete = objPlacement.PIDDeleteItem(objInstr.ChildPlantItemPlantItems.Nth(1).AsLMAItem)
                        blnNeedAdd = True
                    Else
                        MsgBox "Wrong, there are more than 1 Child for this instrument!"
                    End If
                End If
                If blnNeedAdd Then
                    Select Case Value
                        Case "Diaphragm"
                            strFilePath = "\Instrumentation\Actuators\Diaph Actuator.sym"
                        Case "Single acting cylinder"
                            strFilePath = "\Instrumentation\Actuators\Single Action Cyl Act.sym"
                        Case "Pilot operated cylinder"
                            strFilePath = "\Instrumentation\Actuators\Pilot Operated Cyl Act.sym"
                        Case "Motor"
                            strFilePath = "\Instrumentation\Actuators\Motor Actuator.sym"
                        Case "Digital"
                            strFilePath = "\Instrumentation\Actuators\Digital Actuator.sym"
                        Case "Electro-hydraulic"
                            strFilePath = "\Instrumentation\Actuators\Electric-Hydraulic Act.sym"
                        Case "Single solenoid"
                            strFilePath = "\Instrumentation\Actuators\Solenoid Actuator.sym"
                        Case "Single solenoid w/reset"
                            strFilePath = "\Instrumentation\Actuators\Solenoid Act w-Man Reset.sym"
                        Case "Double solenoid"
                            strFilePath = "\Instrumentation\Actuators\Double Solenoid Act.sym"
                        Case "Pilot"
                            strFilePath = "\Instrumentation\Actuators\Pilot Actuator.sym"
                        Case "Weight"
                            strFilePath = "\Instrumentation\Actuators\Weight Actuator.sym"
                        Case "Manual"
                            strFilePath = "\Instrumentation\Actuators\Manual Actuator.sym"
                        Case "Spring"
                            strFilePath = "\Instrumentation\Actuators\Spring Actuator.sym"
                        Case "Capacitance sensor"
                            strFilePath = "\Instrumentation\Actuators\Capacitance Sensor Act.sym"
                        Case "Ball float"
                            strFilePath = "\Instrumentation\Actuators\Ball Float Actuator.sym"
                        Case "Displacement float"
                            strFilePath = "\Instrumentation\Actuators\Displacement Float Actuator.sym"
                        Case "Paddle wheel"
                            strFilePath = "\Instrumentation\Actuators\Paddle Wheel Actuator.sym"
                        Case "Diaphragm Rotary Actuator"
                            strFilePath = "\Instrumentation\Actuators\Diaph Actuator.sym"
                            Set objSym = DataSource.GetSymbol(objInstr.Representations.Nth(1).Id)
                            x = objSym.XCoordinate
                            y = objSym.YCoordinate
                        Case Else
                            'do nothing
                            strFilePath = ""
                    End Select
                
                    If strFilePath <> "" Then
                        Set objSym = DataSource.GetSymbol(objInstr.Representations.Nth(1).Id)
                        x = objSym.Attributes("XCoordinate")
                        y = objSym.Attributes("YCoordinate")
                        Set objSymbol = objPlacement.PIDPlaceSymbol(strFilePath, x, y) ' targetitem:=objSym.AsLMAItem)
                    Else
                        MsgBox "Couldn't find corresponding Actuator"
                    End If
                End If
                AddActuator = True
           End If
        End If
        
    Next
    
'clean up
    Set objPlacement = Nothing
    Set Item = Nothing
    Set objSym = Nothing
    Set objSymbol = Nothing
    Set objInstr = Nothing
    Set objPlantItem = Nothing
    Set objInstrActuator = Nothing
    
    Exit Function
ErrHandler:
    MsgBox "Error happened: " & Err.Description
'clean up
    Set objPlacement = Nothing
    Set Item = Nothing
    Set objSym = Nothing
    Set objSymbol = Nothing
    Set objInstr = Nothing
    Set objPlantItem = Nothing
    Set objInstrActuator = Nothing
End Function


Private Sub ILMForeignCalc_DoValidatePropertyNoUI(DataSource As Llama.LMADataSource, Items As Llama.LMAItems, PropertyName As String, Value As Variant)

End Sub
