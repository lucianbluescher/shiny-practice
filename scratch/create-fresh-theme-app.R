library(fresh)

create_theme(
        theme = "default",
        
        bs_vars_global(
            body_bg = "beige",
            text_color = "hotpink",
            link_color = "royalblue"
        ),
        
        bs_vars_navbar(
            default_bg = "limegreen",
            default_color = "gray",
            default_hover_color = "salmon"
        ),
        
        bs_vars_tabs(
            border_color = "red"
        ),
        
        output_file = here::here("two-file-app", "www", "fresh-theme.css")
)
