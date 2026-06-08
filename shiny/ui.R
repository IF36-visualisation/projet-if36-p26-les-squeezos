#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(plotly)

dashboardPage(
  dashboardHeader(title="Données sur les jeux Steam"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Graphiques", tabName = "graphs", icon = icon("th")),
      
      #Input pour sélectionner les genres
      checkboxGroupInput(
        inputId = "selected_genres",
        label = "Sélectionner les genres :",
        choices = unique(jeux_genres_separes$genres),
        selected = "Action"
      )
      
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "graphs",
              # Graphique du nombre de jeu par année pour chaque genre
              fluidRow(plotlyOutput("plot1"),
                       plotlyOutput("plot2"))
              )
      )
  )
)
