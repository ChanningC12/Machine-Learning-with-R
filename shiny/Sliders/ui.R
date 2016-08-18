# How to use the sliderInput widget in shiny
library(shiny)
# runExample("05_sliders")

shinyUI(fluidPage(
    titlePanel("Demostration of sliderInput widget in shiny"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("slide", "Select the value from Slider", min = 0, max = 5, value = 3, step = 0.5, animate = T) # range: value = c(2,3)
            ),
        mainPanel(
            textOutput("out")
            )
        )
    
    ))