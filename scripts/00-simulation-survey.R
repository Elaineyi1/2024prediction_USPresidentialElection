# Purpose: Simulate the survey data from Polarization Research Lab 
# and the 2020 vote results from Kaggle
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 7 March 2024
# Prerequisites: Download and get familiar with the survey dataset

set.seed(123)

statename = c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "Delaware", "New Jersey", "New York", "Pennsylvania", "Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota", "Virginia", "Alabama", "Arkansas", "Florida", "Georgia", "Louisiana", "Mississippi", "North Carolina", "South Carolina", "Texas", "Kentucky", "Maryland", "Oklahoma", "Tennessee", "West Virginia", "Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "California", "Oregon", "Washington", "Alaska", "Hawaii", "District of Columbia")
race = c("White", "Other", "Hispanic", "Two or more races", "Asian", "Black", "Middle Eastern","Native American")
education = c("4-year","Post-grad", "2-year","Some college", "High school graduate","No HS")
marital = c("Domestic / civil partnership","Widowed","Married","Never married","Divorced","Separated")
vote2020 = c("Joe Biden","Donald Trump","Other","Jo Jorgensen","Did not vote for President","Howie Hawkins")
candidate = c("Joe Biden", "Donald Trump")

simulated_app <-
  tibble("race" = sample(race, 500, replace = TRUE),
         "birthyr" = sample(1910:2006, 500, replace = TRUE),
         "statename" = sample(statename, 500, replace = TRUE),
         "gender" = sample(c('Female','Male'), 500, replace = TRUE),
         "pid3" = sample(c("Republican","Democrat","Independent","Other","Not sure"), 500, replace = TRUE),
         "education" = sample(education, 500, replace = TRUE),
         "vote2020" = sample(vote2020, 500, replace = TRUE),
         "marital" = sample(marital, 500, replace = TRUE))


simulated_2020 <- tibble("statename" = rep(statename, each = 2),
                         "candidate" = c(rep(x = candidate, times = 51)),
                         "votes" = sample(10000:10000000, 102, replace = TRUE))
                         


