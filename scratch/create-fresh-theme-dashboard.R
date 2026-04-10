library(fresh)

create_theme(
    
    adminlte_color(
        light_blue = "darkblue"
    ), 
    
    adminlte_global(
        content_bg = "beige",
        box_bg = "beige",
        info_box_bg = "beige"
    ),
    
    adminlte_sidebar(
        dark_bg = "darkblue",
        dark_color = "beige",
        dark_hover_color = "salmon"
    ),
    
    adminlte_vars(
        navbar_light_color = "beige",
        navbar_light_hover_color = "salmon"
    ),
    
    adminlte_tabset(
        border_color = "red"
    ),
    
    adminlte_button(
        default_color = "darkblue",
        default_hover_color = "salmon"
    ),
    
    adminlte_box(
        default_color = "#3455",
        default_hover_color = "salmon"
    )
    output_file = here::here("two-file-app", "www", "fresh-theme.css")
)



