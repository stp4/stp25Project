
Get_Data <-  function(myswd, Rdata) {
 
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

knitr::opts_chunk$set(echo = TRUE)
require(stpvers)
require(tidyverse)

# source( 'R/miscFun.r' , echo=F)
",myswd,
'

# -- Load Data ----------------------------------------------
#  
# car::some(DF <- GetData("Raw data/File.R"))
# save(DF, file="Raw data/', Rdata,'")


# -- Tidy Data ---------------------------------------------
# DF %>% Drop_NA(key) %>%
#        mutate(jahr = factor(jahr)) %>%
#        Label(sex=Geschlecht)
#      
#  save(DF, file="Processed data/', Rdata,'")
      
')}