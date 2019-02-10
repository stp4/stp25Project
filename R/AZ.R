#' Arbeitszeit
#'
#' @param Lines Arbeitszeiten als Text 
#' @param sep Tabulator
#' @param projektabschluss Zeit für Projektabschluss
#' @param ... nicht Benutzt
#'
#' @return data.frame
#' @export
#'
AZ <- function(Lines,
               sep = "\\t",
               projektabschluss = 7,
               ...) {
  zeit <- read.table(zz <- textConnection(gsub(sep, " ", Lines)),
                     header = TRUE)
  close(zz)
  
  names(zeit) <- c("Datum",  "Start",   "Ende",   "Task")
  
  
  jetzt <- Sys.time()
 # print(zeit)
  zeit <-  rbind(
    zeit,
    data.frame(
      Datum = format(jetzt, '%d.%m.%Y'),
      
      Start = format(jetzt,  '%H:%M'),
      Ende   = format(jetzt + 60 * projektabschluss,  '%H:%M')   ,
      Task  = "Projektabschluss" ,
      stringsAsFactors = FALSE
    )
  )
  
  zeit$strt <- strptime(zeit$Start, "%H:%M")
  zeit$end <- strptime(zeit$Ende, "%H:%M")
  zeit$Stunden <-
    round(as.numeric(difftime(zeit$end, zeit$strt, units = "hours")), 2)
  zeit$Summe <- cumsum(zeit$Stunden)
  
  zeit$Task <- gsub("_", " ", zeit$Task)
  zeit[, c("Datum",
           "Start",
           "Ende",
           "Task",
           "Stunden",
           "Summe")]
  
}