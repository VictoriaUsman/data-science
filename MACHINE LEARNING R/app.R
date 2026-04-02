library(shiny)
library(shinydashboard)
library(ggplot2)

# Load the data
housing <- read.csv("c:/Data Science/MACHINE LEARNING R/housing.csv")

ui <- dashboardPage(
  dashboardHeader(title = "Housing Data Challenge"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("home"))
    )
  ),
  dashboardBody(
    fluidRow(
      # Visualization 1: Ocean Proximity (Bar Chart)
      box(plotOutput("oceanPlot"), title = "Home Locations by Proximity", width = 12)
    ),
    fluidRow(
      # Visualization 2: Population vs Households (Scatter)
      box(plotOutput("popHousePlot"), title = "Population vs Households", width = 6),
      # Visualization 3: Total Rooms vs Total Bedrooms (Scatter)
      box(plotOutput("roomBedPlot"), title = "Total Rooms vs Total Bedrooms", width = 6)
    )
  )
)

server <- function(input, output) {
  # 1. How many homes are in each location category
  output$oceanPlot <- renderPlot({
    ggplot(housing, aes(x = ocean_proximity, fill = ocean_proximity)) +
      geom_bar() +
      theme_minimal() +
      labs(x = "Location Category", y = "Number of Homes")
  })

  # 2. Population VS Households
  output$popHousePlot <- renderPlot({
    ggplot(housing, aes(x = households, y = population)) +
      geom_point(alpha = 0.5, color = "darkblue") +
      geom_smooth(method = "lm", color = "red") +
      theme_minimal()
  })

  # 3. Total Rooms VS Total Bedrooms
  output$roomBedPlot <- renderPlot({
    ggplot(housing, aes(x = total_rooms, y = total_bedrooms)) +
      geom_point(alpha = 0.5, color = "darkgreen") +
      geom_smooth(method = "lm", color = "orange") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)