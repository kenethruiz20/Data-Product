#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define server logic required to draw a histogram
function(input, output, session) {

output$tabla_1 <- renderDataTable({
  mtcars$car_name <- row.names(mtcars)
  mtcars %>%
    datatable(rownames = FALSE,
              filter = "top",
              options = list(
                pageLength = 5,
                lenghtMenu = c(5,10,25,50)
              ))
              
})

output$tabla_2 <- renderDataTable({
  diamonds %>%
  mutate(vol = x*y*z,
         vol_promedio = mean(vol),
         volp=vol/vol/promedio -1
          ) %>%
    datatable(filter = "top") %>%
    formatCurrency(columns = "price",
                   currency = "$",
                   interval = 3,
                   digits = 2) %>%
    formatPercentage(columns = "volp",digits = 2)%>%
    formatString(columns = "vol",suffix = "mm" )
      
}) 


output$tabla_3 <- renderDataTable({
  mtcars %>%
    datatable(selection = "single", width = 20)
})
  output$output_1 <-renderPrint({
    mtcars[input$tabla_3_rows_selected,]
  })
  
  output$tabla_4 <- renderDataTable({
    mtcars %>%
      datatable(selection = "multiple")
    })
  
  output$output_2 <- renderPrint({)
    mtcars[input$tabla4_rowa_selected,]
    )}
  
    



