## load packages ---------------------------------------------------------------
library(shiny)
library(tidyverse)
library(plotly)

## read data -------------------------------------------------------------------
countries_data <-read_csv("/Users/gulinan/Desktop/MAT381E_Introduction to Data Science/Week_13-14/Week_13_14_Lecture_Notes/data/countries_1998_2011.csv")


## UI ##########################################################################
ui <- fluidPage(
    
    ## application title
    titlePanel("Countries Explorer"),
    
    sidebarLayout(
        
        ## define inputs in sidebar -------------------------------
        sidebarPanel(
            
            
            ## select variable for year ---------------------------
            selectInput(inputId = "year", label = "Year",
                        choices = unique(countries_data$year),
                        selected = 2011),
            
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
            plotlyOutput(outputId = "countries_scatter"),
            
            dataTableOutput(outputId = "countries_table")
        )
    )
)

## SERVER ######################################################################
server <- function(input, output) {
    
    ## filter data base on the selected year value --------------
    countries_subset <- reactive({
        countries_data %>% 
            filter(year == input$year)
    })
    
    
    ## calculate summaries per continent -----------------
    countries_summary <- reactive({
        countries_subset() %>%      ###pay attention:countries_subset() 
            group_by(continent) %>% 
            summarise(gdp_median = median(gdp_per_capita, na.rm = TRUE) %>% round(2),
                      life_exp_median = median(life_exp, na.rm = TRUE) %>% round(2))
    })
    
    
    ## create scatter plot ----------------------------------
    output$countries_scatter <- renderPlotly({
        
        p_scatter <- ggplot(data = countries_subset(),  ###pay attention:countries_subset() 
                            aes_string(x = input$x_axis, y = input$y_axis,
                                       color = "continent",
                                       size = input$point_size,
                                       label = "country"))+
            geom_point(alpha = input$transvalue)+
            theme_minimal()+
            labs(title = input$year)
        
        ggplotly(p_scatter)
    })
    
    
    ## create data table -------------------------------------
    output$countries_table <- renderDataTable({
        if(input$show_table){
            datatable(countries_summary(), rownames = FALSE)  ###pay attention:countries_summary() 
        }
    })
}

## Run the application #########################################################
shinyApp(ui = ui, server = server)