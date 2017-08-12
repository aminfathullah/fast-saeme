library(shiny)
library(DT)
library(shinythemes)
library(saeme)

R.utils::sourceDirectory('functions', recursive = TRUE, modifiedOnly = FALSE)
shinyServer(function(input, output, session)
{
  R.utils::sourceDirectory('sources', recursive = TRUE, modifiedOnly = FALSE)
  
  datah <- reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    data.frame(read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                        quote=input$quote, as.is = T))
  })
  
})