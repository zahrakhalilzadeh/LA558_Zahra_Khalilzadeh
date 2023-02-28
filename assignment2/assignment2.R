# Importing an excel file and Creating two data visuals from R using data of your choice
# February 27, 2023
# Zahra Khalilzadeh


# -----Assignment 2 Craeting Map----------

#Packages and libraries ####
install.packages(c("tidyverse", "googlesheets4"))
#library(googlesheets4)
library(tidyverse)
library("readxl")
library(stringr)

#Load the crash data for 2021 downloaded from Iowa DOT website at https://icat.iowadot.gov/Home/Table/  ####
IowaCrashes <- read_excel("crashdatawithamountofpropertydamage.xlsx") 

#use mutate and str_replace_all() to remove spaces and "/" from the "CrashSeverity" column ####
IowaCrashes_clean <- IowaCrashes %>%
  mutate(CrashSeverity = str_replace_all(CrashSeverity, " ", ""))
IowaCrashes_clean <- IowaCrashes %>%
  mutate(CrashSeverity = str_replace_all(CrashSeverity, "[ /]", ""))

#check the class and type of the "AmountofPropertyDamage" column ####
class(IowaCrashes_clean$AmountofPropertyDamage)

# convert the "AmountofPropertyDamage" column to integer ###
IowaCrashes_clean$AmountofPropertyDamage <- as.integer(IowaCrashes_clean$AmountofPropertyDamage)
class(IowaCrashes_clean$AmountofPropertyDamage)

#grouping and summarizing fields using tidyverse ####
summary_data <- IowaCrashes_clean %>%
  group_by(County, CrashSeverity) %>%
  summarize(sum_property_damage = sum(AmountofPropertyDamage)) %>%
  pivot_wider(names_from = CrashSeverity, values_from = sum_property_damage, values_fill = NA)

# view the resulting summary data frame
print(summary_data)


#load the simple features package so we can read a shapefile ####
install.packages("sf")
library("sf")
iowaCounties_sf <- st_read("Counties.shp")

#plot the shapefile with ggplot2####
#We can plot this shapefile with ggplot2 below but it is just a generic map
ggplot() + 
  geom_sf(data = iowaCounties_sf, size = 3, color = "black", fill = "red") + 
  ggtitle("LA 558 Iowa Counties") + 
  coord_sf()

#Modify shapefile of Iowa Counties ####
#while it would be best to have FIPS or GEOID values, we will
#use the county name to join. But to make the work, the easiest is to have 
#the column name be the same. So we will modify the column name

iowaCounties_sf <- iowaCounties_sf %>% 
  rename("County" = "COUNTY")

#Join shapefile and our summary_data using dplyr####
#to join the geometry to our summary_data use dplyr
#note I put the data withthe geometry on the left of the join
myMap <- left_join(iowaCounties_sf, summary_data, by = "County")

#Plot the variable FatalCrash ####
#FatalCrash which is the Amount of Property Damage for Fatal Crashes and add a title.
ggplot(myMap) + 
  geom_sf(aes(fill = FatalCrash)) +
  ggtitle("LA 558 Assignment 2")

#Remove the background and center the title####
ggplot(myMap) + 
  geom_sf(aes(fill = FatalCrash))+
  scale_fill_continuous(name = "Amount of Property Damage \n for Fatal Crashes")+
  ggtitle("LA 558 Assignment 2") + 
  theme_void() +
  # move the title text to the middle
  theme(plot.title=element_text(hjust=0.5))

# -----Assignment 2 Craeting Bar Chart----------

#Packages and libraries ####
library(tidyverse)

#Load my simple data for ####
df <- read_excel("my_data.xlsx") 

# Filter the dataset to only include people under 30 ####
df_filtered <- df %>%
  filter(age < 30)

# Group the dataset by gender and summarize the average income ####
df_grouped <- df %>%
  group_by(gender) %>%
  summarize(avg_income = mean(income))

# Create a bar chart of the average income by gender ####
ggplot(df_grouped, aes(x = gender, y = avg_income)) +
  geom_bar(stat = "identity", width=0.5, fill = "red") +
  geom_text(aes(label=avg_income), vjust=2.0, size=3.5,color="pink")+
  labs(x = "Gender", y = "Average Income", title = "Average Income by Gender")
