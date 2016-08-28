library(shiny)

shinyUI(pageWithSidebar(
    
    headerPanel("Use case - Change the side bar panel elements based on the selected tab"),
    
    sidebarPanel(
        conditionalPanel(condition = "input.tabselected == 1", h4("Demo conditionalPanel()")),
        conditionalPanel(condition = "input.tabselected == 2", 
                         selectInput("dataset", "select the desired dataset", choices=ls('package:dataset'),selected = "mtcars"),
                         radioButtons("choice", "Choose an option", choices = c("Dataset"=1, "Structure"=2, "Summary"=3))
                         ),
        conditionalPanel(condition = "input.tabselected==3", uiOutput("varx"), uiOutput("vary"))
        ),
    
    mainPanel(
        tabsetPanel(
            tabPanel("About", value=1, helpText("conditional Panel")),
            tabPanel("Data", value=2, conditionalPanel(condition=="input.choice==2",verbatimTextOutput)),
            tabPanel("About", value=3, helpText("conditional Panel"))
            )
        )
    
    
    ))