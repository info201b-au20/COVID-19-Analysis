data <- read.csv("us_states_covid19_daily.csv", stringsAsFactors = F)
library(tidyverse)
data$positive[is.na(data$positive)] <- 0
data$death[is.na(data$death)] <- 0
data$hospitalizedCurrently[is.na(data$hospitalizedCurrently)] <- 0

# 1. calculate daily national total cases summed up by states  
national_total_cases <- data %>% 
  group_by(date) %>% 
  summarise(sum(positive)) %>% 
  select(date, "national_total_cases" = `sum(positive)`)

# 2. calculate daily national deaths cases summed up by states  
national_total_deaths <- data %>% 
  group_by(date) %>% 
  summarise(sum(death)) %>% 
  select(date, "national_total_deaths" = `sum(death)`)

# 3. calculate daily national current hospitalized people summed up by states  
national_current_hospitalized <- data %>% 
  group_by(date) %>% 
  summarise(sum(hospitalizedCurrently)) %>% 
  select(date, "national_current_hospitalized" = `sum(hospitalizedCurrently)`)

# combine above three dataframe into one 
national_statistics <- left_join(national_total_cases, national_total_deaths)

national_statistics <- mutate(
  national_statistics,
  national_current_hospitalized
)

# 4. calculate daily national new cases and add it to national_statistics
national_statistics <- mutate(
  national_statistics,
  national_new_cases =  national_total_cases - lag(national_total_cases, 1, default = 0)
)

# 5. calculate daily national new deaths add it to national_statistics
national_statistics <- mutate(
  national_statistics,
  national_new_deaths =  national_total_deaths - lag(national_total_deaths, 1, default = 0)
)

# 6. calculate daily national change of hospitalized people add it to national_statistics
national_statistics <- mutate(
  national_statistics,
  national_new_hospitalized =  national_current_hospitalized - lag(national_current_hospitalized, 1, default = 0)
)
# View national overall statistics 
# View(national_statistics)
