## load packages ---------------------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(plotly)

## read data -------------------------------------------------------------------
countries_data <- read_csv("/Users/gulinan/Desktop/Introduction to Data Science with R/Week_13-14/Week13_Lecture_Notes/source_files/data/countries_1998_2011.csv")

## subset data
countries_data_2011 <- countries_data %>% 
    filter(year == 2011)


## UI ##########################################################################
ui <- fluidPage(
    
    ## application title
    titlePanel("Countries Explorer"),
    
    sidebarLayout(#position = "right",
        
        ## define inputs in sidebar -------------------------------
        sidebarPanel(
            
            ## select variable for scatter plot x-axis --------------
            ## label: widget label.  
            selectInput(inputId = "x_axis", label = "X axis",
                        choices = c("human_development_index", "corruption_perception_index",
                                    "population", "life_exp", "gdp_per_capita"),
                        selected = "human_development_index"),
            
            ## select variable for scatter plot y-axis ---------------
            selectInput(inputId = "y_axis", label = "Y axis",
                        choices = c("human_development_index", "corruption_perception_index",
                                    "population", "life_exp", "gdp_per_capita"),
                        selected = "corruption_perception_index"),
            
            ## select variable for point size ---------------
            selectInput(inputId = "size", label = "Point Size",
                        choices = c("population", "life_exp", "gdp_per_capita"),
                        selected = "population"),
            
            ## set alpha level for points in the scatter plot ----------------
            sliderInput(inputId ="transvalue", label = "Transparency", 
                        min = 0, max = 1, value = 0.8),
            
            ## checkbox to show/hide data table -------------------
            checkboxInput(inputId = "show_table", label = "Show table",
                          value = TRUE)
            
        ),
        
        ## Show output in main panel -----------------------------------------------
        mainPanel(
            ## show plot
            ## outputId:output variable to read the plot from.	
            plotlyOutput(outputId = "countries_scatter"),
            
            dataTableOutput(outputId ="table")
            
        )
        
    )
    
    
)

## SERVER ######################################################################
server <- function(input, output) {
    
#https://stackoverflow.com/questions/37663854/convert-ggplot-object-to-plotly-in-shiny-application
    output$countries_scatter <- renderPlotly({
      
        ggplotly(ggplot(data = countries_data_2011, 
                     aes_string(x = input$x_axis, y = input$y_axis)) +
                     geom_point(aes_string(color="continent", size=input$size),
                     alpha = input$transvalue) + 
                     theme_minimal()) 
         
      
        
    })
    
    
    output$table <- renderDataTable({
        if(input$show_table){countries_data_2011}
    })
    
    
}

## Run the application #########################################################
shinyApp(ui = ui, server = server)