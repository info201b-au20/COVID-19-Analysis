library(tidyverse)

source("Aggregate_Table_Script.R")

# This plots the U.S. increase of COVID-19 deaths each day.

national_statistics$date <-  as.Date(as.character.Date(national_statistics$date), "%Y%m%d")

ggplot(data = national_statistics, mapping=aes(x = date, y = national_new_deaths)) +
  geom_point() +
  geom_line() +
  ggtitle("Daily U.S. COVID-19 Deaths Increase ") +
  xlab("Date") +
  ylab("Daily COVID-19 Deaths Increase") +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")
