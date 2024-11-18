VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "NamingRule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************
' Copyright (C) 2001, Intergraph Corporation. All rights reserved.
'
'File
'    NamingRule.cls
'
'Author
'    Usha Kiran
'
'Description
'    Interference Naming Rules implementation.
'
'Notes
'   This Code is delivered to end user so that he can modify the same to change the default behavior
'   of the Rules. Rules decide the name of the Interferences, and Interference detection will trigger the
'   implementation at run time using the progid mentioned in Bulk Load.
' Naming Rule:
'   This rules deals with the naming of an Interference according to the users choice.
'   Users who need a different implementation can either modify the existing code or Totally create a
'   new implementation and mention the progid of the same in Bulk load process. name Rule should
'   implement "IJNameRule" rule on any class and mention the progid of the same in Bulk load
'   process.
' procedure for implementing NamingRules:
'   User need to implement 2 methods in the interface
'   1)  ComputeName:
'       This method gets triggered when interference detection process is about to name an interference.
'       and persists the same name to Database. The main purpose of this method is to allow the user
'       to name an Interfernce to be persisted in Database. Detection process will give the default name of the interference
'       on the IJNamedItem interface of IJIfcEntity(interface to access the properties of Interference).
'   2)  GetNamingParents:
'       This method allows the user to select the parents of Interference so that it can use the names of the
'       parents to construct the name of the interference. This method is not supported currently becuase of the
'       Following Reasons:
'           1) unlike Other objects of Smart plant 3D, Inteference detection has fixed parents.
'              Chaning the parents hence is not necessary.
'           2) Moreover when the name of the parents get changed, Interference detection process by design
'              will not make any effort to recalculate the name, unless it is detected by the running server.
'
'History:
'   20 Dec, 2001 : GUK
'   2  may, 2002 : Added comments and function headers, removed the CoretraderKeys.bas reference.
'   24 July, 2003:RI : Modified for TR 42503(Added method GetNodeName)
'   20 Aug,2003  : RI Modified for TR46790
'  08.SEP.2006     KKC  DI-95670  Replace names with initials in all revision history sheets and symbols
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Rules for Building this Dll in End user builds of Smart plant 3d.
'   1) Click on Project-->References on the Tools bar in vb editor.
'   2) Remove the references of the below mentioned dlls.
'   3) Add the references again depending the machine path for Smart plant 3d.
'   4) Build the project and register the Dll on Interfernece server machine.
'
' Referernce Used in this Class: User neeed to change the refereneces before modifying for the first time
' Reference                                                 Location of Dll(locations may change on machines use the reference names to refer the dlls)
'---------                                                  ---------------
'Ingr SP3D FoulCheck v1.0 Library.                          $Smart Plant3d\CommonSchema\Middle\bin\FoulCheck.dll
'Ingr SmartPlant 3D ICDPInterfaces v 1.0 Library            $Smart Plant3d\Core\Client\Bin\IMSICDPInterfacesTlb.dll
'Ingr SmartPlant 3D Attributes v 1.0 Library                $Smart Plant3d\Core\Middle\Bin\Debug\Attributes.dll
'MetaData 1.0 Type Library                                  $Smart Plant3d\Core\Runtime\Debug\MetaData.dll
'Ingr Sp3d Generic NameRuleSemantics 1.0 Type Library       $Smart Plant3d\CommonApp\Middle\Bin\NameRuleSemantics.dll
'Ingr SmartPlant 3D Entity Support v 1.0 Library            $Smart Plant3d\Core\Middle\Bin\IMSDObject.tlb
'Ingr SmartPlant 3D Core Collections v 1.0 Library          $Smart Plant3d\Core\Shared\Collections\Bin\Debug\CoreCollections.dll
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit
Implements IJNameRule
Private Const MODELDATABASE = "Model"
Private Const CONNECTMIDDLE = "ConnectMiddle"
Private Const DBTYPECONFIG = "DBTypeConfiguration"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJNameRule_ComputeName
'   Desc:
'       Set the name of an interference
'       Inputs: Interference with predefined properties and its parents in a collection
'       Outputs: Name of the Interfernece on IJNamed Item Interface
'   Arguments:
'       pEntity [in]                pointer to IJIfcEntity interface(properties of Interference interface)
'       pParents[in]                pointer to First and second objects(parents) participating in Collision in the form of Collection
'       pActiveEntity[in]           pointer to IJIfcEntity interface(properties of Interference interface)
'   Return Values:
'       Nil
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub IJNameRule_ComputeName(ByVal pEntity As Object, ByVal pParents As IMSICDPInterfacesLib.IJElements, ByVal pActiveEntity As Object)
On Error GoTo ErrorHandler
    Dim oIfcNamedEnt As IJNamedItem
    Dim oParentName As IJNamedItem
    Dim strNodeName As String
    Set oIfcNamedEnt = Nothing
    If pParents.count <= 0 Then
        Exit Sub
    End If
    Dim count As Integer
    Set oIfcNamedEnt = pEntity
    
    If Not oIfcNamedEnt Is Nothing Then
        For count = 1 To pParents.count
           On Error Resume Next
           Set oParentName = pParents.Item(count)
           If Not oParentName Is Nothing Then
              oIfcNamedEnt.Name = oIfcNamedEnt.Name & "-" & oParentName.Name
           Else
              strNodeName = ""
              strNodeName = GetNodeName(pParents.Item(count))
              oIfcNamedEnt.Name = oIfcNamedEnt.Name & "-" & strNodeName
           End If
           Set oParentName = Nothing
        Next count
    End If
Exit Sub
ErrorHandler:
    Debug.Assert False
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJNameRule_GetNamingParents
'   Desc:
'       Set the parents to Interference
'       Inputs: Interference with predefined properties
'       Outputs: objects as parents to interference as collection
'   Arguments:
'       pEntity [in]                pointer to IJIfcEntity interface(properties of Interference interface)
'   Return Values:
'       IMSICDPInterfacesLib.IJElements[out]  Collection of parents.
'   Remarks:
'       This method will not be triggered by Interference detection process.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function IJNameRule_GetNamingParents(ByVal pEntity As Object) As IMSICDPInterfacesLib.IJElements
'Nop
'IFC will get the parents Directly through relations and User is not supposed to modify this
'under any circumstances. In case user requires some additional parents he can very well give
'here but it requires separate TR to be filed on this for default implementation.
    Set IJNameRule_GetNamingParents = Nothing
    Exit Function
End Function
Private Function GetNodeName(ByVal Part As Object) As String
On Error GoTo ErrorHandler
    GetNodeName = ""
    Dim oMetaDataQuery As METADATALib.IJDRepositoryQuery
    Dim oAttributeMetaData As METADATALib.IJDAttributeMetaData
    Dim oClassInfo As IJDClassInfo
    Dim pBOCNode As IJDBOClassificationNode
    Dim ObjCLSID As String
    Dim punk As IUnknown
    Dim pConn As IJDConnection
    Dim pIJDPOM As IJDPOM
    Set pIJDPOM = GetResourceManager()
    If Not pIJDPOM Is Nothing Then
        Set punk = pIJDPOM.GetObjectMoniker(Part)
        ObjCLSID = pIJDPOM.ClsidOf(punk)
    End If
    Set punk = Nothing
    
    Set oMetaDataQuery = pIJDPOM
    If Not oMetaDataQuery Is Nothing Then
        Set oAttributeMetaData = oMetaDataQuery
    End If
    If Not ObjCLSID Like "" Then
        Set oClassInfo = oAttributeMetaData.ClassInfo(ObjCLSID)
    End If
    Set oMetaDataQuery = Nothing
    Set oAttributeMetaData = Nothing
    If Not oClassInfo Is Nothing Then
        Set pBOCNode = oClassInfo.BOClassificationLeafNode
    End If
    Set oClassInfo = Nothing
    If Not pBOCNode Is Nothing Then
        GetNodeName = pBOCNode.UserName
    End If
    Set oClassInfo = Nothing
    Set oMetaDataQuery = Nothing
    Set oAttributeMetaData = Nothing
    Set punk = Nothing
    Set pBOCNode = Nothing
    Set oClassInfo = Nothing
Exit Function
ErrorHandler:
    Err.Clear
    Set oClassInfo = Nothing
    Set oMetaDataQuery = Nothing
    Set oAttributeMetaData = Nothing
    Set punk = Nothing
    Set pBOCNode = Nothing
    Set oClassInfo = Nothing
    Debug.Assert False
End Function


Private Function GetResourceManager() As IUnknown
On Error GoTo ErrHndlr
    Dim strModelDBID As String
    Dim jContext As IJContext
    Dim oDBTypeConfig As IJDBTypeConfiguration
    Dim oConnectMiddle As IJDAccessMiddle    'IJDConnectMiddle
    'Get the middle context
    Set jContext = GetJContext()
    'Get IJDBTypeConfiguration and IJDConnectMiddle from the Context.
    Set oDBTypeConfig = jContext.GetService(DBTYPECONFIG)
    Set oConnectMiddle = jContext.GetService(CONNECTMIDDLE)
    Set jContext = Nothing
    'Get the Model DataBase ID given the database type
    strModelDBID = oDBTypeConfig.get_DataBaseFromDBType(MODELDATABASE)
    'Get ModelDB resource Manager given the DataBase ID
    Set GetResourceManager = oConnectMiddle.GetResourceManager(strModelDBID)
Exit Function
ErrHndlr:
    MsgBox Err.Source & ": " & Trim$(Str$(Err.Number)) & " - " & Err.Description
    Debug.Assert False
End Function

