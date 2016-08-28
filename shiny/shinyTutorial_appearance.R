library(shiny)

ui = fluidPage(
    
    sliderInput("num", "Choose the number", value = 25, min = 1, max = 100),
    plotOutput("hist")
    
    )

server = function(input, output){
    
    output$hist = renderPlot({
        hist(input$num)
    })
    
}


shinyApp(ui = ui, server = server)


# My shiny app
ui = fluidPage(
    
    h1("Shiny App"),
    p("See other app in the", a("Show Case", href = "http://www.rstudio.com/products/shiny/shiny-user-showcase/"))
    
)

server = function(input, output){
        })
    
}


shinyApp(ui = ui, server = server)




# 04. wellPanel()
ui = fluidPage(
    wellPanel(
    sliderInput("num", "Choose the number", value = 25, min = 1, max = 100),
    textInput("text", value = "Histogram", label = "Write a title")
    ),
    plotOutput("hist")
    
)

server = function(input, output){
    
    output$hist = renderPlot({
        hist(input$num, main = input$text)
    })
    
}

shinyApp(ui = ui, server = server)



