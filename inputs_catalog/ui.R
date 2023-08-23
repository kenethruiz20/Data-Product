
library(shiny)
library(lubridate)

fluidPage(


    titlePanel("catalogo de los inputs de shiny"),

    sidebarLayout(
        sidebarPanel(
          #aqui van los inputs
          h3("Shiny Inputs"),
          hr(),
          numericInput("ni1","ingrese n:",
                       value = 0,
                       min = -10,
                       max = 10,
                       step = 1),
          sliderInput("si1","ingrese cantidad:",
                      min = 0,
                      max = 100,
                      value = 0,
                      post = "%",
                      animate = TRUE,
                      step = 10),
          sliderInput("si2","ingrese Rango:",
                      min = 0,
                      max = 1000,
                      value = c(0,1000),
                      pre = "$",
                      animate = TRUE,
                      step = 10),
          dateInput("d1","ingrese fecha:", 
                    value = today(),
                    min = today()-1, 
                    max = today()-1,
                    language = "es",
                    weekstart =1),
          dateRangeInput("dri", "Seleccione rando de fechas", start = today()-7,
                         end=today(), separator = "a",language = "es"),
          selectInput("ssi1",
                      "Seleccione un estado",
                      choices = state.name),
          selectInput("Msi1",
                      "Seleccione un estado",
                      choices = state.name,
                      multiple = TRUE,
                      selectize = TRUE),
          checkboxInput("scb1", "Acepto",value = FALSE),
          checkboxGroupInput("cbg1",
                             label = "Seleccion nivel educativo",
                             choices = c("pre-primaria","primaria","secundaria","bachillerato"))
          
          
        ),

        mainPanel(
          # aqui van los outputs
          h3("Numeric Outputs"),
          verbatimTextOutput("ni1_out"),
          h3 ("Single slider input"),
          verbatimTextOutput ("si1_out"),
          h3("Range Slider input"),
          verbatimTextOutput("si2_out"),
          h3 ("Date Input"),
          verbatimTextOutput ("di1_out"),
          h3 ("Range Date input"),
          verbatimTextOutput ("dri_out"),
          h3 ("Select input"),
          verbatimTextOutput ("ssi1_out"),
          h3("Select input"),
          verbatimTextOutput("msi1_out"),
          h3 ("checkboxInput"),
          verbatimTextOutput ("scb1"),
          h3 ("checkboxGroupInput"),
          verbatimTextOutput ("cbg1")
        )
    )
)
