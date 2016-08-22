library(shiny)

shinyServer(function(input,output){
    
    output$txt1 = renderText({
        paste("My first name is: ", input$text1)
    })
        
    output$txt2 = renderText({
        input$action
        isolate(paste("My last name is: ", input$text2))
    })
    
})