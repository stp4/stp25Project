
#setwd("C:/Users/wpete/Dropbox/2_Finanzen/Steuer/2023")









# Helper ------------------------------------------------------------------




#' Konto aufraumen
#'
#' @param x data.frame
#' @param jahr Jahr
#' @param format format des string Jahr
#' @param select Posten des Kontos   Buchungsdatum,	Partnername und Betrag
#'
#' @return data.frame
#' @export
#'
make_konto <- function(x,
                       jahr,
                       format = "%d.%m.%Y",
                       select = c(3, 4, 9)) {
  x <- x[select]
  x$id <- seq_len(nrow(x))
  names(x) <- c("datum", "txt", "euro", "id")
  x |>
    dplyr::mutate(
      einnahmen = ifelse(x$euro > 0, euro, NA),
      ausgaben = ifelse(x$euro < 0, euro, NA),
      datum = lubridate::as_datetime(datum)
    ) |> dplyr::filter(euro != 0, lubridate::year(x$datum) == jahr)
  
}

 


find_item <- function(pattern, x) {
  rslt <- unique(unlist(lapply(pattern , grep, x)))
  if (length(rslt) == 0)
    NULL
  else
    rslt
}
konto_obj <-
  function(x,
           items = NULL,
           name = "Dummy",
           jahr = "2022") {
    if (!is.null(items)) {
      x <- x[items, ]
      x$Pos <- "sva"
    } else {
      x <-
        data.frame(
          datum = lubridate::as_datetime(paste0(jahr, "-01-01")),
          txt = "",
          euro = 0,
          id = 0,
          einnahmen = 0,
          ausgaben = 0,
          Pos = name
        )
    }
    
    x
  }



# file <-
#   paste0(konto_path, konto)
# knt <-
#   readxl::read_excel(file,sheet = 1,skip = 3)
# ## SVA im  Konto suchen
# sva_items <- find_item(sva, knt$txt)
# knt_sva <- konto_obj(knt, sva_items, "sva")
#
# ## Eingaenge sind Krankenkosten
# knt_sva_privat <- knt_sva[is.na(knt_sva$ausgaben),]
# knt_sva <-  knt_sva[!is.na(knt_sva$ausgaben),]
# if(!is.null(sva_items))   knt <-  knt[-sva_items, ]


#' Einkommensteuer
#' 
#' 
#' https://finanzonline.bmf.gv.at/fon/login.do
#' +4369981530117
#' 
#' grundsaetzlich bis 30. April des Folgejahres bis 30. Juni bei uebermittlung auf elektronischem Wege
#'
#'  
#'
#' Önace Code	Text	Taetigkeit 73.	Markt- und Meinungsforschung
#' 
#' 
#' Angaben zur Kommunalsteuer
#' 
#' Gemeindekennziffer: 70364 
#' Bemessungsgrundlage: 0
#' Gesamtbetrag der Bemessungsgrundlage: 0
#' Gesamtbetrag Kommunalsteuer: 0
#' 
#' Taetigkeit als  Liebhaberei 
#' Wenn die Vermietung oder Verpachtung ueber einen laengeren Zeitraum keinen Gewinn
#' erwarten laesst, sind diese Einkuenfte steuerlich unbeachtlich. Das heißt, dass Verluste aus
#' dieser Taetigkeit mit anderen positiven Einkuenften nicht ausgeglichen werden duerfen.
#' Sollte sich ausnahmsweise ein Gewinn ergeben, ist dieser nicht steuerpflichtig.
#' Zu unterscheiden ist dabei zwischen der so genannten  kleinen  Vermietung wie z.B. der
#' Vermietung von Ein- und Zweifamilienhaeusern, Eigentumswohnungen oder Bungalows und
#' der  großen  Vermietung. Das ist die Vermietung von mindestens drei Wohneinheiten,
#' betrifft also vor allem Miethaeuser (siehe dazu das Infoblatt  Liebhaberei im
#'                                     Steuerrecht ).
#'  
#' 
#' @param jahr Jahr
#' @param konto Kontospiegel
#' @param Betriebsausgaben data.frame
#'    Betriebsausgaben = data.frame(
#' datum = "2022-11-07",
#' txt = "Amazon OKI B432dn A4-Schwarzweißdrucker (Duplex, Netzwerk)",
#' euro = -265.40,
#' id = 999,
#' einnahmen = NA,
#' ausgaben  = -265.40,
#' Pos = "Betriebsausgaben"
#' )
#' @param SVA,Reisespesen,Versicherungspraemien,Steuerberater Summe, 
#' @param pauschale Pauschalierung fuer Kleinunternehmer
#' @param AfA,afa_anlagen,afa_instandsetzung Abschreibung 
#' @param konto_path Pfad
#' @param eigene_buchung_konto,visa,versicherung,privat,kirche,spenden,sva Such-String fuer die jeweilige Buchung
#'
#' @return data.frame
#' @export
#'
#' @examples
#'  \dontrun{
#' afa<- 
#' AfA(
#'   list(
#'     nr = 1, datum = "26.01.2012",
#'     pos = "PC L412 Windert GmbH, Bad Oldeslose",
#'     type = "A",
#'     euro = 463.95, nd = 3, rs = 1),
#'   list(
#'     nr = 33, datum = "09.11.2012",
#'     pos = "Buero Fenster+Tuer EA-Ceramic e.U. Hallerstraße 35, Ibk",
#'     type = "I",
#'     euro = 3517.20, nd = 10, rs = 0.5),
#'   list(
#'     nr = 34, datum = "03.12.2012",
#'     pos = "Buero Fussboden-Sanierung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#'     type = "I",
#'     euro = 2271.71, nd = 10, rs = 0.5),
#'   list(
#'     nr = 35, datum = "03.12.2012",
#'     pos = "Buero Fussboden-Heizung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#'     type = "I",
#'     euro = 912.48, nd = 10, rs = 0.5),
#'   list(
#'     nr = 21694, datum = "23.01.2018",
#'     pos = "Thinkpad T450s Matthias Rimkus",
#'     type = "A",
#'     euro = 475, nd = 3, rs = 1),
#'   list(
#'     nr = 130603,  datum = "07.06.2013",
#'     pos = "Bueromöbel Leitgeb&leitgeb 6020 Innsbruck",
#'     type = "I",
#'     euro = 8436.00, nd = 10, rs = 0.5),
#'   jahr=2019,
#'   konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2019/" 
#' )
#' #' 
#'  Steuer(konto = "konto-spiegel.xlsx",
#'         # AfA = afa,
#'         konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2023/",
#'         Versicherung.SVA = 75)
#'         
#' }
#'         
Steuer <- function(jahr = lubridate::year(lubridate::as_date(Sys.time())) - 1,
                    konto = "konto-spiegel.xlsx",
                    # AfA = afa,
                    konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2023/",
                    Versicherung.SVA =NULL,
                    privat = c(
                      "AMAZON",
                      "Delinat",
                      "GOOGLE",
                      "Deutscher Pressevertrieb",
                      "TIWAG",
                      "Privatentnahme",
                      "Krabe",
                      "GIRSTMAIR",
                      "VAILLANT", "Wolfgang", "SCHULER"
                    ),
                    sva = c("Sozialversicherungsanstalt"),
                    pattern_debit = "Debit",
                    Reisespesen = c(Bus = 0, Taxi = 0),
                    Betriebsausgaben =  NULL,
                    Versicherungspraemien = 0,
                    Steuerberater = 0,
                    pauschale = 0.06,
                    AfA = data.frame(
                      Pos = c("Anlagen", "Instandsetzung"),
                      Kennzahl = c(9130, 9150),
                      Betrag = c(0, 0)
                    ),
                    
                    versicherung = c("UNIQA"),
                    kirche = "Bischöfliche",
                    spenden = c("ÖRK", "Kinderpatenschaft")) {
  file <- paste0(konto_path, konto)
  
  cat("\n Bearbeite File: ", file, "\n")
  knt <-
    readxl::read_excel(file, sheet = 1, skip = 3)
  
#  print(head(knt))
  knt <- make_konto(knt, jahr)

  
  
  
  
  ## SVA im  Konto suchen
  sva_items <- find_item(sva, knt$txt)
  knt_sva <- konto_obj(knt, sva_items, "sva")
  
  ## Eingaenge sind Krankenkosten
  knt_sva_privat <- knt_sva[is.na(knt_sva$ausgaben), ]
  knt_sva <-  knt_sva[!is.na(knt_sva$ausgaben), ]
  if (!is.null(sva_items))
    knt <-  knt[-sva_items, ]
  
  
  # ## Auf dem Kono hin und her geschobene Betraege
  # eigene_buchung <- c(grep(eigene_buchung_konto[1], knt$txt),
  #                     grep(eigene_buchung_konto[2], knt$txt))
  # if (length(eigene_buchung) > 0) {
  #   knt_eigene_buchung <- knt[eigene_buchung, ]
  #   cat("\neigene -buchung-konton: \n")
  #   print(knt_eigene_buchung)
  #   cat("\n--------------\n")
  #   knt <- knt[-eigene_buchung, ]
  # }
  
  ##  Privatentnahme
  prvt_items <- find_item(privat, knt$txt)
  knt_privat <- konto_obj(knt, prvt_items, "Privat")
  if (!is.null(prvt_items))
    knt <-   knt[-prvt_items, ]

  
  ## Privatentnahme
  debit_items <- find_item(pattern_debit, knt$txt)
  Privat_debit_kard <- konto_obj(knt, debit_items, "Bankomat")
  if (!is.null(debit_items))
    knt <- knt[-debit_items, ]
  
  
  
  
  
  ## Kirche
  kirche_items <-  find_item(kirche, knt$txt)
  knt_kirche <- konto_obj(knt, kirche_items, "Kirche")
  if (!is.null(kirche_items))
    knt <-   knt[-kirche_items, ]
  
  ## Spende
  spenden_items <- find_item(spenden, knt$txt)
  knt_spenden <-  konto_obj(knt, spenden_items, "Spende")
  if (!is.null(spenden_items))
    knt <-   knt[-spenden_items, ]
  
  ## Versicherung
  versicherung_items <- find_item(versicherung, knt$txt)
  knt_versicherung <-  konto_obj(knt, versicherung_items, "Spende")
  if (!is.null(versicherung_items))
    knt <-   knt[-versicherung_items, ]
  
  
  
  ## Aufdröseln der Positionen im Formular
  knt$Pos <- ifelse(knt$euro > 0, "Ertraege", "Betriebsausgaben")
  
  Einnahmen <- sum(knt$einnahmen, na.rm = TRUE)
  
  
  SVA <-  ifelse(is.null(Versicherung.SVA),
                 sum(knt_sva$euro, na.rm = TRUE) * (-1),
                 Versicherung.SVA)
  Kirche <- sum(knt_kirche$euro, na.rm = TRUE) * (-1)
  Spenden <- sum(knt_spenden$euro, na.rm = TRUE) * (-1)
  
  
  if (!is.null(Betriebsausgaben)) {
    #Fehler abfangen
    Betriebsausgaben$einnahmen  <- NA
    Betriebsausgaben$euro <- -abs(Betriebsausgaben$euro)
    Betriebsausgaben$ausgaben <- -abs(Betriebsausgaben$ausgaben)
    knt <- rbind(knt, Betriebsausgaben)
  }
  
  Ausgaben <- sum(knt$ausgaben, na.rm = TRUE) * (-1)

  Pauschale <- round(pauschale * sum(knt$einnahmen, na.rm = TRUE), 2)
  
  Privat_Debit <- sum(Privat_debit_kard$euro, na.rm = TRUE)
  Privat_Versicherung <- sum(knt_versicherung$euro, na.rm = TRUE)
  Privat <- sum(knt_privat$euro, na.rm = TRUE)
  
  Versicherungspraemien <- sum(Versicherungspraemien, na.rm = TRUE)
  Reisespesen <- sum(Reisespesen, na.rm = TRUE)
  
  afa_anlagen	<- AfA$Betrag[1]
  afa_instandsetzung	<- AfA$Betrag[2]
  
  
  # Das zusammenfuegen muss ueberarbeitet werden
  # rslt2 ist erster versuch
  
  rslt2 <- stp25tools::get_data(
    '
Pos	              Kennzahl	 Eingaben.Ausgaben	Pauschale
"Ertraege"           	9040	 0   0
"AfA Anlagen"	        9130	 0	  NA
"Instandsetzung"	    9150	 0	  NA
"Reisespesen"	        9160	 0   NA
"Versicherung (SVA)"	9225	 0	  0
"Betriebsausgaben"    9230 	0	  NA
"Betriebs-Pauschale" 	9259	 NA  0
"Einkuenfte"	           320	 0	  0
"Versicherungspraemien"	NA	 NA  NA
"Spenden"	              NA	 NA  NA
"Kirche"	              NA   NA  NA
"Steuerberater"	        NA	 NA  NA
"Gewinnfreibetrages"  	NA	 NA  NA
"Umsatzsteuererklaerung" NA	 NA  NA
"UST Gesamtbetrag"	     0	 0	  0
"Kleinunternehmer"	    16	 0	  0
"Kommunalsteuer"        NA	 NA  NA
"Bemessungsgrundlage"	  NA	 0	  0
"Kommunalsteuer"	      NA	 0	  0
"Gemeindekennziffer"   	NA	 70364 70364
"Steuer"               	NA	 0	  0
'
  )
  
  rslt2[[1]][7] <-  paste0(rslt2[[1]][7], pauschale * 100, "%")
  
  # print(rslt2)
  
  
  
  
  
  #  9259 Pauschalierte Betriebsausgaben
  # 320   Summe Kennzahl
  rslt <- data.frame(
    Pos = c(
      "Ertraege",
      "AfA Anlagen",
      "Instandsetzung",
      "Reisespesen",
      "Versicherung (SVA)",
      "Betriebsausgaben",
      paste0("Betriebsausgabenpauschale ", pauschale * 100, "%"),
      
      
      "Einkuenfte",
      "Versicherungspraemien",
      "Spenden",
      "Kirche",
      "Steuerberater",
      "Gewinnfreibetrages",
      "Privat (Debit)",
      "Privat (Versicherung)",
      "Privat",
      
      "Gewinn (ab 2020)",
      "UST Gesamtbetrag",
      "Kleinunternehmer"
    ),
    Kennzahl = c(
      9040,
      9130,
      9150,
      9160,
      9225,
      9230,
      xxxx,
      320,
      "",
      "sind schon eingegeben",
      "sind schon eingegeben",
      
      "",
      "",
      "n.a.",
      "n.a.",
      "n.a.",
      "n.a.",
      "000",
      "016"
    ),
    Betrag = c(
      Einnahmen,
      afa_anlagen,
      afa_instandsetzung,
      Reisespesen,
      SVA,
      Ausgaben,
      Pauschale,
      
      Einnahmen - afa_anlagen - afa_instandsetzung - Reisespesen - SVA - Ausgaben,
      Versicherungspraemien,
      Spenden,
      Kirche,
      Steuerberater,
      0,
      Privat_Debit,
      Privat_Versicherung,
      Privat,
      Einnahmen - Pauschale - SVA - Reisespesen,
      Einnahmen,
      Einnahmen
      
    )
  )
  #  stop("hier ist ein Fehler mit den Spenden die kommen hier nicht hinein")
  cat("\nSpeichern der Buchungsliste \n Pfad: ", konto_path, "\n\n")
  
  
  
  #  print( rbind(knt, knt_kirche, knt_spenden, knt_sva))
  
  write.table(
  #  rbind(knt, knt_kirche, knt_spenden, knt_sva),
    knt,
    paste0(konto_path, "konto_bereinigt.csv"),
   sep = ";"
  )
  

  
  rslt$Eingaben.Ausgaben <- rslt$Betrag
  rslt$Eingaben.Ausgaben[7] <- NA
  
  rslt$Pauschale <- rslt$Betrag
  rslt$Pauschale[c(2, 3, 6, 9)] <- NA
  rslt$Pauschale[8] <-   rslt$Pauschale[17]
  rslt <- rslt[-17, -3]
  
  
  rslt$Eingaben.Ausgaben <-

  stp25stat2::render_f(rslt$Eingaben.Ausgaben, 2, decimal.mark = ",")
  rslt$Pauschale <- stp25stat2::render_f(rslt$Pauschale, 2, decimal.mark = ",")
  
  write.csv(rslt, paste0(konto_path, "Buchungsliste.csv"))
  
  cat("\n------Privat.csv \n")
  # data.frame( knt[!is.na(knt$ausgaben),])
  
  
  print(list(
    knt_privat[-2],
    Privat_Debit[-2],
    knt_versicherung[-2],
    knt_sva_privat[-2]
  ))
  
  # write.csv(
  #   rbind(knt_privat, Privat_Debit, knt_versicherung, knt_sva_privat),
  #   paste0(konto_path, "Privat.csv")
  # )
  
  rslt
  

}



