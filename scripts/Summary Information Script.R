data <- read.csv("us_states_covid19_daily.csv", stringsAsFactors = F)
library(tidyverse)

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
