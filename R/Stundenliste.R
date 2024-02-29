#' Stundenliste
#'
#' @param euro Zahl
#'
#' @return text
Stundenliste <- function(euro = 85,
                         myswd = "",
                         knr,
                         name,
                         email,
                         tel,
                         adr,
                         anrede,
                         betreff,
                         zwischenrechnung = 400,
                         BANK = "TIROLER SPARKASSE",
                         IBAN = "AT89 2050 3033 0288 4626",
                         BIC = "SPIHAT22XXX") {
  jetzt <- Sys.time()
  # print(zeit)
  zeit <-  paste(
    format(jetzt, '%d.%m.%Y'),
    " ",
    format(jetzt - 60 * 16,  '%H:%M'),
    format(jetzt,  '%H:%M'),
    " ",
    " Einarbeiten_ins_Thema"
  )
  
  
  msg <- paste0(
    "#' ---
#' title: Stundenliste
#' author: Wolfgang Peter
#' output:
#'   pdf_document: default
#' ---


#+ echo=FALSE

",
    myswd,
    
    
    "

stp25Project::Arbz()

arbeitszeit <-
stp25Project::AZ(
  '
Datum   Start   Ende   Task
",
    zeit,
    
    "

'
  )



euro <- ",
euro,
"
zwischenrechnung <- ",
zwischenrechnung,
"
h_min <- min(arbeitszeit$Summe)
h_max <- max(arbeitszeit$Summe)

euro <-  euro * h_max
leistungszeitraum <-
  paste(arbeitszeit[1, 1], 'bis', arbeitszeit[nrow(arbeitszeit), 1])


# arbeitszeit
# paste( leistungszeitraum, ', Betrag', euro, 'Euro')

cat(stp25Project::rechnung_email(
  '",
name,
"','",
email,
"',
  '",
anrede,
"', euro, '",
knr,
"',  arbeitszeit,'",
BANK,"',
  '",
IBAN,"',
  '",
BIC, "'
)
  , file = 'Invoice.txt')



if(euro > zwischenrechnung) {
  library(crayon)
  cat(bgMagenta('\n\nBitte dringend eine ') %+% bgYellow('Zwischenrechnung') %+%
      bgMagenta(' stellen!\n\n ', euro, 'Euro (',h_max, 'h )\n\n' )
  )

  if (options()$prompt[1] == 'HTML> ')
    stp25output2::End()
  stop()

}

"
  )
  msg
}




# setwd("C:/Users/wpete/Dropbox/3_Forschung/R-Project/stp25Project/R")
# 
# cat(  Stundenliste(
#   euro = 85,
#   myswd = "",
#   knr = "0001",
#   name = "Hans Dampf",
#   email = "info@hd.com",
#   tel = "0815",
#   adr = "IMp 56",
#   anrede = " Hochwohlgeboren",
#   betreff = "Test",
#   zwischenrechnung = 400,
#   BANK = "HJD-PRIVATBANK",
#   IBAN = "1000 0000 0000 000!",
#   BIC = "ABCDXXX"
#  
# 
#  
#                   
#                   
# ), 
# file = "Stundenliste_txt.R")
