#' Search Cambridge journals metadata.
#' 
#' @import httr XML
#' @importFrom plyr compact
#' @param query Query string
#' @param callopts curl options passed on to GET call
#' @examples \dontrun{
#' # Basic metadata search
#' out <- cambridge_search(query="history")
#' out
#' 
#' # Get certain fields
#' out[,c('creator','pages')]
#' 
#' # Go the web page for an article
#' browseURL(as.character(out[,c('url')][[1]]))
#' }
#' @export
#' @keywords cambridge
cambridge_search <- function(query=NULL, callopts=list())
{
  url <- 'http://cjo:cjo@api.cambridge.org/articles/search'
  args <- compact(list(query=query))
  temp <- content(GET(url, query = args, callopts), as="text")
  out <- xmlParse(temp)
  namespaces_dc <- c(dc='http://purl.org/dc/elements/1.1/')
  namespaces_cup <- c(cup='http://www.cambridge.org/')
  namespaces_dcterms <- c(dcterms='http://purl.org/dc/terms/')  
#   getNodeSet(out, "//dc:creator", namespaces=namespaces_dc)
#   getNodeSet(out, "//cup:url", namespaces=namespaces_cup)
#   getNodeSet(out, "//dcterms:abstractStr[not(dcterms:abstractStr)]", namespaces=namespaces_dcterms)
  thing <- getNodeSet(out, "//cup:article", namespaces=namespaces_cup)
  toget <- c('creator','identifier','title','abstractStr','bibliographicCitation','url','journalTitle','volume','issueNo','pages','year')
  
  getvalues <- function(y){
    tt = sapply(thing, function(x) xmlValue(x[[y]]))
    sapply(tt, function(x) gsub("<(.|\n)*?>|&nbsp","",x), USE.NAMES=FALSE)
  }
  data <- lapply(toget, getvalues)
  names(data) <- toget
  data.frame(do.call(cbind, data[!names(data)=="abstractStr"]), stringsAsFactors=FALSE)
}