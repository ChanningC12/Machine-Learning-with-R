# How to plot using shiny
# renderPlot() to render the plot, plotOutput() to display the plot
# will also use selectInput(), sliderInput(), radioButtons()
# For example, we will use the iris dataset that comes with R

library(shiny)

shinyUI(fluidPage(
    titlePanel(title = h4("Demostration of renderPlot() - a histogram", align = "center")),
    sidebarLayout(
        sidebarPanel(
            selectInput("var","1.Select the variable from the iris dataset", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width" = 4)),
            br(),
            sliderInput("bins","2.Select the number of BINs for histogram", min = 5, max = 25, value = 15),
            br(),
            radioButtons("color","3.Select the color of histogram",choices = c("Green","Red","Yellow"),selected = "Green")
            ),
        
        mainPanel(
            plotOutput("myhist")
            )
    )
    
))