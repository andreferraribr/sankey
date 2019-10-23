#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("ano",
                        "Number of bins:",
                        min = min(influx$ano),
                        max = max(influx$ano),
                        value = c(2005,2018))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        influx<- influx%>%
            filter(ano == input$ano)
        
        ggplot(influx, aes(y = influx$influx_reais, x = ano)) +
            geom_col(position = "dodge", colour = "black") +
            scale_fill_brewer(palette = "Pastel1")+
            guides(fill = FALSE)+
            theme(axis.text.y = element_text(angle = 00, hjust = 1, vjust = 1, size = 7))+
            coord_flip()
        
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
