Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services

Public Class SelectSetLabForm

    'Declare a SelectSet Service reference
    Private m_oSelectSet As SelectSet
    Private WithEvents m_oEVSelectSet As SelectSet

    Private Sub SelectSetLabForm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        m_oEVSelectSet = Nothing

    End Sub

    Private Sub SelectSetLabForm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        m_oSelectSet = ClientServiceProvider.SelectSet
    End Sub

    Private Sub btnRemove1stObject_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemove1stObject.Click
        m_oSelectSet.SelectedObjects.Remove(m_oSelectSet.SelectedObjects.Item(0))
    End Sub

    Private Sub btnClearSelection_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClearSelection.Click
        m_oSelectSet.SelectedObjects.Clear()
    End Sub

    Private Sub chkDelayedUpdate_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkDelayedUpdate.CheckedChanged
        m_oSelectSet.SelectedObjects.WaitForUpdate = chkDelayedUpdate.Checked

    End Sub

    Private Sub chkListenToEvents_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkListenToEvents.CheckedChanged
        If (chkListenToEvents.Checked = True) Then
            m_oEVSelectSet = m_oSelectSet
            IvEvents.Items.Add(" Started Listening to SelectSet Events")
        Else
            m_oEVSelectSet = Nothing
            IvEvents.Items.Add(" Stopped Listening to SelectSet Events")
        End If
    End Sub

    Private Sub m_oEVSelectSet_Added(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectSet.Added
        IvEvents.Items.Add("Added " & BusinessObject.ToString)
    End Sub

    Private Sub m_oEVSelectSet_Removed(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectSet.Removed
        IvEvents.Items.Add("Removed " & BusinessObject.ToString)
    End Sub

    Private Sub btnRemoveAndReloadAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveAndReloadAll.Click
        Dim oSelObjs As ReadOnlyBOCollection = m_oSelectSet.SelectedObjects.Clone
        m_oSelectSet.SelectedObjects.Remove(oSelObjs)
        If (chkDelayedUpdate.Checked) Then
            With m_oSelectSet.SelectedObjects
                .WaitForUpdate = False
                .WaitForUpdate = chkDelayedUpdate.Checked

            End With
        End If

        For Each oBO As BusinessObject In oSelObjs
            m_oSelectSet.SelectedObjects.Add(oBO)
        Next

        If (chkDelayedUpdate.Checked) Then
            With m_oSelectSet.SelectedObjects
                .WaitForUpdate = False
                .WaitForUpdate = chkDelayedUpdate.Checked

            End With
        End If
    End Sub

    Private Sub btnContainmentCheck_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnContainmentCheck.Click
        Dim oBO As BusinessObject = m_oSelectSet.SelectedObjects.Item(0)
        MsgBox("SelectSet Contains Object(0) Originally? " & m_oSelectSet.SelectedObjects.Contains(oBO))

        m_oSelectSet.SelectedObjects.Remove(oBO)
        MsgBox("SelectSet Contains Object(0) after Remove(0)?" & m_oSelectSet.SelectedObjects.Contains(oBO))

        m_oSelectSet.SelectedObjects.Add(oBO)
        MsgBox("SelectSet Contains Object(0) After Added Back?" & m_oSelectSet.SelectedObjects.Contains(oBO))

    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        IvEvents.Items.Clear()
    End Sub

End Class