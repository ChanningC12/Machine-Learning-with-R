# Share the shiny app: share through a server
# two components: User Interface (UI), Server Instruction

### Step 1: App template
# ui = fluidPage()
# server = function(input, output){}
# shinyApp(ui = ui, server = server)

### Step 2: Add elements as arguments to fluidPage()
### Step 3: Create reactive inputs with an *Input() function
### Step 4: Display reactive results with an *Output() function


# Input functions
# Buttons: actionButton(), submitButton()
# Single checkbox: checkboxInput()
# CheckboxGroupInput()
# Date input: dateInput()
# Date range: dateRangeInput()
# File input: fileInput()
# Numeric input: numericInput()
# Password input: passwordInput()
# Radio buttons: radioButtons()
# Select box: selectInput()
# Sliders: sliderInput()
# Text input: textInput()

# Syntax: sliderInput(inputId = "num", label = "Choose a number", ...)

# Output functions
# dataTableOutput()
# htmlOutput()
# imageOutput()
# plotOutput()
# tableOutput()
# textOutput()
# uiOutput()
# verbatimTextOutput()

# Syntax: plotOutput("plot")

# To display output, add it to fluidPage() with an *Output function.e.g. plotOutput(outputId="hist")

### Server
# server = function(input,output){
#    output$hist = renderPlot({hist(rnorm(input$num))})
# }
# 1. save objects to display to output$
# 2. build objects to display with render*(), which creates the type of output you wish to make
# 3. use input values with input$
# renderDataTable()
# renderImage()
# renderPlot()
# renderPrint()
# renderTable()
# renderText()
# renderUI()

# Share your app: every shiny app is maintained by a computer running R, app.R or ui.R and server.R
# Shinyapps.io, install shinyapps package



# 2. How to customize reactions
# Reactivity
# Reactive values nofity the functions that use them when they become invalid
# The objects created by reactive functions respond

# Managing state with reactiveValues()


# 3. Customize Appearance
# Add content with tags function: tags$h1() = <h1> </h1>
# names(tags)
# useful functions: a(), br(), code(), em(), h1(), hr(), img(), p(), strong()

# Layout functions: 
# fluidRow() adds rows to the grid
# column() adds columns within a row
# Panel: group multiple elements into a single unit with its own properties
# tabPanel: creates stackable layer of elements. Each tab is like a small UI of its own
# tabsetPanel: combines tabs into a single panel
# fluidPage(
#    tabsetPanel(
#        tabPanel("tab1", "contents")
#        tabPanel("tab2", "contents")
#        tabPanel("tab3", "contents")
#        ))

# navbarPage and navbarMenu
# dashboardPage() comes in the shinydashboard package



























