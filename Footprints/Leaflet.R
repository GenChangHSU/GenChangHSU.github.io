########## Visualization of Life Experiences with Leaflet ##########
########## Author: Gen-Chang Hsu ###########

library(tidyverse)
library(magrittr)
library(leaflet)
library(mapview)

### Base map
Map_lf <- leaflet(options = leafletOptions(minZoom = 1, maxZoom = 12)) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap)


### Marker dataframe 
Markers <- data.frame(Year = 2014, 
                      Title = "International Biology Olympiad",
                      Long = 115.194,
                      Lat = -8.649,
                      Image = "",
                      URL = "")


### Add markers to the map
Map_lf <- Map_lf %>%
  addCircleMarkers(data = Markers) %>%
  setView(0, 25, 2)


### Save the map
mapshot(Map_lf, url = "Map.html")










