# creating three plots/maps/graphics.
# February 28, 2023
# Zahra Khalilzadeh


# -----Assignment 3 A plot using variable(s) of choice from TidyCensus and acquire data from the decennial US Census----------

#Packages and libraries ####
install.packages(c("tidycensus", "tidyverse", "geofacet", "ggridges"))
library(tidycensus)
#census_api_key("b4bad71133f6d71d963ea2cb01d2b884e6e416b8", install = TRUE)
install.packages("RColorBrewer")  # Install RColorBrewer package
library("RColorBrewer")           # Load RColorBrewer
library(sf)
library(ggplot2)
library(tidyverse)
library("readxl")
library(stringr)


# search-variables####
vars_acs <- load_variables(2021, "acs5")
View(vars_acs)


#Arizona Map:Percentage of each race(normalizing data) in counties of Arizona####
##Select variables for race####
race_vars <- c(
  White = "B03002_003",
  Black = "B03002_004",
  Native = "B03002_005",
  Asian = "B03002_006",
  Other = "B03002_007"
)

AZ_race <- get_acs(geography = "county", 
                   state = "AZ",
                   summary_var = "B03002_001",
                   variables = race_vars,
                   year = 2021)
AZ_race
##Calculate percentages,mutate-and-select####
az_race_percent <- AZ_race %>%
  mutate(percent = 100 * (estimate / summary_est)) %>%
  select(NAME, variable, percent) %>%
  mutate(NAME = str_remove_all(NAME, " County, Arizona"))
#view-percent
az_race_percent

az_race_percent_wide<- az_race_percent %>%
  pivot_wider(names_from = variable, values_from = percent, values_fill = NA)

az_race_percent_wide


##Plot the map of Arizona####

arizona_counties <- tigris::counties(state = "AZ", cb = TRUE)
arizona_counties_Native <- left_join(arizona_counties, az_race_percent_wide, 
                                     by = c("NAME" = "NAME"))
ggplot() +
  geom_sf(data = arizona_counties_Native, aes(fill = Native)) +
  scale_fill_gradient() +
  labs(title = "Native Race Percentage by County in Arizona",
       fill = "Native Race Percentage") +
  theme_void()

#Arizona Bar Chart: What is the largest group(race) by county in Arizona?####
##Largest group(race)####
largest_groupAZ <- az_race_percent %>%
  group_by(NAME) %>%
  filter(percent == max(percent))
###view-largest-group####
largest_groupAZ

##Plot the bar chart of largest races in Arizona counties####
ggplot(largest_groupAZ, aes(x=NAME , y=percent, fill = variable)) + 
  geom_bar(stat = "identity")+
  xlab("County") +
  ylab("Percentage of Largest Race") +
  labs(title = "Largest Race by County in Arizona", subtitle = "This map shows which race has the largest amount in each county of Arizona") +
  coord_flip()

#New Jersey Bar Chart: Household vacancies by county in New Jersey####
##Largest group(race)####
# Get ACS5 data for household vacancies by county in New Jersey
nj_vacancies <- get_acs(geography = "county", 
                        variables = c("B25004_001","B25003_001", "NAME"), 
                        state = "NJ", 
                        year = 2021)
nj_vacancies
nj_vacancies <- nj_vacancies%>%
  select(NAME, variable, estimate)
nj_vacancies
# Rename variables
nj_vacancies_wide <- nj_vacancies %>% 
  mutate(NAME = str_remove_all(NAME, " County, New Jersey"))%>%
  pivot_wider(names_from = variable, values_from = estimate, values_fill = NA)%>%
  rename(county = NAME,
         vacancies = B25004_001,
         occupied = B25003_001) 
  

nj_vacancies_wide_final<- nj_vacancies_wide %>% 
                          mutate(vacancy_rate = 100 * (vacancies / (occupied +vacancies)))
nj_vacancies_wide_final
##Plot the bar chart of largest races in Arizona counties####
ggplot(nj_vacancies_wide_final, aes(x=county , y=vacancy_rate)) + 
  geom_bar(stat = "identity")+
  geom_col(fill = "red", color = "navy", alpha = 0.5) +
  theme_minimal(base_family = "Verdana") +
  xlab("County") +
  ylab("Percent vacant households") +
  labs(title = "Household vacancies by county in New Jersey",
       subtitle = "2021 American Community Survey (ACS)") +
  coord_flip()

#Creating a map using imported data####
##Load the crash data for 2021 downloaded from Iowa DOT website at https://icat.iowadot.gov/Home/Table/  ####
IowaSoybeanYield <- read_excel("SoybeanYielIowa.xlsx") 
##convert the "yield" column to integer ####
IowaSoybeanYield$yield <- as.integer(IowaSoybeanYield$yield)
class(IowaSoybeanYield$yield)
IowaSoybeanYield$year <- as.integer(IowaSoybeanYield$year)
class(IowaSoybeanYield$year)
##getting yield for 2018 ####
filtered_IowaSoybeanYield <- filter(IowaSoybeanYield, year == 2018)
filtered_IowaSoybeanYield
##load the simple features package so we can read a shapefile ####
install.packages("sf")
library("sf")
iowaCounties_sf <- st_read("Counties.shp")

##plot the shapefile with ggplot2####

#Modify shapefile of Iowa Counties ####
#while it would be best to have FIPS or GEOID values, we will
#use the county name to join. But to make the work, the easiest is to have 
#the column name be the same. So we will modify the column name

iowaCounties_sf <- iowaCounties_sf %>% 
  rename("County" = "COUNTY")

#Join shapefile and our summary_data using dplyr####
#to join the geometry to our filtered_IowaSoybeanYield use dplyr
#note I put the data withthe geometry on the left of the join
myMap <- left_join(iowaCounties_sf, filtered_IowaSoybeanYield, by = "County")

##Plot the variable yield ####
ggplot(myMap) + 
  geom_sf(aes(fill = yield))+
  scale_fill_continuous(name = "Soybean Yield in 2018")+
  ggtitle("Soybean Yield in 2018 by County in Iowa") + 
  theme_void() +
  # move the title text to the middle
  theme(plot.title=element_text(hjust=0.5))
