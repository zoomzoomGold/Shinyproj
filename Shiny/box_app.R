


library(shiny)
library(ggplot2)
library(hrbrthemes)


ui <- fluidPage(

 
    titlePanel("Temperature Change over years by region"),

    sidebarLayout(
        sidebarPanel(
      
            sliderInput("year",
                        "Year:",
                        min = 1995,
                        max = 2020,
                        value = 1995)
        ),

      
        mainPanel(
           plotOutput("box", height = 800, width = 1500)
        ),
        
    )
)


server <- function(input, output) {

    cc <- read.csv("C:/docs/babson/QTM2623/Shiny/CC.csv")
    mean_temp = aggregate(CC$AvgTemperature, list(CC$Region, CC$Year), mean)
    
    reactive_data = reactive ({
        year_choice = input$year
        return(CC[CC$Year==year_choice,])
    })
   
    output$box <- renderPlot({
        
        data_by_year=CC[CC$Year==input$year,]
        ggplot(data_by_year, ylim=c(0,100), aes(x=data_by_year$Region, y=data_by_year$AvgTemperature, fill=Region)) +
            geom_boxplot()+
            theme_ipsum() +
            ggtitle("Avg. Temp") +
            xlab("Region")+
            ylab("Temp (F)")+
            scale_y_continuous(breaks=seq(0,100,5))
            
})
}

# Run the application 
shinyApp(ui = ui, server = server)
