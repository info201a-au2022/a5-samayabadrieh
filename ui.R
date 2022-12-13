# Load libaries
library(plotly)
library(ggplot2)
library(shinythemes)
library(dplyr)
library(shiny)
library(tidyverse)

# Source server file
source("server.R")

# Grabbing values from sever to UI
country_highest_co2 <- highest_co()
yr_highest_co2 <- yr_highest_co2()
yr_lowest_co2 <- yr_lowest_co2()

#----------------------------------------------------------------------------#
## Code for my intro panel
#----------------------------------------------------------------------------#

ui <- fluidPage(
  page_one <- tabPanel(
    "App Overview",
    titlePanel("App Overview"),
    
    # My intro stuff
    h3("Introduction"),
    p("Climate change is perhaps the most pressing global issue of the current
      era. If nothing is done to analyze and act on the circumstances of our
      situation, then humankind will be culpable for its own destruction as a results
      of our willful ignorance and lack of urgency. Therefore, analyses covering
      the issue in a similar vein as the following report are incredibly important
      to get the ball rolling for some sustainable change."),
    p("My approach to sparking some urgency and awareness over the course of 
      this report started with using the expansive dataset available to us, a
      dataframe from OUr World in Data, which centers discussion about emissions
      in a way that's traced to individual countries, which is great for distributing
      the responsibility for fixing our planet's current trajectory. I went for
      the variables I found to be the easiest to deal with: country, year, and
      co2 (these were columns; co2 meant annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in million tonnes). I decided that 
      this was not specific enough to appeal to my main readers, so I narrowed the 
      dataset to three large North American countries: the US, Canada, and 
      Mexico. Finally, seeing as this report will be read by mostly college 
      students, I decided to limit the dataset to a timeframe I thought would be 
      most relevant to that demographic: 2000 through 2021"),
    
    # My 3 values
    h3("Three Relevant Values of Interest"),
    p("My three relevant values of interest serve as answers to the following 
      questions:"),
    p("Question 1: In which country out of Mexico, Canada, and the US is CO2 
      emission the highest (2000-2021)?"),
    p("Answer 1: Out of Mexico, Canada, and the US, CO2 emission was the highest in"
      , paste(country_highest_co2), "."),
    p("Question 2: In which year did that country produce the highest amount of CO2?"),
    p("Answer 2: The year during which the highest amount of co2 was produced was"
      , paste(yr_highest_co2), "."),
    p("Question 3: In which year did that country produce the lowest amount of CO2?"),
    p("Answer 3: The year during which the lowest amount of co2 was produced was"
      , paste(yr_lowest_co2), "."),
    
    # Intro to my interactive visualization
    h3("Interactive Visualization"),
    p("The data visualization I created in order to highlight the mounting issue
      of pollution is a line chart. Each line corresponds to a country which you
      can select (either the US, Mexico, or Canada), and you can also select 
      colors for the lines which are more accessble for certain disibilities
      such as color blindness or weak close-up vision.")
  ),
)

#----------------------------------------------------------------------------#
## Second Panel with data visualization
#----------------------------------------------------------------------------#

page_two <- tabPanel(
  "Interactive Visualization",
  titlePanel("Linechart of CO2 emissions in North America"),
  
  # My interactive panels
  sidebarLayout(
    sidebarPanel(
      
      # First interactive panel
      selectInput(
        inputId = "pickcolor",
        label = "Select a color which is accessible to you.",
        choices = c("red", "blue", "purple", "black")
      ),
      
      # Second interactive panel
      radioButtons(
        inputId = "countryid",
        label = "Select a North American Country.",
        c("United States", "Canada", "Mexico")
      )
    ),
    
#----------------------------------------------------------------------------#
## Instructions to interact with plot
#----------------------------------------------------------------------------#
    
    mainPanel(
      plotlyOutput("linegraph"),
      p("The following chart offers two different input widgets: Color
        accessibility selection and country selection. Country selection can be
        used to access the different countries in the (narrowed) dataset:
        US, Mexico, and Canada. The color accessibility selection is supposed
        to make the graph readable for those with color-blindness or farsightedness.
        Those with Deuteranopia can choose red, people with Protanopia can
        choose purple, and those with Tritanopia can choose blue.
        There are some key takeaways that can be extracted from checking out
        this graph. First, you'll notice that the United States was decreasing
        in CO2 output for awhile, but is currently spiking. Canada is showing a
        very erratic trend with big peaks and valleys. Mexico was at a plateau,
        but currently has seen a huge drop in CO2. This is interesting, because
        it provides some context to the values calculated at the beginning of the
        report. The trend I pointed out with the United States is both uplifting,
        but also disappointing. If the trend was only downwards, it would help 
        make the US having the most CO2 output a little less upsetting. However,
        in the context of the spike at the end of the US curve, the high consumption
        of CO2 in the US is much more concerning, and supports climate change activism
        that has picked up recently. Mexico's plateau followed by a drop is great!
        This implies that perhaps the US can stand to learn something from Mexico.
        And finally, the trend for Canada leaves me with the impression that perhaps
        data surveys for Canada need to be improved in quality and accuracy.")
    )
  )
)

#----------------------------------------------------------------------------#
## Tabs and Theme
#----------------------------------------------------------------------------#

ui <- navbarPage(
  theme = shinytheme("darkly"),
  "An Exploration of Carbon Dioxide Emissions",
  page_one,
  page_two
)
    
    
    