## load packages ---------------------------------------------------------------
library(shiny)
library(tidyverse)

## read data -------------------------------------------------------------------
countries_data <- 
  read_csv("/Users/gulinan/Desktop/MAT381E_Introduction to Data Science/Week_13-14/Week_13_14_Lecture_Notes/data/countries_1998_2011.csv")

## subset data
countries_data_2011 <- countries_data %>% 
                            filter(year == 2011)


## UI ##########################################################################
ui <- fluidPage(
    
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
                        selected = "corruption_perception_index")
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
    
    ## input and output are list-type objects. list elements will be named by me.
    ## create a scatter plot.
    ## output is a reserved word.
    ## countries_scatter is given by me.
    ## input has two parts: x_axis and y_axis
    ## renderPlot({expr}): Renders a reactive plot that is suitable for assigning to an output plot.
    ## expr: An expression that generates a plot.	
 
    output$countries_scatter <- renderPlot({
        #x_axis and y_axis variables will be selected by the user through input widgets.
        #input is a reserved word. The x_axis and y_axis names are given by me.
        #keep the variables as strings.that's why we are using aes_string().
        ggplot(data = countries_data_2011, 
               aes_string(x = input$x_axis, y = input$y_axis)) + 
#https://stackoverflow.com/questions/63734097/why-do-i-have-to-use-aes-string-with-ggplot-in-shiny
#When you take user input in shiny you get variables as string.            
#Hence, by using aes_string you "tell" R/Shiny that I am passing column names 
#as string but treat them as columns from the dataframe and not as string.            
            geom_point(aes_string(color="continent")) +
            theme_minimal()
        
    })
}

## Run the application #########################################################
shinyApp(ui = ui, server = server)