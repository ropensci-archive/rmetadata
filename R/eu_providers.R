#' Europeana data providers.
#' 
#' @import httr jsonlite assertthat
#' @export
#' @param providerid Provider ID
#' @param datasetid Dataset ID
#' @param datasets (logical) Whether to return datasets or not with provider information. Ignored 
#' when providerid is NULL (the default for that parameter).
#' @param start (numeric) Record number to start with.
#' @param limit	(numeric) Size of the result set to fetch.
#' @param country_code (character) Two-letter ISO 3166-1 country code. Not all countries give data 
#' back of course, for example, there is no data for country_code='US'. 
#' @param callopts Curl options passed on to httr::GET, see examples
#' @examples \dontrun{
#' eu_providers(limit=1)
#' eu_providers(limit=1, start=3)
#' out <- eu_providers(limit=3)
#' out$meta
#' out$items
#' eu_providers(start=3)
#' eu_providers(providerid=20239)
#' eu_providers(providerid=20239, datasets=TRUE)
#' eu_providers(datasetid=2023901)
#' identical(eu_providers(providerid=20239, datasets=TRUE)$items, 
#'    eu_providers(datasetid=2023901)$items)
#'    
#' # Country codes
#' out <- eu_providers(country_code='UK')
#' sapply(out$items, "[[", "country") # check that all country fields are UK 
#' 
#' # Curl debugging
#' library("httr")
#' eu_providers(limit=1, callopts=verbose())
#' }

eu_providers <- function(providerid = NULL, datasetid = NULL, datasets = FALSE, start = NULL, 
  limit = 10, country_code = NULL, key = NULL, callopts=list())
{
  if(is.null(key))
    key <- getOption("europeana_api_key")
  
  assert_that(if(!is.null(providerid)) is.null(datasetid) else TRUE)
  assert_that(if(!is.null(datasetid)) is.null(providerid) else TRUE)
  
  url <- 'http://europeana.eu/api/v2/providers.json'
  if(!is.null(providerid)){
    if(datasets){
      url <- sprintf('http://europeana.eu/api/v2/provider/%s/datasets.json', providerid)
    } else {  
      url <- sprintf('http://europeana.eu/api/v2/provider/%s.json', providerid)
    }
  }
  if(!is.null(datasetid)){
    url <- sprintf('http://europeana.eu/api/v2/dataset/%s.json', datasetid)
  }
  
  args <- rmet_compact(list(wskey=key, countryCode=country_code, offset=start, pagesize=limit))
  tt <- GET(url, query=args, callopts)
  check_response(tt)
  assert_that(tt$headers$`content-type` == 'application/json;charset=UTF-8')
  res <- content(tt, as = "text")
  out <- fromJSON(res, simplifyVector = FALSE)
  list(meta=out[ !names(out) %in% "items" ], items=out$items)
}