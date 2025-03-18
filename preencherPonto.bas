Sub preencher_ponto()

  Dim nome_mes As String: nome_mes = StrConv(MonthName(Month(Date)), vbProperCase)
  Dim dia As String: dia = Format(Day(Date), "00")
  
  Dim almoco_start As String: almoco_start = Hour(Time) & ":" & Minute(Time)
  Dim almoco_end As String: almoco_end = Hour(Time) + 1 & ":" & Minute(Time)
  Dim nome_dia As String: nome_dia = WeekdayName(Weekday(Date))
  
  Dim nome_planilha As String: nome_planilha = Application.GetOpenFilename("Excel Files (*.xls; *.xlsx), *")
  Dim planilha_ponto As Workbook: Set planilha_ponto = Workbooks.Open(nome_planilha)
  Dim aba_ponto As Worksheet: Set aba_ponto = planilha_ponto.Sheets(nome_mes)
  
  Dim linha As Integer: linha = 12
  For linha = linha To aba_ponto.Range("A12").End(xlDown).Row
  
    If Cells(linha, 1).Text = dia And Cells(linha, 2).Text = nome_dia Then
      Cells(linha, 3) = "09:00"
      Cells(linha, 4) = almoco_start
      Cells(linha, 5) = almoco_end
      Cells(linha, 6) = "18:00"
      
      Exit For
    End If
  Next
  
  planilha_ponto.Close (True)  
  Call MsgBox("Ponto preenchido!", , "")
  
  Call otimiza
  Application.Quit

End Sub

Sub otimiza()

  Application.ScreenUpdating = Not Application.ScreenUpdating
  Application.Visible = Not Application.Visible

End Sub