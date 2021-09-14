#' Stundenliste
#'
#' @param euro Zahl 
#'
#' @return text
 
Stundenliste<- function(euro=76, myswd="",
                        knr, name, email,tel, adr, anrede, betreff){
  
  
  jetzt <- Sys.time()
  # print(zeit)
  zeit <-  paste(
   format(jetzt, '%d.%m.%Y'), " ",
   format(jetzt,  '%H:%M'), " ",
   format(jetzt + 60 * 15,  '%H:%M'), " Einarbeiten_ins_Thema"
  ) 
 
  
msg<- paste0(
    "#' ---
#' title: Stundenliste
#' author: Wolfgang Peter
#' output:
#'   pdf_document: default
#' ---


#+ echo=FALSE

",myswd,


"

stp25Project::Arbz()

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

cat(stp25Project::rechnung_email(
  '", name, "','", email, "',
  '", anrede, "', euro, '", knr, "',  arbeitszeit)
  , file = 'Invoice.txt')

")  
  msg
}
