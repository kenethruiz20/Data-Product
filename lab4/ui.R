library(shiny)
library(ggplot2)
library(DT)

# Cargamos los datos
data(mtcars)

# Función para generar el gráfico
plot_mpg_wt <- function(data, selected_points = NULL, hover_point = NULL) {
  p <- ggplot(data, aes(x = wt, y = mpg)) +
    geom_point(aes(color = ifelse(rownames(data) %in% selected_points, "selected", ifelse(rownames(data) == hover_point, "hover", "normal")))) +
    xlab("Peso (lb/hp)") +
    ylab("Millas por galón")
  return(p)
}

# UI de la app
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("alpha", "Opacidad:", min = 0, max = 1, value = 0.5),
      sliderInput("size", "Tamaño:", min = 0.5, max = 5, value = 1)
    ),
    mainPanel(
      plotOutput("plot", click = "plot_click", dblclick = "plot_dblclick", hover = "plot_hover", brush = "plot_brush"),
      DTOutput("mytable")  
    )
  )
)

# Server de la app
server <- function(input, output, session) {
  selected_points <- reactiveVal(character(0))
  hover_point <- reactiveVal(NULL)
  
  # Generamos el gráfico inicial
  output$plot <- renderPlot({
    plot_mpg_wt(mtcars, selected_points(), hover_point()) +
      geom_point(alpha = input$alpha, size = input$size) +
      scale_color_manual(values = c("normal" = "black", "hover" = "gray", "selected" = "green"))
  })
  
  # Actualizamos el punto seleccionado al hacer clic
  observeEvent(input$plot_click, {
    info <- nearPoints(mtcars, input$plot_click)
    if (!is.null(info)) {
      point_name <- rownames(info)
      if (point_name %in% selected_points()) {
        selected_points(selected_points()[-which(selected_points() == point_name)])
      } else {
        selected_points(c(selected_points(), point_name))
      }
    }
  })
  
  # Actualizamos el punto al hacer hover
  observeEvent(input$plot_hover, {
    info <- nearPoints(mtcars, input$plot_hover)
    if (!is.null(info)) {
      hover_point(rownames(info))
    }
  })
  
  # Quitamos el color al punto al hacer doble click
  observeEvent(input$plot_dblclick, {
    hover_point(NULL)
  })
  
  # Actualizamos la tabla al hacer brush
  output$mytable <- renderDT({
    if (!is.null(input$plot_brush)) {
      brushedPoints(mtcars, input$plot_brush)
    }
  })
}

# Ejecutamos la app
shinyApp(ui, server)