## load packages ---------------------------------------------------------------
library(shiny)
library(tidyverse)

## read data -------------------------------------------------------------------
countries_data <-read_csv("/Users/gulinan/Desktop/MAT381E_Introduction to Data Science/Week_13-14/Week_13_14_Lecture_Notes/data/countries_1998_2011.csv")


## subset data
countries_data_2011 <- countries_data %>% 
    filter(year == 2011)


## UI ##########################################################################
ui <- fluidPage(
    
    sidebarLayout(#position = "right",
        
        ## define inputs in sidebar -------------------------------
        sidebarPanel(
            
            ## select variable for scatter plot x-axis --------------
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
            selectInput(inputId = "point_size", label = "Point Size",
                        choices = c("population", "life_exp", "gdp_per_capita"),
                        selected = "population")
        ),
        
        ## Show output in main panel -----------------------------------------------
        mainPanel(
            ## show plot
            ## outputId:output variable to read the plot from.	
            plotOutput(outputId = "countries_scatter")
        )
    )
)

## SERVER ######################################################################
server <- function(input, output) {
    
    #add a third element to input list.
    output$countries_scatter <- renderPlot({
        ggplot(data = countries_data_2011, 
               aes_string(x = input$x_axis, y = input$y_axis)) +
            geom_point(aes_string(color="continent", size=input$point_size) ) +
            #point size depends on a variable.
            theme_minimal()
    })
}

## Run the application #########################################################
shinyApp(ui = ui, server = server)