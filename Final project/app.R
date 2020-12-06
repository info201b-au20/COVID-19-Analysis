# Load packages

library("shiny")
library("plotly")
library("tidyverse")
library("maps")
library("mapproj")
library("RColorBrewer")
library("leaflet") 

# Source the files needed to run Shiny app

source("app_ui.R")
source("app_server.R")

# Creates Shiny app

shinyApp(ui = ui, server = server)