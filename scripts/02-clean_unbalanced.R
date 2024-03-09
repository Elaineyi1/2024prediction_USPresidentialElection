#### Preamble ####
# Purpose: Clean the census data (population) from IPUMS
# and the survey data (sample) from Polarization Research Lab, America's Political Pulses
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 7 March 2023
# Prerequisites: Get familiar with the population and sample datasets

# install.packages('dplyr')
# install.packages('readr')
library(dplyr)
library(readr)

# Clean the dataset
data_app_clean <- data_app_raw |> 
  select(inputstate, gender, race, educ, pid3, marstat, birthyr) |>
  mutate(Race_mod = case_when(
    race == "White" ~ "White",
    race == "Black" ~ "Black",
    race == "Asian" ~ "Asian",
    race %in% c("Native American", "Middle Eastern", "Two or more races", "Other", "Hispanic") ~ "Other race"
  ),
  Age = 2024 - birthyr) |> filter(marstat != "Domestic / civil partnership")

data_ipums_clean <- data_ipums |> 
  select(SEX, MARST, STATEICP, RACE, EDUC, AGE) |> 
  mutate(Race_mod = case_when(
    RACE == 1 ~ "White",
    RACE == 2 ~ "Black",
    RACE %in% c(4, 5, 6) ~ "Asian",
    RACE %in% c(3, 7, 8, 9) ~ "Other race"
  ),
  Marital_mod = case_when(
    MARST %in% c(1, 2) ~ "Married",
    MARST == 3 ~ "Separated",
    MARST == 4 ~ "Divorced",
    MARST == 5 ~ "Widowed",
    MARST == 6 ~ "Never married",
    MARST == 9 ~ "Blank"
  ),
  SEX = case_when(
    SEX == 1 ~ "Male",
    SEX == 2 ~ "Female"),
  Education_mod = case_when(
    EDUC %in% c(00, 01, 02, 03, 04, 05) ~ "No HS",
    EDUC == 06 ~ "High school graduate",
    EDUC == 07 ~ "Some college",
    EDUC == 08 ~ "2-year",
    EDUC == 10 ~ "4-year",
    EDUC == 11 ~ "Post-grad",
    TRUE ~ "No HS"
  ))

data_ipums_clean <- data_ipums_clean |>
  filter(AGE >= 18) |>
  mutate(
    age_group = case_when(
      AGE >= 18 & AGE <= 29 ~ "18-29",
      AGE >= 30 & AGE <= 44 ~ "30-44",
      AGE >= 45 & AGE <= 59 ~ "45-59",
      AGE >= 60 ~ "60+"
    )
  )
data_app_clean <- data_app_clean |>
  filter(Age >= 18) |>
  mutate(
    age_group = case_when(
      Age >= 18 & Age <= 29 ~ "18-29",
      Age >= 30 & Age <= 44 ~ "30-44",
      Age >= 45 & Age <= 59 ~ "45-59",
      Age >= 60 ~ "60+"
    )
  )

state_codes <- data.frame(
  STATEICP = c(01, 02, 03, 04, 05, 06, 11, 12, 13, 14, 21, 22, 23, 24, 25, 31, 32, 33, 34, 35, 36, 37, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 52, 53, 54, 56, 61, 62, 63, 64, 65, 66, 67, 68, 71, 72, 73, 81, 82, 98),
  inputstate = c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "Delaware", "New Jersey", "New York", "Pennsylvania", "Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota", "Virginia", "Alabama", "Arkansas", "Florida", "Georgia", "Louisiana", "Mississippi", "North Carolina", "South Carolina", "Texas", "Kentucky", "Maryland", "Oklahoma", "Tennessee", "West Virginia", "Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "California", "Oregon", "Washington", "Alaska", "Hawaii", "District of Columbia"),
  state2 = c("CT", "ME", "MA", "NH", "RI", "VT", "DE", "NJ", "NY", "PA", "IL", "IN", "MI", "OH", "WI", "IA", "KS", "MN", "MO", "NE", "ND", "SD", "VA", "AL", "AR", "FL", "GA", "LA", "MS", "NC", "SC", "TX", "KY", "MD", "OK", "TN", "WV", "AZ", "CO", "ID", "MT", "NV", "NM", "UT", "WY", "CA", "OR", "WA", "AK", "HI", "DC")
)
data_ipums_clean$STATEICP <- as.numeric(data_ipums_clean$STATEICP)
data_ipums_clean <- data_ipums_clean |>
  left_join(state_codes, by = "STATEICP") 
data_ipums_clean <- data_ipums_clean |> select(SEX, Marital_mod, inputstate, state2, Education_mod, Race_mod, STATEICP, age_group)

data_app_clean <- data_app_clean |>
  left_join(state_codes, by = "inputstate") 
data_app_clean <- data_app_clean |>
  select(Race_mod, STATEICP, inputstate, state2, pid3, gender, educ, marstat, age_group)

data_app_clean <- data_app_clean |> filter(pid3 %in% c("Republican", "Democrat")) 
data_app_clean <- data_app_clean |>
  mutate(vote_biden = as.numeric(case_when(
    pid3 == "Republican" ~ 0,
    pid3 == "Democrat" ~ 1
  )))


# Rename column names
data_app_clean <- data_app_clean |>
  rename(race = Race_mod,
         stateicp = STATEICP,
         statename = inputstate,
         state_abv = state2,
         education = educ,
         marital = marstat,
         age = age_group)

data_ipums_clean <- data_ipums_clean |>
  rename(race = Race_mod,
         stateicp = STATEICP,
         statename = inputstate,
         state_abv = state2,
         gender = SEX,
         education = Education_mod,
         marital = Marital_mod,
         age = age_group)

# Save cleaned datasets
write_csv(
  x = data_ipums_clean,
  file = "inputs/IPUMS/cleaned_population_data.csv"
)

write_csv(
  x = data_app_clean,
  file = "inputs/APP/cleaned_sample_data.csv"
)

write_csv(
  x = data_app_raw,
  file = "inputs/APP/raw_sample_data.csv"
)

