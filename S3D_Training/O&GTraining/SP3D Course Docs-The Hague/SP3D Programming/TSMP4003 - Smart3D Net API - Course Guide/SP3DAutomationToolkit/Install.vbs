	'Vista Installation Script
	Option Explicit
	Dim objShell, objFSO, strPath
	Set objShell = CreateObject("Shell.Application")
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	strPath = objFSO.GetParentFolderName (WScript.ScriptFullName)
	Dim OSVersion
	OSVersion = GetOsVersionNumber()
	If (CDbl(OSVersion) < 4) then 
		Msgbox "Must be Running Windows NT4.0 or Higher"
		WScript.Quit
	End If
	
	Dim wsShell
	Set wsShell = CreateObject("WScript.Shell")
	If Not objFSO.FolderExists("\\" & wsShell.ExpandEnvironmentStrings("%computername%") & "\Admin$\System32") then 
		msgbox "ERROR - Active User Does NOT have Administrative Privileges" & _
		vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	end if
	
	If objFSO.FileExists(strPath & "\MainInstallScript.VBS") Then
		if (CDbl(OSVersion) >= 6.0) Then
			 objShell.ShellExecute "wscript.exe", _ 
				Chr(34) & strPath & "\MainInstallScript.VBS" & Chr(34), "", "runas", 1		
		Else
			 objShell.ShellExecute "wscript.exe", _ 
				Chr(34) & strPath & "\MainInstallScript.VBS" & Chr(34), "", "open", 1
		End if
	Else
		 MsgBox "Script file MainInstallScript.VBS not found"
	End If 

Function GetOsVersionNumber()
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Determines OS by reading reg val & comparing to known values
' OS version number returned as:
'		Windows 9X:	0
'		Windows NT4:	4
'		Windows 2k:	5
'		Windows XP:	5.1
'		Windows 2003:	5.2
'		Windows Vista:	6.0
'		Windows 7:	6.1
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   Dim oShell, sOStype, sOSversion, GetOsVersionNumberReg
   Set oShell = CreateObject("Wscript.Shell")

   'On Error Resume Next
   sOStype = oShell.RegRead(_
     "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions\ProductType")
   If Err.Number<>0 Then
     ' Hex(Err.Number)="80070002"
     ' - Could not find this key, OS must be Win9x
     Err.Clear
     GetOsVersionNumber = 0
     Exit Function  ' >>>
   End If

   GetOsVersionNumberReg = oShell.RegRead(_
     "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\CurrentVersion")
   If Err.Number<>0 Then
     GetOsVersionNumber = "Unknown NTx"
     ' Could not determine NT version
     Exit Function  ' >>>
   End If

   SetLocale "en-us"  ' do not remove
   GetOsVersionNumber = CSng(GetOsVersionNumberReg)
   If GetOsVersionNumber > 49 Then
     GetOsVersionNumber = CSng(Replace(GetOsVersionNumberReg, ".", ","))
   End If

End Function
