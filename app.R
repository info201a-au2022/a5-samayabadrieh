# Load libaries
library(plotly)
library(ggplot2)
library(shinythemes)
library(dplyr)
library(shiny)
library(tidyverse)

# Sourcing
source("ui.R")
source("server.R")

# Run the app
shinyApp(ui = ui, server = server)