# Nighttime Lights: Main Script

# Filepaths --------------------------------------------------------------------
git_dir <- file.path("/Users", "rmarty", "Library", "CloudStorage", "OneDrive-WBG", "Documents",
                     "GitHub", "niger-economic-monitoring", "notebooks", "nighttime-lights")

data_dir <- file.path("/Users", "rmarty", "Library", "CloudStorage", "OneDrive-SharedLibraries-WBG", 
                      "Development Data Partnership - Niger Economic Monitor", "Data")

data_dir <- file.path("~/Dropbox/World Bank/Side Work/", 
                      "Development Data Partnership - Niger Economic Monitor", "Data")

boundaries_dir <- file.path(data_dir, "Boundaries")
ntl_dir  <- file.path(data_dir, "Nighttime Lights")
city_dir <- file.path(data_dir, "Cities")

# Packages ---------------------------------------------------------------------
library(dplyr)
library(lubridate)
library(sf)
library(ggplot2)
library(leaflet)
library(haven)
library(terra)
library(blackmarbler)
library(stringr)
library(exactextractr)
library(purrr)
library(stringr)
library(exactextractr)
library(blackmarbler)
library(sparkline)
library(sparklyr)
