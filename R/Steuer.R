#' Einkommensteuer
#' 
#' 
#' https://finanzonline.bmf.gv.at/fon/login.do
#' +4369981530117
#' 
#' grundsätzlich bis 30. April des Folgejahres bis 30. Juni bei Übermittlung auf elektronischem Wege
#'
#'  
#'
#' Önace Code	Text	Tätigkeit 73200	Markt- und Meinungsforschung
#' 
#' Tätigkeit als  Liebhaberei 
#' Wenn die Vermietung oder Verpachtung über einen längeren Zeitraum keinen Gewinn
#' erwarten lässt, sind diese Einkünfte steuerlich unbeachtlich. Das heißt, dass Verluste aus
#' dieser Tätigkeit mit anderen positiven Einkünften nicht ausgeglichen werden dürfen.
#' Sollte sich ausnahmsweise ein Gewinn ergeben, ist dieser nicht steuerpflichtig.
#' Zu unterscheiden ist dabei zwischen der so genannten  kleinen  Vermietung wie z.B. der
#' Vermietung von Ein- und Zweifamilienhäusern, Eigentumswohnungen oder Bungalows und
#' der  großen  Vermietung. Das ist die Vermietung von mindestens drei Wohneinheiten,
#' betrifft also vor allem Miethäuser (siehe dazu das Infoblatt  Liebhaberei im
#'                                     Steuerrecht ).
#'  
#' 
#' @param jahr Jahr
#' @param konto Kontospiegel
#' @param SVA,Betriebsausgaben,Reisespesen,Versicherungspraemien,Steuerberater Summe, 
#' @param pauschale Pauschalierung für Kleinunternehmer
#' @param AfA,afa_anlagen,afa_instandsetzung Abschreibung 
#' @param konto_path Pfad
#' @param eigene_buchung_konto,visa,versicherung,privat,kirche,spenden,sva Such-String fuer die jeweilige Buchung
#'
#' @return
#' @export
#'
#' @examples
#' #' 
#' afa<- 
#' AfA(
#'   list(
#'     nr = 1, datum = "26.01.2012",
#'     pos = "PC L412 Windert GmbH, Bad Oldeslose",
#'     type = "A",
#'     euro = 463.95, nd = 3, rs = 1),
#'   list(
#'     nr = 33, datum = "09.11.2012",
#'     pos = "Büro Fenster+Tür EA-Ceramic e.U. Hallerstraße 35, Ibk",
#'     type = "I",
#'     euro = 3517.20, nd = 10, rs = 0.5),
#'   list(
#'     nr = 34, datum = "03.12.2012",
#'     pos = "Büro Fussboden-Sanierung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#'     type = "I",
#'     euro = 2271.71, nd = 10, rs = 0.5),
#'   list(
#'     nr = 35, datum = "03.12.2012",
#'     pos = "Büro Fussboden-Heizung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#'     type = "I",
#'     euro = 912.48, nd = 10, rs = 0.5),
#'   list(
#'     nr = 21694, datum = "23.01.2018",
#'     pos = "Thinkpad T450s Matthias Rimkus",
#'     type = "A",
#'     euro = 475, nd = 3, rs = 1),
#'   list(
#'     nr = 130603,  datum = "07.06.2013",
#'     pos = "Büromöbel Leitgeb&leitgeb 6020 Innsbruck",
#'     type = "I",
#'     euro = 8436.00, nd = 10, rs = 0.5),
#'   jahr=2019,
#'   konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2019/" 
#' )
#' 
#' Steuer(
#'   konto="umsaetze2019.csv", 
#'   AfA = afa,
#'   Versicherungspraemien = c(Zuericher = 460.56, Uniqa = 0),
#'   jahr=2019,
#'   konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2019/" 
#' )
Steuer <- function(jahr = lubridate::year(lubridate::as_date(Sys.time())) - 1,
                   konto = "umsaetze2019.csv",
                   SVA = NA,
                   Betriebsausgaben = c(VISA = 0, Buecher = 0),
                   Reisespesen = c(Bus = 0, Taxi = 0),
                   Versicherungspraemien = 0, Steuerberater = 0,
                   # bar_einnahmen = 0,
                   pauschale = 0.20,
                   AfA = data.frame(
                     Pos = c("Anlagen", "Instandsetzung"),
                     Kennzahl = c(9130, 9150),
                     Betrag = c(0, 0)
                   ),
               
                   konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2019/",
                   eigene_buchung_konto = c("AT573626000100540567", "AT573626000000540567"),
                   visa = "VISA-RECHNUNG",
                   versicherung = c("UNIQA"),
                   privat = c(
                     "Delinat",
                     "Lebensmitteltechnik",
                     "Deutscher Pressevertrieb",
                     "TIWAG",
                     "Privatentnahme",
                     "Hechenblaikner",
                     "0006000079753746",
                     "Wolfgang Peter"
                   ),
                   kirche = "Bischöfliche",
                   spenden = c("ÖRK", "Kinderpatenschaft"),
                   sva = "AT69ZZZ00000003350") {
  knt <-
    read.csv2(paste0(konto_path, konto),
              header = FALSE,
              encoding = "UTF-8")
  knt[[2]] <-
    gsub("Auftraggeber: ", "", gsub("Zahlungsempfänger: ", "", knt[[2]]))
  knt <- knt[, c(6, 2, 4)]
  names(knt) <- c("datum", "txt", "euro")
  knt$einnahmen <- ifelse(knt$euro > 0, knt$euro, NA)
  knt$ausgaben <- ifelse(knt$euro < 0, knt$euro, NA)
  knt$datum <-
    lubridate::as_datetime(knt$datum, format = "%d.%m.%Y %H:%M:%S:")
  
  knt <- knt[lubridate::year(knt$datum) == jahr, ]
  
  sva <- grep(sva, knt$txt)
  knt_sva <- knt[sva, ]
  knt <- knt[-sva, ]
  knt_sva$Pos <- "sva"
  
  
  eigene_buchung <- c(grep(eigene_buchung_konto[1], knt$txt),
                      grep(eigene_buchung_konto[2], knt$txt))
  knt_eigene_buchung <- knt[eigene_buchung, ]
  knt <- knt[-eigene_buchung, ]
  
  
  prvt <- c()
  for (i in privat)
    prvt <- c(prvt, grep(i, knt$txt))
  
  knt_privat <- knt[prvt, ]
  knt <- knt[-prvt, ]
  knt_privat$Pos <- "privat"
  
  visa <- grep(visa, knt$txt)
  knt_visa <- knt[visa, ]
  knt <- knt[-visa, ]
  knt_visa$Pos <- "visa"
  
  kirche <- grep(kirche, knt$txt)
  knt_kirche <- knt[kirche, ]
  knt <- knt[-kirche, ]
  knt_kirche$Pos <- "kirche"
  
  spenden <- c(grep(spenden[1], knt$txt), grep(spenden[2], knt$txt))
  knt_spenden <- knt[spenden, ]
  knt <- knt[-spenden, ]
  knt_spenden$Pos <- "spenden"
  
  versicherung <- grep(versicherung, knt$txt)
  knt_versicherung <- knt[versicherung, ]
  knt <- knt[-versicherung, ]
  knt_versicherung$Pos <- "versicherung"
  
  knt$Pos <- ifelse(knt$euro > 0, "Erträge", "Betriebsausgaben")
  
  
  
  Einnahmen <- sum(knt$einnahmen, na.rm = TRUE)
  
  if (is.na(SVA))
    SVA <- sum(knt_sva$euro, na.rm = TRUE) * (-1)
  Kirche <- sum(knt_kirche$euro, na.rm = TRUE) * (-1)
  Spenden <- sum(knt_spenden$euro, na.rm = TRUE) * (-1)
  Ausgaben <-
    sum(knt$ausgaben, na.rm = TRUE) * (-1) + sum(Betriebsausgaben)
  Pauschale <-
    round(pauschale * sum(knt$einnahmen, na.rm = TRUE), 2)
  
  Privat_Visa <- sum(knt_visa$euro)
  Privat_Versicherung <- sum(knt_versicherung$euro)
  Privat <- sum(knt_privat$euro)
  
  Versicherungspraemien <- sum(Versicherungspraemien)
  Reisespesen <- sum(Reisespesen)
  
  afa_anlagen	= AfA$Betrag[1]
  afa_instandsetzung	= AfA$Betrag[2]
  
  rslt <- data.frame(
    Pos = c(
      "Erträge",
      "AfA Anlagen",      "Instandsetzung",
      "Reisespesen", "Versicherung (SVA)", "Betriebsausgaben",
      "Einkünfte", 
      "Versicherungsprämien", "Spenden","Kirche", "Steuerberater",
      "Privat (Visa)","Privat (Versicherung)","Privat",
      "Betriebsausgabenpauschale 20%","Gewinn (ab 2020)",
      "UST Gesamtbetrag", "Kleinunternehmer"
    ),
    Kennzahl = c(
      9040,
      9130,  9150,
      9160,  9225,  9230,  320,
      455,
      "",  "",  "",
      "n.a.", "n.a.", "n.a.",
      "", "",
      "000", "016"
    ),
    Betrag = c(
      Einnahmen,
      afa_anlagen, afa_instandsetzung,
      Reisespesen, SVA, Ausgaben,
      Einnahmen - afa_anlagen - afa_instandsetzung - Reisespesen - SVA - Ausgaben,
      Versicherungspraemien, Spenden, Kirche,  Steuerberater,
      Privat_Visa,  Privat_Versicherung, Privat,
      Pauschale, Einnahmen - Pauschale - SVA,
      Einnahmen,Einnahmen
      
    )
  )
  
  cat("\nSpeichern der Buchungsliste \n Pfad: ", konto_path, "\n\n")
  write.csv(
    rbind(knt, knt_kirche, knt_spenden, knt_sva),
    paste0(konto_path, "konto_bereinigt.csv")
  )
  write.csv(rslt, paste0(konto_path, "Buchungsliste.csv"))
  
  rslt$Betrag<- stp25rndr::Format2(rslt$Betrag, 2, decimal.mark=",")
  rslt
}


#' Abschreibung
#' 
#' linearen AfA
#'
#' @param ... Liste mit Anlagen
#' @param jahr Jahr
#' @param konto_path Pfad
#' @export
#' 
AfA <-
  function(..., 
           jahr = lubridate::year(lubridate::as_date(Sys.time())) - 1,
           konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2019/"
           ) {
    
    rslt <- data.frame(
      nr = integer(),
      datum = character(),
      pos =	character(),
      euro = numeric(),
      nd = integer(),
      rs = numeric()
    )
    
    for (i in list(...)) {
      bchng <- as.data.frame(i)
      bchng$datum <-
        lubridate::as_date(bchng$datum , format = "%d.%m.%Y")
      bchng$datum <- bchng$datum - lubridate::years(1)
      bchng_jahr <- NULL
      for (j in seq_len(bchng$nd)) {
        bchng$AfA <- round(bchng$euro / bchng$nd * bchng$rs, 2)
        bchng$datum <- bchng$datum + lubridate::years(1)
        bchng$Rest <- round(bchng$euro - bchng$AfA * j)
        bchng$Rest <- ifelse(bchng$Rest < 1, 1, bchng$Rest)
        
        if (lubridate::year(bchng$datum) <= jahr)
          bchng_jahr <- rbind(bchng_jahr, bchng)
        
      }
      rslt <- rbind(rslt, bchng_jahr)
      
    }
    
    write.csv(rslt, paste0(konto_path, "AfA-Tabelle.csv"))
    rslt_jear <- rslt[lubridate::year(rslt$datum) == jahr, -3]
    write.csv(rslt_jear, paste0(konto_path, "AfA-", jahr, ".csv"))
    
    data.frame(
      Pos = c("Anlagen", "Instandsetzung"),
      Kennzahl = c(9130, 9150),
      Betrag = c(sum(rslt_jear[rslt_jear$type == "A", "AfA"]),
                 sum(rslt_jear[rslt_jear$type == "I", "AfA"]))
    )
    
    
  }
