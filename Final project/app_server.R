# server.R
library(dplyr)
library(tidyverse)
library("ggplot2")
library("shiny")
library(plotly)

raw_data2 <- read.csv("../dataset/state_policy_updates_20201018_1346.csv", 
                      stringsAsFactors = F)
data2 <- subset(raw_data2, raw_data2$date != "1899-12-30")
data_cases2 <- read.csv("../dataset/us_states_covid19_daily.csv")

# Page two variables
data2$date <- as.Date(data2$date)

server <- function(input, output) {
  # Introduction
  # Page one
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
    data_cases_state_2 <- data_cases2 %>% 
      filter(state == input$state2)
    plot_cases2 <- ggplot(data_cases_state_2) +
      geom_point(
        mapping = aes_string(x = data_cases_state_2$date, y = input$cases)
      ) +
      labs(x = "Date", y = "Cases", title = "COVID-19 Cases")
    ggplotly(plot_cases2)
  })
}
  # Page three
  # Summary
}