library(shiny)
shinyServer(function(input, output){
    output$out = renderText(paste("You select the value as: ", input$slide)) # using input $slide (name of the slider), assign it to output variable out
    
})