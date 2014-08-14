# url formats
# http://catalog.hathitrust.org/api/volumes/brief/<id type>/<id value>.json
# http://catalog.hathitrust.org/api/volumes/full/<id type>/<id value>.json

# url1 <- 'http://catalog.hathitrust.org/api/volumes/brief/oclc/424023.json'
# url2 <- 'http://catalog.hathitrust.org/api/volumes/full/oclc/424023.json'
# res <- GET(url2)
# stop_for_status(res)
# tt <- content(res, "text")
# jsonlite::fromJSON(tt)

#' HathiTrust bibliographic API
#'
#' @import httr jsonlite
#' @export
#'
#' @param oclc OCLC Number. Will be normalized to just digits.
#' @param lccn Will be normalized as recommended
#' @param issn Will be normalized to just digits
#' @param isbn Will be normalized to just digits (and possible trailing X). ISBN-13s will be left
#'  alone; ISBN-10s will search against both the ISBN-10 and the ISBN-13
#' @param htid The HathiTrust Volume ID of a particular volume (e.g., mdp.39015058510069)
#' @param recordnumber The 9-digit HathiTrust record number, as described above.
#' @param ids A list of length 1 or more, with lists or vectors inside with many ids
#' to search for
#' @param which (character) One of brief or full.
#' @param searchfor (character) One of single or many.
#' @param ... Further args passed on to httr::GET, see examples
#'
#' @seealso \code{hathi} for description of the output of this function.
#'
#' @examples \dontrun{
#' # Search for a sinlge item by single identifier
#' hathi_bib(oclc=424023)
#' hathi_bib(oclc=424023, which='full')
#' hathi_bib(htid='mdp.39015058510069')
#' hathi_bib(lccn='21019671')
#' hathi_bib(recordnumber='009585561')
#' hathi_bib(issn='9781149102480')
#'
#' # Search for a single item by many identifiers
#' hathi_bib(htid='BJD1', oclc=424023, isbn='0030110408')
#' hathi_bib(htid='BJD1', oclc=424023, isbn='0030110408', which='full')
#'
#' # Search for many items by a single identifier each
#' hathi_bib(lccn='70628581', isbn='0030110408', searchfor='many')
#'
#' # Search for many items by many identifiers each
#' hathi_bib(ids=list(list(htid='BJD1', oclc=424023, isbn='0030110408'),
#'                    list(lccn='70628581', isbn='0030110408')), searchfor='many')
#'
#' # Curl debugging
#' hathi_bib(oclc=424023, config=verbose())
#' }

hathi_bib <- function(oclc=NULL, lccn=NULL, issn=NULL, isbn=NULL, htid=NULL, recordnumber=NULL,
  ids=list(), which='brief', searchfor='single', ...)
{
  which <- match.arg(which, c('brief','full'))

  if(length(ids) == 0){
    calls <- names(sapply(match.call(), deparse))[-1]
    c_vec <- calls[calls %in% c('oclc','lccn','issn','isbn','htid','recordnumber')]

    if(length(c_vec) == 0) stop('please provide at least 1 identifier')
    if(length(c_vec) == 1){
      url <- sprintf('http://catalog.hathitrust.org/api/volumes/%s/%s/%s.json', which, c_vec, get(c_vec))
    }
    if(length(c_vec) > 1){
      searchfor <- match.arg(searchfor, c('single','many'))
      args <- switch(searchfor,
                     single = makeargs(c_vec),
                     many = makeargs(c_vec, sep = "|"))
      url <- sprintf('http://catalog.hathitrust.org/api/volumes/%s/json/%s', which, args)
    }
  } else {
    args <- paste0(vapply(ids, makeargsfromids, character(1)), collapse = "|")
    url <- sprintf('http://catalog.hathitrust.org/api/volumes/%s/json/%s', which, args)
  }

  res <- GET(url, ...)
  stop_for_status(res)
  tt <- content(res, "text")
  jsonlite::fromJSON(tt)
}

makeargs <- function(x, sep=';'){
  out <- list()
  for(i in seq_along(x)){
    out[[i]] <- sprintf("%s:%s", x[[i]], get(x[[i]], envir = parent.frame()))
  }
  out2 <- paste(out, collapse = sep)
  gsub('htid', 'id', out2)
}

makeargsfromids <- function(x){
  out <- list()
  for(i in seq_along(x)){
    out[[i]] <- sprintf("%s:%s", names(x[i]), x[[i]])
  }
  out2 <- paste(out, collapse = ';')
  gsub('htid', 'id', out2)
}
