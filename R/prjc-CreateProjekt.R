#' Projekt erstellen
#' 
#'  
#' Erstellt ein neues Projekt mit der Ordnerstrucktur
#' und den R-Auswertungs-Files.
#'  
#' @param Name,Anrede,Email,Telfon,Adresse Kunde
#' @param Aufwand,Thema,Kommentar,Betreff,Stundensatz Projekt Daten
#' @param Datum,Zeit,Zwischenrechnung Allgemeine Parameter
#' @param KNr Kundennummer default ist NA 
#' @param Folder Ort des Projektes
#' @param kunden_file pfad
#' @param bank,iban,bic Bankverbindung
#' @return nichts
#' @export
#' @importFrom rmarkdown render
#' @importFrom tibble as_tibble
#'
CreateProjekt <- function(
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
 
    kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
    bank = "TIROLER SPARKASSE",
    iban = IBAN(),
    bic = "SPIHAT22XXX"
                         
){
  
# Kunden Datenbank

  kd_data <-
    insert_new_csv(
      kunden_file,
      KNr = KNr,
      Name = Name,
      Email = Email,
      Telfon = Telfon,
      Aufwand = Aufwand,
      Stundensatz = Stundensatz,
      Datum = Datum,
      Zeit = 0,
      Status = "AGB"
    )
  
  file_vertrag <-
    install_projekt(
      Projekt = kd_data$neuer_Kunde,
      KNr = kd_data$KNr,
      Name = Name,
      Email = Email,
      Telfon = Telfon,
      Aufwand = Aufwand,
      Stundensatz = Stundensatz,
      Thema = Thema,
      Kommentar = Kommentar,
      Anrede = Anrede,
      Betreff = Betreff,
      Folder = Folder,
      Datum = Datum,
      Zeit = Zeit,
      Zwischenrechnung = Zwischenrechnung,
      Status = "AGB",
      kunden_file = kunden_file,
      bank = bank,
      iban = iban,
      bic = bic,
    )
  
    rmarkdown::render(file_vertrag, encoding = "UTF-8")
    
  cat("\nFolder:", Folder, "\n\n")
  kd_data$neuer_Kunde
}

#' @noRd
#' 
install_projekt <- function(Projekt,
                            KNr,
                            Name,
                            Email,
                            Telfon,
                            Aufwand,
                            Stundensatz,
                            Thema,
                            Kommentar,
                            Anrede,
                            Betreff,
                            Folder,
                            Datum,
                            Zeit,
                            Zwischenrechnung,
                            Status,
                            kunden_file,
                            bank,
                            iban,
                            bic,
                            ...) {
  project <- cleansing_umlaute(Projekt)
  project_abbr <- abbreviate(project, minlength = 7)
  
  day_time <- Sys.time()
  year <- format(day_time, "%Y")
  day1 <- format(day_time, "%d.%m")
  t1 <- format(day_time, "%H:%M")
  t2 <-  format(day_time + 17 * 60, "%H:%M")
  
  base_folder <-  file.path(Folder, project)
  working_folders <- file.path(base_folder,
                               c("Processed data", 
                                 "Raw data", 
                                 "Results", "R", "Docs", 
                                 "Fig"))
  file_R <- file.path(base_folder, "R", "miscFun.r")
  file_readme <- file.path(base_folder, "README.txt")
  file_vertrag <- file.path(base_folder, "Vertrag.Rmd")
  file_email_vertrag <- file.path(base_folder, "Email-Vertrag.txt")
  file_rechnung <- file.path(base_folder, "Rechnung.Qmd")
  file_stundenliste <- file.path(base_folder, "Stundenliste.R")
  file_invoice <- file.path(base_folder, "Invoice.R")
  file_word <- file.path(base_folder, paste0(project, "(0).docx"))
  file_runall <- file.path(base_folder, paste0("Run-All-", project_abbr, ".R"))
  file_getdata <- file.path(base_folder, paste0("Get-Data-", project_abbr, ".R"))
  
  
  name_Rdata <- paste0(gsub("[^[:alpha:]]", "", project), ".Rdata")
  string_myswd<- paste0("setwd(\"", base_folder ,"\")")
  if(file.exists(base_folder)){
    cat(paste0("\"", 
               paste0(Folder, "/", project), "\" already exists:\nDo you want to overwrite?\n\n"))
    ans <- menu(c("Yes", "No"))
    if (ans == "2") {stop("new_project aborted")
    }else {file.remove(paste0(Folder, .Platform$file.sep, project))}
  }
  
  
  # Create Folder base and working Folder ----------------------------------------
  invisible(folder(folder.name = base_folder))
  suppressWarnings(invisible(folder(folder.name = working_folders)))
  
  # miscFun.r ---------------------------------------------------------------
  cat("#-- Eigene Funktionen", file = file_R)
  
  # Readme.R ----------------------------------------------------------------
  cat(paste(Projekt, Datum, Folder, Kommentar, sep = "\n"), 
      file = file_readme)
  
  # Invoice.R ---------------------------------------------------------------
  
  cat(
    paste0("
# Hier wird Rechnung.Rmd ausgefuert die mit source() die Stundenliste aufruft und die 
# Variable RECHNUNG auf TRUE setzt.

folde <- '../../2_Finanzen/Honorarnoten ", year, " 

quarto::quarto_render('Rechnung.Rmd', 
                   output_file = '", project,".pdf')

"), file = file_invoice)
  
  
  # Word.docx ---------------------------------------------------------------
  cat("", file = file_word)
  
  # Run.R -------------------------------------------------------------------
  cat(
    template_run_all(
      project, Datum, string_myswd, name_Rdata), 
    file = file_runall)
  cat(
    templat_get_data(string_myswd, name_Rdata), 
    file = file_getdata)
  
  
  # Vertrag.Rmd -------------------------------------------------------------
  
  vrtg <-
    Vertrag(
      KNr,
      Name, Email, Telfon, Aufwand, Stundensatz,
      Anrede, Betreff, Zwischenrechnung,
      bank, iban, bic)
  
  rty <- file(file_vertrag, encoding = "UTF-8")
  write(vrtg, file = rty)
  close(rty)
  
  cat("
Wie telefonisch besprochen, habe ich meine Zahlungs- und Vertragsbedingungen zur Dokumentation im Anhang zusammengefasst. Darin enthalten ist auch eine Verschwiegenheitsklausel.
  
Weitere Anmerkung:
Meine Erfahrung hat gezeigt, dass es von Vorteil ist, mit der Betreuerin offen darüber zu sprechen, dass man sich hinsichtlich der statistischen Methoden Unterstützung holt.
In den meisten Fällen wird die Arbeit dadurch einfacher.",
      file = file_email_vertrag)
  
  
  
  # Rechnung.Rmd ------------------------------------------------------------
  rcng <- 
    Rechnung(
      KNr,
      Name, Email, Telfon, Anrede, Betreff,
      bank, iban, bic)
  
  rty <- file(file_rechnung, encoding = "UTF-8")
  write(rcng, file = rty)
  close(rty)
  
  
  # Stundenliste.R ----------------------------------------------------------
  cat(
    Stundenliste(
      KNr,
      Name, Email,Telfon,
      Stundensatz, Anrede, Zwischenrechnung,
      bank, iban, bic,
      string_myswd, kunden_file
    ),
    file = file_stundenliste
  )
  
  file_vertrag
  
}






##devtools::install_github("jennybc/googlesheets")
##install.packages("XML")
##devtools::install_github("hadley/xml2")
#library(googlesheets)






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
  
  cat("\n Kunde\n")
  print(head( Kunde))
 
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
