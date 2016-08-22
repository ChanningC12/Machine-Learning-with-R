library(shiny)

shinyUI(fluidPage(
    titlePanel("Dynamic user interface - RenderUI"),
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "dataset", label = "Select the Dataset of your choice", choices = c("iris","mtcars","trees")),
            br(),
            helpText("The following selectInput drop down choices are dynamically populated based on the dataset selected"),
            br(),
            uiOutput("vx"),
            br(),
            uiOutput("vy")
            ),
        mainPanel(
            plotOutput("p")
            )
        )
    
    ))