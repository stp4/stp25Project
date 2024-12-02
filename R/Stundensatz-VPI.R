





#' Stundensatz
#' 
#' 
#' Stundensatz auf basis nom VPI 
#' Student 80 Euro
#' Firma 120 Euro
#'
#' @param x character.
#' @param VPI numeric.
#'
#' @return numeric Euro
#' @export
#'
#' @examples
#' 
#'  Stundensatz(
#'  "Student",  
#'  VPI = c(
#'    "2020" = 1.4,
#'    "2021" = 2.8,
#'    "2022" = 8.6,
#'    "2023" = 7.8
#' ))
Stundensatz <- function(x = "Student",
                        VPI = c(
                          "2020" = 1.4,
                          "2021" = 2.8,
                          "2022" = 8.6,
                          "2023" = 7.8
                        )) {
  Stnd <- data.frame(
    Jahr = c(as.numeric(names(VPI)), NA),
    VPI = c(as.numeric(VPI), NA) ,
    Euro = NA
  )
  Stnd[1, 3] <- 100
  lst <- nrow(Stnd)
  Stnd[lst, 1] <- Stnd[lst - 1, 1] + 1
  
  
  for (i in seq(1:(lst - 1))) {
    Stnd$Euro[i + 1] <- Stnd$Euro[i] * (1 +  Stnd$VPI[i] / 100)
  }
  
  Stnd$Friseur = round(Stnd$Euro * .23)
  Stnd$Student = round(Stnd$Euro * 0.80)
  Stnd$Firma = round(Stnd$Euro * 1.20)
  
  Stnd[lst, x]
}


