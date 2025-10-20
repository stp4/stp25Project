#' Projekt erstellen
#' 
#'  
#' Erstellt ein neues Projekt mit der Ordnerstrucktur
#' und den R-Auswertungs-Files.
#'  
#' @param Name,Anrede,Email,Telfon,Adresse Kunde
#' @param Aufwand,Thema,Kommentar,Betreff,Stundensatz Projekt Daten
#' @param Datum,Zeit,Folder Allgemeine Parameter
#' @param KNr,save_KNr Kundennummer normal ist NA 
#' @param kunden_file pfad
#' @return nichts
#' @export
#'
CreateProjekt<- function(
    KNr = NA, 
    Name = "Romana Dampf", 
    Email = "hd@gans.dampf.com",
    Telfon = "Tel 0000 12345678",
    Aufwand = "5-9 Stunden",
    Stundensatz = 95,
    Thema = "Forschung und Entwicklung",
    Kommentar = "Kein Kommentar",
    Anrede = "Sehr geehrte Frau",
    Betreff = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit",
    Folder = "C:/Users/wpete/Dropbox/1_Projekte",                                          
    Datum = format(Sys.time(), "%d.%m.%Y"),
    Zeit = format(Sys.time(), "%H:%M"),
    Zwischenrechnung=999,
    Status ="AGB",
    kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
    bank = "TIROLER SPARKASSE",
    iban = IBAN(),
    bic = "SPIHAT22XXX"
                         
){
  
 # print(paste("KNR:", KNr, "  save:", save_KNr))

# Kunden Datenbank --------------------------------------------------------

  kd_data <- insert_new_csv(kunden_file,
                            KNr,
                            Name,
                            Email,
                            Telfon,
                            Aufwand,
                            Stundensatz,
                            Datum,
                            Zeit=0,
                            Status)
  
 
    file_vertrag <-
      install_projekt(
      Projekt = kd_data$neuer_Kunde,
      KNr = kd_data$KNr,
      Name,Email,Telfon,Aufwand,Stundensatz,
      Thema,Kommentar,Anrede,Betreff,
      Folder,Datum,Zeit,
      Zwischenrechnung,
      Status,
      kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
      bank,iban,bic,
    )
    
    rmarkdown::render(file_vertrag, encoding = "UTF-8")
    
 
  
  
  cat("\nFolder:", Folder, "\n\n")
  kd_data$neuer_Kunde
}



#' @rdname CreateProjekt
#'
#' @export
#'
update_status_csv <- function(kunden_file = 'C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv',
                              KNr = 0L,
                              Status = "unbekannt",
                              Datum_Status = format(Sys.time(), "%d.%m.%Y")
                              ) {
  Kunde_dat <- read.csv(kunden_file, stringsAsFactors = FALSE)
  if (KNr[1] %in% Kunde_dat$KNr) {
    Kunde_dat$Status[Kunde_dat$KNr == KNr] <- Status
    Kunde_dat$Datum_Status[Kunde_dat$KNr == KNr] <- Datum_Status
    write.csv(Kunde_dat,
              kunden_file,
              row.names = FALSE,
              quote = FALSE)
    paste("Status für Kunde", KNr , "auf", Status, "gesetzt.")
  }
  else{
    paste("Fehler: Kundennummer", KNr, "nicht gefunden.")
    
  }
}




#' @rdname CreateProjekt
#'
#' @export
update_arbeitszeit <- function(kunden_file = 'C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv',
                               KNr = 0L,
                               Zeit = 0,
                               Status = "in Arbeit",
                               Datum_Status = format(Sys.time(), "%d.%m.%Y")
                               ) {
  Kunde_dat <- read.csv(kunden_file, stringsAsFactors = FALSE)
  if (KNr[1] %in% Kunde_dat$KNr) {
    Kunde_dat$Status[Kunde_dat$KNr == KNr] <- Status
    Kunde_dat$Zeit[Kunde_dat$KNr == KNr] <- Zeit
    Kunde_dat$Datum_Status[Kunde_dat$KNr == KNr] <- Datum_Status
    write.csv(Kunde_dat,
              kunden_file,
              row.names = FALSE,
              quote = FALSE)
    paste("Status für Kunde", KNr , "Zeit auf", Zeit, "gesetzt.")
  }
  else{
    paste("Fehler: Kundennummer", KNr, "nicht gefunden.")
    
  }
}








#' @rdname CreateProjekt
#'
#' @export
#'
insert_new_csv <- function(kunden_file,
                           KNr,
                           Name,
                           Email,
                           Telfon,
                           Aufwand,
                           Stundensatz,
                           Datum,
                           Zeit,
                           Status,
                           Datum_Status = format(Sys.time(), "%d.%m.%Y")) {
  

  Kunde <- read.csv(kunden_file, stringsAsFactors = FALSE)
 # if( !("Datum_Status" %in% names(Kunde) )) Kunde$Datum_Status <- ""
 #Kunde$Zeit <- "0"
 #Kunde$Datum_Status <-  Kunde$Datum
  
  
  if(is.na(KNr)) KNr <- max(Kunde$KNr, na.rm=TRUE) + 1L
  else if (is.numeric(KNr)) KNr <- as.integer(KNr)
  
  neuer_Kunde <-  cleansing_umlaute(paste(KNr, Name))
  neuer_Kunden_Daten <- data.frame(
    KNr = KNr,
    Datum = Datum,
    Zeit = Zeit,
    Name = Name,
    Email = Email,
    Tel = Telfon,
    Stundensatz = Stundensatz,  
    Aufwand =Aufwand,
    Status = Status,
    Datum_Status = Datum_Status,
    stringsAsFactors = FALSE
  )
  
  Kunde <- tibble::as_tibble(
    rbind(neuer_Kunden_Daten,
          Kunde[order(Kunde$KNr, decreasing = TRUE),]))
  
  write.csv(Kunde, kunden_file, row.names = FALSE, quote = FALSE)  
  
  
  list(neuer_Kunde = neuer_Kunde, KNr = KNr)
}
