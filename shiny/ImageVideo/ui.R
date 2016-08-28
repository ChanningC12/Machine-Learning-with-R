library(shiny)
names(tags)

shinyUI(fluidPage(
    
    sidebarLayout(
        sidebarPanel(
            tags$img(src = "IMG_1890.jpg", heights = 100, width = 200)
            ),
        mainPanel("vd")
        )
    
    ))