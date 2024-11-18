Attribute VB_Name = "CorePreferences"
Option Explicit
''///////////////////////////////////////////////////////////////////////////////////
''// Core Supported Preferences
''//    string constants for the preferences manager - changed within
''//    the tools/options command
''///////////////////////////////////////////////////////////////////////////////////

'Double - milliseconds - used by QuickPick
Public Const TKCorePrefOptionsViewDwellTime = "PrefOptionsViewDwellTime"

'Boolean - set by SelectCmd true when InsideFence set on ribbon bar
Public Const TKCorePrefIsInsideFence = "PrefSelectIsInsideFence"

'Long - used by SelectCmd for HiLight color
Public Const TKCoreColorHighlight = "PrefOptionsColorHighlight"

'String - used by SelectCmd for last selected filter name
Public Const TKCoreSelectFilterName = "task.PrefSelectFilterName"

Public Const TKCorePrefOptionsLocateZone = "PrefOptionsLocateZone"

'Added for preference color change -RZ 8/30/2000
Public Const TKPrefOptionsColorSelected = "PrefOptionsColorSelected"

'background color for new views jjh 2-Apr-2001
Public Const TKCorePrefOptionsColorBackground = "PrefOptionsColorBackground"

'Moved from CommonApp to Core to be able to retrive in file\SaveAs dyang 12/6/02
Public Const TKCorePrefOptionsSessionFilePath = "PrefOptionsDirWorkspace"

