make_konto <- function(x,
                       jahr,
                       format = "%d.%m.%Y",
                       select = c(1, 2, 4, 7)) {
  x$id <- seq_len(nrow(x))
  x[[2]] <-
    gsub("Auftraggeber: ", "", gsub("Zahlungsempfänger: ", "", x[[2]]))
  x <- x[select]
  
  names(x) <- c("datum", "txt", "euro", "id")
  x$einnahmen <- ifelse(x$euro > 0, x$euro, NA)
  x$ausgaben <- ifelse(x$euro < 0, x$euro, NA)
  x$datum <-
    lubridate::as_datetime(x$datum, format = format)
  
  x[lubridate::year(x$datum) == jahr,]
}


konto_obj <-
  function(x,
           items = NULL,
           name = "Dummy",
           jahr = "2022") {
    if (!is.null(items)) {
      x <- x[items, ]
      x$Pos <- "sva"
    } else {
      x <-
        data.frame(
          datum =     lubridate::as_datetime(paste0(jahr, "-01-01")),
          txt = "",
          euro = 0,
          id = 0,
          einnahmen = 0,
          ausgaben = 0,
          Pos = name
        )
    }
    
    x
  }

find_item <- function(pattern, x) {
  rslt<- unique(unlist(lapply(pattern , grep, x)))
  if(length(rslt) == 0 ) NULL
  else rslt
}
