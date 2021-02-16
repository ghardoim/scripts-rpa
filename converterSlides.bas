Sub converter_PPT_JPG()
    
  'On Error Resume Next

  Dim fileName As String: fileName = Application.GetOpenFilename("PPT Files (*.ppt; *.pptx), *")
  Dim pptApp As PowerPoint.Application: Set pptApp = New PowerPoint.Application
  Dim pptFile As Presentation: Set pptFile = pptApp.Presentations.Open(fileName, msoFalse)
  Dim pptSlides As Slides: Set pptSlides = pptFile.Slides
  Dim oSlide As Slide
  
  For Each oSlide In pptSlides
      
    With oSlide.Shapes
      .Range.Align msoAlignCenters, msoTrue
  
      If 1 = .Count Then
        .Range.Align msoAlignMiddles, msoTrue
      
      End If
    End With
    oSlide.Export pptFile.Path & "\domingo_" & oSlide.SlideNumber & ".jpg", "JPG"
  Next
  
  With pptFile
    .Save
    .Close
  End With
  
  pptApp.Quit
  Application.Quit
End Sub

