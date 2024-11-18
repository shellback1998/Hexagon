Imports Ingr.SP3D.Common.Client
Imports Ingr.SP3D.Common.Client.Services
Imports Ingr.SP3D.Common.Middle.Services
Imports Ingr.SP3D.Common.Middle
Imports Ingr.SP3D.Systems.Middle
Imports Ingr.SP3D.Equipment.Middle

Public Class EqpRotate
    Inherits BaseModalCommand

    Public Overrides Sub OnStart(ByVal commandID As Integer, ByVal argument As Object)

        Dim oPos As New Position
        Dim oRotPos As Position

        With ClientServiceProvider.SelectSet.SelectedObjects
            If (.Count > 0) AndAlso (TypeOf .Item(0) Is Equipment) Then
                'get equipment

                'rotate the equipment 45 deg around an axis pointing North,
                'passing through a poin 3 m above the equipment position
                Dim oEqp As Equipment = .Item(0)

                'get equipment position
                oPos.Set(oEqp.Matrix.GetIndexValue(12), oEqp.Matrix.GetIndexValue(13), oEqp.Matrix.GetIndexValue(14))

                'get the point 3 m higher than the Equip position
                oRotPos = oPos.Offset(New Vector(0, 0, 3))

                Dim oT1 As New Matrix4X4
                Dim oT2 As New Matrix4X4
                Dim oT3 As New Matrix4X4
                Dim oT As New Matrix4X4 'identity

                oT1.Translate(New Vector(-oRotPos.X, -oRotPos.Y, -oRotPos.Z))
                oT2.Rotate(System.Math.PI / 4, New Vector(0, 1, 0))
                oT3.Translate(New Vector(oRotPos.X, oRotPos.Y, oRotPos.Z))

                'note this is done in reverse order that if we had to do
                'the transforms one by one
                oT.MultiplyMatrix(oT3)
                oT.MultiplyMatrix(oT2)
                oT.MultiplyMatrix(oT1)

                Dim oTrans As ITransform = oEqp

                oTrans.Transform(oT)

                'equivalent to:
                'oTrans.Transform(oT1)
                'ClientServiceProvider.TransactionMgr.Compute()

                'oTrans.Transform(oT2)
                'ClientServiceProvider.TransactionMgr.Compute()

                'oTrans.Transform(oT3)
                'ClientServiceProvider.TransactionMgr.Compute()



                ClientServiceProvider.TransactionMgr.Commit("rotation")

            End If
        End With

    End Sub

End Class
