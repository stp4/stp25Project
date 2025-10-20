#' @rdname CreateProjekt
#' 
#' @export
#' 
Stundenliste <- function(     KNr,
                              Name,Email,Telfon,Stundensatz,
                              Anrede,
                              Zwischenrechnung,
                              bank,iban,bic,
                              string_myswd) {
  jetzt <- Sys.time()
  # print(zeit)
  zeit_stempel <-  paste(
    format(jetzt, '%d.%m.%Y'),
    " ",
    format(jetzt - 60 * 16,  '%H:%M'),
    format(jetzt,  '%H:%M'),
    " ",
    " Einarbeiten_ins_Thema"
  )
  
  
 paste0(
"#' ---
#' title: Stundenliste
#' ---

Status <- 'in Arbeit'


",
string_myswd,
"


stp25Project::Arbz()

Stundenliste <-
stp25Project::AZ(
  '
Datum   Start   Ende   Task
",
zeit_stempel,
    
"

'
  )





euro <- ",Stundensatz,"
zwischenrechnung <- ",Zwischenrechnung,"
h_min <- min(Stundenliste$Summe)
h_max <- max(Stundenliste$Summe)
Euro <-  euro * h_max



if(exists('RECHNUNG')){
  leistungszeitraum <-
    paste(Stundenliste[1, 1], 'bis', Stundenliste[nrow(Stundenliste), 1])
  
  cat(stp25Project::rechnung_email(
  '",KNr,"','",Name,"','",Email,"','",Anrede,"', Euro,  Stundenliste,'",bank,"', '",iban,"', '",bic, "')
  , file = 'Invoice.txt')
  
    if( RECHNUNG) {
    Status <- 'Rechnung'
    }

} 


stp25Project::update_arbeitszeit(KNr = ", KNr," , Zeit = h_max, Status = Status)



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

}



