library(shiny)
shinyServer(function(session,input,output){
    
    observeEvent(
        input$Year,
        updateSelectInput(session, "Month", "Month", choices = data$Month[data$Year==input$Year])
        )
    
    observeEvent(
        input$Month,
        updateSelectInput(session, "Name", "Name", choices = data$Name[data$Month==input$Month & data$Year==input$Year])
    )
    
    output$dataset = renderTable({
        data
    })
    
})