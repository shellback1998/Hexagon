Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services

Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Common.Middle.Services



Public Class SelectSetLabFrm
    Private m_oSelectset As SelectSet

    Private WithEvents m_oEVSelectset As SelectSet



    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        m_oSelectset.SelectedObjects.Remove( _
            m_oSelectset.SelectedObjects.Item(0))
    End Sub

    Private Sub SelectSetLabFrm_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        m_oEVSelectset = Nothing
    End Sub

    Private Sub SelectSetLabFrm_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        m_oSelectset = ClientServiceProvider.SelectSet


    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim oBo As BusinessObject

        oBo = m_oSelectset.SelectedObjects.Item(0)

        MsgBox("Selectset contains object(0) originally? " & _
                m_oSelectset.SelectedObjects.Contains(oBo))

        m_oSelectset.SelectedObjects.Remove(oBo)

        MsgBox("Selectset contains object(0) after remove(0)? " & _
                m_oSelectset.SelectedObjects.Contains(oBo))

        m_oSelectset.SelectedObjects.Add(oBo)
        MsgBox("Selectset contains object(0) after added back? " & _
                m_oSelectset.SelectedObjects.Contains(oBo))
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        m_oSelectset.SelectedObjects.Clear()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim oSelObjs As ReadOnlyBOCollection

        oSelObjs = m_oSelectset.SelectedObjects.Clone

        m_oSelectset.SelectedObjects.Remove(oSelObjs)

        If CheckBox2.Checked Then
            With m_oSelectset.SelectedObjects
                .WaitForUpdate = False
                .WaitForUpdate = CheckBox2.Checked
            End With
        End If

        For Each obo As BusinessObject In oSelObjs
            m_oSelectset.SelectedObjects.Add(obo)
        Next
    End Sub



    Private Sub CheckBox2_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckBox2.CheckedChanged
        m_oSelectset.SelectedObjects.WaitForUpdate = CheckBox2.Checked
    End Sub

    Private Sub CheckBox1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckBox1.CheckedChanged
        If CheckBox1.Checked Then
            m_oEVSelectset = m_oSelectset
            lvEvents.Items.Add("Started Listening to Select set events")
        Else
            m_oEVSelectset = Nothing
            lvEvents.Items.Add("Stopped Listening to Select Set events.")
        End If
    End Sub

    Private Sub m_oEVSelectset_Added(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectset.Added
        lvEvents.Items.Add("Added " & BusinessObject.ToString)
    End Sub

    Private Sub m_oEVSelectset_Removed(ByVal BusinessObject As Ingr.SP3D.Common.Middle.BusinessObject) Handles m_oEVSelectset.Removed
        lvEvents.Items.Add("Removed " & BusinessObject.ToString)
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        lvEvents.Items.Clear()
 
    End Sub
End Class