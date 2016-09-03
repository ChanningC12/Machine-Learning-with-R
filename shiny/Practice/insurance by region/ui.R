library(shiny)

shinyUI(fluidPage(
    titlePanel("Insurance charges by region"),
    sidebarLayout(
        sidebarPanel(
            selectInput("smk", "Smoker", choices = c("yes","no")),
            selectInput("sex", "Sex", choices = c("female","male")),
            sliderInput("age","Age", min=min(insurance$age),max=max(insurance$age), value = c(min(insurance$age),max(insurance$age))),
            sliderInput("child","Children", min=min(insurance$children),max=max(insurance$children),value = c(min(insurance$children),max(insurance$children)))
            ),
        mainPanel(
            plotOutput("barplot"))
        )
    
    ))