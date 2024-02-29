
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
                         Email = "romi@gmail.com",
                         Tel = "Tel 0650 8550 525",
                         Adresse = "Srasse, Ort",
                         Aufwand = "5-9 Stunden",
                         Thema = "Forschung und Entwicklung",
                         Kommentar = "Kein Kommentar",
                         Betreff = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit",
                         Stundensatz = 76,
                         Datum = format(Sys.time(), "%d.%m.%Y"),
                         Zeit = format(Sys.time(), "%H:%M"),
                         Folder = "C:/Users/wpete/Dropbox/1_Projekte",
                         KNr = NA, 
                         save_KNr =  is.na(KNr),
                         kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
                         FunktionsTest = FALSE,
                     #    useGoogel= FALSE,
                     #    googel_file="ProjektVorlageKunde",
                     #    googel_reiter="Stammdaten",
                     #    googel_zell="A:K",
                         Templat="small",
                     zwischenrechnung=400,
                     BANK = "TIROLER SPARKASSE",
                     IBAN = "AT89 2050 3033 0288 4626",
                     BIC = "SPIHAT22XXX"
                         
){
  
  
  print(paste("KNR:", KNr, "  save:", save_KNr))
  
 
    cat(kunden_file,"\n")
    Kunde <- read.csv(kunden_file)
    print(tail(Kunde[1:4]))
    
 
    if(is.na(KNr)) KNr <- Kunde[nrow(Kunde), 1] + 1
    Kunden_Daten <-  lapply( 
      list(KNr, Datum, Zeit, 
           Name, Email, Tel,
           Adresse, Aufwand, 
           Thema, Kommentar, Stundensatz),
      function(x) gsub("[,;]", " ", x))
    
    neuer_Kunde <- stp25tools::cleansing_umlaute(paste(KNr, Name))
    
    if(save_KNr){
      
    cat("\n\nSpeichere neue Kunde\n\n")  
      
    write.table(
      Kunden_Daten,
      file = kunden_file,
      sep = ",",
      append = TRUE,
      quote = FALSE,
      col.names = FALSE,
      row.names = FALSE
    ) }
    

  
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
  
  neuer_Kunde
}