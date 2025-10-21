
Get_Data <- function(myswd = " setwd('C:/Users/wpete/Dropbox/1_Projekte/001 Dummy')",
                      Rdata = "DF.Rdata") {
 
paste0(
"#' ---
#' title: Daten Aufbereiten
#' author: Wolfgang Peter
#' output:
#'   html_document
#' ---
 
#+ setup, include=FALSE
# knitr::opts_chunk$set(echo = TRUE)

if (!('stp25tools2' %in% .packages())) {
  library(tidyverse)
  library(stp25output2)
  library(stp25tools2)
  # library(stp25stat2)
  # library(stp25plot)
  # library(effects)
  # library(lattice)
  # library(ggplot2)
}
# source('R/miscFun.r', echo=F)
",myswd,
'

# -- Load Data ----------------------------------------------
#  
# DF <- get_data("Raw data/File.R")
# save(DF, file="Raw data/', Rdata,'")


# -- Tidy Data ---------------------------------------------
# DF <- DF |> filter(key) |>
#        mutate(jahr = factor(jahr)) |>
#        Label(sex=Geschlecht)
#      
#  save(DF, file="Processed data/', Rdata,'")
      
')
  
}