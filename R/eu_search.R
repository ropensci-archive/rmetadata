#' Europeana search.
#' 
#' @import httr jsonlite
#' @export
#' @param query 
#' @param callopts Curl options passed on to httr::GET
#' @examples \dontrun{
#' eu_search(query='Mona Lisa')
#' eu_search(query='who:"Leonardo da Vinci"')
#' eu_search(query='mona AND lisa')
#' out <- eu_search(query='Lasioglossum')
#' out$itemsCount
#' out$items[[6]]
#' library("httr")
#' GET(out$items[[6]]$link)
#' browseURL(out$items[[6]]$guid)
#' }

eu_search <- function(query, key = NULL, callopts=list())
{
  if(is.null(key))
    key <- getOption("europeana_api_key")
  url <- 'http://europeana.eu/api/v2/search.json'
  args <- eu_compact(list(query=query, wskey=key))
  tt <- GET(url, query=args, callopts)
  warn_for_status(tt)
  res <- content(tt, as = "text")
  out <- fromJSON(res, simplifyVector = FALSE)
  out
}

