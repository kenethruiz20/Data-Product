
library(shiny)

function(input, output, session) {

   #numeric input
  output$ni1_out <- renderPrint({
    print(input$ni1)
    (str(input$ni1))
  })
  #single slider input
  output$ni1_out<- renderPrint({
    print(Input$si1)
    (str(input$si1))
  })
  #single slider input
  output$si2_out<- renderPrint({
    print(Input$si2)
    str(input$si2)
  })
  #single date input
  output$di1_out<- renderPrint({
    print(Input$di1)
    str(input$di1)
  })
  
  #Select input
  output$ssi1_out <- renderPrint({
    print(input$ssi1)
    (str(input$ssi1))
  })
  #Select input
  output$msi1_out<- renderPrint({
    print(Input$msi1)
    (str(input$msi1))
  })
  #checkboxInput
  output$scb1_out<- renderPrint({
    print(Input$scb1)
    str(input$scb1)
  })
  #checkboxInput
  output$cbg1_out<- renderPrint({
    print(Input$cbg1)
    str(input$cbg1)
  })

}
