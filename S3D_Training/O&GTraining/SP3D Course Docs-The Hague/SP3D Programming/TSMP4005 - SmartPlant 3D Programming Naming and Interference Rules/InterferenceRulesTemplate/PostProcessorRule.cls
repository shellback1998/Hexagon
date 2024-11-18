VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ProcessorRule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************
' Copyright (C) 2001, Intergraph Corporation. All rights reserved.
'
'File
'    PostProcessorRule.cls
'
'Author
'    GUK
'
'Description
'    Interference Processor Rules implementation.
'
'Notes
'   This Code is delivered to end user so that he can modify the same to change the default behavior
'   of the Rules. There are 3 kinds of Rules so far, and Interference detection will trigger the
'   implementation at run time using the progid mentioned in Bulk Load.
' Pre Processor Rule:
'   ProcessObject
'   This Rule will be called by the Remote engine after it updates the Range in the
'   spatial index. The object under processing and the Object type are sent as arguments
'   and this Rule returns variant_true or false. Based on this the object is either
'   ignored or considered further.
'   If the user does not implement this Rule then every object will be processed by default.
'   By default all the Plate system objects are ignored. The user can modify this and also
'   ignore specific objects base on the object sent in
' Processor Rule:
'   This rules deals with the Creation and modification of Interference according to the users choice.
'   Users who need a different implementation can either modify the existing code or Totally create a
'   new implementation and mention the progid of the same in Bulk load process. Processor Rule should
'   implement "IJDInterferenceRule" rule on any class and mention the progid of the same in Bulk load
'   process.
' Types of Processor Rules:
'   There are 3 kinds of methods in processor Rules and they are the following.
'   1)  CreateInterference:
'       This rule gets triggered just after Interference detection detects an Interference and just before
'       persisting the same to Database. The main purpose of this rule is to decide whether user really
'       needs this Interfernce to be persisted in Database. Industry practice is not to report the
'       Insulation and insulation interferences when 2 pipes are connected by an Elbow. Inputs and
'       outputs of the this rules is directly mentioned in the header section of the  method
'       "IJDInterferenceRule_CreateInterference". This rule will also allow to put the user notes and
'       user can choose his own status for the interference.
'       Once the user chooses this particular interference to be recorded in the database, he/she may also need to
'       assign the proper permission group for the same.
'       user may also need  to initialize the below with proper permission group names.
'       m_strPermissionGroups(0) = Name of Supports Related Permission Group
'                                  created by user. Default name is "IFC Supports"
'       m_strPermissionGroups(1) = Name Conduit Related Permission Group
'                                   created by user. Default is "IFC Conduits"
'       m_strPermissionGroups(2) = Name Cableway Related Permission Group
'                                   created by user. Default name is "IFC Cableway"
'       m_strPermissionGroups(3) = Name HVAC Related Permission Group
'                                   created by user. Default name is "IFC HVAC"
'       m_strPermissionGroups(4) = Name Piping Related Permission Group
'                                   created by user. Default name is "IFC Piping"
'       m_strPermissionGroups(5) = Name Structure Related Permission Group
'                                   created by user. Default name is  "IFC Structure"
'       m_strPermissionGroups(6) = Name Equipment Related Permission Group
'                                   created by user. Default name is "IFC Equipment"
'       m_strPermissionGroups(7) = Name Interference volumes Related Permission Group
'                                   created by user. Default name is "IFC Volumes"
'       User should interpret the above in the following way.
'       The above list of permission groups are according to the above rank. when an interference
'       happens with 2 different objects, Interference is recorded in the lowest rank of interfering objects.
'       there by people who are incharge of the same will correct them accordingly.
'
'   2)  ModifyInterference:
'       This gets triggered when Interference detection process is trying to modify an interference,
'       because of modification of the parts participating in the collision. Default implementation
'       just changes the status and Notes of an interfernece. Rule gives both Old and New interference
'       with all the properties. User can see their properties and change / add /remove Notes and status
'       of an interference.
'   3)  GetValidPhysicalRepresentation:
'       Interference detection uses aspects while Colliding an object with other objects in Database.
'       Incase Detection process finds an object which has 2 physical representations, process will
'       ask the end user to choose the proper representation to be used for that type of object in collision
'       purposes. User has to mention the aspect required to be used. Default implementation takes "Detailed
'       Physical Aspect" for the collision purposes.
' Post Processor Rule:(NONE)
'History:
'   20 Dec, 2001 : GUK
'   2  may, 2002 : Added comments and function headers, removed the CoretraderKeys.bas reference.
'   18 Aug, 2003 : RI --Modified for TR 46564
'   15 Sept, 2003 : RI --Modified for CR 48418
'   17 Sept, 2003 : RI --Modified for TR 48650
'   17 Oct, 2003 : RI --Modified for TR 50573 & 50672
'   5 Nov, 2003 : RI --Modified for TR 51739
'   26 Nov, 2004 : RI --Modified for DI 67515
'   16th Mar, 2005 : RI --modified for TR 73807
'   1st May, 2006 : JP  --Modified for TR 97083
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
'Ingr SmartPlant 3D ApplicationContextSupport v 1.0 Library $Smart Plant3d\Core\Client\Bin\Debug\ApplicationContextSupport.dll
'Ingr Sp3d MiddleContextProj Type Library v1.0              $Smart Plant3d\CommonApp\Middle\Bin\Debug\GSCADMiddleContextProj.dll
'Ingr Smart plant 3D POM (Persistent Object manager)-       $Smart Plant3d\Core\Middle\Bin\Debug\ResPom.dll
'v 1.0 Library
'Ingr Smart plant 3D Server Context support v1.0 Library    $Smart Plant3d\Core\runtime\Debug\ServerContextSupport.dll
'Ingr Smart plant 3D ConnectMiddle V.10 Library             $Smart Plant3d\Core\Middle\Bin\Debug\IMSConnectMiddle.dll
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit
Private Const SMALL_VALUE = 0.00001 ' For comparing Double values
Implements IJDInterferenceRule      ' Rule implementing Interface.
Implements IJDInterferencePrePrcsrRule   ' Pre Processor Rule
Private m_strPermissionGroups() As String
Private Const MODELDATABASE = "Model"
Private Const CONNECTMIDDLE = "ConnectMiddle"
Private Const DBTYPECONFIG = "DBTypeConfiguration"


Private Sub Class_Initialize()
On Error GoTo ErrorHandler
    
    'Initialize the permission groups to default groups. The end user can add new permission
    'groups to the array and redim the variable
    ReDim m_strPermissionGroups(8) As String
    m_strPermissionGroups(0) = "IFC Supports"
    m_strPermissionGroups(1) = "IFC Conduits"
    m_strPermissionGroups(2) = "IFC Cableway"
    m_strPermissionGroups(3) = "IFC HVAC"
    m_strPermissionGroups(4) = "IFC Piping"
    m_strPermissionGroups(5) = "IFC Structure"
    m_strPermissionGroups(6) = "IFC Equipment"
    m_strPermissionGroups(7) = "IFC Volumes"
    
    Exit Sub
ErrorHandler:
    Debug.Assert False
End Sub

Private Sub Class_Terminate()
    'Release the Service.
End Sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJDIfcPreProcessorRule_ProcessObject
'Desc:
'       Decide whether to Process the object or not.
'       Inputs: The object under process and its object type.
'
'Arguments:
'       pObject [in]                Pointer to object being processed
'       strObjectType[in]           Object Type of object participating in Collision
'    Return Values:
'       Boolean[out]       True means Object is considered for further False means donot.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function IJDInterferencePrePrcsrRule_ProcessObject(ByVal pObject As Object, _
                                        ByVal strObjectType As String) As Boolean
On Error GoTo ErrorHandler
    'by default Rule will process the object the Interfernece
    IJDInterferencePrePrcsrRule_ProcessObject = True
    On Error Resume Next
    On Error GoTo ErrorHandler
    
'    The follwoing is the way to ignore objects based on the ObjectType. The below
'    code ignores  PlateSystem objects. Change the strObjectType to ignore some other
'    objects

'''    If strObjectType Like "Plate System" Then
'''        IJDInterferencePrePrcsrRule_ProcessObject = False
'''    End If
Exit Function
ErrorHandler:
    'Just incase there is a failure.
    Err.Clear
    Debug.Assert False
    IJDInterferencePrePrcsrRule_ProcessObject = True
End Function
Private Sub AssignIFCPermissionGroup(ByVal pNewInterference As _
                GSCADFoulCheck.IJIfcEntity, ByVal strParentType1 As String, ByVal _
                strParentType2 As String)
On Error GoTo ErrorHandler
    Dim strInterferencePG As String
    Dim nPGNumber As Long
    Dim pObject As IJDObject
    Dim PGIndexObj1 As Long
    Dim PGIndexObj2 As Long
    PGIndexObj1 = PGIndexObj2 = -1
    strInterferencePG = ""
    'Set the permission groups based on the Object types
    PGIndexObj1 = GetPermissionGroupIndex(strParentType1)
    PGIndexObj2 = GetPermissionGroupIndex(strParentType2)
    If ((PGIndexObj1) <> -1 And (PGIndexObj2 <> -1)) Then
        If PGIndexObj1 < PGIndexObj2 Then
            strInterferencePG = m_strPermissionGroups(PGIndexObj1)
        Else
            strInterferencePG = m_strPermissionGroups(PGIndexObj2)
        End If
    Else
        If ((PGIndexObj1 = -1) And (PGIndexObj2 = -1)) Then
            Exit Sub
        Else
            If (PGIndexObj1 = -1) Then
                strInterferencePG = m_strPermissionGroups(PGIndexObj2)
            Else
                strInterferencePG = m_strPermissionGroups(PGIndexObj1)
            End If
        
        End If
    End If
    
    Set pObject = pNewInterference
    nPGNumber = ConvertPGNameToNumber(strInterferencePG)
    
    If ((Not pObject Is Nothing) And (nPGNumber <> 0)) Then
        pObject.PermissionGroup = nPGNumber
    Else
        'No need to set any permission grp. Ifc object will exist in the group in
        'which it was created
    End If
    Set pObject = Nothing
    Exit Sub
ErrorHandler:
    'Just incase there is a failure.
    Err.Raise Err.Number
    Debug.Assert False
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJDInterferenceRule_CreateInterference
'   Desc:
'       Decide on whether to create an interference or not.
'       Inputs: Interference with predefined properties, its parent types and parents
'       Outputs: Modified properties on Interference Object.
'                Boolean Variable through method itself deciding factor to create an interference or not.
'   Arguments:
'       IfcType [in]                InterferenceCatogory
'       pInterferenceObj[in, out]   pointer to IJIfcEntity interface(properties of Interference interface)
'       strParentType1[in]          Type of first Parent participating in Collision
'       strParentType2[in]          Type of second Parent participating in Collision
'       pParent1[in]                pointer to First object(parent) participating in Collision
'       pParent2[in]                pointer to second object(parent) participating in Collision
'   Return Values:
'       Boolean[out]                True means create Interference.
'                                   False means donot create interference
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function IJDInterferenceRule_CreateInterference(ByVal IfcType As GSCADFoulCheck.InterferenceCategory, _
                                                        ByVal pInterferenceObj As GSCADFoulCheck.IJIfcEntity, _
                                                        ByVal strParentType1 As String, ByVal strParentType2 _
                                                        As String, ByVal pParent1 As Object, ByVal pParent2 _
                                                        As Object, ByVal eCollisionType As IfcCollisionType) As Boolean

On Error GoTo ErrorHandler
    'by default Rule will Create the Interfernece
    IJDInterferenceRule_CreateInterference = True
    Dim bChkInsulationFilter As Boolean
    bChkInsulationFilter = False
    'Check the Category of Interference. if it is unknown type then exit with out doing any thing.
    If IfcType = IfcUnknownInterfernece Then
        'The following means interference is not created
        IJDInterferenceRule_CreateInterference = False
        Exit Function
    End If
    
    If (AreBothImportedObjects(pParent1, pParent2)) Then
        IJDInterferenceRule_CreateInterference = False
        Exit Function
    End If

'    If IfcType = IfcServerInterference Then
'    'assign a permission group to the IFC object based on rule
'        AssignIFCPermissionGroup pInterferenceObj, strParentType1, strParentType2
'    End If
    'Set the user properties to Server interferences.
    If IfcType = IfcServerInterference Then
        If pInterferenceObj.InterferenceType = ftSevereFoul Then
            pInterferenceObj.InterferenceStatus = fsUnacceptableFoul
        ElseIf pInterferenceObj.InterferenceType = ftOptionalFoul Then
            pInterferenceObj.InterferenceStatus = fsUndefinedFoul
        ElseIf pInterferenceObj.InterferenceType = ftClearanceFoul Then
            pInterferenceObj.InterferenceStatus = fsAcceptableFoul
        Else 'It is a Bad part foul
            pInterferenceObj.InterferenceStatus = fsUnacceptableFoul
        End If
    End If
    ' if parent types are not same then exit let system create interference
    If (strParentType1 <> strParentType2) Then
        Exit Function
    Else
        'We generate Interference between any of the objects unless it is Pipes
        'future test for Ducts and Cables parts.
        If Not (strParentType1 Like "Pipes") Then
            'assign a permission group to the IFC object based on rule
            Exit Function
        End If
        'Check for insulation and insulation aspect.
        If pInterferenceObj.InterferenceAspectA = pInterferenceObj.InterferenceAspectB Then
            'Check whether this aspect is insulation aspect or not
            If GetAspectName(pInterferenceObj.InterferenceAspectA) Like "Insulation" Then
                ' Is Pipes are connected by an Elbow? if yes then donot create interference
                bChkInsulationFilter = IsConnectedbyIntermediate(pParent1, pParent2)
                If bChkInsulationFilter = True Then
                    IJDInterferenceRule_CreateInterference = False
                    Exit Function
                Else 'Pipes are not connected through elbow-->Create interference
                    IJDInterferenceRule_CreateInterference = True
                    Exit Function
                End If
            End If
        End If
    End If
Exit Function
ErrorHandler:
    'Just incase there is a failure.
    Err.Raise Err.Number
    Debug.Assert False
    pInterferenceObj.InterferenceRemark = "Problem in the VB rule"
    pInterferenceObj.InterferenceStatus = fsUndefinedFoul
    ' Still create the interference
    IJDInterferenceRule_CreateInterference = True
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJDInterferenceRule_GetValidPhysicalRepresentation
'   Desc:
'       Decide on what physical aspect to choose for Collision puproses.
'       Inputs: Type of Object dealing with, Value of the Supported physical multiple
'               physical aspects of the object
'       Output: Aspect Code of the required aspect.
'
'   Arguments:
'       strObjectType[in]           Type of the object which supports multiple physical aspects
'
'   Return Values:
'       long[out]                Aspect to be used for Collision purposes.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function IJDInterferenceRule_GetValidPhysicalRepresentation(ByVal strObjectType As String, ByVal SupportedPhysicalReps As Long) As Long
On Error GoTo ErrorHandler
    'Kept a check for Pipe Supports as Detailed physical aspect Geometry is not good.
    If ((strObjectType Like "Pipe Supports") Or (strObjectType Like "Duct Supports") Or (strObjectType Like "Cable Tray Supports")) Then
        IJDInterferenceRule_GetValidPhysicalRepresentation = GetAspectCode("Simple physical")
    Else
        IJDInterferenceRule_GetValidPhysicalRepresentation = GetAspectCode("Detailed physical")
    End If
Exit Function
ErrorHandler:
    Debug.Assert False
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IJDInterferenceRule_ModifyInterference
'   Desc:
'       Modify the properties of an Interference.
'       Inputs: new and old Interferences with predefined properties, its parent types and parents
'       Outputs: Modified new interference properties on new Interference Object.
'
'   Arguments:
'       IfcType [in]                InterferenceCatogory
'       pNewInterference[in, out]   pointer to IJIfcEntity interface(properties of Interference interface)
'       pOldInterference[in]        pointer to IJIfcEntity interface(properties of Interference interface)
'       strParentType1[in]          Type of first Parent participating in Collision
'       strParentType2[in]          Type of second Parent participating in Collision
'   Return Values:
'       pNewInterference[out]       With new modified properties set.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Sub IJDInterferenceRule_ModifyInterference(ByVal IfcType As GSCADFoulCheck.InterferenceCategory, _
                                                   ByVal pNewInterference As GSCADFoulCheck.IJIfcEntity, _
                                                   ByVal pOldInterference As GSCADFoulCheck.IJIfcEntity, _
                                                   ByVal strParentType1 As String, ByVal strParentType2 As String)
On Error GoTo ErrHndlr
    'Compare the severity of the Interference.
    Dim strAppendNotes As String
    Dim strexistingNotes As String
    strAppendNotes = ""  'If the user adds any string here that will be appended to the IFC object it is really modified
    If IfcType = IfcServerInterference Then
        Select Case (pOldInterference.InterferenceType)
            Case ftSevereFoul
                pOldInterference.InterferenceStatus = fsUnacceptableFoul
            Case ftOptionalFoul
                pOldInterference.InterferenceStatus = fsUndefinedFoul
            Case ftClearanceFoul
                pOldInterference.InterferenceStatus = fsAcceptableFoul
            Case ftBadPartFoul
                pOldInterference.InterferenceStatus = fsUndefinedFoul
        End Select
        If Not (strAppendNotes Like "") Then
            strexistingNotes = pOldInterference.InterferenceRemark
            strexistingNotes = strexistingNotes + strAppendNotes
            pOldInterference.InterferenceRemark = strexistingNotes
        End If
    End If
    Exit Sub
ErrHndlr:
    Debug.Assert False
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       GetAspectName (Helper function, Private:)
'   Desc:
'       Get the user defined nale of the aspect given the Aspect Code
'       Inputs: Aspect Value
'       Outputs: Name of the aspect as defined in Code List tables.
'
'   Arguments:
'       aspect [in]                Long value of the Aspect
'   Return Values:
'       String[out]                Name of the Aspect
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function GetAspectName(ByVal aspect As Long) As String
On Error GoTo ErrorHandler
    Dim oCodeListMetadata As IJDCodeListMetaData
    Dim oInfoCol As IJDInfosCol
    Dim oCodelistvalue As IJDCodeListValue
    Dim count As Long
    Dim counter As Long
    Dim punkpom As IUnknown
    'Initialize the name with undefined
    GetAspectName = "Undefined"
    'Get the interface to Codelsit metadata
    Set oCodeListMetadata = GetResourceManager()
    'Get the info collection of All the aspects defined in Catalog
    Set oInfoCol = oCodeListMetadata.CodelistValueCollection("AspectCode")
    count = oInfoCol.count
    'Loop all the aspect values and match the current passed number and get the name of the aspect
    For counter = 1 To count
        Set oCodelistvalue = oInfoCol.Item(counter)
        If Not oCodelistvalue Is Nothing Then
            If aspect = oCodelistvalue.ValueID Then
                GetAspectName = oCodelistvalue.ShortValue
                Exit For
            End If
        End If
        Set oCodelistvalue = Nothing
    Next counter
    'Release the allocated memory
    Set oCodeListMetadata = Nothing
    Set oInfoCol = Nothing
    Set oCodelistvalue = Nothing
Exit Function
ErrorHandler:
    'Incase there is any Error
    Set oCodeListMetadata = Nothing
    Set oInfoCol = Nothing
    Set oCodelistvalue = Nothing
    Debug.Assert False
    GetAspectName = "UnDefined"
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       IsConnectedbyIntermediate(Helper function, Private)
'   Desc:
'       Check weather 2 objects are connected by an intermedaiate Object.
'       Inputs: both the objects participating in Collision
'       Outputs: boolean True means Connected, False means they are not connected.
'
'   Arguments:
'       Obj1 [in]               pointer to First object participating in Collision
'       Obj2 [in]               pointer to second object participating in Collision
'   Return Values:
'       Boolean[out]       True means Objects are connected by Intermediate.
'                          False means donot.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function IsConnectedbyIntermediate(ByVal Obj1 As Object, ByVal Obj2 As Object) As Boolean
On Error GoTo ErrorHandler

    Dim oParent1 As IJFoulCheck
    Dim oParent2 As IJFoulCheck
    Dim oParent1ConParts  As IJDObjectCollection
    Dim oParent2ConParts  As IJDObjectCollection
   
    Dim pUnk1 As Variant
    Dim pUnk2 As Variant
    Dim strObjIdentity1 As String
    Dim strObjIdentity2 As String
    IsConnectedbyIntermediate = False
    Set oParent1 = Nothing
    Set oParent2 = Nothing
   
    Set oParent1 = Obj1
    Set oParent2 = Obj2
    On Error GoTo ErrorHandler
    If ((oParent1 Is Nothing) Or (oParent2 Is Nothing)) Then
        Exit Function
    End If
    Set oParent1ConParts = Nothing
    Set oParent2ConParts = Nothing
    
    Set oParent1ConParts = New JObjectCollection
    Set oParent2ConParts = New JObjectCollection

    oParent1.GetConnectedParts oParent1ConParts
    oParent2.GetConnectedParts oParent2ConParts
    If ((oParent1ConParts.count <= 0) Or (oParent2ConParts.count <= 0)) Then
        Exit Function
    End If
    On Error GoTo ErrorHandler
    'we have list of connected parts that has to be compared
    For Each pUnk1 In oParent1ConParts
        strObjIdentity1 = GetObjectIdentifyer(pUnk1)  'GetObjectFromMnkr(pUnk1)
        If Not (strObjIdentity1 Like "") Then
            For Each pUnk2 In oParent2ConParts
                strObjIdentity2 = GetObjectIdentifyer(pUnk2) 'GetObjectFromMnkr(pUnk2)
                If strObjIdentity2 Like strObjIdentity1 Then
                    IsConnectedbyIntermediate = True
                    Exit For
                End If
                'Just reinitialize
                strObjIdentity2 = ""
            Next pUnk2
            If IsConnectedbyIntermediate = True Then
                Exit For
            End If
        End If
        'Just reinitialize
        strObjIdentity1 = ""
    Next pUnk1
   
    If oParent1ConParts.count > 0 Then
        oParent1ConParts.Clear
    End If
    Set oParent1ConParts = Nothing
    If oParent2ConParts.count > 0 Then
        oParent2ConParts.Clear
    End If
    Set oParent2ConParts = Nothing
    Set oParent1 = Nothing
    Set oParent2 = Nothing
    Set pUnk1 = Nothing
    Set pUnk2 = Nothing
Exit Function

ErrorHandler:
    'Do return an error any error will be handled from Remote Engine
    Debug.Assert False
    If oParent1ConParts.count > 0 Then
        oParent1ConParts.Clear
    End If
    Set oParent1ConParts = Nothing
    If oParent2ConParts.count > 0 Then
        oParent2ConParts.Clear
    End If
    Set oParent2ConParts = Nothing
    Set oParent1 = Nothing
    Set oParent2 = Nothing
    Set pUnk1 = Nothing
    Set pUnk2 = Nothing
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       Distance(Helper function, Private)
'   Desc:
'       Check weather 2 objects are in the same location or not.
'       Inputs: both the interference objects generated by Collision detection process
'       Outputs: double value: distance between the objects
'   Arguments:
'       pObj1 [in]               pointer to IJIfcEntity interface(properties of Interference interface)
'       pObj2 [in]               pointer to IJIfcEntity interface(properties of Interference interface)
'   Return Values:
'       double[out]       distance between both the interferences
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function Distance(ByVal pobj1 As IJIfcEntity, ByVal pObj2 As IJIfcEntity) As Double
    Dim pX As Double, pY As Double, pZ As Double
    Dim cX As Double, cY As Double, cZ As Double
    pobj1.GetFoulLocation pX, pY, pZ
    pObj2.GetFoulLocation cX, cY, cZ
    Distance = Sqr(((cX - pX) ^ 2) + ((cY - pY) ^ 2) + ((cZ - pZ) ^ 2))
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       GetAspectCode (Helper function, Private:)
'   Desc:
'       Get the user defined value of the aspect given the Aspect name
'       Inputs: Aspect name
'       Outputs: Value of the aspect as defined in Code List tables.
'   Arguments:
'       aspect [in]                 Name of the Aspect
'   Return Values:
'       String[out]                 Long value of the Aspect
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Function GetAspectCode(ByVal aspect As String) As Long
On Error GoTo ErrorHandler
    Dim oCodeListMetadata As IJDCodeListMetaData
    Dim oInfoCol As IJDInfosCol
    Dim oCodelistvalue As IJDCodeListValue
    Dim count As Long
    Dim counter As Long
    GetAspectCode = 0
    Set oCodeListMetadata = GetResourceManager()
    Set oInfoCol = oCodeListMetadata.CodelistValueCollection("AspectCode")
    count = oInfoCol.count
    For counter = 1 To count
        Set oCodelistvalue = oInfoCol.Item(counter)
        If Not oCodelistvalue Is Nothing Then
            If aspect = oCodelistvalue.ShortValue Then
                GetAspectCode = oCodelistvalue.ValueID
                Exit For
            End If
        End If
        Set oCodelistvalue = Nothing
    Next counter
    Set oCodeListMetadata = Nothing
    Set oInfoCol = Nothing
    Set oCodelistvalue = Nothing
Exit Function
ErrorHandler:
    Set oCodeListMetadata = Nothing
    Set oInfoCol = Nothing
    Set oCodelistvalue = Nothing
    Debug.Assert False
    GetAspectCode = 0
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Function:
'       GetObjectFromMnkr (Helper function, Private:)
'   Desc:
'       not implemented
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function GetObjectFromMnkr(ByVal punk As IUnknown) As IUnknown
On Error GoTo ErrHndlr
    Set GetObjectFromMnkr = Nothing
Exit Function
ErrHndlr:
    Err.Clear
End Function
'Gets the PG string  and return the corresponding permission group number
Private Function ConvertPGNameToNumber(ByVal strPFName As String) As Long
On Error GoTo ErrHndlr
    Dim CID As Long
    Dim count As Long
    Dim CIDName As String
    Dim acc As Long
    Dim i As Long
    
    Dim oMidCtx As IJMiddleContext
    Dim oDBTypeConfig As IJDBTypeConfiguration
    Dim oDataBaseConfig As IJDataBaseConfiguration
    Dim oACConfig As IJAccessControlConfiguration
    Dim oAccessControl As IJAccessControl
    Dim bFound As Boolean
    
    Set oDBTypeConfig = New DBTypeConfiguration
    Set oDataBaseConfig = New DataBaseConfiguration
    Set oACConfig = New AccessControlConfiguration
    
    Set oMidCtx = New GSCADMiddleContext 'should come with initialzied one
    oMidCtx.GetConfigurationTablesFromMiddle oDBTypeConfig, oDataBaseConfig, oACConfig
    Set oAccessControl = oACConfig.AccessControl
    count = oACConfig.NumberConditionIDs
    
    For i = 1 To count
        oACConfig.GetConditionIDByIndex i, CIDName, CID
        oAccessControl.GetAccessRight CID, acc
        If ((acc And acUpdate) = acUpdate) Then
            If CIDName Like strPFName Then
                On Error Resume Next
                ConvertPGNameToNumber = CID
                bFound = True
                Exit For
            End If
        Else
            bFound = False
        End If
    Next i
    'Could not find any permission group .. assingning 0
    If bFound = False Then
        ConvertPGNameToNumber = 0
    End If
    Exit Function
ErrHndlr:
    Err.Raise Err.Number
    Debug.Assert False
End Function

Private Function GetPermissionGroupIndex(strParentType) As Long
On Error GoTo ErrHndlr

    'the  following is the default ranking on the basis of which the permission
    'groups will be assigned. The end user can edit the following to set his priority
    Select Case (strParentType)
    
    Case "Pipe Supports", "Cable Tray Supports", "Duct Supports"
        GetPermissionGroupIndex = 0
        
    Case "Conduit Components", "Conduits"
        GetPermissionGroupIndex = 1
    
    Case "Cable Tray Components", "Cableway Along Leg", "Cableway Straight", _
                "Cable Trays", "Cableway Turn"
        GetPermissionGroupIndex = 2
    
    Case "HVAC Components", "Ducts"
        GetPermissionGroupIndex = 3
    
    Case "Pipes", "Piping Welds", "Piping Components", "Piping Instruments", _
                "Piping Specialty Items"
        GetPermissionGroupIndex = 4
    
    Case "Member Part Linear", "Member Part Curve", "Slab", _
		 "Equipment Foundation", "Footing", "Stairs", "Ladders", "Handrails"
        GetPermissionGroupIndex = 5
    
    Case "Legacy Equipment", "Legacy Designed Equipment", "Equipment"
        GetPermissionGroupIndex = 6
    
    Case "Interference Volumes"
        GetPermissionGroupIndex = 7
    
    Case Default
        GetPermissionGroupIndex = -1
    End Select
    
ErrHndlr:
    Debug.Assert False
End Function

Private Function GetObjectIdentifyer(ByVal punk As IUnknown) As String
On Error GoTo ErrHndlr
    GetObjectIdentifyer = ""
    'First get the POM
    Dim oPOM As IUnknown
    Dim pIJDPOM As IJDPOM
    Set oPOM = GetResourceManager()
    If Not oPOM Is Nothing Then
        Set pIJDPOM = oPOM
        If Not pIJDPOM Is Nothing Then
            GetObjectIdentifyer = pIJDPOM.ClsidOf(punk)
        End If
    End If
ErrHndlr:
Err.Clear
GetObjectIdentifyer = ""
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

Private Function AreBothImportedObjects(Obj1 As Object, Obj2 As Object) As Boolean
On Error GoTo ErrHndlr
    AreBothImportedObjects = False
    Dim oMoniker1 As IUnknown
    Dim oMoniker2 As IUnknown
    Dim pPOM As IJDPOM
    Set pPOM = GetResourceManager()
    If Not pPOM Is Nothing Then
        Set oMoniker1 = pPOM.GetObjectMoniker(Obj1)
        If (pPOM.SupportsInterface(oMoniker1, "IJImportedStructureItem")) Then
            Set oMoniker2 = pPOM.GetObjectMoniker(Obj2)
            If (pPOM.SupportsInterface(oMoniker2, "IJImportedStructureItem")) Then
                AreBothImportedObjects = True
            End If
        End If
    End If
CleanUp:
    Set oMoniker1 = Nothing
    Set oMoniker2 = Nothing
    Set pPOM = Nothing
Exit Function
ErrHndlr:
    AreBothImportedObjects = False
    GoTo CleanUp
End Function

