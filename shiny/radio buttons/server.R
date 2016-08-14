library(shiny)

shinyServer(
    
    function(input, output){
# use input variables to assign it to output variable    
        output$myname = renderText(input$name)
        output$myage = renderText(input$age)
        output$mygender = renderText(input$gender)
        
    }
    
    )