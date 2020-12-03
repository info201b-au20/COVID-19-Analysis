# ui.R
library(shiny)
library(plotly)
library(tidyverse)
library(dplyr)

# Introduction
intro <- tabPanel()
# Interactive page one
page_one <- tabPanel()
# Interactive page two
page_two <- tabPanel()
# Interactive page three
page_three <- tabPanel()
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