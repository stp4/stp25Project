#' Create Folder
#'
#' \code{folder} - Create a folder/directory.
#' @param ... Namen der Folder
#' @param folder.name weis nicht  = NULL
#' @return \code{folder} creates a folder/directory.
#' @rdname file_handling
#' @export
folder <- function(..., folder.name = NULL) {
  if (!is.null(folder.name)) {
    x <- strsplit(folder.name, split = ", ")
  } else {
    x <- substitute(...())
  }
  if (!is.null(x)) {
    x <- unblanker(scrubber(unlist(lapply(x, function(y) {
      as.character(y)}))))
  }
  hfolder <- function(folder.name = NULL) {
    if (is.null(folder.name)) {
      FN <- mgsub(c(":", " "), c(".", "_"),
                  substr(Sys.time(), 1, 19))
    } else {
      FN <-folder.name
    }
    if (length(unlist(strsplit(FN, "/"))) == 1) {
      x <- paste(getwd(), "/", FN, sep = "")
    } else {
      x <- FN
    }
    dir.create(x)
    return(x)
  }
  if (is.null(x)) {
    hfolder()
  } else {
    if (length(x) == 1) {
      hfolder(x)
    } else {
      lapply(x, function(z) {
        hfolder(z)
      })
    }
  }
}



