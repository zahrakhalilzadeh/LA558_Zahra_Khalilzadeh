# Create a simple map of a variable of your choice in R using TidyCensus after you watch 
#the video for today. Add the graphic and some description text/title to a markdown page and 
#put in your GitHub as Exercise6a.md  Make sure and link to this from your page that has the
#other assignment and exercise links. 
# March 1, 2023
# Zahra Khalilzadeh


# -----Exercise6a----------

#Packages and libraries ####
install.packages(c("tidycensus", "tidyverse", "geofacet", "ggridges"))
library(tidycensus)
#census_api_key("b4bad71133f6d71d963ea2cb01d2b884e6e416b8", install = TRUE)


## search-variables###
vars <- load_variables(2020, "pl")
View(vars)

#Review the available geographies in tidycensus from the tidycensus documentation. 
#Acquire data on total households (variable H1_001N) for a counties of Iowa.
totalhouseholdsIA_wide <- get_decennial(
  geography = "county",
  state = "IA",
  variables = c(total_households = "H1_001N"), 
  output = "wide",
  year = 2020
)


#show-named-variables####
totalhouseholdsIA_wide

totalhouseholdsIA <- get_decennial(
  geography = "county",
  state = "IA",
  variables = c(total_households = "H1_001N"), 
  year = 2020
)

arrange(totalhouseholdsIA , desc(value))

below10000 <- filter(totalhouseholdsIA, value < 10000)
below10000

#Percentage of each household(normalizing data) in counties of Iowa####
#What summary_var  does id it takes in a single variabe we want to use as a denominator, which
#is usually the hole number of observations, for example for the following example, we have
#number of each ocupancy status including,
#Occupied = "H1_002N", Vacant = "H1_003N",and we know that the total number
#of each variable in censuc data is _001 so, here the variable that we give it to summary_var 
#is "H1_001N" which is total number of householedS in each geography for each type of occupancy
#status which are the same becasue total number of households do not change 
#by occupancy status, and then we can use that variable
#to calculate percentage for occupancy status.
HouseholdStatus_vars <- c(
  Occupied = "H1_002N",
  Vacant = "H1_003N"
)

IA_Household <- get_decennial(
  geography = "county",
  state = "IA",
  variables = HouseholdStatus_vars,
  summary_var = "H1_001N",
  year = 2020
)


#view-summary-variable####
IA_Household

#mutate-and-select####
IA_Household_percent <- IA_Household %>%
  mutate(percent = 100 * (value / summary_value)) %>%
  select(NAME, variable, percent) %>%
  mutate(NAME = str_remove_all(NAME, " County, Iowa"))
IA_Household_percent  

IA_Household_percent_wide<- IA_Household_percent %>%
  pivot_wider(names_from = variable, values_from = percent, values_fill = NA)

  


#view-percent####
IA_Household_percent_wide

install.packages("RColorBrewer")  # Install RColorBrewer package
library("RColorBrewer")           # Load RColorBrewer
library(sf)
library(ggplot2)

#Plot the map of Iowa####

iowa_counties <- tigris::counties(state = "IA", cb = TRUE)
iowa_counties_Household <- left_join(iowa_counties, IA_Household_percent_wide, 
                               by = c("NAME" = "NAME"))
ggplot() +
  geom_sf(data = iowa_counties_Household, aes(fill = Vacant)) +
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Household Vacancy Percentage by County in Iowa",
       fill = "Vacant") +
  theme_void()
 
