library(shiny)
library(ggplot2)

shinyServer(function(input,output)({
    
    var = reactive({
        switch(input$dataset,
               "iris" = names(iris), # if dataset is iris, then return all the column names of iris
               "mtcars" = names(mtcars),
               "trees" = names(trees)
               )
    })
    
    output$vx = renderUI({
        selectInput("variablex", "Select the First (X) variable", choices = var())
    })
    
    output$vy = renderUI({
        selectInput("variabley", "Select the First (Y) variable", choices = var())
    })
    
    output$p = renderPlot({
        attach(get(input$dataset))
        plot(x = get(input$variablex), y = get(input$variabley), xlab = input$variablex, ylab = input$variabley)
    })
    
})
    
    )