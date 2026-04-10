# load pkgs ----
library(arrow)
library(leaflet)
library(tidyverse)

# read in processed data ----
lake_data <- read_parquet(here::here("shinydashboard", "data", "lake_data_processed.parquet"))

# practice filter ----
    filtered_lakes_df <- lake_data |>
        filter(Elevation >= 8 & Elevation <= 20) |> 
        filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
        filter(AvgTemp >= 4 & AvgTemp <= 6)


# practice building leaflet ---- 
leaflet() |> 
    # add tiles
    addProviderTiles(providers$Esri.WorldImagery) |> 
    # set view over AK
    setView(lng = -152.048442, lat = 70.249234, zoom = 6) |> 
    # add mini map
    addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
    # add markers 
    addMarkers(data = filtered_lakes_df,
               lng = ~Longitude, 
               lat = ~Latitude,
               popup = ~paste0(
                   "Site name: ", Site, "<br>",
                   "Elevation: ", Elevation, " meters (above SL)", "<br>",
                   "Avg Depth: ", AvgDepth, " meters", "<br>",
                   "Avg Lake Bed Temperature: ", AvgTemp, " °C"
               ))
    