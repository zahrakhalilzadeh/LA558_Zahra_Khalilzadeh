# Create a simple Leaflet map in R of a point and add it to your GitHub page. 
#Use example provided in the lecture . 
# March 21, 2023
# Zahra Khalilzadeh


# -----Exercise7b----------

#Packages and libraries ####
install.packages(c("leaflet", "tidycensus", "tidyverse", "plotly"))
library(leaflet)
library(tidycensus)
library(tidyverse)
library(readxl)

# Set value for the minZoom and maxZoom settings. ####
leaflet(options = leafletOptions(minZoom = 0, maxZoom = 2))

#make the map and zoom it to my location. ####
mylong= -93.65149
mylat= 42.02596
map <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng= mylong, lat=mylat, popup="Zahra's Office at Iowa State Unversity") %>%
  setView(lng= mylong, lat=mylat, zoom = 18) #Zoom to my location
map  # Print the map
