
library(shiny)
library(tidyverse)
library(DT)
library(plotly)
library(shinythemes)


## read data -------------------------------------------------------------------
countries_data <- read_csv("/Users/gulinan/Desktop/Introduction to Data Science with R/Week_13-14/Week13_Lecture_Notes/source_files/data/countries_1998_2011.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("superhero"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            
         selectInput(inputId = "yearr", 
                        label = "Year",
                        choices = unique(countries_data$year),
                        selected = 2011),
            
            
          selectInput(inputId = "x_axis", 
              label = "X axis",
              choices = c("human_development_index", "corruption_perception_index",
                          "population","life_exp", "gdp_per_capita"),
              selected = "human_development_index"),
          
      
          selectInput(inputId = "y_axis", 
                      label = "Y axis",
                      choices = c("human_development_index", "corruption_perception_index",
                                  "population","life_exp", "gdp_per_capita"),
                      selected = "corruption_perception_index"),
          
          selectInput(inputId = "point_size",
                      label = "Point size",
                      choices = c("population","life_exp", "gdp_per_capita"),
                      selected = "population"),
          
          
          sliderInput( inputId = "transvalue",
                       label = "Transparency",
                       min = 0,
                       max = 1,
                       value = 0.8),
            
          checkboxInput(inputId = "show_table",
                        label = "Show Table",
                        value = TRUE
              
          )
          
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
    
            tabsetPanel(type="tabs",
                        tabPanel(title="Plot", plotlyOutput("countries_scatter")),
                        tabPanel(title="Summary Table", dataTableOutput("mytable"))             
                
            )
            
            
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
    
    countries_subset <-  reactive({
                         countries_data %>% 
                         filter(year == input$yearr)
                         })
    
    
    
    summary_table <- reactive({
                     countries_subset() %>%      ###pay attention:countries_subset() 
                     group_by(continent) %>% 
                    summarise(gdp_median = median(gdp_per_capita, na.rm = TRUE) %>% round(2),
                    life_exp_median = median(life_exp, na.rm = TRUE) %>% round(2))
    
    })
    
    
    
    
    
 output$countries_scatter <- renderPlotly({
          
     ggplot(data = countries_subset() , aes_string(x=input$x_axis, y=input$y_axis)) +
                            geom_point(aes_string(color="continent", size = input$point_size), alpha=input$transvalue) +
                            labs(title = input$yearr)
          
                            }
                            )
 
 
 
  output$mytable     <-  renderDataTable({
         
       if(input$show_table == TRUE){summary_table()}
    
                       }
                       )
 
 
}

# Run the application 
shinyApp(ui = ui, server = server)
