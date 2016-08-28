library(shiny)

# Template
ui = fluidPage(
    sliderInput("num", label="Choose a number", value = 25, min = 1, max = 100),
    plotOutput("hist")
    )

server = function(input,output){
    
    output$hist = renderPlot({
        title = "Histogram"
        hist(rnorm(input$num))
    })
    
}

shinyApp(ui = ui, server = server)
