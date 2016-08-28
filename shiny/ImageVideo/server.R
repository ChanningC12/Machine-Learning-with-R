library(shiny)

shinyServer(function(input,output){
        
        output$vd = renderUI({
            
            h6("intro video", br(), tags$video(src = "Windmill.mp4", type = "video/mp4", width = "350"))
            
        })
        
    })
