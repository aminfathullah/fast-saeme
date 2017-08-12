
tagList(
    tags$head(tags$link(rel="shortcut icon", type="image/png", href='http://www.iconj.com/ico/b/k/bko1rhzyge.ico')),
    navbarPage('FAST',
               theme = shinythemes::shinytheme(theme = "cerulean"),
               tabPanel('Data management', uiOutput('data')),
               navbarMenu('Small Area Estimation', 
                          tabPanel('Fay Herriot with Measurement Error', uiOutput('fhme')))
    )
)