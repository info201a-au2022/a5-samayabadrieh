# Load libaries
library(plotly)
library(ggplot2)
library(shinythemes)
library(dplyr)
library(shiny)
library(tidyverse)

# Load data
co_df <- read.csv(
  "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
)

#----------------------------------------------------------------------------#
## Part 1: Three Values of Interest
#----------------------------------------------------------------------------#

# A dataframe with observations pertaining to some North American countries
# after 1999 to work with.
  noram_df <- co_df %>%
    filter(
      country == "United States" | country == "Canada" |
        country == "Mexico",
      year > 1999 
    )
  
# From the dataframe produced by that function, this function pulls the country
# with the highest consumption of CO2 per capita
highest_co <- function() {
  high_co2 <- noram_df %>%
    select(country, co2, year) %>%
    group_by(country) %>%
    filter(year > 1999) %>%
    summarize(sum_co2 = sum(co2)) %>%
    filter(sum_co2 == max(sum_co2, na.rm = TRUE)) %>%
    pull(country)
  return(high_co2)
}

# This function then takes the result of the above function, and then determines
# The year in which that nation produced the largest amount of co2
yr_highest_co2 <- function() {
  input_country <- highest_co()
  yr_most_co2 <- noram_df %>%
    select(year, country, co2) %>%
    group_by(year) %>%
    filter(country == input_country) %>%
    summarize(yr_most_co2 = sum(co2, na.rm = TRUE)) %>%
    filter(yr_most_co2 == max(yr_most_co2, na.rm = TRUE)) %>%
    pull(year)
  return(yr_most_co2)
}

# This function takes in the same input as the above function, and then determines
# The year in which that nation produced the smallest amount of co2
yr_lowest_co2 <- function() {
  input_country <- highest_co()
  yr_least_co2 <- noram_df %>%
    select(year, country, co2) %>%
    group_by(year) %>%
    filter(country == input_country) %>%
    summarize(yr_least_co2 = sum(co2, na.rm = TRUE)) %>%
    filter(yr_least_co2 == min(yr_least_co2, na.rm = TRUE)) %>%
    pull(year)
  return(yr_least_co2)
}

#----------------------------------------------------------------------------#
## Part 2: Histogram
#----------------------------------------------------------------------------#

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$linegraph <- renderPlotly({
      graph_data <- noram_df %>%
        filter(country %in% input$countryid)
        
      my_plot <- ggplot(data = graph_data, mapping = aes(
        x = year,
        y = co2
      )) +
        geom_line(aes(color = country)) +
        scale_color_manual(values = input$pickcolor) +
        ggtitle("The Carbon Dioxide Output of the US, Mexico, and Canada Over 
                Time (2000-2021)") +
        labs(
        x = "Year", y = "Annual total production-based emissions of 
             carbon dioxide (CO₂), excluding land-use change, measured in million tonnes"
          ) +
        labs(
          caption = "This figure shows trends in CO2 emissions for Mexico, the US,
          and Canada over time (from 2000 to 2021)."
        ) +
        theme(plot.caption = element_text(hjust = 0.5))
    })
  }