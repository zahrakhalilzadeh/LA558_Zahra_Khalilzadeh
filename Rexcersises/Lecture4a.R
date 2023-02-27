#Zahra Khalilzadeh
#Lecture 4a
#LA 558, Spring 2023
# -----Header----------

#Packages and libraries ####
install.packages("tidyverse", dependencies = TRUE )
install.packages("tidycensus")
library(tidyverse)
library(tidycensus)

# Introduction ####
install.packages("rlang")
library(rlang)
usethis::edit_r_environ()

#If your key is stored properly this will retrieve it.
Sys.getenv("b4bad71133f6d71d963ea2cb01d2b884e6e416b8")

# optionally instead of retrieving it, you could add the key below.
#census_api_key('b4bad71133f6d71d963ea2cb01d2b884e6e416b8', overwrite = FALSE, install = TRUE)



## ----Median Age--------------------------------------
medianAge <- get_acs(
  geography = "county",
  variables = "B01002_001",
  state = "IA",
  ##survey = "acs5"
)

medianAge


## ----Iowa Household income----------------------------------------------------
iowa_income <- get_acs(
  state = "Iowa",
  geography = "county",
  variables = c(hhincome = "B19013_001")
) %>%

mutate(NAME = str_remove(NAME, " County, Iowa"))

View(iowa_income)


## ----moe-plot-----------------------------------------------------
ggplot(iowa_income, aes(x = estimate, y = reorder(NAME, estimate))) +
  geom_errorbarh(aes(xmin = estimate - moe, xmax = estimate + moe)) +
  geom_point(size = 3, color = "darkgreen") +
  labs(title = "Median household income",
       subtitle = "Counties in Iowa",
       x = "2015-2019 ACS estimate",
       y = "") +
  scale_x_continuous(labels = scales::dollar)


## ----beeswarm---------------------------------------
install.packages("ggbeeswarm")
library(ggbeeswarm)

##White = "B03002_003",

race_income <- get_acs(
  geography = "block group",
  state = "IA",
  ##county = c("Boone", "Story", "Adair", "Polk"),
  variables = c(Black = "B03002_004",
                Asian = "B03002_006",
                Hispanic = "B03002_012"),
  summary_var = "B19013_001"
) %>%
  group_by(GEOID) %>%
  filter(estimate == max(estimate, na.rm = TRUE)) %>%
  ungroup() %>%
  filter(estimate != 0)

race_income

p <- ggplot(race_income, aes(x = variable, y = summary_est, color = summary_est)) +
  geom_quasirandom(alpha = .5) +
  coord_flip() +
  theme_minimal() +
  scale_color_viridis_c(guide = FALSE) +
  scale_y_continuous(labels = scales::dollar) +
  labs(x = "Largest race group within Block Group",
       y = "Median household income",
       title = "Household income distribution by largest racial/ethnic group",
       subtitle = "Iowa Census Block Groups",
       caption = "Data source: 2015-2019 ACS")

#p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))

p
