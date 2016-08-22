library(shiny)
shinyServer(function(input,output){
    
    output$tabs = renderUI({
        
        Tabs = lapply(paste("tab no.", 1:input$n, sep=" "), tabPanel) # lapply() apply tabPanel function on each of tab title to get a list of tabPanels
        
        do.call(tabsetPanel, Tabs)
        
        })
    
}
    )