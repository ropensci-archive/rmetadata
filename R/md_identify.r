#' Identify the OAI-PMH service for each data provider.
#' 
#' Identifies the data sources from the OAI-PMH list, and others not on that list, 
#' 		including PMC, DataCite, Hindawi Journals, Dryad, and Pensoft Journals.
#' 
#' @import plyr httr XML
#' @param provider The metadata provider to identify.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @param ... further arguments passed on to agrep (only used when fuzzy
#' 		 equals TRUE). 
#' @seealso \code{\link{md_getrecord}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_listsets}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_identify(provider = "datacite")
#' md_identify(provider = c("datacite","pensoft")) # many providers
#' md_identify(provider = "arXiv") # arXiv
#' md_identify(provider = c("harvard", "journal")) # no match for one, two matches for other
#' md_identify(provider = c("data", "theory", "biology"))
#' md_identify(provider = "Takasu database") # refine previous for data
#' 
#' # Using fuzzy match
#' md_identify(provider = "biology", fuzzy=TRUE)
#' }
#' @export
md_identify <- function(provider = NULL, fuzzy = FALSE, ...) 
{
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(x) {
		if(fuzzy){ get_ <- providers[ agrep(x, providers[,1]), ] } else
			{ get_ <- providers[ grep(x, providers[,1]), ] }
		if(nrow(get_) == 0){
			stop("\nNo match found!\n")
		} else
			if(nrow(get_) > 1){ 
				# user prompt
					# sort alphabetically
					get_df <- get_[order(get_$repo_name), ]
					rownames(get_df) <- 1:nrow(get_df)
					
					# prompt
					cat("\n\n")
					print(data.frame(get_df$repo_name))
					cat("\nMore than one match found for provider '", provider, "'!\n
          Enter row number of provider (other inputs will return 'NA'):\n") # prompt
					take <- scan(n = 1, quiet = TRUE, what = 'raw')
      		
					# Get base url to use
					if(length(take) == 0)
						stop(paste("\nYou need to type in a number from 1 to ",nrow(get_df),'\n',sep=''))
					if(take %in% seq_len(nrow(get_df))){
						take <- as.numeric(take)
						cat("Input accepted, took provider '", as.character(get_df$repo_name[take]), "'.\n")
						url <-  get_df$base_url[take]
					} else { stop("\nNo match found!\n") }
			} else
				{ url <- get_[,"base_url"] }
		args <- list(verb = "Identify")
		xmlToList(xmlParse(content(GET(url, query=args), as="text")))$Identify
	}
	
	tt <- llply(provider, doit)
	if(class(tt[[1]])=="data.frame"){ 
		names(tt) <- provider
		tt
	} else 
		{ ldply(tt, function(x) data.frame(t(as.matrix(x)))) }	
}