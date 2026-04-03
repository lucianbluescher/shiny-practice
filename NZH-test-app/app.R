library(shiny)
library(tidyverse)

reach_df <- readRDS("data/reach_df.rds")

ui <- fluidPage(
    titlePanel("Reach Explorer"),
    
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("dam_type_input", "Dam Type",
                               choices  = unique(reach_df$dam_type),
                               selected = unique(reach_df$dam_type)
            ),
            checkboxGroupInput("cascade_input", "Cascade Status",
                               choices  = unique(reach_df$cascade_status),
                               selected = unique(reach_df$cascade_status)
            ),
            checkboxGroupInput("downstream_input", "Has Current Downstream",
                               choices  = c("TRUE", "FALSE"),
                               selected = c("TRUE", "FALSE")
            ),
            checkboxGroupInput("upstream_input", "Has Current Upstream",
                               choices  = c("TRUE", "FALSE"),
                               selected = c("TRUE", "FALSE")
            ),
            hr(),
            helpText(paste("Total rows:", nrow(reach_df)))
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Scatter",
                         br(),
                         plotOutput("scatter_plot")
                ),
                tabPanel("Table",
                         br(),
                         tableOutput("data_table")
                ),
                tabPanel("Summary",
                         br(),
                         verbatimTextOutput("summary_out")
                )
            )
        )
    )
)

server <- function(input, output) {
    
    filtered_df <- reactive({
        reach_df |>
            filter(
                dam_type %in% input$dam_type_input,
                cascade_status %in% input$cascade_input,
                as.character(has_current_downstream) %in% input$downstream_input,
                as.character(has_current_upstream) %in% input$upstream_input
            )
    })
    
    output$scatter_plot <- renderPlot({
        df <- filtered_df()
        
        ggplot(df, aes(x = min_distance_upstream_km, y = min_distance_downstream_km,
                       color = cascade_status, shape = dam_type)) +
            geom_point(size = 3, alpha = 0.8, na.rm = TRUE) +
            labs(
                x = "Min Distance Upstream (km)",
                y = "Min Distance Downstream (km)",
                color = "Cascade Status",
                shape = "Dam Type",
                title = paste("Showing", nrow(df), "of", nrow(reach_df), "dams")
            ) +
            theme_minimal() +
            theme(legend.position = "right")
    })
    
    output$data_table <- renderTable({
        filtered_df()
    })
    
    output$summary_out <- renderPrint({
        summary(filtered_df())
    })
}

shinyApp(ui = ui, server = server)