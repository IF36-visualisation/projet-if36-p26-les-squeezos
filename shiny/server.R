#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

jeux <- read.csv('../../games_march2025_cleaned.csv')
jeux_genres_separes$release_year <- substr(jeux_genres_separes$release_date, 1, 4)

#jeux_genres_separes %>% filter(release_year > 2010) %>% count()
# Trop peu de jeux avant 2010 donc on décide de ne considérer que les jeux sortis après 2010 pour une meilleure visibilité.
jeux_genres_separes <- jeux_genres_separes %>% filter(release_year > 2010)


# Define server logic required to draw a histogram
function(input, output) {
    output$plot1 <- renderPlotly({
      jeux_genres_choisis <- jeux_genres_separes %>% filter(genres %in% input$selected_genres)
      
      graph <- ggplot(jeux_genres_choisis, mapping = aes(x = release_year, color = genres, 
                                                         group = genres)) + 
      geom_point(stat = "count") + geom_line(stat = "count") +
      labs(title = "Nombre de jeux par année pour chaque genre", y = "Nombre de jeux", x = "Genre") + 
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    ggplotly(graph)
    })
  
    output$plot2 <- renderPlotly({
      jeux_genres_choisis <- jeux_genres_separes %>% filter(genres %in% input$selected_genres)
      mean_by_year <- aggregate(pct_pos_total ~ release_year + genres, data=jeux_genres_choisis, mean)
      
      graph <- ggplot(mean_by_year, mapping = aes(x = release_year, y = pct_pos_total, color = genres, 
                                                         group = genres)) + 
        geom_point() + geom_line() +
        labs(title = "Appréciation des jeux par année pour chaque genre", y = "Nombre de jeux", x = "Genre") + 
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
      ggplotly(graph)
    })

}