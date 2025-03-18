Sub insere_sumario(nome_arquivo As String, niveis As Integer)

  Dim appWord As Word.Application: Set appWord = CreateObject("Word.Application")
  Dim documento As Word.Document: Set documento = appWord.Documents.Add
  Dim cursor As Word.Selection: Set cursor = appWord.Selection

  With cursor
    .Style = documento.Styles("Título")
    .ParagraphFormat.Alignment = wdAlignParagraphCenter
    
    Call .TypeText(UCase(nome_arquivo) & vbNewLine & vbNewLine)
    
    For i = 1 To niveis
      .Style = documento.Styles("Título " & i)
      .ParagraphFormat.Alignment = wdAlignParagraphLeft
      
      Call .TypeText("Parágrafo " & i & vbNewLine)
    Next

    Call .GoTo(wdGoToLine, wdGoToAbsolute, 3)
  End With
  Call documento.TablesOfContents.Add(documento.Paragraphs(2).Range)
  
  Call documento.SaveAs2(ThisWorkbook.Path & "\" & nome_arquivo & ".docx")
  Call appWord.Quit
End Sub