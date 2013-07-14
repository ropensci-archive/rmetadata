rmdCache <- new.env(hash=TRUE)

#' Check if object is of class datacite
#' @param x input
#' @export
is.datacite <- function(x) inherits(x, "datacite")