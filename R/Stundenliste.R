#' Stundenliste
#'
#' @param euro Zahl
#'
#' @return text
Stundenliste <- function(euro = 85,
                         myswd = "",
                         knr,
                         name,
                         email,
                         tel,
                         adr,
                         anrede,
                         betreff,
                         zwischenrechnung = 400) {
  jetzt <- Sys.time()
  # print(zeit)
  zeit <-  paste(
    format(jetzt, '%d.%m.%Y'),
    " ",
    format(jetzt - 60 * 16,  '%H:%M'),
    format(jetzt,  '%H:%M'),
    " ",
    " Einarbeiten_ins_Thema"
  )
  
  
  msg <- paste0(
    "#' ---
#' title: Stundenliste
#' author: Wolfgang Peter
#' output:
#'   pdf_document: default
#' ---


#+ echo=FALSE

",
    myswd,
    
    
    "

stp25Project::Arbz()

arbeitszeit <-
stp25Project::AZ(
  '
Datum   Start   Ende   Task
",
    zeit,
    
    "

'
  )



euro <- ",
euro,
"
zwischenrechnung <- ",
zwischenrechnung,
"
h_min <- min(arbeitszeit$Summe)
h_max <- max(arbeitszeit$Summe)

euro <-  euro * h_max
leistungszeitraum <-
  paste(arbeitszeit[1, 1], 'bis', arbeitszeit[nrow(arbeitszeit), 1])


# arbeitszeit
# paste( leistungszeitraum, ', Betrag', euro, 'Euro')

cat(stp25Project::rechnung_email(
  '",
name,
"','",
email,
"',
  '",
anrede,
"', euro, '",
knr,
"',  arbeitszeit)
  , file = 'Invoice.txt')



if(euro > zwischenrechnung) {
  library(crayon)
  cat(bgMagenta('\n\nBitte dringend eine ') %+% bgYellow('Zwischenrechnung') %+%
      bgMagenta(' stellen!\n\n ', euro, 'Euro (',h_max, 'h )\n\n' )
  )

  if (options()$prompt[1] == 'HTML> ')
    stp25output2::End()
  stop()

}

"
  )
  msg
}


#' Anwesenheitszeiten
#'
#' @param monat Number
#' @param jahr  Number
#' @param start Number
#' @param Taetigkeiten  liste
#' @param Arbeitstage string
#' @param Woche string
#' @param Arbeitsfrei string
#' @param Wochenende string
#' @param Urlaub string
#'
#' @return data.frame
#' @export
#'
#' @examples
#' \dontrun{
#'  Anwesenheitszeiten(monat = 12,
#' jahr = 2022,
#' start = 15,
#' Urlaub= c("2022-12-19",  "2022-12-30"))
#'
#'   holidays()
#'   }
Anwesenheitszeiten <-
  function(monat = lubridate::month(Sys.Date()),
           jahr = lubridate::year(Sys.Date()),
           start = NULL,
           Taetigkeiten = list(
             list("1: Teamgruppenbesprechungen", 1),
             list("2: Student/innenbesprechstunden", 6),
             list("3: Fixe Lehrtermine", 0),
             list("4: Fixtermine an technischen Geräten", 0),
             list("5: Sonstige dienstliche Erfordernisse", 3)
           ),
           Arbeitstage = c("Monday", "Tuesday", "Wednesday", "Thursday"),
           Woche = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
           Arbeitsfrei = setdiff(Woche, Arbeitstage),
           Wochenende = c("Saturday", "Sunday"),
           Urlaub = NULL) {
    set.seed(2)    
    if (is.list(Taetigkeiten))
      Taetigkeiten <- unlist(lapply(Taetigkeiten , function(x) {
        if (x[[2]] > 0)
          rep(x[[1]], x[[2]])
      }))
    # holidays
    holidays <- holidays(jahr)
    
    # Kalender
    ganzes_jahr <-
      data.frame(date = lubridate::as_date(
        lubridate::as_date(paste0(jahr, "-01-01")):lubridate::as_date(paste0(jahr, "-12-31"))))
    ganzes_jahr <-
      dplyr::left_join(ganzes_jahr, holidays, by = "date")
    ganzes_jahr  <- dplyr::mutate(
      ganzes_jahr,
      holiday = ifelse(is.na(holiday), FALSE, holiday),
      weekday = weekdays(date),
      workday =  weekday %in% Arbeitstage,
      Arbeitszeit = ifelse(workday &
                             (!holiday)   , 2.5, 0),
      Taetigkeiten = sample(rep(
        Taetigkeiten, length.out = nrow(ganzes_jahr)
      )),
      Taetigkeiten = ifelse(is.na(name), Taetigkeiten, paste("Feiertag:",  name)),
      Taetigkeiten = ifelse(weekday %in%  Arbeitsfrei, "n.a.", Taetigkeiten),
      Anwesenheitszeiten = zeiten(nrow(ganzes_jahr)),
      Anwesenheitszeiten = ifelse(Arbeitszeit == 0, "---", Anwesenheitszeiten),
      Datum = format(date, "%a %d.%b")
    )
    
    
    ganzes_jahr <-
      dplyr::filter(ganzes_jahr, !weekday %in% Wochenende)
    
    
    ganzes_monat <-
      ganzes_jahr[lubridate::month(ganzes_jahr$date) == monat, ]
    
    if (!is.null(start))
      ganzes_monat <-
      ganzes_monat[lubridate::day(ganzes_monat$date) >= start,]
    
    
    if (!is.null(Urlaub)) {
      #  print(ganzes_monat)
      Urlaub <-
        which(ganzes_monat$date %in% lubridate::as_date(Urlaub)
              & ganzes_monat$workday)
      ganzes_monat[Urlaub, "Taetigkeiten"] <- "Urlaub"
      ganzes_monat[Urlaub, "Anwesenheitszeiten"] <- "---"
      ganzes_monat[Urlaub, "Arbeitszeit"] <- 0
    }
    
    ganzes_monat[, c("Datum",
                     "Taetigkeiten",
                     "Anwesenheitszeiten",
                     "Arbeitszeit")]
    
  }




 

zeiten <- function(n = 365, time = 2.5) {
  h <-  sample(rep(c(8, 8, 8, 8, 8, 8, 9, 9, 10, 11), length.out = n))
  min <-
    sample(rep(c(00, 00, 00, 00, 00, 00, 00, 15, 15, 30, 45), length.out = n))
  
  start <-  as.POSIXct(paste0(h, ":", min), format = "%H:%M")
  end <- start + time * 60 * 60
  
  paste(
    start = format(start, format = "%H:%M"),
    "bis",
    end = format(end, format = "%H:%M")
  )
}


holidays <- function(jahr = lubridate::year(Sys.Date())) {
  url <-
    paste0("https://date.nager.at/api/v3/publicholidays/",
           jahr,
           "/AT")
  holidays <-  httr::content(httr::GET(url))
  Joseph <- paste0(jahr, "-03-19")
  holidays <- data.frame(date = unlist(sapply(holidays, "[", 1)),
                         name = unlist(sapply(holidays, "[", 2)))
  holidays <- rbind(holidays, c(Joseph , "Joseph"))
  holidays <-  holidays[order(holidays[[1]]), ]
  holidays$date <- lubridate::as_date(holidays$date)
  holidays$holiday <- TRUE
  holidays
}
