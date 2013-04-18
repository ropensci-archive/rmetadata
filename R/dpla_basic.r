#' Search metadata from the Digital Public Library of America (DPLA).
#' 
#' @import httr
#' @param q Query terms.
#' @return A list for now...
#' @export
#' @examples \dontrun{
#' # Basic search, "fruit" in any fields
#' dpla_basic("fruit")
#' }
dpla_basic <- function(q = NULL)
{
  url = "http://api.dp.la/v2/items"
  key <- getOption("dplakey")
  args <- compact(list(api_key=key, q=q))
  content(GET(url, query = args))
}