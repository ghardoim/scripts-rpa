Private Sub UserForm_Initialize()
  Me.txt_niveis.Value = 1
End Sub

Private Sub UserForm_Terminate()
  Application.ScreenUpdating = True
  Application.Visible = True
  Application.Quit
End Sub

Private Sub spn_niveis_SpinUp()
  Dim nivel As Integer: nivel = Me.txt_niveis.Value
  If nivel < 9 Then Me.txt_niveis.Value = nivel + 1
End Sub

Private Sub spn_niveis_SpinDown()
  Dim nivel As Integer: nivel = Me.txt_niveis.Value
  If nivel > 1 Then Me.txt_niveis.Value = nivel - 1
End Sub

Private Sub btn_criar_Click()
  If txt_nome <> "" Then
    Call insere_sumario(Me.txt_nome.Value, Me.txt_niveis.Value)
    Call MsgBox("ARQUIVO CRIADO COM SUCESSO!", vbInformation, "SUCESSO")
    Call Unload(Me)
  End If
End Sub