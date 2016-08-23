library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Demonstration of actionButton() and isolate"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("dataset","Choose a dataset:",choices = c("iris","pressure","mtcars")),
            numericInput("obs","Number of observations",6),
            br(),
            p("In this example..."),
            actionButton("act","Click to update/view the observation of the selected dataset!"),
            br(),
            p("Instruction...")
            ),
        
        mainPanel(
            h4(textOutput("dataname")),
            verbatimTextOutput("structure"),
            h4(textOutput("observation")),
            tableOutput("view")
            )
        
        )
    
    ))