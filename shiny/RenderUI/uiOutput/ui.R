library(shiny)
shinyUI(fluidPage(
    titlePanel("Demonstration of renderUI in shiny - Dynamically creating the tabs based on user inputs"),
    sidebarLayout(
        sidebarPanel(
            numericInput("n", "Enter the number of tabs needed", 1)
            ),
        
        mainPanel(
            uiOutput("tabs")
            )
        )
    ))