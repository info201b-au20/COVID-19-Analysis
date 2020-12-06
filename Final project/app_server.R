# server.R
library(dplyr)
library(tidyverse)
library("ggplot2")
library("shiny")
library(plotly)
library("maps")
library("mapproj")
library("RColorBrewer")
library("leaflet") 

raw_data2 <- read.csv(file = "state_policy_updates_20201018_1346.csv")
data2 <- subset(raw_data2, raw_data2$date != "1899-12-30")
data_cases2 <- read.csv(file = "us_states_covid19_daily.csv")
###############################################################################
# Page one variables



###############################################################################
# Page two variables
data2$date <- as.Date(data2$date)


server <- function(input, output) {
  # Introduction
  # Page one
  source("Aggregate_Table_Script.R")
  national_statistics$date <-  as.Date(as.character.Date(national_statistics$date), "%Y%m%d")
  
    output$scatter1 <- renderPlotly({
      plot_national_COVID <- ggplot(data = national_statistics) +
        geom_point(
          mapping = aes_string(x = national_statistics$date, y = input$y_input),
          color = input$color_input,
          size = input$size_input
        ) +
        geom_line(mapping = aes_string(x = national_statistics$date, y = input$y_input)) +
        ggtitle("Trend Over Time") +
        xlab("Date")
      ggplotly(plot_national_COVID)
    })
  
  
  
  # Page two
  output$scatter2 <- renderPlotly({
    policy_per_month2 <- data2 %>% 
      filter(state_id == input$state2) %>% 
      mutate(month = format(date, "%m")) %>% 
      group_by(month) %>% 
      summarize(total = n())
    plot_policy_2 <- ggplot(policy_per_month2) +
      geom_point(
        mapping = aes(x = month, y = total)
      ) +
      labs(x = "Month", y = "Number of Published Policies", title = 
             "Published Policies Per Month Chart")
    ggplotly(plot_policy_2)
  })
  
  output$scatter_cases2 <- renderPlotly({
    type <- c("positive", "totalTestResults", "hospitalized currently", 
              "recovered", "death")
    types <- c("positive", "totalTestResults", "hospitalizedCurrently", 
              "recovered", "death")
    data_cases_state_2 <- data_cases2 %>% 
      filter(state == input$state2)
    plot_cases2 <- ggplot(data_cases_state_2) +
      geom_point(
        mapping = aes_string(x = data_cases_state_2$date, y = types[input$cases])
      ) +
      labs(x = "Date", y = "Cases", title = "COVID-19 Cases")
    ggplotly(plot_cases2)
  })

######## Page three ##################################################
### data ############
source("Summary_Information_Script.R")

case_ratio <- state_positive_totalResults
death_ratio <- state_death_totalResults

case_death_data <- case_ratio %>% 
  rename("case_ratio" = positive_ratio) %>%
  left_join(death_ratio, by = "state") %>% 
  rename("death_ratio" = death_ratio)

m_data <- case_death_data
m_data$state <- state.name[match(case_death_data$state, state.abb)]
m_data$state[is.na(case_death_data$state)] <- "district of columbia"
m_data <- drop_na(m_data)
m_data <- mutate(m_data, names = tolower(state))


states_data <- map_data("state") %>%
  rename(state = region) %>%
  left_join(m_data, by="state")

mapStates = map("state", fill = TRUE, plot = FALSE)
mapStates$names[60] <-  "washington"
mapStates$names[21] <- "massachusetts"
mapStates$names[55] <- "virginia"
mapStates$names[39] <- "north carolina"
mapStates$names[35] <- "new york"
mapStates$names[23] <- "michigan"
mapStates$names[24] <- "michigan"
mapStates$case_ratio <- m_data$case_ratio[match(mapStates$names, m_data$names)]
mapStates$death_ratio <- m_data$death_ratio[match(mapStates$names, m_data$names)]

################# create map #############################

output$map_id <- renderLeaflet({
  bins <- c(0, 0.001, 0.01, 0.1, 1)
  pal <- colorBin("YlOrRd", domain = m_data[[input$ratio_id]] , bins = bins)
  labels <- sprintf(
    "<strong>%s</strong><br/>%g",
    mapStates$names, mapStates[[input$ratio_id]]
  ) %>% lapply(htmltools::HTML)
  
  leaflet(data = mapStates) %>% 
    addPolygons(
      fillColor = ~pal(mapStates[[input$ratio_id]]),
      weight = 3,
      opacity = 1,
      color = "white",
      dashArray = "2",
      fillOpacity = 0.7,
      highlight = highlightOptions(
        weight = 5,
        color = "#666",
        fillOpacity = 0.7,
        bringToFront = TRUE),
      label = labels
    )
})

##########################################################

  # Summary

}
