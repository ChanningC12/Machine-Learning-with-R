# Example "01_hello"

library(shiny)
# setwd("../")
# setwd("Examples/01_hello/")
# getwd()   

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application Title
    titlePanel("Hello Shiny!"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "bins",
                "Number of bins:",
                min=1,
                max=50,
                value=30
                )
            ),
        
        # show plot of the generated distribution
        mainPanel(
            plotOutput(
                plotOutput("distPlot")
            )
        )
    )
    )
)


