#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    ## Main header
    tags$h1("My First Shiny App"),
    
    tags$p(" I love data science."),
    
    ## Un-ordered list
    
    tags$ul(
        tags$li("Tidyverse"), 
        tags$li("Rvest"), 
        tags$li("Shiny")
    ),
    

    ## Tags can be nested.
    
    tags$p(
          "The link to the Shiny website is",
           tags$a(href = "https://www.rstudio.com/shiny/", "rstudio.com/shiny."),
           tags$strong("I strongly recommend that you take a look at it!")
    ),
    
    ## Some line break.
    tags$br(),
        
    ## Include image.
    
    tags$img(src="https://i.vimeocdn.com/video/776716658.webp?mw=1100&mh=619&q=70", width="200", height="200"),
   
    ## Some line break.
    tags$br(),
    
    tags$span(style="color:purple", "Have a good summer!..")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
