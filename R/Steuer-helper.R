# make_konto <- function(x,
#                        jahr,
#                        format = "%d.%m.%Y",
#                        select = c(1, 2, 4, 7)) {
#   x$id <- seq_len(nrow(x))
#   x[[2]] <-
#     gsub("Auftraggeber: ", "", gsub("Zahlungsempfänger: ", "", x[[2]]))
#   x <- x[select]
#   
#   names(x) <- c("datum", "txt", "euro", "id")
#   x$einnahmen <- ifelse(x$euro > 0, x$euro, NA)
#   x$ausgaben <- ifelse(x$euro < 0, x$euro, NA)
#   x$datum <-
#     lubridate::as_datetime(x$datum, format = format)
#   
#   x[lubridate::year(x$datum) == jahr,]
# }
# 
# 
# 
# 
# find_item <- function(pattern, x) {
#   rslt<- unique(unlist(lapply(pattern , grep, x)))
#   if(length(rslt) == 0 ) NULL
#   else rslt
# }
