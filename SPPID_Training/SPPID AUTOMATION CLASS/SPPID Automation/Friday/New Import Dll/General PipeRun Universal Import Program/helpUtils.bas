Attribute VB_Name = "helpUtils"
'***********************************************************************
'Modifications:
'5/19/2000      Reset ComponentsHelpKey for WinHelp to HtmlHelp conversion.  -- dmw
'6/12/00        Added Html Help declarations, new procedure for right-click
                'What's This? functionality -- dmw
'7/12/00        Added GetControlHtmlHelpTopic proc. -- dmw
'***********************************************************************

Option Explicit

Declare Function RegEnumValue Lib "advapi32.dll" Alias "RegEnumValueA" _
(ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpValueName As String, _
lpcbValueName As Long, ByVal lpReserved As Long, lpType As Long, lpData As Byte, _
lpcbData As Long) As Long

Declare Function RegEnumValueStr Lib "advapi32.dll" Alias "RegEnumValueA" _
    (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpValueName As String, _
    lpcbValueName As Long, ByVal lpReserved As Long, lpType As Long, _
    ByVal lpData As String, lpcbData As Long) As Long

' Note that if you declare the lpData parameter as String, you must pass it By Value.
Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" _
(ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, _
ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long

Declare Function RegQueryValueExNULL Lib "advapi32.dll" Alias "RegQueryValueExA" _
   (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, _
   lpType As Long, ByVal lpData As Long, lpcbData As Long) As Long

Declare Function RegQueryValueExString Lib "advapi32.dll" Alias "RegQueryValueExA" _
   (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, _
   lpType As Long, ByVal lpData As String, lpcbData As Long) As Long

Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" _
   (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, _
   ByVal samDesired As Long, phkResult As Long) As Long

Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long

'use for displaying right-click What's This? popups
Public Declare Function HtmlHelpPopup Lib "hhctrl.ocx" Alias "HtmlHelpA" _
   (ByVal hwnd As Long, ByVal lpHelpFile As String, ByVal wCommand As HH_COMMAND, _
    ByRef dwData As Any) As Long
    
'use for displaying topics
Public Declare Function HtmlHelpLong Lib "hhctrl.ocx" Alias "HtmlHelpA" _
   (ByVal hwnd As Long, ByVal lpHelpFile As String, ByVal wCommand As HH_COMMAND, _
   ByVal dwData As Long) As Long
     
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
Public Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long

Private Const HKEY_LOCAL_MACHINE = &H80000002
Private Const ERROR_NONE = 0
Public Const ERROR_SUCCESS = 0&

Private Const KEY_QUERY_VALUE = &H1
Private Const KEY_ENUMERATE_SUB_KEYS = &H8
Private Const KEY_NOTIFY = &H10
Private Const READ_CONTROL = &H20000
Private Const KEY_READ = KEY_QUERY_VALUE + KEY_ENUMERATE_SUB_KEYS + KEY_NOTIFY + READ_CONTROL


Public Const SM_CYCAPTION = 4
Public Const SM_CXFRAME = 32
Public Const SM_CYFRAME = 33
Public Const SM_CYSMCAPTION = 51
Public Const SM_CYSIZEFRAME = SM_CYFRAME
Public Const SM_CXSIZEFRAME = SM_CXFRAME


'Private Const ModelerHelpFileKey = "Software\Intergraph\Applications\SmartplantPID.Application\Help\HelpFile"
'Private Const ModelerHelpPathKey = "Software\Intergraph\Applications\SmartplantPID.Application\Setup\HelpDir"
Private Const ComponentsHelpKey = "Software\Microsoft\Windows\Html Help"

'Html Help commands
Public Enum HH_COMMAND
    HH_DISPLAY_TOPIC = &H0
    HH_DISPLAY_TOC = &H1
    HH_DISPLAY_INDEX = &H2
    HH_DISPLAY_SEARCH = &H3
    HH_SET_WIN_TYPE = &H4
    HH_GET_WIN_TYPE = &H5
    HH_GET_WIN_HANDLE = &H6
    HH_DISPLAY_TEXT_POPUP = &HE    ' Display string resource ID or text in a pop-up window.
    HH_HELP_CONTEXT = &HF          ' Display mapped numeric value in dwData.
    HH_TP_HELP_CONTEXTMENU = &H10  ' Text pop-up help, similar to WinHelp's HELP_CONTEXTMENU.
    HH_TP_HELP_WM_HELP = &H11      ' text pop-up help, similar to WinHelp's HELP_WM_HELP.
End Enum

'for html popups
Public Type POINTAPI
    x As Long
    y As Long
End Type


Public Type HH_RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Public Type HH_POPUP
    cbStruct As Long          ' size of structure
    hinst As Long             ' instance handle for string resource
    idString As Long          ' string resource id, or text id if pszFile is specified in HtmlHelp call
    pszText As String         ' used if idString is zero
    Pt As POINTAPI            ' top center of popup window
    clrForeground As Long     ' use VB constant
    clrBackground As Long     ' use VB constant
    rcMargins As HH_RECT      ' amount of space between edges of window and text, -1 for each member to ignore
    pszFont As String         ' facename, point size, char set, BOLD ITALIC UNDERLINE
End Type


' copied from MSDN and modified.
Function QueryValueStringEx(ByVal lhKey As Long, ByVal szValueName As String, strValue As String) As Long
     Dim cch As Long
     Dim lrc As Long
     Dim lType As Long
     Dim lValue As Long
     Dim sValue As String

     On Error GoTo errHandler

     ' Determine the size and type of data to be read
     lrc = RegQueryValueExNULL(lhKey, szValueName, 0&, lType, 0&, cch)
     If lrc = ERROR_NONE Then
        sValue = String(cch, 0)
        lrc = RegQueryValueExString(lhKey, szValueName, 0&, lType, _
                sValue, cch)
        If lrc = ERROR_NONE Then
            strValue = Left$(sValue, cch - 1)
        Else
            strValue = ""
        End If
                 
    Else
        strValue = ""
    End If
    
    Exit Function

errHandler:

    LogError "Common - HelpUtils::QueryValueStringEx " & Err.Description
    
End Function

' This is for the manager components as well as for the modeling environment
Public Sub SetHelpFilePath(strHelpFileName As String, Optional strGadgetsTxt As String)

    On Error GoTo errHandler
    
    Dim strFullHelpFilePath As String
    Dim tmpStr As String
    Dim lRetValue As Long
    Dim hKey As Long
    
    'open the specified key
    lRetValue = RegOpenKeyEx(HKEY_LOCAL_MACHINE, ComponentsHelpKey, 0, _
                           KEY_READ, hKey) 'Raj TR fix 11460  'KEY_ALL_ACCESS
    
    If lRetValue = 0 Then
        QueryValueStringEx hKey, strHelpFileName, tmpStr
    
        ' set the app help path and name
        strFullHelpFilePath = tmpStr & "\" & strHelpFileName
        App.HelpFile = strFullHelpFilePath
        
'        If strGadgetsTxt <> "" Then
'            App.HelpFile = App.HelpFile & "::/" & strGadgetsTxt
'        End If
        
        RegCloseKey hKey
    Else
        '   if ComponentsHelpKey cannot be opened, set HelpFile to dummy name
        App.HelpFile = "dummyname.chm"
    End If
    
    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::SetHelpFilePath " & Err.Description
    
End Sub

'This procedure populates the Html Help popup
Public Sub GetHtmlHelpPopup(ByVal lngHelpID As Long, HtmlPopup As HH_POPUP)

    On Error GoTo errHandler

    With HtmlPopup
        .cbStruct = Len(HtmlPopup)
        .idString = lngHelpID
        .clrBackground = -1
        .clrForeground = -1
        With .rcMargins
            .Left = -1
            .Top = -1
            .Bottom = -1
            .Right = -1
        End With
        Call GetCursorPos(HtmlPopup.Pt)
    End With

    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::GetHtmlHelpPopup " & Err.Description
    
End Sub

'Set html help .chm file name and path; display topic for forms
Public Sub GetHtmlHelpTopic(ByVal Form As Form, ByVal strHelpFileName As String, _
   ByVal lngHelpID As Long, Optional strGadgetsTxt As String)
   
    On Error GoTo errHandler
    
    'set file name and path to .chm help file
    Call SetHelpFilePath(strHelpFileName)
    
    If lngHelpID = 0& Then
    
        Call HtmlHelpLong(0, App.HelpFile, HH_DISPLAY_TOPIC, 0&)
    
    Else
        
        Call HtmlHelpLong(0, App.HelpFile, HH_HELP_CONTEXT, lngHelpID)
        
    End If
    
'    'reset help file name for What's This? help functionality
'    If Len(strGadgetsTxt) > 0 Then
'        App.HelpFile = App.HelpFile & "::/" & strGadgetsTxt
'    End If
    
    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::GetHtmlHelpTopic " & Err.Description
    
End Sub

'Set html help gadgets.txt file and path; display popup for forms
Public Sub GetHtmlHelpGadgets(ByVal Form As Form, ByVal strHelpFileName As String, _
   ByVal lngHelpID As Long, ByVal strGadgetsTxt As String)
   
    Dim HtmlPopup As HH_POPUP
   
    On Error GoTo errHandler
    
    Call SetHelpFilePath(strHelpFileName)
    
    'populate html help popup
    Call GetHtmlHelpPopup(lngHelpID, HtmlPopup)
    
'    'set app file name to html help gadgets file
'    App.HelpFile = App.HelpFile & "::/" & strGadgetsTxt
    
    'display popup
    Call HtmlHelpPopup(Form.hwnd, App.HelpFile, HH_DISPLAY_TEXT_POPUP, HtmlPopup)
    
    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::GetHtmlHelpGadgets " & Err.Description

End Sub

'Set html help gadgets.txt file and path; display popup for control
Public Sub GetControlHtmlHelpGadgets(ByVal Ctrl As Control, ByVal strHelpFileName As String, _
   ByVal lngHelpID As Long, ByVal strGadgetsTxt As String)
   
    Dim HtmlPopup As HH_POPUP
   
    On Error GoTo errHandler
    
    Call SetHelpFilePath(strHelpFileName)
    
    'populate html help popup
    Call GetHtmlHelpPopup(lngHelpID, HtmlPopup)
    
'    'set app file name to html help gadgets file
'    App.HelpFile = App.HelpFile & "::/" & strGadgetsTxt
    
    'display popup
    Call HtmlHelpPopup(Ctrl.hwnd, App.HelpFile, HH_DISPLAY_TEXT_POPUP, HtmlPopup)
    
    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::GetControlHtmlHelpGadgets " & Err.Description

End Sub


'Set html help .chm file name and path; display topic for control
Public Sub GetControlHtmlHelpTopic(ByVal Ctrl As Control, ByVal strHelpFileName As String, _
   ByVal lngHelpID As Long, Optional strGadgetsTxt As String)
   
    On Error GoTo errHandler
    
    'set file name and path to .chm help file
    Call SetHelpFilePath(strHelpFileName)
    
    If lngHelpID = 0& Then
    
        Call HtmlHelpLong(0, App.HelpFile, HH_DISPLAY_TOPIC, 0&)
    Else
        
        Call HtmlHelpLong(0, App.HelpFile, HH_HELP_CONTEXT, lngHelpID)
    End If
            
'    'reset help file name for What's This? help functionality
'    If Len(strGadgetsTxt) > 0 Then
'        App.HelpFile = App.HelpFile & "::/" & strGadgetsTxt
'    End If
    
    Exit Sub
    
errHandler:

    LogError "Common - HelpUtils::GetControlHtmlHelpTopic " & Err.Description
    
End Sub

