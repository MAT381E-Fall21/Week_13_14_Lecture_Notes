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
  
  ## Include video.
  
  tags$iframe(src="https://www.youtube.com/embed/xJALSnbBHhk", width="1000", height="500",
              frameborder="0", 
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"),
  
  tags$br(),
  
  tags$span(style="color:purple", "Have a good winter break!..")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)