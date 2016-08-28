library(shiny)

ui = fluidPage(
    sliderInput("num", label="Choose a number", value = 25, min = 1, max = 100),
    textInput("text", label="Write a title", value = "Histogram of Random Normal Values"),
    plotOutput("hist"),
    verbatimTextOutput("summary")
)

server = function(input,output){
    
    data = reactive({
        rnorm(input$num)
        })
    
    output$hist = renderPlot({
        hist(data()), main = input$text)
    })
    
    output$summary = renderPrint({
        summary(data())
    })
    
}

shinyApp(ui = ui, server = server)


# Isolate: will not respond to reactive
library(shiny)

ui = fluidPage(
    sliderInput("num", label="Choose a number", value = 25, min = 1, max = 100),
    textInput("text", label="Write a title", value = "Histogram of Random Normal Values"),
    plotOutput("hist"),
    verbatimTextOutput("summary")
)

server = function(input,output){
    
    data = reactive({
        rnorm(input$num)
    })
    
    output$hist = renderPlot({
        hist(data()), main = isolate({input$text}))
    })

output$summary = renderPrint({
    summary(data())
})

}

shinyApp(ui = ui, server = server)


# ObserveEvent(input$clicks, {print(input$clicks)})
# actionButton(inputID = "go", label = "Click Me!")
# observe({print(input$clicks)})
# Delay reactions with eventReactive()


library(shiny)

ui = fluidPage(
    sliderInput("num", label="Choose a number", value = 25, min = 1, max = 100),
    actionButton("go","Update"),
    plotOutput("hist")
)

server = function(input,output){
    
    data = eventReactive(input$go, {
        rnorm(input$num)
    })
    
    output$hist = renderPlot({
        hist(data())
    })



}

shinyApp(ui = ui, server = server)


# ReavtiveValues
ui = fluidPage(
    actionButton("norm", "Normal"),
    actionButton("unif", "Uniform"),
    plotOutput("hist")
    )

server = function(input,output){
    rv = reactiveValues(data = rnorm(100))
    
    observeEvent(input$norm, {rv$data = rnorm(100)})
    observeEvent(input$unif, {rv$data = runif(100)})
    
    output$hist = renderPlot({
        hist(rv$data)
    })
    
}

shinyApp(ui = ui, server = server)







