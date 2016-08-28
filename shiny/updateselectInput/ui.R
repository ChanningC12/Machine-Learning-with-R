library(shiny)

shinyUI(fluidPage(
    titlePanel("Demo updateselectInput() and aso introducing observeEvent() function"),
    selectInput("Year", "Year", choices = unique(data$Year)),
    selectInput("Month","Month", choices = "", selected = ""), # empty choice
    selectInput("Name","Name", choices = "", selected = ""),
    tableOutput("dataset")
    ))