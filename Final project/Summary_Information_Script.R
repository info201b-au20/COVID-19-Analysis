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
  summarise(positive_ratio = positive / total) %>% 
  select(state, positive_ratio)

# 2. The ratio of death to totalTestResults in each state.
state_death_totalResults <- data %>% 
  filter(date == max(date)) %>% 
  group_by(state) %>% 
  summarise(death_ratio = death / total) %>% 
  select(state, death_ratio)

# 3. Daily increase in positive cases in each state.
state_daily_positive_increase <- data %>% 
  group_by(date, state) %>% 
  summarise(positive_increase = positive - lag(positive, default = 0)) %>%
  select(date, state, positive_increase)

# 4. Daily increase in death cases in each state.
state_daily_death_increase <- data %>% 
  group_by(date, state) %>% 
  summarise(death_increase = death - lag(death, default = 0)) %>%
  select(date, state, death_increase)

# 5. The daily ratio of hospitalized currently to positive cases in each state
ratio_hospitalized_total <- data %>% 
  group_by(date, state) %>% 
  summarise(hospitalized_ratio = hospitalizedCurrently / positive) %>%
  select(date, state, hospitalized_ratio)
ratio_hospitalized_total$hospitalized_ratio[is.na(ratio_hospitalized_total$hospitalized_ratio)] <- 0

