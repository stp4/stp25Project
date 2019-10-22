#' Rechnungs-Templat
#'
#' @param KNr,Name,Email,Tel,Adresse,Anrede KundenDaten
#'
#' @return string
 
Rechnung<- function(KNr=0,
                    Name= "Vorname Name",
                    Email= " ",
                    Tel=" ",
                    Adresse=" ",
                    Anrede= "Sehr geehrte Frau",
                    Betreff="Beratung"
                   ){
 
RNr <-paste0(format(Sys.time(), '%m%d'), KNr)
nname<-  paste( Anrede, stringr::str_split(Name, " ")[[1]][2])
  
  
adr_kunde<-paste("  -", Name, "\n",
                 "  -", Adresse, "\n",
                 "  -", Email, "\n",
                 "  -", Tel, "\n")
  
paste(   
'---
author: Dipl.-Ing. Wolfgang Peter
return-address: 
  - Innsbrucker Straße 14
  - 6176 Völs
return-phone: +43 699 8153 0117
return-email: w.peter@statistik-peter.at 

address:
',
adr_kunde,

'

customer: ', KNr, '   
invoice: ', RNr, '     
subject: Honorarnote
opening: ', nname,'
closing: Mit freundlichen Grüßen
signature: DI Wolfgang Peter
signature-before: "0.5\\\\baselineskip"

lang: de
papersize: a4

output: komaletter::komaletter 
---
  

```{r setup-knit, include=FALSE}

library(knitr)
opts_chunk$set(
  echo = FALSE,
  warning = FALSE)

source("stundenliste.R")

```


Ich erlaube mir, Ihnen für die ', Betreff, ' folgende Honorarnote zu übermitteln.


In der Rechnung wird keine Umsatzsteuer ausgewiesen, da die Umsätze 
gemäß § 6 Abs. 1 Z 27 UStG (Kleinunternehmer) unecht USt.-befreit sind. 

Steuer-Nr. 81 248/5589, Leistungszeitraum: `r leistungszeitraum `




```{r stunden-liste, results="markup", echo=FALSE}

knitr::kable(arbeitszeit, format="markdown")

```



**Zu zahlender Betrag `r paste0(sprintf("%1.1f", euro), "0")` Euro  **


IBAN: AT08 3626 0000 0052 4652
BIC: RZTIAT22260 

Ich ersuche Sie den Rechnungsbetrag sofort auf mein Geschäftskonto zu überweisen und 
danke für Ihren Auftrag. 

'  
)  
  
  
}


#' Rechnung erstellen
#' 
#'  
#' @param Name,Anrede,Email,Euro,RNr,Stundenliste  Kunde
#' @return text
#' @export
rechnung_email<- function(Name="Hans Dampf",
                 Email="h.dampf@gmail.com",
                 Anrede="Hallo",
                 Euro=12,
                 RNr="0815",
                 Stundenliste=""){
  
  
  Euro<-  paste0(sprintf("%1.1f", Euro), "0")
  
  paste0(Email,
  '
  
  ', Anrede, ' ', Name,',
für die statistisch Beratung erlaube ich mir das vereinbarte Honorar in Rechnung zu stellen. Falls noch Fragen auftauche können Sie mich natürlich jederzeit kontaktieren.

zu zahlender Betrag ',	Euro,' Euro 
BIC     RZTIAT22260
IBAN    AT083626000000524652


Ich ersuche Sie den Rechnungsbetrag sofort ohne Skontoabzug unter Angabe Ihrer Rechnungsnummer ',
         RNr, ' zu überweisen und danke
für Ihren Auftrag.

Mit freundlichen Grüssen
Wolfgang Peter


Stundenliste

',toString.data.frame(Stundenliste) ,

'


--
DI Wolfgang PETER
Statistik-Peter e.U.
Data Engineering & Statistics
Innsbruckerstr 14
6176 Voels / Innsbruck

Mobil: +43 699 81530117
http://statistik-peter.at/

  ')}



# https://stackoverflow.com/questions/45508982/r-data-frame-to-plain-text


toString.data.frame = function (object,
                                ...,
                                digits = NULL,
                                quote = FALSE,
                                right = TRUE,
                                row.names = TRUE) {
  nRows = length(row.names(object))
  
  if (length(object) == 0) {
    return(paste(sprintf(
      ngettext(
        nRows,
        "data frame with 0 columns and %d row",
        "data frame with 0 columns and %d rows"
      )
      ,
      nRows
    )
    , "\\n", sep = ""))
    
  } else if (nRows == 0) {
    return(gettext("<0 rows> (or 0-length row.names)\\n"))
    
  } else {
    # get text-formatted version of the data.frame
    m = as.matrix(format.data.frame(object, digits = digits, na.encode =
                                      FALSE))
    
    # define row-names (if required)
    if (isTRUE(row.names)) {
      rowNames = dimnames(object)[[1]]
      
      if (is.null(rowNames)) {
        # no row header available -> use row numbers
        rowNames = as.character(1:NROW(m))
        
      }
      # add empty header (used with column headers)
      rowNames = c("", rowNames)
      
    }
    # add column headers
    m = rbind(dimnames(m)[[2]], m)
    
    # add row headers
    m = cbind(rowNames, m)
    
    # max-length per-column
    maxLen = apply(apply(m, c(1, 2), stringr::str_length), 2, max, na.rm =
                     TRUE)
    
    
    # add right padding
    ##  t is needed because "If each call to FUN returns a vector of length n, then apply returns an array of dimension c(n, dim(X)[MARGIN])"
    m = t(apply(m, 1, stringr::str_pad, width = maxLen, side = "right"))
    
    m = t(apply(
      m,
      1,
      stringr::str_pad,
      width = maxLen + 3,
      side = "left"
    ))
    
    # merge columns
    m = apply(m, 1, paste, collapse = "")
    
    # merge rows (and return)
    return(paste(m, collapse = "\n"))
    
  }
}