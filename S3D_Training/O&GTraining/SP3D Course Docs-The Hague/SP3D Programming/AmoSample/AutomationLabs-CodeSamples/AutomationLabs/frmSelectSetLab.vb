
Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle

Public Class frmSelectSetLab
    'declare a SelectSet Service reference
    Private m_oSelectSet As SelectSet
    'declare a WithEvents SelectSet Service reference
    'to listen to SelectSet events
    Private WithEvents m_oEVSelectSet As SelectSet

    Private Sub frmSelectSetLab_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        m_oEVSelectSet = Nothing
    End Sub

    Private Sub frmSelectSetLab_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'get SelectSet service
        m_oSelectSet = ClientServiceProvider.SelectSet
    End Sub

    Private Sub btnClear_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClear.Click
        'clear selected objects
        m_oSelectSet.SelectedObjects.Clear()
    End Sub

    Private Sub btnRemove1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemove1.Click
        m_oSelectSet.SelectedObjects.Remove(m_oSelectSet.SelectedObjects.Item(0))
    End Sub

    Private Sub chkDelay_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkDelay.CheckedChanged
        'set the WaitForUpdate property on the SelectSet
        m_oSelectSet.SelectedObjects.WaitForUpdate = chkDelay.Checked
    End Sub

   
    Private Sub chkEvents_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkEvents.CheckedChanged
        If chkEvents.Checked = True Then
            'start listening to events
            m_oEVSelectSet = m_oSelectSet
            lvEvents.Items.Add("Started listening to Select Set events")
        Else
            'stop listening
            m_oEVSelectSet = Nothing
            lvEvents.Items.Add("Stopped listening to Select Set events")
        End If
    End Sub

    Private Sub m_oEVSelectSet_Added(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectSet.Added
        lvEvents.Items.Add("Added " + BusinessObject.ToString)
    End Sub

    Private Sub m_oEVSelectSet_Removed(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectSet.Removed
        lvEvents.Items.Add("Removed " + BusinessObject.ToString)
    End Sub

    Private Sub btnRemAndReload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemAndReload.Click
        Dim oSelObjs As ReadOnlyBOCollection
        'get a copy of selected objects
        oSelObjs = m_oSelectSet.SelectedObjects.Clone

        'Remove selected objects from SelectSet
        m_oSelectSet.SelectedObjects.Remove(oSelObjs)

        'Hilite display will not be updated if DelayedUpdate in ON, so
        'turn it OFF to force display update
        If chkDelay.Checked = True Then
            m_oSelectSet.SelectedObjects.WaitForUpdate = False 'Hilite Updates
            m_oSelectSet.SelectedObjects.WaitForUpdate = chkDelay.Checked 'reverts back to user setting
        End If

        'add back originally selected objects one-by-one
        For Each oBO As BusinessObject In oSelObjs
            m_oSelectSet.SelectedObjects.Add(oBO)
        Next

        'Hilite display will not be updated if DelayedUpdate in ON, so
        'turn it OFF to force display update
        If chkDelay.Checked = True Then
            m_oSelectSet.SelectedObjects.WaitForUpdate = False 'Hilite Updates
            m_oSelectSet.SelectedObjects.WaitForUpdate = chkDelay.Checked 'reverts back to user setting
        End If

    End Sub

    Private Sub btnContainmentChk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContainmentChk.Click
        Dim oBO As BusinessObject = m_oSelectSet.SelectedObjects(0)

        MsgBox("Select Set Contains object (0) originally? - " & m_oSelectSet.SelectedObjects.Contains(oBO))

        m_oSelectSet.SelectedObjects.Remove(oBO)

        MsgBox("Select Set Contains object (0) After Remove? - " & m_oSelectSet.SelectedObjects.Contains(oBO))

        m_oSelectSet.SelectedObjects.Add(oBO)

        MsgBox("Select Set Contains object (0) After Adding Back? - " & m_oSelectSet.SelectedObjects.Contains(oBO))


    End Sub

    Private Sub btnClearOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClearOut.Click
        lvEvents.Items.Clear()
    End Sub

   
End Class