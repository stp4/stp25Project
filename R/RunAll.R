


small_project <-  function(project = "dummy",
                           datum = "",
                           myswd = " setwd('C:/Users/wpete/Dropbox/1_Projekte/001 Dummy')",
                           Rdata = "DF.Rdata") {
  
  
  
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
# knitr::opts_chunk$set(echo = TRUE, warnings=FALSE)
require(tidyverse)
  # session <- sessionInfo()
  # report::report(session)
require(stp25output2)
require(stp25stat2)
require(stp25tools)
# require(stp25plot)
      
#+ setup-plot, include=FALSE
# graphics.off()
# lattice::trellis.par.set(bw_theme())
# require(effects)
# require(lattice)
# lattice.options(default.args = list(as.table = TRUE))
  ",myswd," 
# source('R/miscFun.r', echo=F)
Projekt('', '", project,"', '" ,datum,"')

# set_opt(
#   caption = TRUE,
#   percent = list(
#     style = 2,
#     null_percent_sign =  ' . ',
#     digits = 0,
#     #percentage_str = '',
#     #include_name = ', n (%)'
#   ),
#   mean = list(style = 1,
#               include_name = ', mean (sd)'),
#   median = list(style = 3,
#                 include_name = ', median (range)'),
#   Fstat =list(include.statistic=FALSE),
#   table = list(
#     stubhead = 'Items',
#     measure.name.m = 'Mittelwert/Prozent',
#     measure.name.total = 'Summe',
#     measure.name.statistics = 'P-Werte'
#   )
# )


#+ tab-arbeitszeit, include=TRUE, echo=FALSE, results='asis'
  source('Stundenliste.R')
  Output( arbeitszeit[-nrow(arbeitszeit),] )



# -- Load Data ----------------------------------------------
# 
#   DF <- GetData('Raw data/File.R')
#   save(DF, file = 'Raw data/", Rdata,"')


#+ tidy-data, include=TRUE
#
# DF %>% 
#        mutate(jahr = factor(jahr)) %>%
#        Label(sex='Geschlecht')
#
#  save(DF, file='Processed data/", Rdata,"')


#+ filter, results='asis'
#
#  N <- nrow(DF)



# -- Analyze Data ----------------------------------------------
#+ results='asis'
#  DF %>% Tbll_desc(sex) %>% 
Output('Soziodemografische Merkmale der Teilnehmer zu Beginn der Studie')


#+ fig.cap='Health', fig.height=2.70, fig.width=10, echo=FALSE
#  plot(1)
#  SaveData( w=9.45, h=2.45)
  

  
  
End()
")
  
} 


# RunAll <- function(project, datum, myswd, Rdata)
# {
#   
#   paste0(
#     '
# require(tidyverse)
# require(stp25output2)
# require(stp25stat2)
# require(stp25tools)
# # require(stp25plot)
#       
# # - Grafik settings
# # graphics.off()
# # lattice::trellis.par.set(bw_theme())
# # require(effects)
# # require(lattice)
# # 
# # lattice.options(default.args = list(as.table = TRUE))
# 
# '
#     ,myswd,
#     '
# Projekt("", "',project,'", "' ,datum,'")
#       
# #- Arbeitszeit 
#     source("Stundenliste.R")
#     Output( arbeitszeit[-nrow(arbeitszeit),] )
#       
# #   Methode()
# #   Materials("Data laden und transformieren")
# #   Research_Design("Beschreibung des Studiendesigns (Experiment, Kohortenstudie, ...)")
# #    Measures("Fragebogen und Skalen (Reliabilitaetsanalyse)")
# #   # load("Processed data/', Rdata,'")
# #   # N <- nrow(DF)
# #   Results()
# #   Demographic_Variables()
# #   Statistic("H1 Korrelation", file="(4) Analyse.R")
# #   Statistic("H2 Regressionsanalyse", file="(5) Analyse.R")
# #   Statistic("H3 Korrelation", file="(6) Analyse.R")
# #   Statistic("H4 Regressionsanalyse", file="(7) Analyse.R")
# #   Statistic("Weitere Befunde", file="(8) Analyse.R")
#       
# #  #Anhang()
# 
#  End()
#       
#       ') 
# }




# cat(
#   small_project(), file="C:/Users/wpete/Dropbox/1_Projekte/001 Dummy/analyze.R")
 