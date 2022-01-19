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
    ## Body ----
    dashboardBody(
        
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        tags$script(
            HTML(
                '// Sets the name next to navbar
      $(document).ready(function() {
        $("header").find("nav").append(\'<span class="myClass", style="color:white"><b>Texas Water Foundation </b></span>\');
      }),
      $(document).ready(function(){
  $("a[data-toggle=tab]").on("show.bs.tab", function(e){
    Shiny.setInputValue("activeTab", $(this).attr("data-value"));
  });
});
     '
            )
        ),

tabItems(
    ### Welcome ----
    tabItem(tabName = "welcome",
            column(
                width = 12,
                fluidRow(
                    shinydashboard::box(
                        title = NULL,
                        width = 12,
                        solidHeader = TRUE,
                        background = "blue",
                        status = "primary",
                        br(),
                        fluidRow(
                            column(
                                width = 9,
                                h1(strong("Welcome to the TWF Dashboard!"),
                                   style = "font-size:5em;")),
                            column(
                                width = 3,
                                div(
                                    style = "text-align: center;padding-right:30px;
                      padding-bottom: 15px;padding-top: 30px;", 
                      appButton(
                          inputId = "welcome_bt",
                          label = "Welcome Guide",
                          enable_badge = TRUE, 
                          icon = icon("book-open"),
                          badgeColor = "red", 
                          badgeLabel = 3,
                          width = '100%'
                      ))
                            ))
                    )
                ),
                fluidRow(
                    column(12,
                           style = "padding-left:30px;",
                           h1("Brought to you by:"))
                )
            )),
    ### AQ ----
    tabItem(tabName = "geo",
            column(
                width = 12,
                offset = 0,
                fluidRow(
                    column(style = 'padding-left:30px;padding-bottom: 15px;padding-top: 0px;',
                           width = 9,
                           h1(strong("Geography")))),
                fluidRow(column(
                    width = 12,
                    shinydashboard::box(
                        width = 8,
                        solidHeader = FALSE,
                        status = "primary",
                        # dataUI(
                        #     #Selector UI
                        #     "air",
                        #     choices = list(
                        #         "O3",
                        #         "Ozone - CAPCOG",
                        #         "PM2.5",
                        #         "PM2.5 - CAPCOG",
                        #         "Percentile for PM2.5"
                        #     ),
                        #     selected = "PM2.5"
                        # ),
                        # mapUI("air_map", height = "650") #Map UI
                    ),
                    shinydashboard::box(
                        width = 4,
                        solidHeader = FALSE,
                        status = "primary",
                        #plotsUI("aq_bar")
                    )
                    
                ))
            )),
    ### Attributions ----
    tabItem(
        tabName = "attributions",
        column(
            width = 10,
            offset = 1,
            style = 'padding-left:30px;padding-bottom: 15px;padding-top: 0px;',
            h1(strong("Attributions"))
            

        )
    )
    )
)
)

# Server ----

server <- function(input, output, session) {
    
    
}

# Run App ----
shinyApp(ui = ui, server = server)
        