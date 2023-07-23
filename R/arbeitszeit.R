#' Dummy fuer die Stundenliste
#'
#' @param x minuten
#'
#' @return string
#' @export
#'
#' @examples
#' \dontrun{
#' Arbz()
#' }
Arbz <-
  function(task = NULL,  time = NULL, ...) {
    if (is.null(time))
      time <- sample(40:60,
                     size = 1,
                     replace = TRUE)
    else
      time <- time * 60
    
   # print(class(task))
    
    
    if(is.null(task) ) {
      task <- "Auswerten"
      
      cat("
 1 = Einarbeiten_ins_Thema
 2 = Aufbereiten_der_Daten
 3 = Deskriptive_Analyse 
 4 = Inferenzstatistische_Analyse
 5 = Kommunikation
")
      }
    else if( is.numeric(task)) {
     # task <- as.character(task)
      task <- switch(task,
             "1"= "Einarbeiten_ins_Thema",
             "2"=  "Aufbereiten_der_Daten" ,
             "3" =  "Deskriptive_Analyse"   ,       
             "4" = "Inferenzstatistische_Analyse",
             "5" =  "Kommunikation",
             "Auswerten")
    }
    else    task <- gsub(" +", "_", task)
    
    strt <- Sys.time()
    end <- strt + time * 60
 
    paste0(format(strt, "%d.%m.%Y    %H:%M"),
           "    ",
           format(end, "%H:%M"),
           "    ",
           task)
    
  }

# Arbz()
# Arbz("Auswerten Text  mit l" , 1)
# 
# Arbz( 1)




