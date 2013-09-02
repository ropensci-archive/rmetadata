#' Get Datacite data.
#' 
#' Get Datacite data from a search using dc_search.
#' 
#' @import plyr
#' @param input Output from bison function.
#' @param what One of summary, brielf, all, or list specific columns as comma
#'    separated character string.
#' @param as As a data.frame (df) or list (list)
#' @return A message, data.frame or list.
#' @description what=summary prints a message with summary of search, what=brief 
#'    returns all data in a data.frame, what=all returns all data, 
#'    what=<character string of column names> returns just those column names
#' @examples \dontrun{
#' # output data
#' out <- dc_search(q="ecology")
#' class(out) # check for the correct class (should be "datacite")
#' dc_data(out) # summary of output
#' dc_data(input=out, what="brief") # just key columns as a data.frame
#' dc_data(input=out, what="doi,creator") # pick specific columns to return, as data.frame
#' dc_data(input=out, what="brief", as='list')
#' }
#' @export
dc_data <- function(input = NULL, what='summary', as='df') UseMethod("dc_data")

#' @S3method dc_data datacite
#' 
dc_data.datacite <- function(input = NULL, what = 'summary', as = 'df')
{
  if(!is.datacite(input))
    stop("Input is not of class datacite")
  
  if(!what=='summary'){
    dat <- input$response$docs
    if(any(names(dat[[1]]) %in% "creator")){
      cat_creator <- function(x){
        tt <- paste0(x$creator, collapse=";")
        x$creator <- tt
        x
      }
      dat <- llply(dat, cat_creator)
    }
    if(any(names(dat[[1]]) %in% "subject")){
      cat_subject <- function(x){
        tt <- paste0(x$subject, collapse=";")
        x$subject <- tt
        x
      }
      dat <- llply(dat, cat_subject)
    }
  }
  
  if(what=='summary'){
    temp <- input$response
    message(sprintf("%s objects found, started at %s and returned %s", temp$numFound, temp$start, length(temp$docs)))
  } else
    if(what=="brief"){
      if(as=='df'){        
        ldply(dat, function(x) data.frame(x[names(x) %in% c('dataset_id','doi','title','date','creator','publisher','subject')]))
      } else
      {
        llply(dat, function(x) x[names(x) %in% c('dataset_id','doi','title','date','creator','publisher','subject')])
      }
    } else
      if(what=="all"){
        if(as=='df'){ ldply(dat) } else { dat }
      } else
      {
        toget <- strsplit(what, split=",")[[1]]
        if(as=='df'){
          ldply(dat, function(x) data.frame(x[names(x) %in% toget]))
        } else
        {
          llply(dat, function(x) data.frame(x[names(x) %in% toget]))
        }
      }
}