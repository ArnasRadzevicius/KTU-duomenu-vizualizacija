
library(shiny)
library(tidyverse)
library(shinydashboard)
library(readr)


ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = "Konsultacine verslo ir kito valdymo veikla - 702200"), 
                    dashboardSidebar(selectizeInput(inputId = "imones_pavadinimas",label = "Pavadinimas", choices = NULL, selected = NULL)),
                    dashboardBody(tabPanel("Vidutinio atlyginimo grafikas", plotOutput("plot"))))



server <- function(input, output, session) {
  data <- read_csv("https://github.com/kestutisd/KTU-duomenu-vizualizacija/raw/main/laboratorinis/data/lab_sodra.csv")
  
  
  
  sorted_data <- data %>%
    filter(ecoActCode == 702200)
  
  updateSelectizeInput(session, "imones_pavadinimas", 
                       choices = sorted_data$name, 
                       server = TRUE)
  
  output$plot <- renderPlot(
    sorted_data %>%
      filter(name == input$imones_pavadinimas) %>%
      ggplot(aes(x = month, y = avgWage)) +
      theme_minimal() +
      geom_line(colour = 'blue') +
      labs(x = "Month", y = "AverageWage"))
}
shinyApp(ui = ui, server = server)

