#' Get a random set of DOI's through CrossRef.
#' 
#' @import httr
#' @param doi A long-form DOI.
#' @param justshort If TRUE, return just the short DOI. If false, the short DOI, 
#' 		the submitted long-form DOI, and whether the short DOI is new. 
#' @return Either the short DOI or the submitted DOI, the short DOI, and whether 
#' 		it is a new short DOI or not.
#' @details See here \url{http://shortdoi.org/} for more information.
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @seealso \code{\link{crossref_search}}, \code{\link{crossref_citation}}, \code{\link{crossref_search_free}}
#' @examples \dontrun{
#' # Geta a short DOI, just the short DOI returned
#' short_doi(doi = "10.1371/journal.pone.0042793")
#' short_doi(doi = "10.1890/10-0340.1")
#' 
#' # Geta a short DOI, all data returned
#' short_doi(doi = "10.1371/journal.pone.0042793", justshort=FALSE)
#' }
#' @export
short_doi <- function(doi = NULL, justshort = TRUE)
{
	url = "http://shortdoi.org/"
	url2 <- paste(url, doi, '?format=json', sep='')
	temp <- content(GET(url2))
	if(justshort) { temp$ShortDOI } else { temp }
}