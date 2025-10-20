#' @rdname CreateProjekt
install_projekt <- function( Projekt,
                             KNr,
                             Name,Email,Telfon,Aufwand,Stundensatz,
                             Thema,Kommentar,Anrede,Betreff,
                             Folder,Datum,Zeit,
                             Zwischenrechnung,
                             Status,
                             kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
                             bank,iban,bic,
                            ...
                            
                            ) {
  
  project <- cleansing_umlaute(Projekt)
  project_abbr <- abbreviate(project, minlength = 7)
  
  
  day_time <- Sys.time()
  year <- format(day_time, "%Y")
  day1 <- format(day_time, "%d.%m")
  t1 <- format(day_time, "%H:%M")
  t2 <-  format(day_time + 17 * 60, "%H:%M")
  
  
  base_folder <-  file.path(Folder, project)
  working_folders <- file.path(base_folder,
                               c("Processed data", "Raw data", "Results", "R", "Docs", "Fig"))
  file_R <- file.path(base_folder, "R", "miscFun.r")
  file_readme <- file.path(base_folder, "README.txt")
  file_vertrag <- file.path(base_folder, "Vertrag.Rmd")
  file_email_vertrag <- file.path(base_folder, "Email-Vertrag.txt")
  file_rechnung <- file.path(base_folder, "Rechnung.Rmd")
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
  
  

# base and working Folder -----------------------------------------------------------------

  (invisible(folder(folder.name = base_folder)))
  suppressWarnings(invisible(folder(folder.name = working_folders)))
# miscFun.r ---------------------------------------------------------------
  cat("#-- Eigene Funktionen", file = file_R)
# Readme.R ----------------------------------------------------------------
  cat(paste(Projekt, Datum, Folder, Kommentar, sep = "\n"), 
      file = file_readme)
  
  
  # Invoice.R ---------------------------------------------------------------
  
  
  cat(paste0(
    "
# Hier wird Rechnung.Rmd ausgefuert die mit source() die Stundenliste aufruft und die 
# Variable RECHNUNG auf TRUE setzt.

rmarkdown::render('Rechnung.Rmd', 
                   encoding='UTF-8', 
                   output_file= '../../2_Finanzen/Honorarnoten ", year, "/",
    project,".pdf')


"), file = file_invoice)
  
  
  
  # Word.docx ---------------------------------------------------------------
  
  cat("", file = file_word)
  
  # Run.R -------------------------------------------------------------------
  cat(small_project(project, Datum, string_myswd, name_Rdata), file = file_runall)
  cat(Get_Data(string_myswd, name_Rdata), file = file_getdata)
  # cat("\nOk ... all files created.\n\n")
  
  
  
# Vertrag.Rmd -------------------------------------------------------------

  vrtg <-
    Vertrag(
      KNr,
      Name,Email,Telfon,Aufwand,Stundensatz,
      Anrede,Betreff,
      Zwischenrechnung,
      bank,iban,bic
     # name, adr, tel, email, knr, euro, h, betreff, zwischenrechnung, BANK, IBAN, BIC
      
      )
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
    Rechnung(KNr,
             Name,
             Email,
             Telfon,
             Anrede,
             Betreff,
             bank,iban,bic)
  rty <- file(file_rechnung, encoding = "UTF-8")
  write(rcng, file = rty)
  close(rty)
# Stundenliste.R ----------------------------------------------------------
  cat(
    Stundenliste(
      KNr,
      Name,Email,Telfon,Stundensatz,
      Anrede,
      Zwischenrechnung,
      bank,iban,bic,
      string_myswd
    ),
    file = file_stundenliste
  )
 
  




  

  file_vertrag

}






##devtools::install_github("jennybc/googlesheets")
##install.packages("XML")
##devtools::install_github("hadley/xml2")
#library(googlesheets)




