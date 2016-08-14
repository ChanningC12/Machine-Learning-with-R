# create user interface
# control the layout, appearance,widgets that capture user input. Also, displayes the output (eg, the title, page layout, text input, radio buttons, drop down menus, graphs, etc.)

library(shiny)

# Define UI for the shiny application

shinyUI(fluidPage(
    # Application title
    titlePanel(title = "This is my first shiny app, hello shiny!"),
    
    sidebarLayout(position = "right",
        # Sidebar panel
        sidebarPanel(h3("this is side bar panel"), h4("widget4"),h5("widget5")),
        # Main Panel
        mainPanel(h4("this is the main panel text, output is displayed here"),
                  h5("this is the output5")
                  ),
                )
            )
    )

