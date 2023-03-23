# Leaflet mapping: Make a Chloropleth map.
# 
# March 23, 2023
# Zahra Khalilzadeh

install.packages("leaflet", "leaflet.providers", "tidyverse", "sf")
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)

# Read in the shapefile
languageCount <- st_read("languagecountIowa.shp")

# Set the projection to use lat and longs
languageCount <- st_transform(languageCount, crs = 4326)

# I should have corrected the name of the count field. It is currently 
# language_c, but I can use dplyr to rename the column!
languageCount  <- languageCount %>% rename(count = language_c)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = languageCount,  # borders of all counties
              color = "blue", fill = NA, weight = 1)
m

# Display only a few counties, Boone and Green for example.
languageCount_selection1 <- languageCount %>% 
  filter(COUNTY %in% c("Boone", "Greene"))

# Or maybe only the counties with no participants? Look for not > than 0 or NA
languageCount_selection2 <- languageCount %>% 
  filter(is.na(count) | !count > 0)

# First I better replace the NA in the entire dataframe with a 0.
languageCount <- languageCount %>%
  replace(is.na(.), 0)

# Select the color scheme from Color Brewer
library("RColorBrewer") #I think either Leaflet or tidyverse loads this for you
display.brewer.all()

bins <- c(0, 2, 4, 6, 8, 10, 12, 14, 16, Inf)
pal <- colorBin("PuBu", domain = languageCount$count, bins = bins)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = languageCount,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.8)
m

# Add interaction
m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = languageCount,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.8,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE)
  )
m

# With that working we now need to display the county and the count in a popup
# Start with the description of the labels , must do this before
labels <- sprintf(
  "<strong>%s</strong><br/>%g languages",
  languageCount$COUNTY, languageCount$count
) %>% lapply(htmltools::HTML)


m <- leaflet() %>%
  setView(-94.5, 42.2, 6)  %>%
  addTiles() %>%
  addPolygons(data = languageCount,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.8,  #be careful, you need to switch the ) to a comma
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto"))
m

#finally we can add a legend! I will append this to m
m %>% addLegend(pal = pal, values = count, opacity = 0.7, title = "Languages",
                position = "bottomright")

