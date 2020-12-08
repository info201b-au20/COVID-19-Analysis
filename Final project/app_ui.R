# Load the packages

library("shiny")
library("plotly")
library("tidyverse")
library("maps")
library("mapproj")
library("RColorBrewer")
library("leaflet")

###############################################################################
# Introduction

# First paragraph of introduction

first_p <- tags$p("Due the huge impacts of COVID-19, many people in the United
                  States has been through a lot of changes and difficulties.
                  Every time talking to our friends, Keep safe has been the
                  best wishes. Our group decided to analysis date about
                  COVID-19. Our data comes from the following two websites:")

# Second paragraph for the introduction

second_p <- tags$p("In order to combine two data sets and get more
                   understanding of COVID-19 conditions. We set three major
                   questions for this project:")

# Create three bullet points for the three questions

ul <- tags$ul(
  tags$li("What is the U.S. COVID-19 trend in time series?"),
  tags$li("Did the policy work to reduce the seriousness of COVID-19?"),
  tags$li("How serious is the COVID-19 condition in each state?")
)

# Creates the introduction tab panel

intro <- tabPanel(
  title = tags$h4("Introduction"),
  tags$header(h1("COVID-19 Project Introduction")),
  tags$img(src = "https://iforum-sg.c.huawei.com/dddd/images/2020/3/21/38ae040f-6684-4eb4-9724-a34dae9bd80b.png?imageId=84891"),
  first_p,
  tags$p(tags$a(
    href = "https://github.com/info201b-au20/COVID-19-Analysis/blob/gh-pages/dataset/us_states_covid19_daily.csv",
    "Daily state data set"
  )),
  tags$p(tags$a(
    href = "https://github.com/info201b-au20/COVID-19-Analysis/blob/gh-pages/dataset/state_policy_updates_20201018_1346.csv",
    "State policy data"
  )),
  second_p,
  ul
)
###############################################################################
# Interactive page one

# Source the data file from the analysis

source("Aggregate_Table_Script.R")

# Select the columns that need to be used

select_columns <- c(
  "National total cases", "National total deaths",
  "National current hospitalized", "National new cases",
  "National new Deaths", "National new Hospitalized"
)

# Y input of the scatter plot

y_input_1 <- selectInput(
  inputId = "y_input",
  label = "Y variable",
  choices = select_columns
)

# Color input of the scatter plot

color_input_1 <- selectInput(
  inputId = "color_input",
  label = "Color",
  choices = list("Red" = "red", "Blue" = "blue", "Green" = "green")
)

# Size input of the scatter plot

size_input_1 <- sliderInput(
  inputId = "size_input",
  label = "Size of point", min = 1, max = 10, value = 2
)

# Creates a main panel that will display the scatter plot

scatter_main_1 <- mainPanel(
  plotlyOutput("scatter1")
)

# Creates a sidebar panel to display the different y variable, color, and size
# choices

scatter_sidepanel_1 <- sidebarPanel(
  y_input_1,
  color_input_1,
  size_input_1
)

# Creates the tab panel for the first scatter plot

page_one <- tabPanel(
  title = tags$h4("National COVID-19"),
  tags$header(h1("National COVID-19 Trend")),
  sidebarLayout(
    scatter_sidepanel_1,
    scatter_main_1
  )
)
###############################################################################
# Interactive page two
raw_data2 <- read.csv(file = "state_policy_updates_20201018_1346.csv")
data2 <- subset(raw_data2, raw_data2$date != "1899-12-30")
state <- distinct(data2, state_id)
state <- state[[1]]
data_cases2 <- read.csv(file = "us_states_covid19_daily.csv")
type <- c(
  "Positive case", "Total Test Result", "Hospitalized currently",
  "Recovered case", "Death case"
)

# create sidebar choices
scatter_sidebar_2 <- sidebarPanel(
  # choose a state
  selectInput(
    inputId = "state2",
    label = "Choose a State",
    choices = state,
    selected = state[1]
  ),
  # choose a data type
  selectInput(
    inputId = "cases",
    label = "Choose a Data Type",
    choices = type,
    selected = type[1]
  )
)

# two graphs
scatter_main_2 <- mainPanel(
  plotlyOutput("scatter2"),
  plotlyOutput("scatter_cases2")
)

page_two <- tabPanel(
  title = tags$h4("Policy"),
  tags$header(h1("Policy and Cases")),
  sidebarLayout(
    scatter_sidebar_2,
    scatter_main_2
  ),
  p("The published policies per month chart shows how many policies in each 
    state were published in each month. The COVID-19 Cases chart shows the 
    number of five different type of cases in each state, which could help us 
    interpret the severity of the disease. By presenting the two graphs together
    , we could see whether more policies will help reduce the cases, or the 
    policies didn't help with the situation at all.")
)
###############################################################################
# Interactive page three ###

### create panel for map ###
page_three <- tabPanel(
  title = tags$h4("MAP"),
  tags$header(h1("State Condition")),
  sidebarLayout(
    sidebarPanel(
      p("You can choose the ratio you want to look at, the ratio is calculated
        by positive cases/death over total test result"),
      selectInput(
        inputId = "ratio_id",
        label = h3("Ratio Selection"),
        choices = c("case_ratio", "death_ratio"),
        selected = 1
      )
    ),
    mainPanel(
      tags$h1("MAP"),
      leafletOutput("map_id"),
      p("In the map, the darker the color, the higher the ratio.
         The states that have a high death ratio are 
         close to the coast such as NJ, MA, PA. 
         The states that have a high case ratio are generally 
         in the middle of the US such as SD, IA, TX. It could be that coast 
         enviroment benefits the spread of virus")
    )
  )
)
###############################################################################
# Summary

# FIrst paragraph of the conclusion page

p1 <- tags$p("The first COVID-19 case in United States is around April, and
             reach the peak in July. Until October, the national COVID-19 trend
             seems keep increasing. To brought from the National COVID-19 page,
             this disease is really drangerous because the data of new cases or
             deaths never reduce to zero since the first case was found.")

# Second paragraph of the conclusion page

p2 <- tags$p("In the plot of policies number each month, each states publish
             policies related to COVID-19 in order to control the condition.
             But, each state's cases still increasing.  Thus, those policies
             that try to reduce COVID-19 cases does not work.")

# Third paragraph of the conclusion page

p3 <- tags$p("In the map of each state COVID-19 condition, the darker color
             means the more serious stuation. There are patterns we can see
             on the map: the states that have a high death ratio are close
             to the coast such as NJ, MA, PA; the states that have a high
             case ratio are generally in the middle of the US such as SD,
             IA, TX.")

# Creates three bullet points to display the above three paragraphs

com <- tags$ul(
  tags$li(p1),
  tags$li(p2),
  tags$li(p3)
)

# Create a tab panel that will display the conclusion

last <- tabPanel(
  title = tags$h4("Summary"),
  tags$header(h1("Conclusion")),
  com
)

###############################################################################

# Create a ui for the Shiny app

ui <- navbarPage(
  includeCSS("style.css"),
  title = tags$h2("COVID-19"),
  selected = tags$h4("Introduction"),
  intro,
  page_one,
  page_two,
  page_three,
  last
)
