output$fhme <- renderUI({
  data <- datah()
  var_list <- names(data)
  sidebarLayout(
    sidebarPanel(
      selectizeInput('y', 'Direct estimator', var_list),
      selectizeInput('mse_y', 'MSE of y', var_list),
      selectizeInput('x', 'Auxiliary variables', var_list, multiple = T, options = list(placeholder = 'select one or more variable(s)')),
      selectizeInput('mse_x', 'MSE of Auxiliary variables', var_list, multiple = T, options = list(placeholder = 'select one or more variable(s)')), 
      actionButton("go", "Calculate")
    ),
    mainPanel(
      tabsetPanel(
        id = "tabs", 
        tabPanel(
          title = "Estimation",
          conditionalPanel("input.go == 0",
                           verbatimTextOutput("help")),
          conditionalPanel("input.go != 0",
                           verbatimTextOutput("head")),

          br(),
          br(),
          textOutput("pre_table"),
          tags$style(type="text/css", "#pre_table {font-weight: bold;}"),
          helpText(" "),
          dataTableOutput("estimation")
        ),
        tabPanel(
          title = "Plot",
          plotOutput("plot", width = "400px", height = "400px")
        )
      )
    )
  )
})

output$help <- renderPrint({
  cat("Steps: \n")
  cat("1. Select variable y, variance y, x and variance x\n")
  cat("2. Press \"Calculate\" button\n\n")
  cat("Note: \n")
  cat("Please choose the variables carefully! \nIf there is an error in variable selection, reload this page!")
})

output$head <- renderPrint({
  if(!is.null(sae$vals))
  {
    sae_me <- sae$vals
    cat("Call:\n")
    print(sae_me$call)
    cat("\n\nBeta:\n")
    print(as.vector(sae_me$beta))
    sae$val <- sae_me
    cat("\n ")
  }
})

output$pre_table <- renderText({
  sae_me <- var()
  sae$vals <- sae_me
  
  if(!is.null(sae$val))
    return("Estimated values:")
})
output$estimation <- DT::renderDataTable({
  est_table <- NULL
  sae_me <- sae$val
  if(!is.null(sae_me))
  {
    est_table <- data.frame("y"=sae_me$y_me, "gamma"=sae_me$gamma, "mse"=sae_me$mse)
  }
  est_table
  DT::datatable(est_table, rownames = T, autoHideNavigation = T, class = "table table-striped table-bordered", options = list(columns.className = "dt-left"))
})

output$plot <- renderPlot({
  if(is.null(sae$vals))
    sae_me <- var()
  else
    sae_me <- sae$vals
  
  plot(sae_me)
})

var <- eventReactive(input$go, {
  progress <- Progress$new(session, min=1, max=10)
  on.exit(progress$close())
  progress$set(message = 'Calculation in progress')
  progress$set(value = 5)
  data <- datah()
  y <- data[,input$y]
  x <- data[,input$x]
  mse_y <- data[,input$mse_y]
  mse_x <- data[,input$mse_x]
  
  sae_me <- FHme(y, cbind(1, x), mse_y, cbind(0, mse_x))
  progress$set(value = 10)
  sae_me
})
observe({
  var_list <- names(datah())
  y <- input$y
  x <- input$x
  mse_y <- input$mse_y
  mse_x <- input$mse_x
  
  updateSelectizeInput(session, "mse_y", choices = pull_values(var_list, c(y, x, mse_x)), selected = mse_y)
  updateSelectizeInput(session, "x", choices = pull_values(var_list, c(y, mse_y, mse_x)), selected = x)
  updateSelectizeInput(session, "mse_x", choices = pull_values(var_list, c(y, x, mse_y)), selected = mse_x)
})

pull_values <- function(x, values)
{
  matched_index <- as.logical(match(x, values, nomatch = 0))
  return(x[!matched_index])
}

sae <- reactiveValues()