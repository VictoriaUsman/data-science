
# Load libraries
library(shiny)
library(shinydashboard)
library(ggplot2)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Iris Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualizations", tabName = "viz", icon = icon("chart-bar")),
      # Interactive Function: Slider to filter by Sepal Length
      sliderInput("sepal_range", "Filter Sepal Length:", 
                  min = 4, max = 8, value = c(4, 8), step = 0.1)
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "viz",
        fluidRow(
          # Visualization 1: Species Count
          box(plotOutput("speciesPlot"), title = "Species Distribution", width = 6),
          # Visualization 2: Sepal Relationship
          box(plotOutput("scatterPlot"), title = "Sepal Width vs Length", width = 6)
        ),
        fluidRow(
          # Visualization 3: Petal Length Boxplot
          box(plotOutput("boxPlot"), title = "Petal Length Analysis", width = 12)
        )
      )
    )
  )
)

# Define Server
server <- function(input, output) {
  # Reactive filtering based on slider input
  filtered_iris <- reactive({
    iris[iris$Sepal.Length >= input$sepal_range[1] & iris$Sepal.Length <= input$sepal_range[2], ]
  })

  output$speciesPlot <- renderPlot({
    ggplot(filtered_iris(), aes(x = Species, fill = Species)) + 
      geom_bar() + theme_minimal() + labs(y = "Count")
  })

  output$scatterPlot <- renderPlot({
    ggplot(filtered_iris(), aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
      geom_point(size = 3) + theme_minimal()
  })

  output$boxPlot <- renderPlot({
    ggplot(filtered_iris(), aes(x = Species, y = Petal.Length, fill = Species)) + 
      geom_boxplot() + theme_minimal()
  })
}

# Run the App
shinyApp(ui = ui, server = server)