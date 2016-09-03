library(shiny)

shinyServer(function(input, output){
    
    selectedData = reactive({
        
        insurance[insurance$smoker %in% input$smk & insurance$sex %in% input$sex, ]
        
    })
    
    
    output$barplot = renderPlot({
      
      regionmean = tapply(selectedData()$charges, selectedData()$region, mean)
      barplot(regionmean)
        
    })
    
})