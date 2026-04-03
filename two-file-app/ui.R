# ---- user interface ----

ui <- navbarPage(
    title = "LTER Animal Explorer",
    
    # Page 1: intro tabPanel
  
    tabPanel(title = "About this App",
             
             # intro text fluidRow ----
             fluidRow(
                    
                 # use columns to create white space on sides
                 column(1),
                 column(10, includeMarkdown("text/about.md")),
                 column(1)
                 
    ),  # END (Page 1) intro tabPanel, 
    
    hr(), # creates light gray horizontal line
    
    # footer text ----
    includeMarkdown("text/footer.md")
    ),
    # Page 2: data explorer tabPanel
    tabPanel(title = "Explore the Data",
             
             tabsetPanel(
                 
                 # trout tabPanel ----
                 tabPanel(
                     title = "Trout",
                     
                     # trout sidebarLayout
                     sidebarLayout(
                         
                         sidebarPanel( 
                             
                             # channel type pickerInput ----
                             pickerInput(inputId = "channel_type_input", label = "Select channel type(s):",
                                         choices = unique(clean_trout$channel_type),
                                         selected = c("cascade", "pool"),
                                         multiple = TRUE,
                                         options = pickerOptions(actionsBox = TRUE)), # END channel type pickerInput
                                         
                             # section checkboxGroupButtons ----
                             checkboxGroupButtons(inputId = "section_input", label = "Select a sampling section(s):",                                            choices = c("clear cut forest", "old growth forest"),
                                                  selected = c("clear cut forest", "old growth forest"),
                                                  individual = FALSE, justified = TRUE, size = "sm",
                                                  checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                                                   no = icon("xmark", lib = "font-awesome"))), 
                         
                         ), # END trout sidebarPanel  
                         # trout mainPanel ----
                         mainPanel(
                             
                             plotOutput(outputId = "trout_scatterplot_output")
                         )
                     ) # END trout sidebarLayout
                 ), # END Trout tabPanel
                 
                 # penguins tabPanel ----
                 tabPanel(
                     title = "Penguins",
                     
                     # penguin sidebarLayout ----
                     sidebarLayout(
                         
                         # penguin sidebarPanel ----
                         sidebarPanel(
                             
                             pickerInput(inputId = "penguin_island_input", label = "Select an island(s):",
                                         choices = c("Torgersen", "Dream", "Biscoe"),
                                         selected = c("Torgersen", "Dream", "Biscoe"),
                                         multiple = TRUE,
                                         options = pickerOptions(actionsBox = TRUE)), # END penguin species pickerInput
                             # bin number sliderInput ----
                             sliderInput(inputId = "bin_num_input", 
                                         label = "Select number of bins:",
                                         min = 1, max = 100, value = 25) # END bin number sliderInput

                         ), # END penguin sidebarPanel
                         
                         # penguin mainPanel ----
                         mainPanel(
                             
                             plotOutput(outputId = "flipper_length_histogram_output")
                             
                         ) # END penguin mainPanel
                         
                     ) # END penguin sidebarLayout
                 ) # END penguin tabPanel
             ) # END tabsetPanel
    ) # END (Page 2) data explorer tabPanel
) # END navbarPage