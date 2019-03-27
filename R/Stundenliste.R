#' Stundenliste
#'
#' @param euro Zahl 
#'
#' @return text
 
Stundenliste<- function(euro=76, myswd=""){
  
  
  jetzt <- Sys.time()
  # print(zeit)
  zeit <-  paste(
   format(jetzt, '%d.%m.%Y'), " ",
   format(jetzt,  '%H:%M'), " ",
   format(jetzt + 60 * 15,  '%H:%M'), " Einarbeiten_ins_Thema"
  ) 
 
  
  msg<- paste(
    "#' ---
#' title: Stundenliste
#' author: Wolfgang Peter
#' output:
#'   pdf_document: default
#' ---


#+ echo=FALSE

",myswd,


"

arbeitszeit <-
stp25Project::AZ(
  '
Datum   Start   Ende   Task
", zeit,

"

'
  )



euro <- ",euro,"  

h_min <- min(arbeitszeit$Summe)
h_max <- max(arbeitszeit$Summe)

euro <-  euro * h_max
leistungszeitraum <-
  paste(arbeitszeit[1, 1], 'bis', arbeitszeit[nrow(arbeitszeit), 1])


# arbeitszeit
# paste( leistungszeitraum, ', Betrag', euro, 'Euro')
# achtung das geht nicht von hier rmarkdown::render('Rechnung.Rmd', encoding='UTF-8')

"




)  
  msg
}