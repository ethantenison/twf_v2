# Configuration ----
library(shiny)
library(shinyjs)
library(RColorBrewer)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(sf)
library(htmltools)
library(shinyWidgets)
library(DT)
library(plotly)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyhelper)
library(readxl)

# Data & Scripts 

options(scipen = 999)

# Geographies
gcd <- readRDS("./data/processed/gcd.rds")
aqu <- readRDS("./data/processed/aqu.rds")
rb <- readRDS("./data/processed/rb.rds")
riv <- readRDS("./data/processed/riv.rds")
rwpa <- readRDS("./data/processed/rwpa.rds")


#Modules

# UI ----

jsToggleFS <- 'shinyjs.toggleFullScreen = function() {
     var element = document.documentElement,
 enterFS = element.requestFullscreen || element.msRequestFullscreen || element.mozRequestFullScreen || element.webkitRequestFullscreen,
 exitFS = document.exitFullscreen || document.msExitFullscreen || document.mozCancelFullScreen || document.webkitExitFullscreen;
 if (!document.fullscreenElement && !document.msFullscreenElement && !document.mozFullScreenElement && !document.webkitFullscreenElement) {
 enterFS.call(element);
 } else {
 exitFS.call(document);
 }
 }'

ui <- dashboardPage(
    title = "Texas Water Foundation Dashboard",
    dashboardHeader(title = "Texas Water"),
    ## Sidebar ----
    dashboardSidebar(
        useShinyjs(),
        shinyjs::extendShinyjs(text = jsToggleFS, functions = "toggleFullScreen"),
        sidebarMenu(
            id = "tabs",
            menuItem("Welcome",
                     tabName = "welcome",
                     icon = icon("search")),
            conditionalPanel(condition = "input.tabs == 'welcome'"),
            menuItem("Geography",
                     tabName = "geo",
                     icon = icon("wind")),
            conditionalPanel(condition = "input.tabs == 'geo'"),
            menuItem(
                "Attributions",
                tabName = "attributions",
                icon = icon("info-circle")
            ),
            conditionalPanel(condition = "input.tabs == 'attributions'"),
            hr(style = "margin-top: 5px; margin-bottom: 5px; width:90%"),
            HTML(
                "<button type='button' class='btn btn-default action-button shiny-bound-input' style='display: block;
        margin: 6px 5px 6px 15px; width: 200px;color: #152934;' onclick = 'shinyjs.toggleFullScreen();
        '><i class='fa fa-expand fa-pull-left'></i> Fullscreen</button>"
            )
    )),
    dashboardBody()
)

# Server ----

server <- function(input, output, session) {
    
    
}

# Run App ----
shinyApp(ui = ui, server = server)
        