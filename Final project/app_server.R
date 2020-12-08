# Load packages

library("tidyverse")
library("ggplot2")
library("shiny")
library("plotly")
library("maps")
library("mapproj")
library("RColorBrewer")
library("leaflet")

# Create a server for the Shiny app
server <- function(input, output) {
  ##### Page one ##############################################################
  source("Aggregate_Table_Script.R")
  
  # List the different choices
  
  choose_1 <- list(
    "National total cases" = "national_total_cases",
    "National total deaths" = "national_total_deaths",
    "National current hospitalized" =
      "national_current_hospitalized",
    "National new cases" = "national_new_cases",
    "National new Deaths" = "national_new_deaths",
    "National new Hospitalized" = "national_new_hospitalized"
  )
  
  # Change the date format to year/month/day
  
  national_statistics$date <- as.Date(as.character.Date(
    national_statistics$date
  ), "%Y%m%d")

  # Create the first scatter plot
  
  output$scatter1 <- renderPlotly({
    plot_national_covid <- ggplot(data = national_statistics) +
      geom_point(
        mapping = aes_string(
          x = national_statistics$date,
          y = choose_1[[input$y_input]]
        ),
        color = input$color_input,
        size = input$size_input
      ) +
      geom_line(mapping = aes_string(
        x = national_statistics$date,
        y = choose_1[[input$y_input]]
      )) +
      ggtitle("Trend Over Time") +
      xlab("Date") +
      ylab(input$y_input)
    ggplotly(plot_national_covid)
  })



  #### Page two ###############################################################
  output$scatter2 <- renderPlotly({
    raw_data2 <- read.csv(file = "state_policy_updates_20201018_1346.csv")
    data2 <- subset(raw_data2, raw_data2$date != "1899-12-30")
    data2$date <- as.Date(data2$date)
    # How mach policies published each month?
    policy_per_month2 <- data2 %>%
      filter(state_id == input$state2) %>%
      mutate(month = format(date, "%m")) %>%
      group_by(month) %>%
      summarize(total = n())
    
    # Create graph "Published policies per month" chart
    plot_policy_2 <- ggplot(policy_per_month2) +
      geom_point(
        mapping = aes(x = month, y = total)
      ) +
      labs(
        x = "Month", y = "Number of Published Policies", title =
          "Published Policies Per Month Chart"
      )
    ggplotly(plot_policy_2)
  })
  
  # Create graph "COVID-19 Cases"
  output$scatter_cases2 <- renderPlotly({
    data_cases2 <- read.csv(file = "us_states_covid19_daily.csv")
    name <- list(
      "Positive case" = "positive",
      "Total Test Result" = "totalTestResults",
      "Hospitalized currently" = "hospitalizedCurrently",
      "Recovered case" = "recovered", "Death case" = "death"
    )
    data_cases_state_2 <- data_cases2 %>%
      filter(state == input$state2)
    plot_cases2 <- ggplot(data_cases_state_2) +
      geom_point(
        mapping = aes_string(x = "date", y = name[[input$cases]])
      ) +
      labs(x = "Date", y = "Cases", title = "COVID-19 Cases")
    ggplotly(plot_cases2)
  })

  ######## Page three #########################################################

  ################# create map ################################################

  output$map_id <- renderLeaflet({
    source("Summary_Information_Script.R")
    case_ratio <- state_positive_totalResults
    death_ratio <- state_death_totalResults
    
    ### combine data ###
    case_death_data <- case_ratio %>%
      rename("case_ratio" = positive_ratio) %>%
      left_join(death_ratio, by = "state") %>%
      rename("death_ratio" = death_ratio)
    
    ### change state abbreviation to full name in lower case
    m_data <- case_death_data
    m_data$state <- state.name[match(case_death_data$state, state.abb)]
    m_data$state[is.na(case_death_data$state)] <- "district of columbia"
    m_data <- drop_na(m_data)
    m_data <- mutate(m_data, names = tolower(state))
    
    ### create map geography and fill out null places ###
    map_states <- map("state", fill = TRUE, plot = FALSE)
    mapStates$names[56] <-  "washington"
    mapStates$names[57] <-  "washington"
    mapStates$names[58] <-  "washington"
    mapStates$names[59] <-  "washington"
    mapStates$names[60] <-  "washington"
    mapStates$names[20] <- "massachusetts"
    mapStates$names[21] <- "massachusetts"
    mapStates$names[22] <- "massachusetts"
    mapStates$names[21] <- "massachusetts"
    mapStates$names[34] <- "new york"
    mapStates$names[35] <- "new york"
    mapStates$names[36] <- "new york"
    mapStates$names[37] <- "new york"
    mapStates$names[38] <- "north carolina"
    mapStates$names[39] <- "north carolina"
    mapStates$names[40] <- "north carolina"
    mapStates$names[23] <- "michigan"
    mapStates$names[24] <- "michigan"
    mapStates$names[53] <- "virginia"
    mapStates$names[54] <- "virginia"
    mapStates$names[55] <- "virginia"
    map_states$case_ratio <- m_data$case_ratio[match(
      map_states$names,
      m_data$names
    )]
    map_states$death_ratio <- m_data$death_ratio[match(
      map_states$names,
      m_data$names
    )]
    mapStates$case_ratio[8] <- 0.040009550
    mapStates$death_ratio[8] <- 0.0016371121
    
    max = max(m_data[[input$ratio_id]])
    bins <- c(0, max/8, max/6, max/4, max/2, 1)
    pal <- colorBin("YlOrRd", domain = m_data[[input$ratio_id]], bins = bins)
    labels <- sprintf(
      "<strong>%s</strong><br/>%g",
      map_states$names, map_states[[input$ratio_id]]
    ) %>% lapply(htmltools::HTML)

    leaflet(data = map_states) %>%
      addPolygons(
        fillColor = ~ pal(map_states[[input$ratio_id]]),
        weight = 3,
        opacity = 1,
        color = "white",
        dashArray = "2",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        label = labels
      ) %>% 
      addLegend(pal = pal, values = mapStates[[input$ratio_id]], opacity = 0.7, title = "Ratio",
                position = "bottomright")
  })
}
