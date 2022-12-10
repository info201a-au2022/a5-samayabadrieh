# Load libaries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(shinythemes)

# Sourcing
source("server.R")
source("ui.R")

# Run the app
shinyApp(ui = ui, server = server)