#' Search metadata from the Digital Public Library of America (DPLA).
#' 
#' @import httr
#' @param queries A list of query terms paired with the fields you want to 
#'    search them in. You can search on specific fields, see details below.
#' @details You can search on a vector of the fields to return in the output. 
#'    The default is all fields. Options are:
#'    \itemize{
#'      \item{title}{Object title}
#'      \item{description}{Description}
#'      \item{subject}{Subjects, semicolon separated}
#'      \item{language}{Language}
#'      \item{format}{Format, one of X, Y.}
#'      \item{collection}{Collection name}
#'      \item{type}{Type of object}
#'      \item{publisher}{Publisher name}
#'      \item{creator}{Creator}
#'      \item{provider}{Data provider}
#'      \item{score}{Matching score on your query}
#'      \item{creator}{Creator}
#'    }
#' @return A list for now...
#' @examples \dontrun{
#' # Search by specific fields
#' dpla_by_fields(queries=c("fruit,title","basket,description"))
#' 
#' # Items from before 1900
#' dpla_by_fields("1900,date.before")
#' }
#' @export
dpla_by_fields <- function(queries = NULL)
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