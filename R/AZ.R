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
  zeit$Datum <-   gsub("[:punct:-]", ".", zeit$Datum)
  
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
  zeit$Datum <- strptime( as.character(zeit$Datum)  ,"%d.%m")
  
  zeit$Datum <- as.POSIXct( paste(  format(zeit$Datum,  "%Y-%m-%d"), format(zeit$strt, "%H:%M") ))
  
  zeit<- zeit[order(zeit$Datum),]
  #  
  zeit$strt <- as.POSIXct(zeit$strt)
  zeit$end <- as.POSIXct(zeit$end)
  
  
  
  to_num <- function(x) {
    x <- gsub("[:punct:]", "", x)
    # print(x)
    as.numeric(x) * 60
  }
  
  zeit <-
    dplyr::mutate(
      
      zeit,
      end = dplyr::case_when(is.na(end) &
                               !is.na(Ende) ~   strt + to_num(Ende), TRUE ~ end),
      Ende = format(end, "%H:%M"),
      Start =  format(strt, "%H:%M"), 
      Datum= format(Datum, "%d.%m.%Y"),
      Stunden =
        round(as.numeric(difftime(end, strt, units = "hours")), 2),
      Summe= cumsum(Stunden)
    )
  
  
  
  
  zeit$Task <- gsub("_", " ", zeit$Task)
  zeit[, c("Datum",
           "Start",
           "Ende",
           "Task",
           "Stunden",
           "Summe")]
  
}