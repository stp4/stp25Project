RunAll <- function(project, datum, myswd, Rdata){
 
    paste0(
'
require(stpvers)
require(tidyverse)
      
# set_my_options(prozent=list(digits=c(1,0), style=2))
graphics.off()
# require(stp25plot)
#  reset_lattice()
#  set_lattice_bw(col = grey.colors(4, start = 0.4, end = 0.9))
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


small_project <-  function(project="dummy", 
                           datum="Fri May 10 08:46:24 2019", 
                           myswd=NA, 
                           Rdata="DF.Rdata") {
  
  
  paste0(
    "#' ---
#' title: ", project,"
#' author: Wolfgang Peter
#' output:
#'   pdf_document
#' keep_tex: yes
#' lang: de-DE
#' ---
 
 
#+ setup, include=FALSE
  knitr::opts_chunk$set(echo = TRUE, warnings=FALSE)
  require(stpvers)
  require(tidyverse)

  ",myswd," 
  # source( 'R/miscFun.r' , echo=F)
  Projekt('', '", project,"', '" ,datum,"')


  #-- Speicherort aendern
  # set_my_options(fig_folder='Fig2/')
  #
  #
  #-- Format aendern
  #set_my_options(prozent=list(digits=c(1,0), style=2))
  #
  #set_my_options(mittelwert=list(digits=c(1,0), plusmin_sign=TRUE))
  set_my_options(prozent = list(null_percent_sign =  ' . ' ))
  #
  #-- Impliziet (also nicht als default vorhanden) #set_my_options(mittelwert=list(include_name=FALSE)))
  # set_my_options(style_mean = list(line_break = '<br>'))
  #
  # set_my_options(mittelwert = list(median.style = 'IQR'))
  # set_my_options(caption= 'include.n') 
  #
  #-- Sprache ändern
  # set_my_options(bez=list(statistics='Sig-Test'))
  # options()$stp25$bez$sig.test
  # set_my_options(bez=NULL)
  
  

#+ setup-plot, include=FALSE
  # require(stp25plot)
  graphics.off()
  reset_lattice() 
  set_lattice_bw(col = grey.colors(4, start = 0.4, end = 0.9)) 



#+ tab-arbeitszeit, include=TRUE, echo=FALSE, results='asis'
  source('Stundenliste.R')
  Output( arbeitszeit[-nrow(arbeitszeit),] )



# -- Load Data ----------------------------------------------
#  
#   car::some(DF <- GetData('Raw data/File.R'))
#   save(DF, file = 'Raw data/", Rdata,"')


#+ tidy-data, include=TRUE
#
# DF %>% Drop_NA(key) %>%
#        mutate(jahr = factor(jahr)) %>%
#        Label(sex='Geschlecht')
#
#    DF <- transform(DF,
#    h1 = NA,
#    h2 = NA
#  )       
  
# DF  <- Label(DF,
#    h1='I Health-Related Indicators',
#    h2='II Health-Related Behaviour',
#    sex='Sex',
#    age ='Age (years)')
#  save(DF, file='Processed data/", Rdata,"')


#+ filter, results='asis'
#
#  DF<- Drop_NA(DF, diet)
#  DF<- Drop_NA(DF,  age)
#
#  N <- nrow(DF)



# -- Analyze Data ----------------------------------------------
#+ results='asis'
#  DF %>% Tabelle2(sex) 


#+ fig.cap='Health', fig.height=2.70, fig.width=10, echo=FALSE
#  plot(1)
#  SaveData( w=9.45, h=2.45)
  

  
  
End()
")
  
} 

cat(
  small_project(),file="C:/Users/wpete/Dropbox/1_Projekte/001 Dummy/analyze.R")
 