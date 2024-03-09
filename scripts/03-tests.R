# Purpose: Download and Read in census data and survey data from IPUMS 
# and Polarization Research Lab, and the 2020 vote results from Kaggle
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 9 March 2024
# Prerequisites: Be familar with the datasets.


# Testing data_app_clean
# State name and stateicp
connecticut_row_n <- data_app_clean |> filter(stateicp == 01) |> nrow()
connecticut_row <- data_app_clean |> filter(statename == 'Connecticut') |> nrow()
rhode_row_n <- data_app_clean |> filter(stateicp == 05) |> nrow()
rhode_row <- data_app_clean |> filter(statename == 'Rhode Island') |> nrow()
New_York_row_n <- data_app_clean |> filter(stateicp == 13) |> nrow()
New_York_row <- data_app_clean |> filter(statename == 'New York') |> nrow()
ohio_row_n <- data_app_clean |> filter(stateicp == 24) |> nrow()
ohio_row <- data_app_clean |> filter(statename == 'Ohio') |> nrow()
virginia_row_n <- data_app_clean |> filter(stateicp == 40) |> nrow()
virginia_row <- data_app_clean |> filter(statename == 'Virginia') |> nrow()
florida_row_n <- data_app_clean |> filter(stateicp == 43) |> nrow()
florida_row <- data_app_clean |> filter(statename == 'Florida') |> nrow()
maryland_row_n <- data_app_clean |> filter(stateicp == 52) |> nrow()
maryland_row <- data_app_clean |> filter(statename == 'Maryland') |> nrow()
New_Mexico_row_n <- data_app_clean |> filter(stateicp == 66) |> nrow()
New_Mexico_row <- data_app_clean |> filter(statename == 'New Mexico') |> nrow()
Hawaii_row_n <- data_app_clean |> filter(stateicp == 82) |> nrow()
Hawaii_row <- data_app_clean |> filter(statename == 'Hawaii') |> nrow()

stopifnot(connecticut_row_n == connecticut_row,
          rhode_row_n == rhode_row,
          New_York_row_n == New_York_row,
          ohio_row_n == ohio_row,
          virginia_row_n == virginia_row,
          florida_row_n == florida_row, 
          maryland_row_n == maryland_row,
          New_Mexico_row_n == New_Mexico_row,
          Hawaii_row_n == Hawaii_row)

# Race, Age, Gender, Education and Marital status
stopifnot(all(sort(unique(data_app_clean$race)) == sort(c('Asian', 'Black', 'White', 'Other race'))))
stopifnot(all(sort(unique(data_app_clean$age)) == sort(c("60+", "30-44", "18-29", "45-59"))))
stopifnot(all(sort(unique(data_app_clean$gender)) == sort(c("Male", "Female"))))
stopifnot(all(sort(unique(data_app_clean$marital)) == sort(c("Widowed","Married","Never married","Divorced","Separated"))))
stopifnot(all(sort(unique(data_app_clean$education)) == sort(c("Post-grad","4-year","Some college","High school graduate","2-year","No HS"))))

# Political
stopifnot(is.numeric(data_app_clean$vote_biden), 
          length(unique(data_app_clean$pid3)) == 2)


# Testing data_app_clean_20
Massachusetts20_row_n <- data_app_clean_20 |> filter(stateicp == 03) |> nrow()
Massachusetts20_row <- data_app_clean_20 |> filter(statename == 'Massachusetts') |> nrow()
Delaware20_row_n <- data_app_clean_20 |> filter(stateicp == 11) |> nrow()
Delaware20_row <- data_app_clean_20 |> filter(statename == 'Delaware') |> nrow()
Illinois20_row_n <- data_app_clean_20 |> filter(stateicp == 21) |> nrow()
Illinois20_row <- data_app_clean_20 |> filter(statename == 'Illinois') |> nrow()
South_Carolina20_row_n <- data_app_clean_20 |> filter(stateicp == 48) |> nrow()
South_Carolina20_row <- data_app_clean_20 |> filter(statename == 'South Carolina') |> nrow()
Colorado20_row_n <- data_app_clean_20 |> filter(stateicp == 62) |> nrow()
Colorado20_row <- data_app_clean_20 |> filter(statename == 'Colorado') |> nrow()
California20_row_n <- data_app_clean_20 |> filter(stateicp == 71) |> nrow()
California20_row <- data_app_clean_20 |> filter(statename == 'California') |> nrow()
Nevada20_row_n <- data_app_clean_20 |> filter(stateicp == 65) |> nrow()
Nevada20_row <- data_app_clean_20 |> filter(statename == 'Nevada') |> nrow()
Pennsylvania20_row_n <- data_app_clean_20 |> filter(stateicp == 14) |> nrow()
Pennsylvania20_row <- data_app_clean_20 |> filter(statename == 'Pennsylvania') |> nrow()

stopifnot(Massachusetts20_row_n == Massachusetts20_row,
          Delaware20_row_n == Delaware20_row,
          Illinois20_row_n == Illinois20_row,
          South_Carolina20_row_n == South_Carolina20_row,
          Colorado20_row_n == Colorado20_row, 
          California20_row_n == California20_row,
          Nevada20_row_n == Nevada20_row,
          Pennsylvania20_row_n == Pennsylvania20_row)
stopifnot(all(sort(unique(data_app_clean_20$age)) == sort(c("60+", "30-44", "18-29", "45-59"))))
stopifnot(all(sort(unique(data_app_clean_20$gender)) == sort(c("Male", "Female"))))
stopifnot(is.numeric(data_app_clean_20$vote_biden), 
          length(unique(data_app_clean_20$vote2020)) == 2)


# data_ipums_clean
stopifnot(is.numeric(data_ipums_clean$stateicp))
stopifnot(length(unique(data_ipums_clean$state_abv)) == 51)
stopifnot(all(sort(unique(data_ipums_clean$education)) == sort(c("Post-grad","4-year","Some college","High school graduate","2-year","No HS"))))
stopifnot(all(sort(unique(data_ipums_clean$race)) == sort(c('Asian', 'Black', 'White', 'Other race'))))
stopifnot(all(sort(unique(data_ipums_clean$age)) == sort(c("60+", "30-44", "18-29", "45-59"))))
stopifnot(all(sort(unique(data_ipums_clean$gender)) == sort(c("Male", "Female"))))
stopifnot(all(sort(unique(data_ipums_clean$marital)) == sort(c("Widowed","Married","Never married","Divorced","Separated"))))

# statevote2020
stopifnot(is.numeric(statevote2020$support_biden_prop), 
          length(unique(statevote2020$state)) == 51,
          statevote2020$support_biden_prop <= 1,
          is.numeric(statevote2020$Donald_Trump),
          is.numeric(statevote2020$Joe_Biden))









