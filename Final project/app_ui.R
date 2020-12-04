# ui.R
library(shiny)
library(plotly)
library(tidyverse)
library(dplyr)

raw_data2 <- read.csv("../dataset/state_policy_updates_20201018_1346.csv", 
                      stringsAsFactors = F)
data2 <- subset(raw_data2, raw_data2$date != "1899-12-30")
data_cases2 <- read.csv("../dataset/us_states_covid19_daily.csv")
type <- c("positive", "totalTestResults", "hospitalized currently", 
          "recovered", "death")
colnames1 <- colnames(national_statistics)
select_columns <- colnames1[colnames1 != "date"]
###############################################################################
# Introduction
intro <- tabPanel()
###############################################################################
# Interactive page one

y_input_1 <- selectInput(
  inputId = "y_input",
  label = "Y variable",
  choices = select_columns
)

color_input_1 <- selectInput(
  inputId = "color_input",
  label = "Color",
  choices = list("Red" = "red", "Blue" = "blue", "Green" = "green")
)

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in the graph.

size_input_1 <- sliderInput(
  inputId = "size_input",
  label = "Size of point", min = 1, max = 10, value = 2
)

scatter_main_1 <- mainPanel(
  plotlyOutput("scatter1")
)

scatter_sidepanel_1 <- sidebarPanel(
  y_input_1,
  color_input_1,
  size_input_1
)

page_one <- tabPanel(
  title = "National COVID-19",
  titlePanel("National COVID-19 Trend"),
  sidebarLayout(
    scatter_sidepanel_1,
    scatter_main_1
)
)
###############################################################################
# Interactive page two
scatter_sidebar_2 <- sidebarPanel(
  selectInput(
    inputId = "state2",
    label = "Choose a State",
    choices = data2$state_id
  ),
  selectInput(
    inputId = "cases",
    label = "Choose a Data Type",
    choices = type
  )
)

scatter_main_2 <- mainPanel(
  plotlyOutput("scatter2"),
  plotlyOutput("scatter_cases2")
)

page_two <- tabPanel(
  title = "Policy",
  titlePanel("Policy and Cases"),
  sidebarLayout(
    scatter_sidebar_2,
    scatter_main_2
  )
)
###############################################################################
# Interactive page three
page_three <- tabPanel()

###############################################################################
# Summary
last <- tabPanel()

ui <- navbarPage(
  includeCSS("style.css"),
  title = "COVID-19",
  intro,
  page_one,
  page_two,
  page_three,
  last
)