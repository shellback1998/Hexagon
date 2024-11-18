Attribute VB_Name = "HelpIDs"
'**************************************************
'Modifications:
'   7/5/00      WinHelp to HtmlHelp conversion changes. -- dmw
'**************************************************

Option Explicit

'Command Buttons
Public Const IDH_BTN_COMMON_CLOSE = 1
Public Const IDH_BTN_COMMON_CANCEL = 2
Public Const IDH_BTN_COMMON_OK = 3
Public Const IDH_BTN_COMMON_APPLY = 4
Public Const IDH_BTN_COMMON_HELP = 5
Public Const IDH_BTN_COMMON_Default = 6
Public Const IDH_BTN_COMMON_Browse = 7

'File Menu Commands
Public Const IDH_DLG_FileNew = 34001
Public Const IDH_CBX_FileNew_Templates = 34002
Public Const IDH_RAD_FileNew_NewDocument = 34003
Public Const IDH_RAD_FileNew_NewTemplate = 34004
Public Const IDH_DLG_FileOpen = 34005
Public Const IDH_LBX_FileMenu_Lookin = 34006
Public Const IDH_BTN_FileMenu_UpOneLevel = 34007
Public Const IDH_BTN_FileMenu_CreateNewFolder = 34008
Public Const IDH_BTN_FileMenu_List = 34009
Public Const IDH_BTN_FileMenu_Details = 34010
Public Const IDH_TXT_FileMenu_Filename = 34011
Public Const IDH_LBX_FileMenu_Filetype = 34012
Public Const IDH_TXT_FileMenu_FoldersFilesBox = 34013
Public Const IDH_BTN_FileOpen_Open = 34014
Public Const IDH_DLG_Export = 34015
Public Const IDH_LBX_FileSave_Savein = 34016
Public Const IDH_LBX_FileSave_Saveastype = 34017
Public Const IDH_BTN_FileSave_Save = 34018
Public Const IDH_DLG_FileProperties = 34019
Public Const HIGH_CREATING_DOCUMENTS = 34020

'Page Setup Dialog Box
Public Const IDH_DLG_PageSetup = 110
Public Const IDH_CBX_PageSetup_PaperSize = 34021
Public Const IDH_CBX_PageSetup_Width = 112
Public Const IDH_CBX_PageSetup_Height = 113
Public Const IDH_GRP_PageSetup_Orientation = 114
Public Const IDH_RAD_PageSetup_Portrait = 115
Public Const IDH_RAD_PageSetup_Landscape = 116
Public Const IDH_TXT_PageSetup_Watermark = 121
Public Const IDH_CMD_PageSetup_Browse = 127
Public Const IDH_GRP_PageSetup_ShowWatermark = 122
Public Const IDH_CHK_PageSetup_WhileWorking = 34022
Public Const IDH_CHK_PageSetup_WhilePrinting = 34023
Public Const IDH_DLG_PageSetup_Margins = 130
Public Const IDH_CBX_PageSetup_Top = 34024
Public Const IDH_CBX_PageSetup_Bottom = 132
Public Const IDH_CBX_PageSetup_Left = 34025
Public Const IDH_CBX_PageSetup_Right = 134

'Print Dialog Box
Public Const IDH_DLG_Print = 34026
Public Const IDH_GRP_Print_Printer = 160
Public Const IDH_GRP_Print_PrintRange = 34027
Public Const IDH_GRP_Print_Copies = 34028
Public Const IDH_GRP_Print_Options = 163
Public Const IDH_CBX_Print_Name = 34040
Public Const IDH_CHK_Print_PrintToFile = 142
Public Const IDH_BTN_Print_Properties = 143
Public Const IDH_RAD_Print_Drawing = 145
Public Const IDH_RAD_Print_View = 146
Public Const IDH_CHK_Print_All = 34029
Public Const IDH_CHK_Print_Active = 34030
Public Const IDH_RAD_Print_Selection = 34031
Public Const IDH_CHK_Print_FitToPage = 149
Public Const IDH_RAD_Print_PrintWatermark = 34032
Public Const IDH_CBX_Print_PrintBlackWhite = 151
Public Const IDH_CBX_Print_NumberOfCopies = 34033
Public Const IDH_BTN_Print_Settings = 34034
Public Const IDH_LBL_Print_Status = 34035
Public Const IDH_LBL_Print_Type = 34036
Public Const IDH_LBL_Print_Where = 156
Public Const IDH_LBL_Print_Comment = 34037
Public Const IDH_CHK_Print_Collate = 34038
Public Const HIGH_PRINT_DOCUMENT = 34039

'Edit Menu Commands
Public Const IDH_DLG_EditPasteSpecial = 34101
Public Const IDH_LBL_PasteSpecial_Source = 34102
Public Const IDH_RAD_PasteSpecial_Paste = 34103
Public Const IDH_RAD_PasteSpecial_PasteLink = 34104
Public Const IDH_LBL_PasteSpecial_As = 34105
Public Const IDH_GRP_PasteSpecial_Result = 34106
Public Const IDH_DLG_EditProperties = 34107
Public Const IDH_LBX_Properties_Name = 34108
Public Const IDH_LBX_Properties_Value = 34109
Public Const IDH_DLG_InsertObject = 34110
Public Const HIGH_COPYING_ELEMENTS = 34111
Public Const HIGH_EMBEDDING = 34112
Public Const HIGH_LINKING = 34113
Public Const HIGH_OBJECT_ELEMENT_SELECTION = 34114
Public Const IDH_CMD_EditProperties = 27120

'View Properties Dialog Box
Public Const IDH_DLG_ViewProperties = 34201
Public Const IDH_DLG_ViewProperties_General = 34202
Public Const IDH_DLG_ViewProperties_Display = 34203
Public Const IDH_DLG_ViewProperties_Grid = 34204
Public Const IDH_DLG_ViewProperties_ConsistencyIndicator = 34205
Public Const IDH_TXT_Properties_ViewName = 203006
Public Const IDH_TXT_Properties_Description = 203007
Public Const IDH_LBL_Properties_ViewType = 203008
Public Const IDH_LBX_Properties_Readout = 203009
Public Const IDH_CHK_Properties_Labels = 203010
Public Const IDH_CHK_Properties_DrawingBorder = 203011
Public Const IDH_CHK_Properties_Grids = 203012
Public Const IDH_CHK_Properties_Notes = 203013
Public Const IDH_CHK_Properties_ConsistencyIndicators = 203014
Public Const IDH_CHK_Properties_Display = 203015
Public Const IDH_CHK_Properties_Snap = 203016
Public Const IDH_LBX_Properties_Style = 203017
Public Const IDH_LBX_Properties_Spacing = 203018
Public Const IDH_CBX_Properties_Index = 203019
Public Const IDH_LBX_Properties_Density = 34220
Public Const IDH_CHK_Properties_ErrorsAboveSeverity = 203020
Public Const IDH_CHK_Properties_Warnings = 203021
Public Const IDH_CHK_Properties_ApprovedWarnings = 203022
Public Const IDH_GRP_Properties_OnOff = 34224
Public Const IDH_DLG_ReviewInconsistencies = 180

'Options Dialog Box
Public Const IDH_DLG_ToolsOptions = 34301
Public Const IDH_DLG_ToolsOptionsGeneral = 34302
Public Const IDH_DLG_ToolsOptionsColors = 34303
Public Const IDH_DLG_ToolsOptionsPlacement = 34304
Public Const IDH_DLG_ToolsOptionsFiles = 34305
Public Const IDH_CHK_ToolsGeneral_Updatelinks = 34306
Public Const IDH_CHK_ToolsGeneral_RecentlyUsedFiles = 34307
Public Const IDH_CHK_ToolsGeneral_Displayasprinted = 34308
Public Const IDH_CHK_ToolsGeneral_Showstatusbar = 34309
Public Const IDH_CBX_ToolsColors_Background = 34310
Public Const IDH_CBX_ToolsColors_Highlight = 34311
Public Const IDH_CBX_ToolsColors_SelectedElements = 34312
Public Const IDH_CBX_ToolsColors_Handles = 34313
Public Const IDH_CBX_ToolsPlacement_Construction = 34314
Public Const IDH_CBX_ToolsPlacement_Tolerances = 34315
Public Const IDH_CBX_ToolsPlacement_Locate = 34316
Public Const IDH_CBX_ToolsPlacement_Breakaway = 34317
Public Const IDH_GRP_ToolsFiles_Scalereference = 34318
Public Const IDH_RAD_ToolsFiles_Coincident = 34319
Public Const IDH_RAD_ToolsFiles_SelectScale = 34320
Public Const IDH_RAD_ToolsFiles_CustomScale = 34321
Public Const HIGH_CUSTOMIZATION = 34322
Public Const HIGH_IMPORT_DOCUMENT = 34323

'Reports
Public Const IDH_DLG_ReportNewTemplate = 34401
Public Const IDH_LBX_ReportNewTemplate_SourceTemplate = 34402
Public Const IDH_TXT_ReportNewTemplate_Name = 34403
Public Const IDH_LBX_ReportNewTemplate_ItemType = 34404
Public Const IDH_TXT_ReportNewTemplate_Location = 34405
Public Const IDH_GRP_ReportNewTemplate_ReportType = 34406
Public Const IDH_RAD_ReportNewTemplate_Fixedformat = 34407
Public Const IDH_RAD_ReportNewTemplate_Tabularformat = 34408
Public Const IDH_RAD_ReportNewTemplate_Compositeformat = 34409
Public Const IDH_TXT_ReportNewTemplate_Description = 34433
Public Const IDH_TXT_ReportNewTemplate_Filename = 34434
Public Const IDH_BTN_ReportNewTemplate_Browse = 34465
Public Const IDH_DLG_ReportNewTemplateDirectory = 34446
Public Const IDH_LBX_ReportsDirectoryLookin = 34443
Public Const IDH_CBX_ReportsDirectoryDrives = 34444
Public Const IDH_BTN_ReportsDirectoryNetwork = 34445
Public Const IDH_DLG_ReportEditTemplate = 34410
Public Const IDH_LBX_ReportEdit_AvailableReports = 34411
Public Const IDH_CMD_ReportToolbar_Define = 34462
Public Const IDH_BTN_ReportEdit_Open = 34412
Public Const IDH_BTN_ReportEdit_Properties = 34413
Public Const IDH_DLG_ReportEditNew = 34414
Public Const IDH_DLG_ReportDeleteTemplate = 34415
Public Const IDH_LBX_ReportDelete_AvailableReports = 34416
Public Const IDH_DLG_ReportToolbarDefineReportStructure = 34417
Public Const IDH_LBX_ReportToolbarDefRptStruct_ReportOn = 34418
Public Const IDH_BTN_ReportToolbarDefRptStruct_New = 34419
Public Const IDH_BTN_ReportToolbarDefRptStruct_Define = 34420
Public Const IDH_BTN_ReportToolbarDefRptStruct_Delete = 34421
Public Const IDH_DLG_ReportToolbarDefineNewItems = 34422
Public Const IDH_LBX_ReportToolbarDefineNewItems_Items = 34423
Public Const IDH_LBX_ReportToolbarDefineNewItems_Name = 34424
Public Const IDH_BTN_ReportToolbarDefineNewItems_Apply = 34425
Public Const IDH_DLG_ReportToolbarDefineReportItems = 34426
Public Const IDH_DLG_ReportToolbarDefineReportItemsFields = 34427
Public Const IDH_LBX_ReportToolbarFieldsTab_DatabaseFields = 34447
Public Const IDH_LBX_ReportToolbarFieldsTab_SelectedFields = 34448
Public Const IDH_BTN_ReportToolbarFieldsTab_Add = 34449
Public Const IDH_BTN_ReportToolbarFieldsTab_Remove = 34450
Public Const IDH_DLG_ReportToolbarDefineReportItemsSort = 34428
Public Const IDH_LBX_ReportToolbarSortTab_DatabaseFields = 34451
Public Const IDH_LBX_ReportToolbarSortTab_SortFields = 34452
Public Const IDH_BTN_ReportToolbarSortTab_Add = 34453
Public Const IDH_BTN_ReportToolbarSortTab_Remove = 34454
Public Const IDH_CBX_ReportToolbarSortTab_Order = 34455
Public Const IDH_DLG_ReportToolbarDefineReportItemsFilter = 34429
Public Const IDH_TXT_ReportToolbarDefineReportItemsFilter_Appliedfilter = 34456
Public Const IDH_BTN_ReportToolbarDefineReportItemsFilter_Browse = 34457
Public Const IDH_DLG_ReportToolbarDefineReportItemsTotals = 34430
Public Const IDH_LBX_ReportToolbarTotalsTab_DatabaseFields = 34458
Public Const IDH_LBX_ReportToolbarTotalsTab_GroupFields = 34459
Public Const IDH_BTN_ReportToolbarTotalsTab_Add = 34460
Public Const IDH_BTN_ReportToolbarTotalsTab_Remove = 34461
Public Const IDH_CMD_ReportToolbar_Format = 34431
Public Const IDH_TXT_FormatSkiprowsbetweenlines = 34463
Public Const IDH_TXT_FormatRowsinheaderreport = 34464
Public Const IDH_CMD_ReportToolbar_MapAttributes = 34432
Public Const IDH_DLG_ReportSelectionCriteria = 34466
Public Const IDH_GRP_ReportSelectionCriteriaReportusing = 34467
Public Const IDH_RAD_ReportSelectionCriteriaCurrentSelection = 34468
Public Const IDH_RAD_ReportSelectionCriteriaEntiretable = 34469
Public Const IDH_RAD_ReportSelectionCriteriaEntiredrawing = 34470
Public Const IDH_CHK_ReportToolbarFieldsTab_Groupdatausingthesefields = 34471

'Window and Table Properties
Public Const IDH_Windows_HIGH = 34501
Public Const IDH_DLG_TableProperties = 34502
Public Const IDH_DLG_AdvTableProperties = 34503
Public Const IDH_DLG_AdvTablePropFilter = 34504
Public Const IDH_DLG_AdvTablePropLayout = 34505
Public Const IDH_CBX_TableProp_ItemType = 34506
Public Const IDH_CBX_TableProp_Filter = 34507
Public Const IDH_CBX_TableProp_Layout = 34508
Public Const IDH_BTN_TableProp_Advanced = 34509
Public Const IDH_GRP_AdvTablePropF_Name = 34510
Public Const IDH_CHK_AdvTablePropF_Default = 34511
Public Const IDH_BTN_AdvTablePropF_Save = 34512
Public Const IDH_BTN_AdvTablePropF_NameDelete = 34513
Public Const IDH_GRP_AdvTablePropF_Definition = 34514
Public Const IDH_OPT_AdvTablePropF_MatchAll = 34515
Public Const IDH_OPT_AdvTablePropF_MatchAny = 34516
Public Const IDH_BTN_AdvTablePropF_Add = 34517
Public Const IDH_BTN_AdvTablePropF_DefinitionDelete = 34518
Public Const IDH_GRP_AdvTablePropF_Edit = 34519
Public Const IDH_CBX_AdvTablePropF_Attribute = 34520
Public Const IDH_CBX_AdvTablePropF_Operator = 34521
Public Const IDH_CBX_AdvTablePropF_Value = 34522
Public Const IDH_CBX_AdvTablePropL_Name = 34523
Public Const IDH_CHK_AdvTablePropL_Default = 34524
Public Const IDH_BTN_AdvTablePropL_Save = 34525
Public Const IDH_BTN_AdvTablePropL_NameDelete = 34526
Public Const IDH_GRP_AdvTablePropL_Definition = 34527
Public Const IDH_CBX_AdvTablePropL_DisplayAttribute = 34528
Public Const IDH_CBX_AdvTablePropL_Caption = 34529
Public Const IDH_BTN_AdvTablePropL_Add = 34530
Public Const IDH_BTN_AdvTablePropL_Insert = 34531
Public Const IDH_BTN_AdvTablePropL_DefinitionDelete = 34532
Public Const IDH_BTN_AdvTablePropL_MoveUp = 34533
Public Const IDH_BTN_AdvTablePropL_MoveDown = 34534
Public Const IDH_CBX_AdvTablePropL_SortAttribute = 34535
Public Const IDH_CBX_AdvTablePropL_Attribute = 34536
Public Const IDH_CBX_AdvTablePropL_Order = 34537
Public Const IDH_CBX_AdvTablePropL_Type = 34538
Public Const IDH_GRP_AdvTablePropL_Edit = 34539
Public Const IDH_CMD_OfficeCompatible_MsOffice = 34601
Public Const IDH_CMD_OfficeCompatible_Features = 34602
Public Const IDH_CMD_OfficeCompatible_UsingSmartPlantPID = 34603
Public Const HIGH_USING_APP_WITH_MS_OFFICE = 34604
Public Const HIGH_MS_OFFICE_COMPATIBLE = 34605
Public Const HIGH_INTELLIMOUSE = 34606
Public Const HIGH_USER_ASSISTANCE = 34607
Public Const HIGH_INTERNET = 34608
Public Const HIGH_PIRATE = 34609
Public Const IDH_CMD_EngineeringDataEditor = 34847
Public Const IDH_DLG_CustomAutoFilter = 34612

'Stockpile
Public Const IDH_DLG_StockpileColumnOrganizer = 34700
Public Const IDH_TXT_StockpileColumnOrganizerAvailable = 34701
Public Const IDH_TXT_StockpileColumnOrganizerDisplayed = 34702
Public Const IDH_BTN_StockpileColumnOrganizerRightarrow = 34703
Public Const IDH_BTN_StockpileColumnOrganizerLeftarrow = 34704
Public Const IDH_BTN_StockpileColumnOrganizerUparrow = 34705
Public Const IDH_BTN_StockpileColumnOrganizerDownarrow = 34706
Public Const IDH_StockpileWindowShortcutMenu = 34708
Public Const IDH_CMD_StockpileShortcutmenuSelectall = 34709
Public Const IDH_CMD_StockpileShortcutmenuLargeicons = 34710
Public Const IDH_CMD_StockpileShortcutmenuSmallicons = 34711
Public Const IDH_CMD_StockpileShortcutmenuList = 34712
Public Const IDH_CMD_StockpileShortcutmenuDetails = 34713

'Filters
Public Const IDH_CMD_AddFilter = 34714
Public Const IDH_DLG_FilterFinder = 34715
Public Const IDH_TXT_FilterFinder_TreeViewBox = 34716
Public Const IDH_BTN_FilterFinder_New = 34717
Public Const IDH_BTN_FilterFinder_Properties = 34718
Public Const IDH_RAD_NewFilter_Simplefilter = 34719
Public Const IDH_RAD_NewFilter_Compoundfilter = 34720
Public Const IDH_DLG_FilterFinder_NewFilter = 34721
Public Const HOW_AddFilter = 34722
Public Const IDH_RAD_PageSetup_Standard = 34723
Public Const IDH_RAD_PageSetup_Custom = 34724
Public Const IDH_TXT_ToolsFiles_MyReports = 34725
Public Const IDH_TXT_Properties_PreventSelection = 34726
Public Const IDH_BTN_ReportNewTemplate_Addtoprojectreport = 34727
Public Const IDH_LBX_FileOpen_LookHierarchy = 34728
Public Const IDH_LBL_FileOpen_DrawingName = 34729
Public Const IDH_LBL_FileOpen_Description = 34730
Public Const IDH_BOX_FileMenu_FoldersFilesBox = 34731

'Consistency Checker
Public Const IDH_DLG_ConsistencyCheck = 34732
Public Const IDH_GRP_ConsistencyCheck_Inconsistency = 34733
Public Const IDH_TXT_ConsistencyCheck_Inconsistency = 34734
Public Const IDH_CHK_ConsistencyCheck_Item1 = 34735
Public Const IDH_CHK_ConsistencyCheck_Item2 = 34736
Public Const IDH_GRP_ConsistencyCheck_PossibleSolutions = 34737
Public Const IDH_LST_ConsistencyCheck_PossibleSolutions = 34738
Public Const IDH_CHK_ConsistencyCheck_ApproveWarning = 34739
Public Const IDH_LBX_ReportEditProperties_SourceTemplate = 34815
Public Const IDH_TXT_ReportEditProperties_Name = 34816
Public Const IDH_LBX_ReportEditProperties_ItemType = 34817

'Edit Menu Commands
Public Const IDH_CMD_Export = 34740
Public Const IDH_CMD_FileProperties = 40001
Public Const IDH_CMD_FileSend = 34742
Public Const IDH_CMD_EditCut = 57635
Public Const IDH_CMD_EditCopy = 57634
Public Const IDH_CMD_EditPaste = 57637
Public Const IDH_CMD_EditDelete = 27122
Public Const IDH_CMD_EditSelectAll = 27121
Public Const IDH_CMD_EditLinks = 57857
Public Const IDH_CMD_SPPIDSymbolObject = 57872
Public Const IDH_DLG_MoveToDrawing = 10954

'View Menu Commands
Public Const IDH_CMD_ViewPrevious = 10200
Public Const IDH_CMD_ViewZoomArea = 10214
Public Const IDH_CMD_ViewZoomIn = 10216
Public Const IDH_CMD_ViewZoomOut = 10217
Public Const IDH_CMD_ViewFit = 10202
Public Const IDH_CMD_ViewPan = 10215
Public Const IDH_CMD_ViewShowGrid = 10205
Public Const IDH_CMD_ViewSnapGrid = 10206
Public Const IDH_CMD_ViewProperties = 27142
Public Const IDH_CMD_WindowTileHorizon = 57651
Public Const IDH_CMD_WindowTileVertical = 57652
Public Const IDH_CMD_HelpLateNews = 34761
Public Const IDH_CMD_Print = 34762
Public Const IDH_CMD_EditMove = 10930
Public Const IDH_CMD_EditRotate = 10929
Public Const IDH_CMD_EditMirror = 10931
Public Const IDH_CMD_SelectTool = 57082
Public Const IDH_DLG_SelectToolrb = 137080
Public Const IDH_BTN_ReportToolbarSortTab_Moveup = 34768
Public Const IDH_BTN_ReportToolbarSortTab_Movedown = 34769
Public Const IDH_CMD_FileSave = 57603
Public Const IDH_DLG_FileSave = 34771
Public Const IDH_CMD_FileSaveAs = 27106 '57604 (old number)
Public Const IDH_CMD_ViewSaveSettings = 27147

'Compound Filters
Public Const IDH_DLG_CompoundFilterProperties = 34773
Public Const IDH_TXT_CompoundFilterProperties_Name = 34775
Public Const IDH_TXT_CompoundFilterProperties_Comments = 34776
Public Const IDH_GRP_CompoundFilterProperties_FilterMethod = 34777
Public Const IDH_OPT_CompoundFilterProperties_MatchAll = 34778
Public Const IDH_OPT_CompoundFilterProperties_MatchAny = 34779

'Filter Properties
Public Const IDH_DLG_FilterProperties = 34780
Public Const IDH_TXT_FilterProperties_Name = 34781
Public Const IDH_TXT_FilterProperties_Description = 34782
Public Const IDH_CBX_FilterProperties_FilterFor = 34783
Public Const IDH_GRP_FilterProperties_FilterMethod = 34784
Public Const IDH_OPT_FilterProperties_MatchAll = 34785
Public Const IDH_OPT_FilterProperties_MatchAny = 34786
Public Const IDH_GRP_FilterProperties_Edit = 34787
Public Const IDH_GRD_FilterProperties_FilterCriteria = 34788
Public Const IDH_CBX_FilterProperties_Attribute = 34789
Public Const IDH_CBX_FilterProperties_Operator = 34790
Public Const IDH_CBX_FilterProperties_Value = 34791
Public Const IDH_BTN_FilterProperties_Add = 34792
Public Const IDH_BTN_FilterProperties_Delete = 34793
Public Const IDH_GRP_FilterProperties_Definition = 34794
Public Const IDH_TXT_FilterProperties_Comments = 34795

'Miscellaneous
Public Const IDH_CHK_ReportToolbarFieldsTab_Repeatparentfields = 34796
Public Const HIDD_TIP_OF_THE_DAY = 1008
Public Const IDH_BTN_StockpileColumnOrganizerProject = 34798
Public Const IDH_BTN_StockpileColumnOrganizerDrawing = 34799
Public Const IDH_CMD_EditUndo = 34801
Public Const IDH_CMD_InsertImage = 10303
Public Const IDH_CMD_DocumentList = 57616
Public Const IDH_CMD_HelpRegisterSPPID = 40034
Public Const IDH_CBX_InconsistencyIndicators_InconsistencyType = 34805
Public Const IDH_GRP_InconsistencyIndicators_Indicator = 34806
Public Const IDH_CMD_ViewCatalogExplorer = 34807
Public Const IDH_CMD_ViewStockpile = 34809
Public Const IDH_GRP_MyReportGadget = 27900
Public Const IDH_GRP_MyProjectGadget = 27800
Public Const IDH_CMD_WindowDrawing = 34810
Public Const IDH_CMD_WindowTable = 34811
Public Const IDH_CMD_InsertObject = 34812
Public Const IDH_CMD_ViewPropertiesGrid = 34813
Public Const IDH_CMD_ReportsMoreReports = 34818
Public Const IDH_DLG_ReportsMoreReports = 34819
Public Const IDH_LBX_ReportsMoreReports = 34820
Public Const IDH_DLG_PropertiesDescription = 34821
Public Const IDH_CMD_ToolsGapNow = 34822
Public Const IDH_CMD_SPPIDSymbolObjOpen = 57873
Public Const HID_HELP_TOPICS = 57666
Public Const HID_TIP_OF_THE_DAY = 10702
Public Const HID_INTERNET_COMMUNITY = 40033

Public Const IDH_CMD_StockpileShortcutmenuDelete = 34823
Public Const IDH_CMD_StockpileShortcutmenuDrawing = 34824
Public Const IDH_CMD_StockpileShortcutmenuPlant = 34825
Public Const IDH_CMD_StockpileShortcutmenuProperties = 34826
Public Const IDH_CMD_StockpileShortcutmenuSaveSettings = 34827
Public Const IDH_CHK_Properties_FilterLabels = 34828
Public Const IDH_CHK_ReportToolbarFieldsTab_Shorttextvalue = 34829

Public Const IDH_RAD_RecreateOnly = 34830
Public Const IDH_RAD_RecreateAll = 34831
Public Const IDH_RAD_RecreateNew = 34832
Public Const IDH_CMD_Import = 34833
Public Const IDH_DLG_SmartSketchWizard = 27181
Public Const IDH_TXT_PropertiesDescription = 34835

Public Const IDH_TXT_AddFilterTab_Filtername = 34836
Public Const IDH_BTN_AddFilterTab_Browse = 34837
Public Const IDH_BTN_AddFilterTab_Parameters = 34838
Public Const IDH_LBX_AddFilterTab_Color = 34839
Public Const IDH_LBX_AddFilterTab_Width = 34840
Public Const IDH_TXT_OldSymbolSource = 34841
Public Const IDH_TXT_NewSymbolSource = 34842
Public Const IDH_DLG_ReportEditProperties = 34814
Public Const IDH_LBX_StockpileSelectDrawing = 34843

Public Const IDH_LBX_Usage = 34844

Public Const IDH_HIGH_CatalogExplorer = 34845
Public Const IDH_ModelerOverview_Properties_HIGH = 34846
Public Const IDH_WorkWithStockpileView_HIGH = 34847
Public Const IDH_LBX_PipingMaterialsClass = 34850

Public Const IDH_BTN_Categorized = 34851
Public Const IDH_BTN_Alphabetic = 34852
Public Const IDH_BTN_ShowBriefProperties = 34853
Public Const IDH_BTN_CopyBulkProperties = 34854
Public Const IDH_BTN_PasteBulkProperties = 34855
Public Const IDH_BTN_DisplayNull = 34856
Public Const IDH_BTN_ShowCaseData = 34857


Public Const IDH_ModelerOverview_HIGH = 131073

Public Const CONST_strHelpFileName As String = "SPPIDHelp.chm"
Public Const CONST_strGadgetsTxt As String = "SPPIDGadgets.txt"

