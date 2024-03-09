#### Preamble ####
# Purpose: Create and clean the balanced survey datasets
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 7 March 2024
# Prerequisites: Know the 2020 US presidential election popular votes ratio

library(dplyr)
library(tidyr)
library(readr)
library(arrow)

set.seed(123)
# Create a balanced survey dataset with 2020 votes ratio matching the actual votes ratio in the 2020 election.
data_app_clean_20_biden <- data_app_raw |> filter(presvote20post == "Joe Biden")
data_app_clean_20_trump <- data_app_raw |> filter(presvote20post == "Donald Trump")
trump_row <- data_app_clean_20_trump |> nrow()
data_app_clean_20_biden_balanced <- data_app_clean_20_biden |>
  slice_sample(n = floor(trump_row*51.3/46.9))
balanced_sample <- bind_rows(data_app_clean_20_biden_balanced, data_app_clean_20_trump)

# Clean the dataset
data_app_clean_20 <- balanced_sample |> 
  select(inputstate, gender, race, educ, pid3, marstat, birthyr, presvote20post) |>
  mutate(Race_mod = case_when(
    race == "White" ~ "White",
    race == "Black" ~ "Black",
    race == "Asian" ~ "Asian",
    race %in% c("Native American", "Middle Eastern", "Two or more races", "Other", "Hispanic") ~ "Other race"
  ),
  Age = 2024 - birthyr) |> filter(marstat != "Domestic / civil partnership")

data_app_clean_20 <- data_app_clean_20 |>
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
data_app_clean_20 <- data_app_clean_20 |>
  left_join(state_codes, by = "inputstate") 
data_app_clean_20 <- data_app_clean_20 |>
  select(Race_mod, STATEICP, inputstate, state2, pid3, gender, educ, marstat, age_group, presvote20post)

data_app_clean_20 <- data_app_clean_20 |> filter(pid3 %in% c("Democrat", "Republican")) |>
  mutate(vote_biden = as.numeric(case_when(
    pid3 == "Republican" ~ 0,
    pid3 == "Democrat" ~ 1
  )))

data_app_clean_20 <- data_app_clean_20 |>
  rename(race = Race_mod,
         stateicp = STATEICP,
         statename = inputstate,
         state_abv = state2,
         education = educ,
         marital = marstat,
         age = age_group,
         vote2020 = presvote20post)

# Clean the 2020 actual vote results dataset
statevote2020 <- statevote_2020 |> group_by(state, candidate) |> 
  filter(candidate %in% c("Donald Trump", "Joe Biden")) |> 
  summarize(votes = sum(total_votes)) |> 
  pivot_wider(names_from = candidate, values_from = votes, values_fill = 0) |> 
  rename(Donald_Trump = "Donald Trump", Joe_Biden = "Joe Biden") |> 
  mutate(support_biden_prop = Joe_Biden / (Joe_Biden + Donald_Trump))


# Save cleaned datasets
write_csv(
  x = data_app_clean_20,
  file = "inputs/APP/cleaned_sample_data_20.csv"
)

write_csv(
  x = statevote2020,
  file = "inputs/Kaggle/cleaned_actual_data_20.csv"
)

write_parquet(x = data_app_clean_20,
              sink = "inputs/APP/cleaned_sample_data_20.parquet")

write_parquet(x = statevote2020,
              sink = "inputs/Kaggle/cleaned_actual_data_20.parquet")
