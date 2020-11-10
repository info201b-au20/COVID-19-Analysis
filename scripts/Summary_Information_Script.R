
data <- read.csv("us_states_covid19_daily.csv", stringsAsFactors = F)
library(tidyverse)
data$positive[is.na(data$positive)] <- 0
data$death[is.na(data$death)] <- 0
data$total[is.na(data$total)] <- 0
data$hospitalizedCurrently[is.na(data$hospitalizedCurrently)] <- 0

# 1. The ratio of positive to totalTestResults in each state.
state_positive_totalResults <- data %>% 
  filter(date == max(date)) %>% 
  group_by(state) %>% 
  summarise(ratio = positive / total) %>% 
  select(state, ratio)

# 2. The ratio of death to totalTestResults in each state.
state_death_totalResults <- data %>% 
  filter(date == max(date)) %>% 
  group_by(state) %>% 
  summarise(ratio = death / total) %>% 
  select(state, ratio)
View(state_death_totalResults)

# 3. Daily increase in positive cases in each state.
state_daily_positive_increase <- data %>% 
  group_by(date, state) %>% 
  summarise(increase = positive - lag(positive, default = 0))

# 4. Daily increase in death cases in each state.
state_daily_death_increase <- data %>% 
  group_by(date, state) %>% 
  summarise(increase = death - lag(death, default = 0))

# 5. The daily ratio of hospitalized currently to positive cases in each state
ratio_hospitalized_total <- data %>% 
  group_by(date, state) %>% 
  summarise(ratio = hospitalizedCurrently / positive)
ratio_hospitalized_total$ratio[is.na(ratio_hospitalized_total$ratio)] <- 0
