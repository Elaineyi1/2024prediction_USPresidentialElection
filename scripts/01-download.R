#### Preamble ####
# Purpose: Download and Read in census data and survey data from IPUMS 
# and Polarization Research Lab, and the 2020 vote results from Kaggle
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 7 March 2024
# Prerequisites: Request for IPUMS ACS data.

# install.packages('ipumsr')
# install.packages('dplyr')
# install.packages('readr')
# install.packages('tidyr')
# install.packages('arrow')
# install.packages('ggplot2')
# install.packages('knitr')
# install.packages('statebins')
# install.packages('modelsummary')
# install.packages('broom')
# install.packages("here")
# install.packages("kableExtra")
library(ipumsr)

# Read in the population data from IPUMS (3373378 obs)
ddi <- read_ipums_ddi("inputs/IPUMS/usa_00005.xml")
data_ipums <- read_ipums_micro(ddi)

# Read in data from American's Political Pulse (20000 obs)
app_week41 <- read.csv("inputs/APP/2023_week41_Oct-06--Oct-13.csv")
app_week42 <- read.csv("inputs/APP/2023_week42_Oct-13--Oct-19.csv")
app_week43 <- read.csv("inputs/APP/2023_week43_Oct-20--Oct-26.csv")
app_week44 <- read.csv("inputs/APP/2023_week44_Oct-27--Nov-02.csv")
app_week45 <- read.csv("inputs/APP/2023_week45_Nov-03--Nov-09.csv")
app_week46 <- read.csv("inputs/APP/2023_week46_Nov-10--Nov-16.csv")
app_week47 <- read.csv("inputs/APP/2023_week47_Nov-17--Nov-27.csv")
app_week48 <- read.csv("inputs/APP/2023_week48_Nov-24--Nov-30.csv")
app_week49 <- read.csv("inputs/APP/2023_week49_Dec-01--Dec-07.csv")
app_week50 <- read.csv("inputs/APP/2023_week50_Dec-08--Dec-14.csv")
app_week51 <- read.csv("inputs/APP/2023_week51_Dec-15--Dec-24.csv")
app_week52 <- read.csv("inputs/APP/2023_week52_Dec-22--Jan-01.csv")

app_week8 <- read.csv("inputs/APP/2024_week8_Feb-16--Feb-23.csv")
app_week7 <- read.csv("inputs/APP/2024_week7_Feb-09--Feb-15.csv")
app_week6 <- read.csv("inputs/APP/2024_week6_Feb-02--Feb-08.csv")
app_week5 <- read.csv("inputs/APP/2024_week5_Jan-26--Feb-01.csv")
app_week4 <- read.csv("inputs/APP/2024_week4_Jan-19--Jan-25.csv")
app_week3 <- read.csv("inputs/APP/2024_week3_Jan-12--Jan-19.csv")
app_week2 <- read.csv("inputs/APP/2024_week2_Jan-06--Jan-12.csv")
app_week1 <- read.csv("inputs/APP/2024_week1_Dec-29--Jan-05.csv")
data_app_raw <- rbind(app_week41, app_week42, app_week43, app_week44, app_week45, app_week46, app_week47, app_week48, app_week49, app_week50, app_week51, app_week52, app_week8, app_week7, app_week6, app_week5, app_week4, app_week3, app_week2, app_week1)

# Read in data from Kaggle
statevote_2020 <- read.csv('inputs/Kaggle/president_county_candidate.csv')
