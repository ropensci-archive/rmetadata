#' Search metadata from the Digital Public Library of America (DPLA).
#' 
#' @import httr
#' @param queries A list of query terms paired with the fields you want to 
#'    search them in.
#' @return A list for now...
#' @export
#' @examples \dontrun{
#' # Search by specific fields
#' dpla_fields(c("fruit,title","basket,description"))
#' }
dpla_fields <- function(queries = NULL)
{
  url = "http://api.dp.la/v2/items"
  key <- getOption("dplakey")
  
  args <- list()
  for(i in seq_along(queries)){
    assign(paste("sourceResource", str_split(queries[[i]], ",")[[1]][[2]], sep="."), str_split(queries[[i]], ",")[[1]][[1]])
    args[[list(grep("sourceResource", ls(), value=TRUE))[[1]][[i]]]] <- eval(parse(text=grep("sourceResource", ls(), value=TRUE)[[i]]))
  }
  
  args <- compact(c(args, api_key=key))
  content(GET(url, query = args))
}