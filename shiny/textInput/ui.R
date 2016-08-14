library(shiny)

# Define UI for the shiny application

shinyUI(fluidPage(
    # Application title
    titlePanel(title = "Demonstration of textInput widget in shiny"),
    
    sidebarLayout(
                  # Sidebar panel
                  sidebarPanel(("Enter the personal information"),
                               textInput("name","Enter your name",""),
                               textInput("age","Enter your age","")),
                  # Main Panel
                  mainPanel(("Personal Information"),
                            textOutput("myname"),
                            textOutput("myage"))
    )
)
)