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



```{r echo=FALSE, results="asis"}
stp25output::Output(arbeitszeit, output="text") 

```



**Zu zahlender Betrag `r paste0(sprintf("%1.1f", euro), "0")` Euro  **


IBAN: AT08 3626 0000 0052 4652
BIC: RZTIAT22260 

Ich ersuche Sie den Rechnungsbetrag sofort auf mein Geschäftskonto zu überweisen und 
danke für Ihren Auftrag. 

'  
)  
  
  
}




