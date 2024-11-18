	'Main Installation Script
	Option Explicit
	Dim objFSO, wsShell, objInstallLog, strMsgBoxTitle ' Globals for this file

	strMsgBoxTitle = "Smart 3D Automation Toolkit Installation"
	Msgbox "Welcome to Automation Toolkit Installation for SmartPlant/Marine 3D", , strMsgBoxTitle
	
	On Error Resume Next ' The script is coded safely.
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	if (objFSO is Nothing) then 
		Msgbox "Unable to Create Scripting.FileSystemObject" & vbCrLf & _
		       "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate.", , strMsgBoxTitle
		WScript.Quit
	End If
	
	Set objInstallLog = objFSO.OpenTextFile("Install.LOG",2,True) ' Create
	If (objInstallLog is Nothing) Then
		Msgbox "Unable to Create/Append to Install.LOG file" & vbCrLf & _
		       "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate.", , strMsgBoxTitle
		WScript.Quit
	End If
	
	Set wsShell = CreateObject("WScript.Shell")
	if (wsShell is Nothing) then 
		LogInstallAction True, "ERROR - Unable to Create WSScript.Shell" & vbCrLf & _
		   "Please follow Manual Steps in QuickSetupInstructions.txt" & _
		   vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	End If
	LogInstallAction False, "INFO - Initialized WScript.Shell"

	If objFSO.FolderExists("\\" & wsShell.ExpandEnvironmentStrings("%computername%") & "\Admin$\System32") then 
		LogInstallAction False, "INFO - Verified Active User has Administrative Privileges"
	else 
		LogInstallAction False, "ERROR - Active User Does NOT have Administrative Privileges" & _
		vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	end if
	
	Dim s3dVersion
	s3dVersion = ReadFromRegistry ("HKLM\SOFTWARE\Intergraph\SP3D\Core\Version\", "")
	If (s3dVersion = "") then 
		s3dVersion = ReadFromRegistry ("HKLM\SOFTWARE\Wow6432Node\Intergraph\SP3D\Core\Version\", "")
	End If
	If (s3dVersion = "") then 	
		LogInstallAction True, "SmartPlant/Marine 3D Installation Not Found !!!" & _
			vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	End If
	LogInstallAction False, "INFO - SmartPlant/Marine 3D Version = " & s3dVersion

	' Get CurrentWorkingDirectory
	Dim curDir
	curDir = objFSO.GetParentFolderName(WScript.ScriptFullName) & "\"
	LogInstallAction False, "INFO - Installing FROM Directory = " & curDir
	' Install & Register the Appropriate version.

	Select Case (Left(s3dVersion, 8))
		Case "08.00.72" : wsShell.Run Chr(34) & curDir & "Register-SP3DAutomation-v2009.bat" & Chr(34), 1, True
		Case "07.00.45" : wsShell.Run Chr(34) & curDir & "Register-SP3DAutomation-v7SP5.bat" & Chr(34), 1, True
		Case "07.00.44" : wsShell.Run Chr(34) & curDir & "Register-SP3DAutomation-v7SP4.bat" & Chr(34), 1, True
		Case "07.00.43" : wsShell.Run Chr(34) & curDir & "Register-SP3DAutomation-v7SP3.bat" & Chr(34), 1, True
		Case Else :                                             
			If (Left(s3dVersion, 5) = "08.01") Then 
				wsShell.Run Chr(34) & curDir & "Register-SP3DAutomation-v2009.1.bat" & Chr(34), 1, True
			Else				
				LogInstallAction False, "Smart 3D Automation Toolkit unavailable for SmartPlant/Marine 3D Version " & s3dVersion & _
					vbCrLf & vbCrLf & "This Installation Script will now terminate."
				WScript.Quit
			End If
	End Select

	Dim cmnAppEnvXMLPath
	cmnAppEnvXMLPath = ReadFromRegistry ("HKLM\SOFTWARE\Intergraph\SP3D\Common\TaskInfo\CommonApp\LogicalXMLPath", "")
	If (cmnAppEnvXMLPath = "") then
		cmnAppEnvXMLPath = ReadFromRegistry ("HKLM\SOFTWARE\Wow6432Node\Intergraph\SP3D\Common\TaskInfo\CommonApp\LogicalXMLPath", "")	
	End If
	LogInstallAction False, "INFO - CommonApp xml Path From Registry = " & cmnAppEnvXMLPath
	If (cmnAppEnvXMLPath = "") then
		LogInstallAction True, "SmartPlant/Marine 3D CommonApp Environment Path Not Found" & vbCrLf & _
		   "Please follow Manual Steps in QuickSetupInstructions.txt" & _
		   vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	End If
	
	' Copy the menuSP3DAutomationPopupTools.xml
	If (Not CopyFileToDestinationFolder (curDir & "menuSP3DAutomationPopupTools.xml", cmnAppEnvXMLPath & "\")) Then
		LogInstallAction True, "Unable to Copy menuSP3DAutomationPopupTools.xml" & vbCrLf & _
		   "Please follow Manual Steps in QuickSetupInstructions.txt" & _
		   vbCrLf & vbCrLf & "This Installation Script will now terminate."
		WScript.Quit
	End If
	LogInstallAction False, "INFO - Copied menuSP3DAutomationPopupTools.xml"

	' Copy the menuSP3DAutomationCustomPopupTools.xml, if it doesnt exist. User might have edited to add his own commands.
	If (not objFSO.FileExists(cmnAppEnvXMLPath & "\menuSP3DAutomationCustomPopupTools.xml")) Then
		If (Not CopyFileToDestinationFolder (curDir & "menuSP3DAutomationCustomPopupTools.xml", cmnAppEnvXMLPath & "\")) Then
			LogInstallAction True, "Unable to Copy menuSP3DAutomationCustomPopupTools.xml" & vbCrLf & _
			   "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate."
			WScript.Quit
		End If
		LogInstallAction False, "INFO - Copied menuSP3DAutomationCustomPopupTools.xml"
	Else
		LogInstallAction False, "INFO - Found Existing menuSP3DAutomationCustomPopupTools.xml"
	End If
	
	' Edit CommonServices.xml, if our entry is not found.
	If (Not FindStringInFile (cmnAppEnvXMLPath & "\CommonServices.xml", "<COMObject progid=" & Chr(34) & "SP3DAutomation.CAutomation" & Chr(34))) Then
		LogInstallAction False, "INFO - Entry not Found in CommonServices.xml"
		If Not (ReplaceStringInFile (cmnAppEnvXMLPath & "\CommonServices.xml", "<xml>", _
				"<xml>" &  vbCrLf & "   <COMObject progid=" & Chr(34) & "SP3DAutomation.CAutomation" & Chr(34) & " optional=" & Chr(34) & "yes" & Chr(34) & "/>") _
		) Then
			LogInstallAction True, "ERROR - Unable to Edit CommonServices.xml" & vbCrLf & _
		       "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate."
			WScript.Quit
		Else
			LogInstallAction False, "INFO - Added Entry in $CommonApp\CommonServices.xml"
		End If
	Else
		LogInstallAction False, "INFO - Entry Found in CommonServices.xml"
	End If

	' Edit CommonPopups.xml, if our entry is not found.
	If (Not FindStringInFile (cmnAppEnvXMLPath & "\CommonPopups.xml", "<IncludeXML href=" & Chr(34) & "$CommonApp\menuSP3DAutomationPopupTools.xml" & Chr(34) & "/>")) Then
		LogInstallAction False, "INFO - Entry not Found in CommonPopups.xml"
		If (Not (ReplaceStringInFile (cmnAppEnvXMLPath & "\CommonPopups.xml", "</xml>", _
		         "<IncludeXML href=" & Chr(34) & "$CommonApp\menuSP3DAutomationPopupTools.xml" & Chr(34) & "/>" & vbCrLf & "</xml>"))) Then
			LogInstallAction True, "ERROR - Unable to Edit CommonPopup.xml" & vbCrLf & _
		       "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate."
			WScript.Quit
		Else
			LogInstallAction False, "INFO - Added Entry in $CommonApp\CommonPopups.xml"
		End If
	Else
		LogInstallAction False, "INFO - Entry Found in CommonPopups.xml"
	End If
	
	' Edit SpaceMgmt\ModifiedCommonPopups.xml
	Dim spaceMgmtXMLPath
	spaceMgmtXMLPath = Replace (cmnAppEnvXMLPath, "\CommonApp\", "\SpaceMgmt\")
	If (Not FindStringInFile (spaceMgmtXMLPath & "\ModifiedCommonPopups.xml", _
			"<IncludeXML href=" & Chr(34) & "$CommonApp\menuSP3DAutomationPopupTools.xml" & Chr(34) & "/>")) Then
		LogInstallAction False, "INFO - Entry not Found in $SpaceMgmt\ModifiedCommonPopups.xml"
		If (Not (ReplaceStringInFile (spaceMgmtXMLPath & "\ModifiedCommonPopups.xml", "</xml>", _
		        "<IncludeXML href=" & Chr(34) & "$CommonApp\menuSP3DAutomationPopupTools.xml" & Chr(34) & "/>" & chr(13) & "</xml>"))) Then
			LogInstallAction True, "ERROR - Unable to Edit $SpaceMgmt\ModifiedCommonPopups.xml" & vbCrLf & _
		       "Please follow Manual Steps in QuickSetupInstructions.txt" & _
			   vbCrLf & vbCrLf & "This Installation Script will now terminate."
			WScript.Quit
		Else
			LogInstallAction False, "INFO - Added Entry in $SpaceMgmt\ModifiedCommonPopups.xml"
		End If
	Else
		LogInstallAction False, "INFO - Entry Found in $SpaceMgmt\ModifiedCommonPopups.xml"
	End If

	Msgbox "Successfully Installed Automation Toolkit Installation for SmartPlant/Marine 3D version " & s3dVersion _
	    & vbCrLf & vbCrLf & _
		"Administrators : Copy S3DAutomationToolkitConfig.TXT to each Plant's SymbolShare and customize as needed." _
		, , strMsgBoxTitle
	LogInstallAction False, "INFO - End Of Installation"
	'End of Installation Script.
	
Function FindStringInFile(strFile, strFind) 
	LogInstallAction False, "INFO - FindStringInFile - " & vbCrLf & "  FIND - " & strFind & vbCrLf & "  IN - " & strFile
	On Error Resume Next
	FindStringInFile = False
	
	If (Not objFSO.FileExists(strFile)) Then 
		LogInstallAction True, "ERROR - FindStringInFile - File Not Found - " & strFile
		Exit Function
	End If
	
	Dim objTextFile, strText
	Set objTextFile = objFSO.OpenTextFile(strFile,1,false) ' Open For read
	If (objTextFile is Nothing) Then 
		LogInstallAction True, "ERROR - FindStringInFile - Unable to Open Text File - " & strFile
		Exit Function
	End If

	Err.Clear
	strText = objTextFile.ReadAll
	If (Err.number <> 0) Then 
		Err.Clear
		LogInstallAction True, "ERROR - FindStringInFile - Unable to Read File Contents - " & strFile
		objTextFile.Close
		Exit Function
	End If
	objTextFile.Close
	
	' Take care of Tab Chars and Multiple spaces - replace them to single space before finding requested string exists or not.
	strText = Replace (strText, Chr(9), " ")
	While (InStr(1,strText, "  ") > 0)
		strText = Replace (strText, "  ", " ")
	Wend
	
	FindStringInFile = (Instr (1, strText, strFind) > 0)
	Err.Clear
	
End Function


Function ReplaceStringInFile(strFile, strFind, strReplace) 
	ReplaceStringInFile = False
	LogInstallAction False, "INFO - ReplaceStringInFile - " & vbCrLf & "  STRING - " &  strFind & vbCrLf & "  WITH - " &  strReplace & vbCrLf & "  IN - " &  strFile
	On Error Resume Next
	
	'Read Existing contents
	Dim objTextFile, strText
	Set objTextFile = objFSO.OpenTextFile(strFile,1,false) ' Open For read
	If (objTextFile is Nothing) Then 
		LogInstallAction True, "ERROR - ReplaceStringInFile - Unable to Open Text File - " & strFile
		Exit Function
	End If
	
	Err.Clear
	strText = objTextFile.ReadAll
	If (Err.number <> 0) Then 
		Err.Clear
		LogInstallAction True, "ERROR - ReplaceStringInFile - Unable to Read File Contents - " & strFile
		objTextFile.Close
		Exit Function
	End If
	objTextFile.Close
	
	'Make Writable
	Dim oFile, bModifiedReadOnly
	set oFile = objFSO.GetFile (strFile)
	If (oFile.attributes and 1) Then ' if ReadOnly, then
		LogInstallAction False, "INFO - ReplaceStringInFile - File Is ReadOnly"
		oFile.attributes = oFile.attributes - 1 ' remove readonly attribute
		If (Err.Number <> 0) then 
			Err.Clear
			LogInstallAction True, "ERROR - ReplaceStringInFile - Unable to Modify File as ReadOnly = False"
			Exit Function
		End If
		bModifiedReadOnly = True
		LogInstallAction False, "INFO - ReplaceStringInFile - Modified File's ReadOnly = False"
	Else
		LogInstallAction False, "INFO - ReplaceStringInFile - File Is not ReadOnly"
	End If
	
	' Replace Strings
	strText = Replace (strText, strFind, strReplace)
	
	'Write back edited text to File.
	Set objTextFile = objFSO.OpenTextFile(strFile, 2, True)
	If (objTextFile is Nothing) Then 
		LogInstallAction True, "ERROR - ReplaceStringInFile - Unable to Open Text File - " & strFile
		Exit Function
	End If
	
	Err.Clear	
	objTextFile.Write strText
	If (Err.Number <> 0) then 
		objTextFile.Close
		LogInstallAction True, "ERROR - ReplaceStringInFile - Unable to Write to Text File - " & strFile
		Err.Clear
		Exit Function
	End If
	objTextFile.Close
	ReplaceStringInFile = True	

	'Revert back ReadOnly bit, if we modified it.
	If (bModifiedReadOnly) then
		set oFile = objFSO.GetFile (strFile)
		If (1 <> (oFile.attributes and 1)) Then ' if not ReadOnly, then
			oFile.attributes = oFile.attributes + 1 ' Dont care if an error happens here.
			LogInstallAction False, "WARNING - ReplaceStringInFile - Unable to make File as ReadOnly - " & strFile
		End If
	End If
End Function
 

'Copy File To Folder
Function CopyFileToDestinationFolder(strSourceFileFullPath, strDestinationPath)
	LogInstallAction False, "INFO - CopyFileToDestinationFolder - " & strSourceFileFullPath & " to " & strDestinationPath
	CopyFileToDestinationFolder = False
	
	If objFSO.FolderExists(strDestinationPath) Then
		LogInstallAction False, "INFO - CopyFileToDestinationFolder - Folder Exists - " &  strDestinationPath
		If objFSO.FileExists(strSourceFileFullPath) Then
			LogInstallAction False, "INFO - CopyFileToDestinationFolder - File Exists - " & strSourceFileFullPath
			Err.Clear
			objFSO.CopyFile strSourceFileFullPath, strDestinationPath, True
			If (Err.Number <> 0) then
				LogInstallAction True, "ERROR - CopyFileToDestinationFolder - Failed to Copy " & strSourceFileFullPath & " to " & strDestinationPath
			Else
				CopyFileToDestinationFolder = True
				LogInstallAction False, "INFO - CopyFileToDestinationFolder - Successfully Copied " & strSourceFileFullPath & " to " & strDestinationPath
			End If
		Else
			LogInstallAction True, "ERROR - CopyFileToDestinationFolder - File not Found - " & strSourceFileFullPath
		End If
	Else
		LogInstallAction True, "ERROR - CopyFileToDestinationFolder - Folder Not found - " & strDestinationPath
	End If
End Function
 
Function ReadFromRegistry (strRegistryKey, strDefault)
	Dim value
	On Error Resume Next
	value = wsShell.RegRead( strRegistryKey )
	If Err.Number <> 0 then
		ReadFromRegistry = strDefault
	Else
		ReadFromRegistry = value
	End If
	Err.Clear
End function

Function LogInstallAction (bShowMsg, strMsg)

	If (bShowMsg) Then Msgbox strMsg, , strMsgBoxTitle
	objInstallLog.WriteLine strMsg
	
End Function