########## Visualization of Life Experiences with Leaflet ##########
########## Author: Gen-Chang Hsu ###########

library(tidyverse)
library(magrittr)
library(leaflet)
library(mapview)
library(sf)
library(sp)
library(rgdal)

### Base map
Map_lf <- leaflet(options = leafletOptions(minZoom = 1, maxZoom = 12)) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap)


### Load in the marker data 
Markers <- read_csv("./Footprints/Footprints.csv", col_names = T)


### Load and merge the CA1 geodata
file_list_CA1 <- list.files("./Footprints/CA1_geodata", pattern = "*line.shp", full.names = TRUE)
CA1_sp <- lapply(file_list_CA1, read_sf) %>% 
  bind_rows() %>%
  st_zm() %>%
  as_Spatial()

file_list_NZ <- list.files("./Footprints/NZ_geodata", pattern = "*line.shp", full.names = TRUE)
NZ_sp <- lapply(file_list_NZ, read_sf) %>% 
  bind_rows() %>%
  st_zm() %>%
  as_Spatial()


### Add markers to the map
Map_lf <- Map_lf %>%
    addCircleMarkers(data = Markers, 
                     ~Long, 
                     ~Lat,
                     popup = ~paste("<img src='", 
                                    Image, 
                                    "'", " style='width: 200px;'>",
                                    "<div style='width: 200px; text-align: center; font-size: 16px;'>",
                                    Year,
                                    Title,
                                    "</div>",
                                    sep = " "),
                     label = ~paste(Year, Title),
                     color = "green",
                     stroke = FALSE, 
                     fillOpacity = 0.7,
                     radius = 10,
                     labelOptions = labelOptions(style = list("font-weight" = "bold",
                                                              "font-size" = "16px"))) %>%
  addPolylines(data = CA1_sp,
               popup = ~paste("<img src='", 
                              filter(Markers, Title == "California Coast Bike Trip")$Image, 
                              "'", " style='width: 200px;'>",
                              "<div style='width: 200px; text-align: center; font-size: 16px;'>",
                              filter(Markers, Title == "California Coast Bike Trip")$Year,
                              filter(Markers, Title == "California Coast Bike Trip")$Title,
                              "</div>", 
                              sep = " "),
               label = ~paste(filter(Markers, Title == "California Coast Bike Trip")$Year, 
                              filter(Markers, Title == "California Coast Bike Trip")$Title),
               fillOpacity = 0.7,
               weight = 10,
               labelOptions = labelOptions(style = list("font-weight" = "bold",
                                                        "font-size" = "16px"))) %>%
  addPolylines(data = NZ_sp,
               popup = ~paste("<img src='", 
                              filter(Markers, Title == "New Zealand South Island Road Trip")$Image, 
                              "'", " style='width: 200px;'>",
                              "<div style='width: 200px; text-align: center; font-size: 16px;'>",
                              filter(Markers, Title == "New Zealand South Island Road Trip")$Year,
                              filter(Markers, Title == "New Zealand South Island Road Trip")$Title,
                              "</div>", 
                              sep = " "),
               label = ~paste(filter(Markers, Title == "New Zealand South Island Road Trip")$Year, 
                              filter(Markers, Title == "New Zealand South Island Road Trip")$Title),
               fillOpacity = 0.7,
               weight = 10,
               labelOptions = labelOptions(style = list("font-weight" = "bold",
                                                        "font-size" = "16px"))) %>%
  setView(0, 25, 2)


### Save the map
mapshot(Map_lf, url = "Map.html")





