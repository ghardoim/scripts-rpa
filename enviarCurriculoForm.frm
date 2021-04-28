Private Sub btn_curriculo_Click()
  Me.txt_anexo.Value = Application.GetOpenFilename("Curr�culo (*.doc; *.docx; *.pdf), *")
End Sub

Private Sub btn_enviar_Click()    
  Dim outlookAPP As Outlook.Application: Set outlookAPP = CreateObject("Outlook.Application")
  Dim email As Outlook.MailItem: Set email = outlookAPP.CreateItem(0)
  Dim saudacao As String
  
  With email
    .To = LCase(Me.txt_para.Value)
    .Subject = Me.txt_assunto.Value
    If Me.txt_anexo.Value <> "" Then .Attachments.Add (Me.txt_anexo.Value)
    
    Select Case Hour(Time)
      Case Is < 12
        saudacao = "Bom dia!"
      Case 12 To 18
        saudacao = "Boa tarde!"
      Case Else
        saudacao = "Boa noite!"
    End Select
    
    .HTMLBody = "<p>" & saudacao & "</p>" & _
                "<p>Vi essa vaga no LinkedIn e fiquei interessado!</p>" & _
                "<p>Segue em anexo meu currículo!</p>" & _
                "<p>Desde já, agradeço a oportunidade.</p>" & _
                "<p>Att.</p>" & _
                "<p>" & Application.UserName & "</p>"
    .Send
  End With
  Application.Wait (Now + TimeValue("00:00:05"))
  outlookAPP.Quit
  
  Call MsgBox("CURRÍCULO ENVIADO!", vbInformation, " ")
End Sub

Private Sub UserForm_Terminate()
  With Application
    .Visible = True
    .ScreenUpdating = True
    .Quit
  End With
End Sub