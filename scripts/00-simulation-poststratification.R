# Purpose: Simulate the census data from the IPUMS
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 7 March 2024
# Prerequisites: Download and get familiar with the post-stratification dataset

set.seed(123)
race_ipums = c('White', 'Black/African American', 'American Indian or Alaska Native', 'Chinese', 'Japanese', 'Other Asian or Pacific Islander', 'Other race, nec', 'Two major races', 'Three or more major races')
education_ipums = c('N/A or no schooling','Nursery school to grade 4', 'Grade 5, 6, 7, or 8','Grade 9','Grade 10','Grade 11','Grade 12','1 year of college', '2 years of college','3 years of college', '4 years of college', '5+ years of college')
marital_ipums = c('Married, spouse present','Married, spouse absent','Separated','Divorced', 'Widowed','Never married/single')
stateicp = c(01, 02, 03, 04, 05, 06, 11, 12, 13, 14, 21, 22, 23, 24, 25, 31, 32, 33, 34, 35, 36, 37, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 52, 53, 54, 56, 61, 62, 63, 64, 65, 66, 67, 68, 71, 72, 73, 81, 82, 98)

simulated_ipums <-
  tibble("race" = sample(race_ipums, 5000, replace = TRUE),
         "age" = sample(18:110, 5000, replace = TRUE),
         "stateicp" = sample(stateicp, 5000, replace = TRUE),
         "gender" = sample(c('Female','Male'), 5000, replace = TRUE),
         "education" = sample(education_ipums, 5000, replace = TRUE),
         "marital" = sample(marital_ipums, 5000, replace = TRUE))