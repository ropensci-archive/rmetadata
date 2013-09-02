#' Count OAI-PMH identifiers for a data provider.
#' 
#' Count identifiers for the data sources from the OAI-PMH list, and others not 
#'     on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @param useurl Setting to TRUE allows you to just provide the metadata
#' 		provider name, and any matches found the function will just use the url
#' 		to query their OAI-PMH API.
#' @param seconds Number of seconds by which to timeout an API call to one of
#' 		the data providers.
#' @seealso \code{\link{md_identify}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_listsets}}, \code{\link{md_getrecord}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Select one
#' count_identifiers("datacite")
#' 
#' # Select a few
#' ldply(c("datacite","pensoft","arXiv"), count_identifiers)
#' }
#' @examples \donttest{
#' # All of them, takes a while, run in parallel, e.g. on AWS RStudio AMI
#' out <- llply(providers[,2], function(x) count_identifiers(x, useurl = T), .inform=T)
#' outdf <- ldply(out)
#' str(outdf)
#' outdf_ <- outdf[!is.na(as.numeric(as.character(outdf$count))), ]  # just those with counts
#' }
#' @export
count_identifiers <- function(provider = NULL, metadataPrefix = 'oai_dc', 
    fuzzy = FALSE, useurl = FALSE, seconds = 3)
{ 
  if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
  { data(providers); message("loaded providers") }
  
  args <- compact(list(verb = 'ListIdentifiers', metadataPrefix = metadataPrefix))
  
  if(useurl == TRUE){ url <- provider } else
  {
    if(fuzzy){ get_ <- providers[ agrep(provider, providers[,1]), ] } else
    { get_ <- providers[ grep(provider, providers[,1]), ] }
    if(nrow(get_) == 0){ data.frame(x="no match found") } else
      if(nrow(get_) > 1){  data.frame(repo_name = get_[,1]) } else 
      { url <- get_[,"base_url"] }
  }
  mm <- tryCatch(GET(url, 
                     config=timeout(seconds))[[4]]$`content-type`, error = function(e) e$message)
  if(length(mm)==0) {dd <- "error"} else {
  if(grepl("timed out", mm)){dd<-"timed out"} else
  {
      nn <- strsplit(mm, ";")[[1]][[1]]
      if(nn == "text/html") { dd<-"not provided" } else 
        if(nn == "text/xml") {
          ss <- tryCatch(http_status(GET(url, query=args,  
                             config=timeout(seconds))), error = function(e) e$message)
          if(grepl("timed out", ss[[1]])){dd<-"timed out"} else {
            if(!grepl("success", ss$category)){dd<-"error"} else {
              tt <- tryCatch(xmlToList(
                xmlParse(
                  content(
                    GET(
                      url, query=args, config=timeout(seconds)), 
                    as="text")))$ListIdentifiers$resumptionToken$.attrs[["completeListSize"]],
                             error = function(e) e$message)
          if(is.null(tt)){dd<-"not provided"} else
            if(class(tt)=="try-error"){ dd<-"not provided" } else 
              if(tt == "subscript out of bounds") { dd<-"not provided" } else
                  { dd<-tt }
      }
      }
    } else { dd<-"bad content type" }
  }
  }
  if(useurl){ provider <- 
    providers[providers$base_url %in% provider, 1]} else {provider <- provider}
  data.frame(provider = provider, count = dd)
}