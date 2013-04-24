#' Search metadata from the Digital Public Library of America (DPLA).
#' 
#' @import httr plyr
#' @param q Query terms.
#' @param verbose If TRUE, the console talks to you :/
#' @param page_size Number of items to return, defaults to 10. Max of 100.
#' @param page Page number to return, defaults to NULL.
#' @param sort_by The default sort order is ascending. Most, but not all fields 
#'    can be sorted on. Attempts to sort on an un-sortable field will return 
#'    the standard error structure with a HTTP 400 status code.
#' @param fields A vector of the fields to return in the output. The default 
#'    is all fields. See details for options. 
#' @param verbose If TRUE, fun little messages print to console to inform you
#'    of things.
#' @details Options for the fields argument are:
#' \itemize{
#'  \item sourceResource.title The title of the object
#'  \item sourceResource.decription The description of the object
#'  \item sourceResource.subject The subjects of the object
#'  \item sourceResource.creator The creator of the object
#'  \item sourceResource.type The type of the object
#'  \item sourceResource.publisher The publisher of the object
#'  \item sourceResource.format The format of the object
#'  \item sourceResource.rights The rights for the object
#'  \item sourceResource.contributor The contributor of the object
#'  \item sourceResource.spatial The spatial of the object
#'  \item isPartOf The isPartOf thing, not sure what this is
#'  \item provider The provider of the object
#' }
#' @return A data.frame of results.
#' @examples \dontrun{
#' # Basic search, "fruit" in any fields
#' dpla_basic(q="fruit")
#' 
#' # Some verbosity
#' dpla_basic(q="fruit", verbose=TRUE, page_size=2)
#' 
#' # Return certain fields
#' dpla_basic(q="fruit", verbose=TRUE, fields=c("publisher","format"))
#' dpla_basic(q="fruit", fields="subject")
#' dpla_basic(q="fruit", fields=c("rights","subject","title","description","creator","type","publisher","format","contributor"))
#' }
#' @export
dpla_basic <- function(q=NULL, verbose=FALSE, fields=NULL, page_size=10, 
                       page=NULL, sort_by=NULL)
{
  fields2 <- fields
  
  if(!is.null(fields)){
    fieldsfunc <- function(x){
      if(x %in% c("title","description","subject","creator","type","publisher",
                  "format","rights","contributor","spatial","isPartOf",
                  "provider")) { paste("sourceResource.", x, sep="") } else { x }
    } 
    fields <- paste(sapply(fields, fieldsfunc, USE.NAMES=FALSE), collapse=",")
  } else {NULL}
  
  url = "http://api.dp.la/v2/items"
  key <- getOption("dplakey")
  args <- compact(list(api_key=key, q=q, page_size=page_size, page=page, fields=fields))
  temp <- content(GET(url, query = args))
  
  # collect header info
  hi <- data.frame(temp[1:3])
  if(verbose)
    message(paste(hi$count, " objects found, started at ", hi$start, ", and returned ", hi$limit, sep=""))
  
  # collect data
  dat <- temp[[4]]
  
  # function to process data for each element
  getdata <- function(y){ 
    process_res <- function(x){
      title <- x$title
      description <- x$description
      subject <- if(length(x$subject)>1){paste(as.character(unlist(x$subject)), collapse=";")} else {x$subject[[1]][["name"]]}
      language <- x$language[[1]][["name"]]
      format <- x$format
      collection <- x$collection[["name"]]
      type <- x$type
      publisher <- x$publisher
      creator <- if(length(x$creator)>1){paste(as.character(x$creator), collapse=";")} else {x$creator}
      rights <- x$rights
      
      replacenull <- function(y){ ifelse(is.null(y), "no content", y) }
      ents <- list(title,description,subject,language,format,collection,type,publisher,creator,rights)
      names(ents) <- c("title","description","subject","language","format","collection","type","publisher","creator","rights")
      ents <- llply(ents, replacenull)
      data.frame(ents)
    }
    if(is.null(fields)){ 
      provider <- data.frame(t(y$provider))
      names(provider) <- c("provider_url","provider_name")
      score <- y$score
      sourceResource <- y$sourceResource
      sourceResource_df <- process_res(sourceResource) 
      data.frame(sourceResource_df, provider, score)
    } else
      { 
        names(y) <- str_replace_all(names(y), "sourceResource.", "")
        process_res(y)
      }
  }
  
  output <- ldply(dat, getdata)
  
  if(is.null(fields)){ output  } else
    { 
      output2 <- output[,names(output) %in% fields2]  
      # convert one column factor string to data.frame (happens when only one field is requested)
      if(class(output2) %in% "factor"){ 
        output3 <- data.frame(output2) 
        names(output3) <- fields2
        output3
      } else { output2 }
    }
}