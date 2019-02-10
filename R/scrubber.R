#-- Functions stolen from library(report)
scrubber <- function(text.var, rm.quote = TRUE, fix.comma = TRUE, ...){
  x <- reducer(Trim(clean(text.var)))
  if (rm.quote) {
    x  <- gsub('\"', "", x)
  }
  if (fix.comma) {
    x <- gsub(" ,", ",", x)
  }
  ncx <- nchar(x)
  x <- paste0(Trim(substring(x, 1, ncx - 1)), substring(x, ncx))
  x[is.na(text.var)] <- NA
  x
}


#internal not exported
reducer <- function(x) gsub("\\s+", " ", x)

#internal not exported
Trim <- function (x) gsub("^\\s+|\\s+$", "", x)

#internal not exported
unblanker <- function(x) subset(x, nchar(x)>0)

#internal not exported
clean <- function(text.var) sub("\\s+", " ", gsub("\r|\n|\t", " ", text.var))

mgsub <- function(pattern, replacement = NULL, text.var, fixed = TRUE, ...){
  key <- data.frame(pat=pattern, rep=replacement,
                    stringsAsFactors = FALSE)
  msubs <-function(K, x, ...){
    sapply(seq_len(nrow(K)), function(i){
      x <<- gsub(K[i, 1], K[i, 2], x, fixed = fixed, ...)
    }
    )
    return(gsub(" +", " ", x))
  }
  x <- Trim(msubs(K=key, x=text.var, ...))
  return(x)
}

