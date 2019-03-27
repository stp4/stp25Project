#' Angebot erstellen
#' 
#'  
#'  
#' @param Name,Anrede,Email,Tel,Adresse Kunde
#' @param Aufwand,Thema,Kommentar,Betreff,Stundensatz Projekt Daten
#' @param Datum,Zeit,Folder Allgemeine Parameter
#' @param KNr,save_KNr Kundennummer normal ist NA 
#' @return nichts
#' @export
CreateAngebot<- function(
  Name = "Vorname Name",  
  Anrede= "Sehr geehrte Frau",  
  Email= " ",  
  Tel=" ",  
  Adresse=" ",
  Datum = format(Sys.time(), "%d.%m.%Y"),  
  Folder = "C:/Users/wpete/Dropbox/1_Projekte",
  KNr="000",
  x="Position  Aufwand  
  Einarbeiten_ins_Thema_und_Kommunikation  2
  Aufbereiten_der_Daten_und_Fehlerprüfung  1.5
  Deskriptive_Analyse_in_Form_von_Tabelle  0.5 
  Deskriptive_Analyse_in_Form_von_Grafiken   3 
  Inferenzstatistische_Analyse_(signifikanz_Test)  0.5
  Ergebnisbericht_mit_stichwortartigen_Kommentaren	 2
  "
  , stundensatz=100 
  , Betreff="Aufwandseinschätzung" 
  
  , einleitung= "Vielen Dank für Ihre Anfrage!"
  , text="Ich unterbreite Ihnen hiermit folgendes Angebot: "  
  , projekt ="Auswertung im Kontext einer wissenschaftlichen Arbeit"
  , text2= "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten."
  , text3= paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
 stundensatz, "Euro.",
 "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"
  )
  , closing= "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen."

  , sep = "\n\n"
  
)
{

  RNr <-paste0(format(Sys.time(), '%m%d'), KNr)
  nname<-  paste( Anrede, stringr::str_split(Name, " ")[[1]][2])
  adr_kunde<-paste("  -", Name, "\n",
   "  -", Adresse, "\n",
   "  -", Email, "\n",
   "  -", Tel, "\n")
  
  
  
  
  txt <- paste(
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
subject: ',  Betreff, '
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

x <- "', x, '"
stundensatz<- ', stundensatz, '

angebot <-   stp25aggregate::GetData(x, output = FALSE)
angebot[, 1] <- gsub("_", " ", as.character(angebot[, 1]))
mysum<- sum(angebot[, 2])
#angebot <- rbind(angebot , list("Summe", mysum))
euro <-   sprintf("%1.2f Euro", mysum*stundensatz)
```

', einleitung, text, projekt, text2, text3,

'

```{r echo=FALSE, results="asis"}
stp25output::Output(angebot, output="text") 

```

Aufwand: `r mysum ` Stunden
Gesamtbetrag:   `r euro ` 


', closing
  )  
  
  
  Folder<- paste0(Folder,"/Angebot.Rmd" )
  
  
  rty <- file(Folder, encoding="UTF-8")
  write(txt, file=rty)
  close(rty)
  
  cat("\nRmd-File für das Angebot wurder erstellt.\n")
  
  Folder
}













#' Angebot
#'
#' @param x das Angbot
#' @param stundensatz  Euro
#' @param titel Betreff
#' @param einleitung,text,projekt,text2,text3,closing,closing2,closing3 Textelemente
#' @param sep seperator
#'
#' @return text (string)
#' @export
#'
#' @examples
#' 
#' Angebot()
Angebot <- function(x="Position Aufwand  
Einarbeiten_ins_Thema_und_Kommunikation 2
Aufbereiten_der_Daten_und_Fehlerprüfung  1.5
Deskriptive_Analyse_in_Form_von_Tabelle  0.5 
Deskriptive_Analyse_in_Form_von_Grafiken   3 
Inferenzstatistische_Analyse_(signifikanz_Test)  0.5
Ergebnisbericht_mit_stichwortartigen_Kommentaren	 2
", stundensatz=85
  , titel="Aufwandseinschätzung"
  , einleitung= "Vielen Dank für Ihre Anfrage!"
  , text="Ich unterbreite Ihnen hiermit folgendes Angebot: "  
  , projekt ="Auswertung im Kontext einer wissenschaftlichen Arbeit"
  , text2= "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten."
  , text3= paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
 stundensatz, "Euro.",
 "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"
   )
  , closing= "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen."
  , closing2= "Mit freundlichen Grüßen"
  , closing3=  "DI Wolfgang Peter"
  , sep = "\n\n"

   
   ){
  angebot <-   stp25aggregate::GetData(x, output = FALSE)
  angebot[, 1] <- gsub("_", " ", as.character(angebot[, 1]))
  mysum<- sum(angebot[, 2])
  #angebot <- rbind(angebot , list("Summe", mysum))
 euro <-   sprintf("%1.2f Euro", mysum*stundensatz)
 
  
  
  
  cat(titel, sep, sep  )
  cat("__________", sep)
  cat(einleitung, paste(text, projekt), paste(text2, text3), sep=sep)
  print(angebot)
  
  cat(sep, 
  "Aufwand", mysum, "Stunden", sep,
  "Gesamtbetrag:", euro, sep
  )
  
  cat(sep, closing, closing2, closing3, sep=sep)
  
  
  
}
  
  