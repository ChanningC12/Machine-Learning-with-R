library(shiny)

shinyUI(fluidPage(
    titlePanel("Iris k-means clustering"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("varx", "X Variable", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
            selectInput("vary", "Y Variable", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), selected = "Sepal.Width"),
            numericInput("num", "Cluster count", value = 3, min=1, max=4)
            ),
        mainPanel(
            plotOutput("plot1")
            )
        )
    
    ))