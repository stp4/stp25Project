


#' Abschreibung
#' 
#' linearen AfA
#'
#' @param ... Liste mit Anlagen
#' @param jahr Jahr
#' @param konto_path Pfad
#' @export
#' @importFrom lubridate as_date year
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



# setwd("C:/Users/wpete/Dropbox/2_Finanzen/Steuer")
# 
# require(stp25Project)
# afa<-
#   AfA(
#     list(
#       nr = 1, datum = "26.01.2012",
#       pos = "PC L412 Windert GmbH, Bad Oldeslose",
#       type = "A",
#       euro = 463.95, nd = 3, rs = 1),
#     list(
#       nr = 33, datum = "09.11.2012",
#       pos = "Buero Fenster+Tuer EA-Ceramic e.U. Hallerstraße 35, Ibk",
#       type = "I",
#       euro = 3517.20, nd = 10, rs = 0.5),
#     list(
#       nr = 34, datum = "03.12.2012",
#       pos = "Buero Fussboden-Sanierung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#       type = "I",
#       euro = 2271.71, nd = 10, rs = 0.5),
#     list(
#       nr = 35, datum = "03.12.2012",
#       pos = "Buero Fussboden-Heizung EA-Ceramic e.U. Hallerstraße 35. Ibk",
#       type = "I",
#       euro = 912.48, nd = 10, rs = 0.5),
#     list(
#       nr = 21694, datum = "23.01.2018",
#       pos = "Thinkpad T450s Matthias Rimkus",
#       type = "A",
#       euro = 475, nd = 3, rs = 1),
#     list(
#       nr = 130603,  datum = "07.06.2013",
#       pos = "Bueromöbel Leitgeb&leitgeb 6020 Innsbruck",
#       type = "I",
#       euro = 8436.00, nd = 10, rs = 0.5),
#     
#     list(
#       nr = 1024382,  datum = "22.09.2021",
#       pos = "THINKPAD T470s ITSCO",
#       type = "A",
#       euro = 566.90, nd = 3, rs = 1),
#     
#     
#     jahr=2021,
#     konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2022/"
#   )


#' das File   
#' umsaetze_2021.csv
#' ist der direkt aud Reiffeien exportiere Kontospiegel
# Steuer(
#   jahr = 2022,
#   konto = "meinElba_umsaetze_AT763633600001324656_suche.csv",
#   AfA = afa,
#   Versicherungspraemien = c(Zuericher = 460.56,
#                             Uniqa = 0),
#   Betriebsausgaben = data.frame(
#     datum = "2022-11-07",
#     txt = "Amazon OKI B432dn A4-Schwarzweißdrucker (Duplex, Netzwerk)",
#     euro = -265.40,
#     id = 999,
#     einnahmen = NA,
#     ausgaben  = -265.40,
#     Pos = "Betriebsausgaben"
#   ), 
#   
#   sva = c(
#     "AT953200006400089219",
#     "AT423200006500089219",
#     "Sozialversicherungsanstalt",
#     "Sozialvers.Anstalt"
#   ),
#   
#   
#   
#   privat = c(
#     "AMAZON",
#     "Delinat",
#     "Lebensmitteltechnik",
#     "Deutscher Pressevertrieb",
#     "TIWAG",
#     "Privatentnahme",
#     "Hechenblaikner",
#     "0006000079753746",
#     "Wolfgang Peter"
#   ),
#   konto_path = "C:/Users/wpete/Dropbox/2_Finanzen/Kontospiegel/2022/"
# )


