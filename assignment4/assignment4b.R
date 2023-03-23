# Leaflet mapping: Create a Leaflet page in R that includes at least 20 markers. 
# adding multiple markers to slippy map
# 
# March 23, 2023
# Zahra Khalilzadeh

install.packages("leaflet", "leaflet.providers", "tidyverse")
library(leaflet)
library(leaflet.providers)
library(tidyverse)

languageyoungpeople1000 <- read.csv("assignment4bmockdata.csv", header = TRUE)
myData <- languageyoungpeople1000

# Add markers from the CSV to this map
map <- leaflet(myData[1:200,]) %>% 
  addTiles() %>%
  addMarkers(~longitude, ~latitude)
map

#add labels and make them circle markers
map <- leaflet(myData[1:200,]) %>% 
  addTiles() %>%
  addCircles(~longitude, ~latitude, label = myData$language)
map

#have a popup of the participant's language
map <- leaflet(myData[1:200,]) %>% 
  addTiles() %>%
  addCircles(~longitude, ~latitude, popup = paste("<strong>", 
                                                  myData$last_name, "</strong><br>", "Language: ", 
                                                  myData$language))
map

# Change the size and color of the circles
map <- leaflet(myData[1:200,]) %>% 
  addTiles() %>%
  addCircles(~longitude, ~latitude, popup= paste("<strong>", 
                                                 myData$last_name, "</strong><br>", "Language: ", 
                                                 myData$language), weight = 4, radius=1000, 
             color="green", stroke = TRUE, fillOpacity = 0.8)
map

# We now have an button containing a group of background layers
map <- leaflet(myData[1:200,]) %>% 
  addTiles(group = "OSM", options = providerTileOptions(minZoom = 4, maxZoom = 10)) %>%
  addProviderTiles("Stamen.TonerLite", group = "Toner", 
                   options = providerTileOptions(minZoom = 8, maxZoom = 10)) %>%
  addProviderTiles("Stamen.Watercolor", group = "Water Color") %>%
  addProviderTiles("Esri.WorldTopoMap", group = "Topo") %>%
  addProviderTiles("OpenStreetMap.Mapnik", group = "Mapnik") %>%
  addProviderTiles("CartoDB.Positron", group = "CartoDB") %>%
  addLayersControl(baseGroups = c("OSM", "Toner", "Water Color", "Topo", "Mapnik", "CartoDB"),
                   options = layersControlOptions(collapsed = TRUE)) %>%
  addCircles(~longitude, ~latitude, popup= paste("<strong>", 
                                                 myData$last_name, "</strong><br>", "Language: ", 
                                                 myData$language), weight = 4, radius=1000, 
             color="green", stroke = TRUE, fillOpacity = 0.8)
map

# Make clusters, note this only appears to work with addMarkers
map <- leaflet(myData[1:200,]) %>% 
  addProviderTiles("Stamen.TonerLite", 
                   options = providerTileOptions(minZoom = 4, maxZoom = 10))%>%
  addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions())
map

