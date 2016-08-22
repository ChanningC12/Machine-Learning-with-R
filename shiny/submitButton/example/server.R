library(shiny)
library(datasets)
shinyServer(function(input,output){
    
    output$dataname = renderText({
        paste("Structure of the dataset",input$dataset)
    })
    
    output$observation = renderText({
        paste("First", input$obs, "observations of the dataset", input$dataset)
    })

    output$structure = renderPrint({
        str(get(input$dataset)) # get() will give the absolute value
    })
    
    output$view = renderTable({
        head(get(input$dataset),n=input$obs)
    })
}
    )