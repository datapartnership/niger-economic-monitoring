# Nighttime Lights: Main Script

# Filepaths --------------------------------------------------------------------
git_dir <- file.path("/Users", "rmarty", "Library", "CloudStorage", "OneDrive-WBG", "Documents",
                     "GitHub", "niger-economic-monitoring", "notebooks", "nighttime-lights")

data_dir <- file.path("/Users", "rmarty", "Library", "CloudStorage", "OneDrive-SharedLibraries-WBG", 
                      "Development Data Partnership - Niger Economic Monitor", "Data")

boundaries_dir <- file.path(data_dir, "Boundaries")
ntl_dir <- file.path(data_dir, "Nighttime Lights")

# Packages ---------------------------------------------------------------------
library(dplyr)
library(lubridate)
library(sf)
library(ggplot2)
library(leaflet)
library(terra)
#library(blackmarbler)