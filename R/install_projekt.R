#' Neues Projektordner erstellen
#'

#'
#' @param project Name des projektes
#' @param datum Datum
#' @param comment Beschreibung
#' @param knr,time,name,tel,email,adr,h,thema,euro,anrede,betreff Kunden-Daten
#' @param path Pfad default Dropbox/1_Projekte
#'
#' @export

install_projekt <-function(project = "000 Dummy",
                         path = "C:/Users/wpete/Dropbox/1_Projekte",
                         knr= 0,
                         datum =   date(),
                         time= "08:08",	
                         name= "Name",
                         email= "name@email.com",
                         tel= "Tel",
                         adr= "Adresse",
                         h= "5-9 Stunden",
                         thema= Thema,
                         comment = "Test Dummy" ,
                         euro= "76",
                         anrede="Sehr geehrte Damen und Herren",
                         betreff="statistische Beratung", 
                         templat= c("small", "large", "chemistry", "technical-report")
                         ){
  WD <- getwd()
  on.exit(setwd(WD))
  day_time<- Sys.time()
  year<- format(day_time, "%Y")
  day1<- format(day_time, "%d.%m")
  t1 <- format(day_time, "%H:%M")
  t2<-  format(day_time+17*60, "%H:%M")
  
  Rdata<- paste0(gsub("[^[:alpha:]]", "", stp25tools::cleansing_umlaute(project)), ".Rdata")

  if(file.exists(paste0(path, "/", project))){
    cat(paste0("\"", paste0(path, "/", project), "\" already exists:\nDo you want to overwrite?\n\n"))
    ans <- menu(c("Yes", "No"))
    if (ans == "2") {stop("new_project aborted")
    }else {file.remove(paste0(path, "/", project))}
  }
  x <- suppressWarnings(invisible(
           folder(folder.name = paste0(path,"/", project))))
  setwd(x)
  "Processed data" <- "Raw scripts" <- "Raw data"  <-  Results <- R <-Docs <- Fig <- NULL
  invisible(folder("Processed data", "Raw data", Results, R, Docs, Fig))
  myswd<- paste0("setwd(\"", x,"\")")
 #---------------------------------------------------------------------------------

  
  
  cat("#-- Eigene Funktionen",
      file = "R/miscFun.r")
  
  cat(paste(project, datum, path, comment, sep = "\n"),
      file = "README.txt")
  
  vrtg <-Vertrag(name, adr, tel, email, knr, euro, h, betreff)
    rty <- file("Vertrag.Rmd", encoding="UTF-8")
    write(vrtg, file=rty)
    close(rty)
  
 rcng <-  Rechnung(knr, name, email, tel, adr, anrede, betreff)
   rty <- file("Rechnung.Rmd", encoding="UTF-8")
   write(rcng, file=rty)
   close(rty)
 
 
 cat( Stundenliste(euro, myswd, knr, name, email, tel, adr, anrede, betreffv), file = "Stundenliste.R")
 
 cat(paste0(
"rmarkdown::render('Rechnung.Rmd', 
                   encoding='UTF-8', 
                   output_file= '../../2_Finanzen/Honorarnoten ", year, "/",
project,".pdf')
"), file = "Invoice.R")
 
 cat("",file = paste0(project, "(1).docx"))
 
nms <- abbreviate(project, minlength =7)
 
 if(templat[1]=="small"){
   
   cat( small_project(project, datum, myswd, Rdata), file = paste0("Run-All-", nms, ".R"))
   cat(Get_Data(myswd, Rdata), file = paste0("Get-Data-", nms, ".R"))
 }
 
 else{
 

 cat(RunAll(project, datum, myswd, Rdata), file = paste0("Run-All-", nms, ".R"))

 cat(Get_Data(myswd, Rdata), file = paste0("Get-Data-", nms, ".R"))

 cat(paste0(
   '
# load("Raw data/', Rdata,'")
# -- Tidy Data ---------------------------------------------
# DF %>% Drop_NA(key) %>%
   #        mutate(jahr = factor(jahr)) %>%
   #        Label(sex=Geschlecht)

# fit1<- Principal(DF[c( )], 4, cut=.35, sort=FALSE)
# fit1$Loadings %>% Output()
#
# DF$x1 <- Reliability2(DF[ ])$index
# DF$c2 <- Reliability2(DF ])$index
#   save(DF, file="Processed data/', Rdata,'")
   '), file = "(2) Measures.R")

 cat(paste0(
   '
# load("Processed data/', Rdata,'")
# APA2(~ sex + age, DF, caption="Beschreibung der Untersuchungsgruppe")
#
# DF %>% Tabelle2(sex, caption="Skalen")
'), file = "(3) Demographic.R")


cat(paste0(
'
# load("Processed data/', Rdata,'")
'), file = "(4) Analyse.R")

cat(paste0(
  '
# load("Processed data/', Rdata,'")
  '), file = "(5) Analyse.R")
cat(paste0(
  '
# load("Processed data/', Rdata,'")
  '), file = "(6) Analyse.R")
cat(paste0(
  '
# load("Processed data/', Rdata,'")
  '), file = "(7) Analyse.R")
cat(paste0(
  '
# load("Processed data/', Rdata,'")
  '), file = "(8) Analyse.R")
}

  cat("\nOk ... all files created.\n\n")
}






##devtools::install_github("jennybc/googlesheets")
##install.packages("XML")
##devtools::install_github("hadley/xml2")
#library(googlesheets)




