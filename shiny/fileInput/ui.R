library(shiny)

shinyUI(fluidPage(
    titlePanel("File Input"),
    sidebarLayout(
        sidebarPanel(
            fileInput("file","Upload the file"),
            helpText("Default max. file size is 5MB"),
            tags$hr(),
            h5(helpText("Select the read.table parameter below")),
            checkboxInput("header","Header", value = F),
            checkboxInput("stringAsFactors", "stringAsFactors", F),
            br(),
            radioButtons("sep", "Separator", choices = c(Comma = ",", Semicolon = ";", Tab = "\t", Space = ''), selected = ",")
            ),
        
        mainPanel(
            uiOutput("tb")
            )
        
        )
    ))