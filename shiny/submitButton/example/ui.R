library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Demonstration of submitButton()"),
    
    sidebarLayout(
        
        sidebarPanel(
            selectInput("dataset","Choose a dataset:",choices = c("iris","pressure","mtcars")),
            numericInput("obs", "Number of observations:", 6),
            submitButton("Update!"),
            p("In this example, changing the user input (dataset or number of observations) will not reflect in the output until the Update button is clicked"),
            p("submitButton is used to control the reactiveness of the change in the user input")
            ),
        
        mainPanel(
            h4(textOutput("dataname")),
            verbatimTextOutput("structure"),
            h4(textOutput("observation")),
            tableOutput("view")
            )
        
        
        )
    
    ))