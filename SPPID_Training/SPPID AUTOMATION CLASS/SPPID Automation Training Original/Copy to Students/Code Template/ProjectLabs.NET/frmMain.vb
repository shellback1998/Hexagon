Option Strict Off
Option Explicit On
Friend Class frmMain
	Inherits System.Windows.Forms.Form
	
	Private blnUsePIDDatasource As Boolean
	
	Private Const CONST_SPID_ModelItem As String = "C76EF274525A4345A6ACE1D179362899"
	Private Const CONST_SPID_ItemNote As String = "9A3B02C271754A8BB46DC4D02F9F0954"
	Private Const CONST_SPID_OPC As String = "A8EC5233227A4F3AB480E9AB39205BCC"
	Private Const CONST_SPID_Vessel As String = "C76EF274525A4345A6ACE1D179362899"
	Private Const CONST_SPID_PipeRun As String = "8B283FA8472F4E3BABB6AF573DF161F4"
	Private Const CONST_SPID_PipingComp As String = "59D6251324574734B9883C8E89E57B4E"
	Private Const CONST_SPID_OfflineInstrument As String = "7EAB72658BA04FD8BD67CFEB4D96DD37"
	Private Const CONST_SPID_InlineInstrument As String = "BC21A415E803496EBDA87129F5F5F540"
	Private Const CONST_SPID_LabelPersist As String = "B9E88D821E8145269E5B398B858555A8"
	
	
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
End Class