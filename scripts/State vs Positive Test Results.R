library(tidyverse)

source("Summary_Information_Script.R")

# This plots the proportion of positive COVID-19 out of total test results in each state.

state_positive_ratio <- ggplot(data = state_positive_totalResults, aes(y=positive_ratio, x=state)) + 
  geom_bar(position="dodge", stat="identity", fill = "red") +
  ggtitle("Proportion of Confirmed Cases in Each State") +
  xlab("State") +
  ylab("Proportion of Positive COVID-19 Test Results") + 
  coord_flip() +
  theme_bw(base_size=5)
