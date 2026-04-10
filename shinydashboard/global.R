# load pkgs ----
library(shiny)
library(shinydashboard)
library(tidyverse)
library(arrow)
library(shinycssloaders)
library(leaflet)
library(markdown)


# read in data ----
lake_data <- read_parquet("data/lake_data_processed.parquet")
