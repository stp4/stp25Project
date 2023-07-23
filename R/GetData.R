
Get_Data <- function(myswd = " setwd('C:/Users/wpete/Dropbox/1_Projekte/001 Dummy')",
                      Rdata = "DF.Rdata") {
 
paste0(
"#' ---
#' title: Daten Aufbereiten
#' author: Wolfgang Peter
#' output:
#'   pdf_document
#' keep_tex: yes
#' lang: de-DE
#' ---
 
#+ setup, include=FALSE
# knitr::opts_chunk$set(echo = TRUE)

require(tidyverse)
require(stp25tools)

#require(stp25output2)
#require(stp25stat2)
# require(stp25plot)
# source('R/miscFun.r', echo=F)
",myswd,
'

# -- Load Data ----------------------------------------------
#  
# DF <- get_data("Raw data/File.R")
# save(DF, file="Raw data/', Rdata,'")


# -- Tidy Data ---------------------------------------------
# DF %>% filter(key) %>%
#        mutate(jahr = factor(jahr)) %>%
#        Label(sex=Geschlecht)
#      
#  save(DF, file="Processed data/', Rdata,'")
      
')}