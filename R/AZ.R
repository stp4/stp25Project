


#' Arbeitsmy_az
#'
#' @param Lines Arbeitsmy_azen als Text
#' @param sep Tabulator
#' @param projektabschluss my_az für Projektabschluss
#' @param zwischenrechnungen  zwischenrechnungen  
#' @param order sortieren
#' @param ... nicht Benutzt
#'
#' @return data.frame
#' @export
#'
#' @examples
#'  \dontrun{
#'  AZ('
#' Datum   Start   Ende Projekt  Task
#' 01-01-2021  14:46 15:20  hs1 "710_HS-3.html Kommentare  plus Grafiken"
#' 26.02.2021   10:17 11:11 hs1 Auswerten
#' 26.02.2021   10:17 11:08 hs2  Auswerten
#' 26.02.2021   10:17 11:08 hs1  Auswerten
#' ',
#' 10
#' )
#'
#'
#'}
AZ <- 
  function(Lines,
           projektabschluss = 0,
           zwischenrechnungen = FALSE,
           order = TRUE,
           sep = "\\t") {
  my_az <- 
    read.table(
       zz <- textConnection(
         gsub(sep, " ", Lines)),
      header = TRUE)
  close(zz)
  
  if (ncol(my_az) == 4)
    default_AZ(my_az, projektabschluss, order, zwischenrechnungen)
  else if (ncol(my_az == 5))
    extended_AZ(my_az, projektabschluss, order, zwischenrechnungen)
}


h_to_time <- 
  function(h, end, rev = FALSE) {
  x <- !grepl("\\:", h)
  r <-  strptime(h, "%H:%M")
  
  if (length(r) > 0)
    if (rev)
      r[x]  <-  end[x] + as.numeric(h[x]) * 3600
  else
    r[x]  <-  end[x] - as.numeric(h[x]) * 3600
  
  r
}

to_min_num <- 
  function(x) {
  x <- gsub("[:punct:]", "", x)
  as.numeric(x) * 60
}

extended_AZ <-
  function(my_az,
           projektabschluss,
           order,
           zwischenrechnungen = FALSE,
           mynames =  c("Datum", "Start", "Ende", "Projekt", "Task"),
           jetzt = Sys.time()) {
    
    if (length(unique(c(names(my_az), mynames))) == 5)
      my_az <- my_az[mynames]
    else
      names(my_az) <- mynames
#  my_az$Datum <-   gsub("[:punct:-]", ".", my_az$Datum)
  
  # add intern
    my_az <-  rbind(
      my_az,
      data.frame(
        Datum =  format(jetzt, '%d.%m.%Y'),
        Start = format(jetzt,  '%H:%M'),
        Ende   = format(jetzt + 60 * projektabschluss, '%H:%M')   ,
        Projekt = "Intern",
        Task  =  if (!zwischenrechnungen) "Projektabschluss" else "Zwischenrechnungen",
        stringsAsFactors = FALSE
      ))
  
  #' hier werden die Minuten in Zeit umgewandelt
  my_az$Ende  <- ifelse(is.na(my_az$End), my_az$Start, my_az$End)
  my_az$end   <- strptime(my_az$Ende, "%H:%M")

  my_az$strt  <- h_to_time(my_az$Start , my_az$end)
  my_az$end   <- h_to_time(my_az$Ende,  my_az$strt, rev=TRUE)
  
 
  my_az$Datum <- lubridate::parse_date_time(my_az$Datum, c("dmY", "dmy", "dm"))

  if (order)
    my_az <- my_az[order(my_az$Datum, my_az$Start), ]
  
  
  my_az$strt <- as.POSIXct(my_az$strt)
  my_az$end <- as.POSIXct(my_az$end)
  

  intern <-  which(my_az$Projekt == "Intern")
  intern_az <- my_az[intern,]
  my_az <- my_az[-intern,]
  
  my_az$Projekt <- factor(my_az$Projekt)
  
  
  total_az <- NULL
  rslt <- split(my_az, my_az$Projekt)

  my_az_list <- list()
  for (i in names(rslt)) {
    temp <-  dplyr::mutate(
      rslt[[i]],
      Ende = format(end, "%H:%M"),
      Start = format(strt, "%H:%M"),
      Datum = format(Datum, "%d.%m.%Y"),
      Stunden =
        round(as.numeric(difftime(
          end, strt, units = "hours"
        )), 2),
      Summe = cumsum(Stunden)
    )
    temp$Task <- gsub("_", " ", temp$Task)
    
    total_az <- rbind(total_az,
                      data.frame(Projekt = i,
                                 Summe = temp[nrow(temp), "Summe"]))
    
    my_az_list[[i]] <-
      temp[, c("Datum",
               "Start",
               "Ende",
               "Task",
               "Stunden",
               "Summe")]
    

  }  
  

  total_az <- rbind(
    total_az,
    data.frame(Projekt = "Summe",
               Summe = sum(total_az$Summe)),
 
    
    data.frame(Projekt = "Intern",
               Summe = with(intern_az, round(
                 as.numeric(difftime(end, strt, units = "hours")), 2
               )))
  )
  names(total_az)[2] <- "Stunden"
  my_az_list[["total"]] <- total_az
  
  my_az_list
}



default_AZ <-  function(my_az, projektabschluss, order, zwischenrechnungen =FALSE) {
  names(my_az) <- c("Datum",  "Start",   "Ende",   "Task")
 # my_az$Datum <-   gsub("[:punct:-]", ".", my_az$Datum)
 
  jetzt <- Sys.time()
  my_az <-  rbind(
    my_az,
    data.frame(
      Datum = format(jetzt, '%d.%m.%Y'),
      
      Start = format(jetzt,  '%H:%M'),
      Ende   = format(jetzt + 60 * projektabschluss,  '%H:%M')   ,
      Task  =  if (!zwischenrechnungen )"Projektabschluss" else  "Zwischenrechnungen ",
      stringsAsFactors = FALSE
    )
  )
  
 
  my_az$Ende  <- ifelse(is.na(my_az$End),  my_az$Start, my_az$End)
  my_az$end <- strptime(my_az$Ende, "%H:%M")
  my_az$strt <- h_to_time(my_az$Start , my_az$end)
  my_az$end   <- h_to_time(my_az$Ende,  my_az$strt, rev=TRUE)
  
  my_az$Datum <- lubridate::parse_date_time(my_az$Datum, c("dmY", "dmy", "dm"))
  
  
  if (order)
    my_az <- my_az[order(my_az$Datum), ]
  
  my_az$strt <- as.POSIXct(my_az$strt)
  my_az$end <- as.POSIXct(my_az$end)
  
  
  my_az <-
    dplyr::mutate(
      my_az,
      
      Ende = format(end, "%H:%M"),
      Start = format(strt, "%H:%M"),
      Datum = format(Datum, "%d.%m.%Y"),
      Stunden =
        round(as.numeric(difftime(end, strt, units = "hours")), 2),
      Summe = cumsum(Stunden)
    )
  
  my_az$Task <- gsub("_", " ", my_az$Task)
  my_az[, c("Datum",
            "Start",
            "Ende",
            "Task",
            "Stunden",
            "Summe")]
  
}
# 
# # # 
# # 
# x<-AZ(
#   '
# Datum   Start   Ende Projekt  Task
# 01-01-2021  14:46 1 hs1 "710_HS-3.html Kommentare"
# 26.01.2021   1 11:11 hs1 Auswerten
# 26.03.2020   10:17 0 hs1 Auswerten
# 26.04.2020   10:17 11:11 hs1 Auswerten
# 26.05.2021   10:17 11:11 hs1 Auswerten
# 26.06.2021   10:17 11:11 hs1 Auswerten
# 26.02.2021   10:17 11:08 hs2  Auswerten
# 26.02   10:17 11:08 hs2  Auswerten
# 26.02.2021   1.5 11:08 hs1  Auswerten
# ',
#   0
# )
#  
# x[[1]]
