
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
#' @param kunden_file,FunktionsTest,useGoogel,googel_file,googel_reiter,googel_zell Datenbank
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
                         useGoogel= FALSE,
                         googel_file="ProjektVorlageKunde",
                         googel_reiter="Stammdaten",
                         googel_zell="A:K",
                         Templat="small"
                         
                         
){
  
  
  print(paste("KNR:", KNr, "  save:", save_KNr))
  
  
  if(useGoogel) {
    user_session_info <- gs_user()
    
    Projekt <-
      googlesheets::gs_gs(googlesheets::gs_title(googel_file))
    Kunde <-
      googlesheets::gs_read(Projekt,
                            ws = googel_reiter,
                            range = cell_cols(googel_zell))
    n_row <- n + 2
    if(is.na(KNr)) KNr <- as.numeric(as.character(last_KNr)) + 1
    Kunden_Daten<-c(KNr,
                    Datum,Zeit,	Name,
                    Email,Tel,Adresse,Aufwand,
                    Thema,Kommentar,Stundensatz)
    neuer_Kunde <-stpvers:::cleansing_umlaute( paste(KNr, Name))
    
    myCopy <-
      googlesheets::gs_copy(Projekt,
                            to = neuer_Kunde)
    
    # cat("\n Erstelle neues Googel-Dokument:",
    #     myCopy$sheet_title,
    #     "\n\n")
    if(save_KNr){
    try(googlesheets::gs_edit_cells(
      Projekt,
      ws = googel_reiter,
      input = Kunden_Daten,
      anchor = paste0("A", n_row),
      trim = TRUE,
      byrow = TRUE
    ))
    #  cat("\nKopiere neuen Kunden in die Projektliste\n")
    
    try(googlesheets::gs_edit_cells(
      myCopy,
      ws = googel_reiter,
      input = Kunden_Daten,
      anchor = paste0("A", 2),
      trim = TRUE,
      byrow = TRUE
    ))
      }
    
  } else{
    
    Kunde <- read.csv(kunden_file)
    if(is.na(KNr)) KNr <- Kunde[nrow(Kunde), 1] + 1
    Kunden_Daten <-  lapply( 
      list(KNr, Datum, Zeit, 
           Name, Email, Tel,
           Adresse, Aufwand, 
           Thema, Kommentar, Stundensatz),
      function(x) gsub("[,;]", " ", x))
    
    
    
    neuer_Kunde <- stpvers:::cleansing_umlaute( paste(KNr, Name))
    
    #print(save_KNr)
    
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
    
  }
  
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
      templat=Templat
    )
    
    rmarkdown::render(paste0(neuer_Kunde, "/Vertrag.Rmd"), encoding = "UTF-8")
    
  }
  cat("\nFolder:", Folder, "\n\n")
  
  neuer_Kunde
}