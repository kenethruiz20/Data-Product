#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Tablas en DT"),
    tabsetPanel(
      tabPanel("Vista Basicas",
               fluidRow(
                 column(12,
                        dataTableOutput("tabla_1")
                        )
               )
              ),
            fluidRow(
              column(12,
                     h1("Tipos de datos"),
                    dataTableOutput("tabla_2")
                    )
        )
        ),
            
      tabPanel("Click en tablas",
               fluidRow(
                 column(6,
                        h2("single select row"),
                        dataTableOutput("tabla_3"),
                        verbatimTextOutput("output_1")
                        ),
                 column(6,
                        h2("multi select row"),
                        dataTableOutput("tabla_4"),
                        verbatimTextOutput("output_2")
                        )
               )
               )
      
    )


