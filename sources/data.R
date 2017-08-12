output$data <- renderUI({
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t',
                     Space=' '),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      wellPanel(
        DT::dataTableOutput('table')
      )
    )
  )
})
output$table <- DT::renderDataTable({
  data <- datah()
  var_names <- names(data)
  classes <- sapply(var_names, function(x) class(data[,x]))
  DT::datatable(data, style = 'bootstrap', rownames = F, autoHideNavigation = T, colnames = paste(var_names, " (", classes, ")", sep = ""))
})