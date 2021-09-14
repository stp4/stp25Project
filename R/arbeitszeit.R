#' Dummy fuer die Stundenliste
#'
#' @param x minuten
#'
#' @return
#' @export
#'
#' @examples
#' 
#' Arbz()
Arbz<- function(x=NULL) {
  if(is.null(x)) x<- sample(x = 40:60, size = 1, replace = TRUE)
  strt <- Sys.time()
  end <- strt+x*60

  paste(format(strt, "%d.%m.%Y   %H:%M"),  format(end, "%H:%M"), "  Auswerten")
  
}
 
Arbz()