rmdCache <- new.env(hash=TRUE)

#' Check if object is of class datacite
#' @param x input
#' @export
is.datacite <- function(x) inherits(x, "datacite")

#' compact rmetadata version
#'
#' @export
#' @param l Input list
#' @keywords internal
rmet_compact <- function (l) Filter(Negate(is.null), l)

#' Check response from web, and catch and give errors to the user.
#' @keywords internal
check_response <- function(x){
  if(!x$status_code == 200){
    stnames <- names(content(x))
    if(!is.null(stnames)){
      if('error' %in% stnames){
        warning(sprintf("Error: (%s) - %s", x$status_code, content(x)$error))
      } else { warning(sprintf("Error: (%s)", x$status_code)) }
    } else { warn_for_status(x) }
  } else { return( x )  }
}