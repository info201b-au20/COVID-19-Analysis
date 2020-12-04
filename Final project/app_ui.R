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

# Introduction
intro <- tabPanel()
# Interactive page one
page_one <- tabPanel()
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

# Interactive page three
page_three <- tabPanel()
# Summary
last <- tabPanel()

ui <- navbarPage(
  #includeCSS("style.css"),
  title = "COVID-19",
  intro,
  page_one,
  page_two,
  page_three,
  last
)