#======================================================
Name      = "Intern Forschung"  # M Medizin Z Zahnmedizin
Anrede    = "Sehr geehrter Herr"
# Dr Artzt #v Veterinär
# B BWL  P Psychologie PH Pädagogische Hochschule OÖ
# U Umit/FH-gesund  X Alles ander
# F Firma
Email     = "hansi@gmail.com"
Tel       = "Tel 0650 8550 525"
Adresse	  = "Addresse"
Aufwand	  = "2-5 Stunden"
Thema	    = "Forschung und Entwicklung"

Kommentar = " "
Betreff  = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit"
#=====================================================
#  75  Student
#  80  Doktorand berufsbegleitend
#  90  Klinik
# 125  Firmen
Stundensatz = 75
Datum =  format(Sys.time(), "%d.%m.%Y")
Zeit = format(Sys.time(), "%H:%M")
Folder  = "C:/Users/wpete/Dropbox/1_Projekte"
#=====================================================







KNr      <- NA
# Name <- gsub("[^A-Za-z0-9 ()]", "", Name)
FunktionsTest <- FALSE
useGoogel<- FALSE
##devtools::install_github("jennybc/googlesheets")
##install.packages("XML")
##devtools::install_github("hadley/xml2")
#library(stp25Project)

library(dplyr)

#-- Get Kunde-Nummer --------------------------------------------------------


if(useGoogel) {
  library(googlesheets)
  user_session_info <- gs_user()
  
  Projekt <- gs_title("ProjektVorlageKunde") %>% gs_gs()
  Kunde <-
    Projekt %>% gs_read(ws = "Stammdaten", range = cell_cols("A:K"))
  
  n_row <- n + 2
  KNr <- as.numeric(as.character(last_KNr)) + 1
} else{
  kunden_file <-
    "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv"
  Kunde <- read.csv(kunden_file)
  KNr <- Kunde[nrow(Kunde), 1] + 1
}


Kunden_Daten<-
list(KNr,    Datum,    Zeit,    Name,
    Email,    Tel,    Adresse,    Aufwand,
    Thema,    Kommentar,    Stundensatz)
neuer_Kunde <-stpvers:::cleansing_umlaute( paste(KNr, Name))
#-- neuen Kunde anlegen ---------------------------------
if(useGoogel){
myCopy <-  Projekt %>%
           gs_copy(to = neuer_Kunde)

cat("\n Erstelle neues Googel-Dokument:", myCopy$sheet_title, "\n\n")

try(Projekt %>% gs_edit_cells(ws = "Stammdaten",
                           input = Kunden_Daten,
                           anchor = paste0("A", n_row),
                           trim = TRUE,
                           byrow = TRUE
                           ))
cat("\nKopiere neuen Kunden in die Projektliste\n" )

try(myCopy %>%  gs_edit_cells(ws = "Stammdaten",
                           input = Kunden_Daten,
                           anchor = paste0("A", 2),
                           trim = TRUE,
                           byrow = TRUE
))
} else{
  write.table(
    Kunden_Daten,
    file = kunden_file,
    sep = ",",
    append = TRUE,
    quote = FALSE,
    col.names = FALSE,
    row.names = FALSE
  )
  
}

if(!FunktionsTest){
#-- Create Project ---------------------------------------------
setwd(Folder)
  stp25Project::CreateProjekt( project = neuer_Kunde,
               path = Folder,
               knr= KNr,
               datum =   Datum,
               time= Zeit,	
               name= Name,
               email= Email,
               tel= Tel,
               adr= Adresse,
               h= Aufwand,
               thema= Thema,
                comment = Kommentar,
               euro= Stundensatz,
               anrede=Anrede
                
                )
  
  
 rmarkdown::render(paste0(neuer_Kunde,"/Vertrag.Rmd"),encoding="UTF-8")
  
}
