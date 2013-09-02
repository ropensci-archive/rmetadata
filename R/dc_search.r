#' Search Datacite metadata.
#' 
#' @template dc
#' @examples \dontrun{
#' # Basic search, "fruit" in any fields
#' out <- dc_search(q="wind", rows=2)
#' dc_data(out) # summary of output
#' dc_data(input=out, what="brief") # as a data.frame
#' dc_data(input=out, what="details") # as a list
#' 
#' # Request specific returned fields
#' out <- dc_search('ecology', 'doi,title')
#' dc_data(out, "brief")
#' 
#' # Request certain serch terms to not be included (notice fewer records)
#' out <- dc_search('ecology -birds')
#' dc_data(out) 
#' 
#' # More complicated queries
#' out <- dc_search('ecology AND (bird or turtle)')
#' dc_data(out)
#' 
#' # Search for an exact phrase (put quotes around the term)
#' out <- dc_search('"wind turbine"')
#' dc_data(out)
#' 
#' # Search within specific field
#' out <- dc_search('title:ecology')
#' dc_data(out)
#' 
#' # Search within a range for a numeric field
#' out <- dc_search('publicationYear:[2000 TO 2005]')
#' dc_data(out)
#' 
#' # Search for records uploaded in last 5 days
#' out <- dc_search('uploaded:[NOW-5DAYS TO NOW]')
#' dc_data(out)
#' 
#' # Return certain number of records
#' out <- dc_search('ecology', fl='doi,date', rows=12)
#' dc_data(out, 'brief')
#' 
#' # Sort by a field
#' out <- dc_search('ecology', fl='doi,date', rows=12)
#' dc_data(out, 'brief')
#' 
#' # Wildcards: You can use ? for a single character or * for multiple characters, 
#' # e.g. w*d would match wood and wind.
#' out <- dc_search('subject:w*d', fl='subject')
#' dc_data(out, 'subject')
#' }
#' @export
#' @keywords datacite
dc_search <- function(q=NULL, fl=NULL, rows=10, sort=NULL)
{
  url <- 'http://search.datacite.org/api'
  args <- compact(list(q=q, fl=fl, rows=rows, sort=sort, wt='json'))
  temp <- content(GET(url, query = args))
  class(temp) <- "datacite"
  return( temp )
}