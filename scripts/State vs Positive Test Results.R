library(tidyverse)

source("Summary_Information_Script.R")

# This plots the proportion of positive COVID-19 out of total test results in each state.

ggplot(data = state_positive_totalResults, aes(y=ratio, x=state)) + 
  geom_bar(position="dodge", stat="identity", fill = "red") +
  ggtitle("Proportion of Positive COVID-19 Test Results Out of Total Test Results in Each State") +
  xlab("State") +
  ylab("Proportion of Positive COVID-19 Test Results") 
  