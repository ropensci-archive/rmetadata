#' Europeana search.
#' 
#' @import httr jsonlite
#' @export
#' @param query (character) Query string
#' @param profile (character) Profile parameter controls the format and richness of the response. 
#' See Details.
#' @param qf (character) Facet filtering query. This parameter can be defined more than once.
#' @param limit (numeric) The number of records to return. Maximum is 100. Defaults to 10.
#' @param start (numeric) The item in the search results to start with. The first item is 1. 
#' Defaults to 1.
#' @param key (character) API key for Europeana
#' @param callopts Curl options passed on to httr::GET
#' @details
#' Possible values of the profile parameter:
#' \itemize{
#'  \item minimal - Returns minimal set of metadata
#'  \item standard - TBD
#'  \item facets - Information about facets is added. For the records the Standard profile is used.
#'  \item breadcrumbs - information about the query is added in the form of breadcrumbs.
#'  \item portal - Standard, Facets, and Breadcrumb combined
#'  \item params - The header of the response will contain a params key, which lists the requested 
#'  and default parameters of the API call.
#' }
#' 
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
#' 
#' # Using the profile parameter
#' eu_search(query='Mona Lisa', profile='minimal', limit=1)
#' eu_search(query='Mona Lisa', profile='standard', limit=1)
#' eu_search(query='Mona Lisa', profile='facets', limit=1)
#' eu_search(query='Mona Lisa', profile='breadcrumbs', limit=1)
#' eu_search(query='Mona Lisa', profile='portal', limit=1)
#' eu_search(query='Mona Lisa', profile='params', limit=1)
#' 
#' # Range search
#' eu_search(query='[a TO b]', limit=3)
#' 
#' # Time range search
#' eu_search(query='YEAR:[1525 TO 1527]', limit=3)
#' 
#' # Date search
#' eu_search(query='timestamp_updated:"2013-03-16T20:26:27.168Z"')
#' 
#' # Geographical bounding box search
#' eu_search(query='pl_wgs84_pos_lat:[45 TO 47] AND pl_wgs84_pos_long:[7 TO 8]', limit=3)
#' 
#' # Using faceting via the qf parameter
#' out <- eu_search(query='Westminster', qf='where:London')
#' out$items[[1]]
#' ## objects containing the term Paris among images
#' eu_search(query='Paris', qf='TYPE:IMAGE')
#' ## objects containing the term Paris among images, with profile='facets'
#' eu_search(query='Paris', qf='TYPE:IMAGE', profile='facets')
#' ## objects containing the term Paris among objects described in French
#' eu_search(query='Paris', qf='LANGUAGE:FR')
#' ## objects dated by the year 1789
#' eu_search(query='Paris', qf='YEAR:1789')
#' ## objects provided by an institution based in France
#' eu_search(query='Paris', qf='COUNTRY:france')
#' ## objects protected by the Rights Reserved - Free Access licence
#' eu_search(query='Paris', qf='RIGHTS:http://www.europeana.eu/rights/rr-f/')
#' ## objects provided by the user community:
#' eu_search(query='Paris', qf='UGC:true')
#' }

eu_search <- function(query, profile = NULL, qf = NULL, limit = 10, start = NULL, key = NULL, 
  callopts=list())
{
  if(is.null(key))
    key <- getOption("europeana_api_key")
  url <- 'http://europeana.eu/api/v2/search.json'
  args <- rmet_compact(list(query=query, profile=profile, qf=qf, rows=limit, start=start, wskey=key))
  tt <- GET(url, query=args, callopts)
  check_response(tt)
  assert_that(tt$headers$`content-type` == "application/json;charset=UTF-8")
  res <- content(tt, as = "text")
  out <- fromJSON(res, simplifyVector = FALSE)
  if('error' %in% names(out)){ NA } else { out }
}