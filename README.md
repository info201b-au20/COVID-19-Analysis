# Project Proposal

Team members:
Paul Sun, Jeff Ye, Joy Zhang, Alaia Chen

### Domain of interest
**Why are you interested in this field/domain?**  
We are interested in how COVID-19 affects of U.S policies and infrastructures in the United States.

**What other examples of data driven project have you found related to this domain (share at least 3)?**  
[Covid in the U.S.: Latest Map and Case Count](https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html)  
[CDC COVID Data Tracker](https://covid.cdc.gov/covid-data-tracker/#cases_casesinlast7days)  
[WHO Coronavirus Disease (COVID-19)](https://covid19.who.int/?gclid=CjwKCAjw_sn8BRBrEiwAnUGJDpn5H4K3_2eKWFi2g8J1Q263dgxMba5PWIvO4i59sCry-Du2o2APnhoC_HcQAvD_BwE)

**What data-driven questions do you hope to answer about this domain (share at least 3)?**
1. What is the relationship between confirmed cases and infrastructures in the United States since February?
2. What kind of policies that each state set up to control the number of people infected COVID-19?
3. How did the policies affect the number of COVID-19 cases in the U.S. since February, 2020?

### Finding Data
#### Data 1: United States DATA
**Where did you download the data (e.g., a web URL)?**  
[https://www.kaggle.com/diogoalex/covid19-stats-and-trends](https://www.kaggle.com/diogoalex/covid19-stats-and-trends)

**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**  
The data is collected by Diogo Silva, up201706892@fe.up.pt, The data is gathered from many different types of sources and form into a csv file. The data is about what has changed due to policies to fight COVID-19. It also shows the trend of community facilities throughout the COVID period.

**How many observations (rows) are in your data?**  
There are 31965 rows in the data set(COVID-19), each row presents daily Covid statistics of a country.

**How many features (columns) are in the data?**  
There are 19 columns in the data set(COVID-19) , each column shows a specific feature such as number of stores, and number of infrastructures.

**What questions (from above) can be answered using the data in this dataset?**
1. The average percent change of number of grocery/parks/residential/retail and recreation/transit stations from 2020/2/15 to 2020/10/13 in the US.
2. Daily rate of change of confirmed Covid-19 cases/ deaths from 2020/2/15 to 2020/10/13 in the US.
3. What is the relationship between confirmed cases and infrastructures in the United States since February?

#### Data 2: COVID-19 STATES DATA
**Where did you download the data (e.g., a web URL)?**  
[https://www.kaggle.com/sudalairajkumar/covid19-in-usa?select=us_states_covid19_daily.csv](https://www.kaggle.com/sudalairajkumar/covid19-in-usa?select=us_states_covid19_daily.csv)

**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**  
This data is obtained from [COVID-19 Tracking project](https://covidtracking.com/) and [NYTimes](https://github.com/nytimes/covid-19-data). This data has information from 50 US states and the District of Columbia at daily level.

**How many observations (rows) are in your data?**  
There are 11,634 observations in the dataset -  us_states_covid19_daily. Each row of the data means daily data  in each state.

**How many features (columns) are in the data?**  
There are 54 features in the dataset - us_states_covid19_daily.

**What questions (from above) can be answered using the data in this dataset?**  
1. The percentage of positive COVID-19 cases in one state compare with the total COVID-19  cases in the nation.
2. The daily increase of COVID-19 cases in all the states.
3. Within the positive COVID-19 cases, the percentage of people who recovered and died from COVID-19.

#### Data 3: Policy in Each State
**Where did you download the data (e.g., a web URL)?**  
[https://catalog.data.gov/dataset/covid-19-state-and-county-policy-orders](https://catalog.data.gov/dataset/covid-19-state-and-county-policy-orders)

**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**  
The data is collected and published by the U.S. Department of Health & Human Services. This data is a manually curated dataset that provides a standardized view into state and county policy orders. It shows the policies that are published in different states to cope with the COVID-19 situation.

**How many observations (rows) are in your data?**  
There are 2674 rows in the data. Each row represents a published policy in a state.

**How many features (columns) are in the data?**  
There are 10 columns in the data.

**What questions (from above) can be answered using the data in this dataset?**

1. What policy is the most efficient in reducing cases?
2. What changes have the policies made in society?
3. Which type of policy is published the most?
4. What kind of policies that each state set up to control the number of people infected COVID-19?
5. How did the policies affect the number of COVID-19 cases in the U.S. since February, 2020?
