
#' Projekt erstellen
#' 
#'  
#' Erstellt ein neues Projekt mit der Ordnerstrucktur
#' und den R-Auswertungs-Files.
#'  
#' @param Name,Anrede,Email,Tel,Adresse Kunde
#' @param Aufwand,Thema,Kommentar,Betreff,Stundensatz Projekt Daten
#' @param Datum,Zeit,Folder Allgemeine Parameter
#' @param KNr,save_KNr Kundennummer normal ist NA 
#' @param kunden_file,FunktionsTest Datenbank
#' @return nichts
#' @export
#'
CreateProjekt<- function(Name = "Romana Dampf", 
                         Anrede = "Sehr geehrte Frau",
                         Email = "hd@gans.dampf.com",
                         Tel = "Tel 0000 12345678",
                         Adresse = "Strasse, Ort",
                         Aufwand = "5-9 Stunden",
                         Thema = "Forschung und Entwicklung",
                         Kommentar = "Kein Kommentar",
                         Betreff = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit",
                         Stundensatz = 76,
                         Datum = format(Sys.time(), "%d.%m.%Y"),
                         Zeit = format(Sys.time(), "%H:%M"),
                         Folder = "C:/Users/wpete/Dropbox/1_Projekte",
                         KNr = NA, 
                        # save_KNr =  is.na(KNr),
                         kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
                         FunktionsTest = FALSE,
                     #    useGoogel= FALSE,
                     #    googel_file="ProjektVorlageKunde",
                     #    googel_reiter="Stammdaten",
                     #    googel_zell="A:K",
                         Templat="small",
                     zwischenrechnung=400,
                     BANK = "TIROLER SPARKASSE",
                     IBAN = IBAN(),
                     BIC = "SPIHAT22XXX"
                         
){
  
 # print(paste("KNR:", KNr, "  save:", save_KNr))

# Kunden Datenbank --------------------------------------------------------

  cat(kunden_file,"\n")
  Kunde <- read.csv(kunden_file, stringsAsFactors = FALSE)
   if( !("Status" %in% names(Kunde) )) Kunde$Status <- "unbekannt"
  
  if(is.na(KNr)) KNr <- max(Kunde$KNr, na.rm=TRUE) + 1L
  else if (is.numeric(KNr)) KNr <- as.integer(KNr)
    
  neuer_Kunde <-  cleansing_umlaute(paste(KNr, Name))
  neuer_Kunden_Daten <- data.frame(
      KNr = KNr,
      Datum = Datum,
      Zeit = Zeit,
      Name = Name,
      Email = Email,
      Tel = Tel,
      Stundensatz = Stundensatz,  
      Status = "AGB",
      stringsAsFactors = FALSE
    )

  
  
    Kunde <- tibble::as_tibble(rbind(neuer_Kunden_Daten, Kunde[order(Kunde$KNr, decreasing = TRUE),]))
    write.csv(Kunde, kunden_file, row.names = FALSE, quote = FALSE)  
     cat("\n\nSpeichere neue Kunde\n\n")  

      
 

  
  if(!FunktionsTest) {
    setwd(Folder)
    install_projekt(
      project = neuer_Kunde,
      path = Folder,
      knr = KNr,
      datum =   Datum,
      time = Zeit,
      name = Name,
      email = Email,
      tel = Tel,
      adr = Adresse,
      h = Aufwand,
      thema = Thema,
      comment = Kommentar,
      betreff=Betreff,
      euro = Stundensatz,
      anrede = Anrede,
      templat=Templat,
      zwischenrechnung=zwischenrechnung,
      BANK = BANK,
      IBAN = IBAN,
      BIC = BIC
    )
    
    rmarkdown::render(paste0(neuer_Kunde, "/Vertrag.Rmd"), encoding = "UTF-8")
    
  }
  cat("\nFolder:", Folder, "\n\n")
  
  
  print(head(Kunde[c(1, 4, 8)]))
  
  neuer_Kunde
}
