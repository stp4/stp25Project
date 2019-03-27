
RunAll <- function(project, datum, myswd, Rdata){
 
    paste0(
'
require(stpvers)
require(tidyverse)
      
# set_my_options(prozent=list(digits=c(1,0), style=2))
graphics.off()
# require(stp25plot)
# reset_lattice()
'
,myswd,
'
Projekt("", "',project,'", "' ,datum,'")
      
#- Arbeitszeit 
    source("Stundenliste.R")
    Output( arbeitszeit[-nrow(arbeitszeit),] )
      
#   Methode()
#   Materials("Data laden und transformieren")
#   Research_Design("Beschreibung des Studiendesigns (Experiment, Kohortenstudie, ...)")
#    Measures("Fragebogen und Skalen (Reliabilitaetsanalyse)")
#   # load("Processed data/', Rdata,'")
#   # N <- nrow(DF)
#   Results()
#   Demographic_Variables()
#   Statistic("H1 Korrelation", file="(4) Analyse.R")
#   Statistic("H2 Regressionsanalyse", file="(5) Analyse.R")
#   Statistic("H3 Korrelation", file="(6) Analyse.R")
#   Statistic("H4 Regressionsanalyse", file="(7) Analyse.R")
#   Statistic("Weitere Befunde", file="(8) Analyse.R")
      
#  #Anhang()

 End()
      
      ') 
}