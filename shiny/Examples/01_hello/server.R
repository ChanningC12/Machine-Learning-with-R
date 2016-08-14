library(shiny)

# Define server logic required to draw a distribution
shinyServer(
    function(input,output){
        
        # Expression that generates a histogram. The expression is wrapped in a call to renderPlot to indicate that:
        # 1. It is "reactive" and therefore should be automatically re-executed when inputs change
        # 2. Its output type is a plot
        
        output$distPlot = renderPlot({
            x = air2[,1] # air2 dataset column 1 - Ozone
            bins = seq(min(x),max(x),length.out=input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x,breaks = bins, col = "darkgrey", border = "white")
            })
    }
    )