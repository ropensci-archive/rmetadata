#' Search the Microsoft Academic Research API.
#' 
#' @import RJSONIO plyr RCurl httr
#' @param FullTextQuery Search terms for a full text query of the MAS API.
#' @param AuthorQuery Search terms for an author query of the MAS API.
#' @param TitleQuery Search terms for a title query of the MAS API.
#' @param JournalQuery Search terms for a journal query of the MAS API.
#' @param ConferenceQuery Search terms for a conference query of the MAS API.
#' @param ResultObjects The object type to be returned, for example, Publication, 
#' 		Author, Conference etc.
#' @param PublicationContent When search for publications, this parameter is used to 
#' 		specify the properties to be returned, for example, Title, Author, Abstract etc.
#' @param StartIdx Record to start at.
#' @param EndIdx Record to end at.
#' @param OrderBy Order results by The sorting method of the result, for example, 
#' 		Year and CitationCount.
#' @param YearStart The start year of the publication. Zero for no requirement.
#' @param YearEnd The end year of the publication. Zero for no requirement.
#' @param return_ Content to return: one of all (journal info and authors), 
#' 		journal (journal information), or authors (author information).
#' @param key API key for the Microsoft Academic Research API.
#' @details For more information, see the README for this package.
#' @examples \dontrun{
#' out <- mar_search(FullTextQuery="science", StartIdx=1, EndIdx=2)
#' lapply(out, function(x) x[["journal"]]) # just journal content
#' lapply(out, function(x) x[["authors"]]) # just authors content
#' 
#' # Using AuthorID - Return only a certain object, here "Author", and search by AuthorID
#' mar_search(AuthorID=23552408, ResultObjects="Author")
#' 
#' # Using AuthorQuery - Return only a certain object, here "Author", and search by AuthorID
#' mar_search(AuthorQuery="Piwowar", ResultObjects="Author")
#' mar_search(AuthorQuery="Piwowar", ResultObjects="Publication")
#' }
#' @export
mar_search <- function(FullTextQuery = NULL, AuthorQuery = NULL, TitleQuery = NULL, 
	JournalQuery = NULL, ConferenceQuery = NULL, ResultObjects = NULL, 
	PublicationContent = NULL, AuthorID = NULL, StartIdx = 1, EndIdx = 10, YearStart = NULL,
	YearEnd = NULL, return_ = "all",
	key = getOption("MicAcaRes", stop("API key needed for Microsoft Academic Research API")))
{
  message("Deprecated, Microsoft isn't supporting MAR anymore.")
#   url <- "http://academic.research.microsoft.com/json.svc/search"
# 	args <- compact(list(AppId=key, FullTextQuery=FullTextQuery, AuthorQuery=AuthorQuery, TitleQuery=TitleQuery, 
# 	                     JournalQuery=JournalQuery, ConferenceQuery=ConferenceQuery, ResultObjects=ResultObjects, 
# 	                     PublicationContent=PublicationContent, AuthorID=AuthorID, StartIdx=StartIdx, EndIdx=EndIdx,
# 	                     YearStart=YearStart, YearEnd=YearEnd))
# 	out <- content(GET(url, query=args))
  
#   makeoutput <- function(x){
#     authors <- ldply(x$Author, function(x) data.frame(compact(x))[,-1])
#     therest <- compact(x[!names(x) %in% c("Author")])
#     df <- lapply(therest, function(x) data.frame(compact(x)))
#     df_ <- df[!sapply(df, function(x) nrow(x))==0]
#     df_2 <- lapply(df_, function(x) x[, !names(x) %in% c("X__type","X__type.1")])
#     if(length(df_2$Keyword)>1){
#       names(df_2$Keyword) <- sapply(names(df_2$Keyword), function(x) strsplit(x, "\\.")[[1]][[1]], USE.NAMES=F)
#       df_2$Keyword <- 
#         paste0(sapply(df_2$Keyword[names(df_2$Keyword) %in% "Name"], as.character),collapse=",")
#     } else {NULL}
#     if(length(df_2$FullVersionURL)>1){
#       df_2$FullVersionURL <- paste0(df_2$FullVersionURL, collapse=",")
#     }
#     df_2$JournalName <- df_2$Journal$FullName
#     df_2 <- df_2[!names(df_2) %in% "Journal"]
#     df_3 <- do.call(cbind, df_2[!names(df_2) %in% "__type"])
#     list(journal = df_3, authors = authors)
#   }
  
#   if(!is.null(ResultObjects) && ResultObjects == 'Author'){
# #     tt <- out$d$Author$Result[[1]]
#     tt <- out$d$Author$Result
#     tt <- lapply(tt, function(x){lapply(x, function(y){ ifelse(is.null(y), "none", y) }) })    
#     getdata <- function(x){
#       one <- x[c('CitationCount','FirstName','GIndex','HIndex','ID','LastName','MiddleName','PublicationCount')]
#       two <- x$ResearchInterestDomain[[1]][!names(x$ResearchInterestDomain[[1]]) %in% "__type"]
#       list(author=one, domains=two) 
#     }
#     llply(tt, getdata)    
#   } else
#   { 
#     out2 <- llply(out$d$Publication$Result, makeoutput)
#     if(return_ == "all"){ out2 } else
#       if(return_ == "journal"){lapply(out2, function(x) x[["journal"]])} else
#         if(return_ == "authors"){lapply(out2, function(x) x[["authors"]])}
#   }
}