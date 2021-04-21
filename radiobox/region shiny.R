
library(shiny)
library(ggplot2)
library(hrbrthemes)
ui = fluidPage(
    titlePanel("AVG temp by year (by Region)"),
    sidebarLayout(
        sidebarPanel(
            selectInput("Region",
                        label = "choose region",
                        choices = list("Africa","Asia","Australia/South Pacific",
                                       "Europe","Middle East","North America",
                                       "South/Central America & Carribean"),
                        selected = "Africa"),
        
    ),
    
   mainPanel(plotOutput("plot"))
    )

)
# Define the server
server = function(input, output) {
    RT<-read.csv("C:/docs/babson/QTM2623/Shiny/radiobox/region_temp.csv")

    plotting = function (df)
    {
        result <- ggplot(df, aes(x=Group.2, y=x))+
            geom_line()+geom_point()+xlab("Year")+ylab("Avg temp (F)") +xlim(1995, 2019)+
            geom_smooth(color="red", se=FALSE) +
            theme_ipsum()  
        result
    }
    convert = function (x)
    {
        if (input$Region == "Africa") {df.name=africa}
        else if (input$Region == "Asia") {df.name=asia}
        else if (input$Region == "Australia/South Pacific")
        {df.name=AUS.SP}
        else if (input$Region == "Europe") {df.name=EUR}
        else if (input$Region == "Middle East") {df.name=ME}
        else if (input$Region == "North America") {df.name=N.A}
        else if (input$Region == "South/Central America & Carribean")
        {df.name=SCA.CAR}
        
    }
    output$plot <- renderPlot({plotting(convert(input$Region))
      
    })
}

# Run the app
shinyApp(ui = ui, server = server)