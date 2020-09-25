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
               projektabschluss = 7,
               order = TRUE,
               sep = "\\t") {
  zeit <- read.table(zz <- 
                       textConnection(gsub(sep, " ", Lines)),
                     header = TRUE)
  close(zz)
  
  names(zeit) <- c("Datum",  "Start",   "Ende",   "Task")
  zeit$Datum <-   gsub("[:punct:-]", ".", zeit$Datum)
  
  jetzt <- Sys.time()
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
  zeit$Ende  <- ifelse( is.na(zeit$End),  zeit$Start, zeit$End)


  zeit$end <- strptime(zeit$Ende, "%H:%M")
   print((zeit$End))
   print((zeit$end))
  zeit$Datum <- strptime(as.character(zeit$Datum)  , "%d.%m")
  
  zeit$Datum <-
    as.POSIXct(paste(
      format(zeit$Datum,  "%Y-%m-%d"), 
      format(zeit$strt, "%H:%M")))
  
 if(order) zeit <- zeit[order(zeit$Datum),]
  
  zeit$strt <- as.POSIXct(zeit$strt)
  zeit$end <- as.POSIXct(zeit$end)
  
  to_num <- function(x) {
    x <- gsub("[:punct:]", "", x)
    as.numeric(x) * 60
  }
  
  zeit <-
    dplyr::mutate(
      zeit,
 #     end = dplyr::case_when(is.na(end) &
 #                              !is.na(Ende) ~ strt + to_num(Ende),
  #                           TRUE ~ end),
      Ende = format(end, "%H:%M"),
      Start = format(strt, "%H:%M"),
      Datum = format(Datum, "%d.%m.%Y"),
      Stunden =
        round(as.numeric(difftime(end, strt, units = "hours")), 2),
      Summe = cumsum(Stunden)
    )
  
  zeit$Task <- gsub("_", " ", zeit$Task)
  zeit[, c("Datum",
           "Start",
           "Ende",
           "Task",
           "Stunden",
           "Summe")]

}


