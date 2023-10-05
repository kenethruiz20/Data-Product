library(plumber)

#' @apiTitle Clase sobre plumber
#' @apiDescription En este endpoint tenemos los 
#' tres ejemplos de como utilizar plumber
#' para crear apis

#' api de echo 
#' @param msg El mensaje a repetir 
#' @get /echo
function(msg=''){
  list(msg = paste0("El mensaje es:", "'",msg, "'"))
}
