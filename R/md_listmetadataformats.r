#' List available metadata formats from various providers.
#' 
#' List metadata formats for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param identifier The OAI-PMH identifier for the record. Optional.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @param seconds Number of seconds to wait for call to complete. 
#' @seealso \code{\link{md_identify}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_getrecord}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_listsets}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # List metadata formats for a provider
#' md_listmetadataformats(provider = "dryad")
#' 
#' # List metadata formats for a specific identifier for a provider
#' md_listmetadataformats(provider = "pensoft", identifier = "10.3897/zookeys.1.10")
#' 
#' # Fuzzy search
#' md_listmetadataformats(provider = "biology", fuzzy=TRUE)
#' md_listmetadataformats(provider = "AnimalPhysiology-LivestockSystems")
#' }
#' @export
md_listmetadataformats <- function(provider = NULL, identifier = NULL, 
																	 fuzzy = FALSE, seconds = 3)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(provider, identifier=NULL) {
		args <- compact(list(verb = 'ListMetadataFormats', identifier = identifier))
		if(fuzzy){ get_ <- providers[ agrep(provider, providers[,1]), ] } else
			{ get_ <- providers[ grep(provider, providers[,1]), ] }
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
				} else { url <- get_[,"base_url"] }
		
		ss <- tryCatch(content(GET(url, query=args, config=timeout(seconds)), as="text"), error = function(e) e$message)
		if(ss == "connect() timed out!"){ message("Connection timed out - try larger seconds arg, or url may be down") } else
		{
			crr <- xmlToList(xmlParse(ss))
			if(!is.null(identifier)) { 
				id <- crr$request$.attrs[[2]] 
				df_ <- ldply(crr$ListMetadataFormats, function(x) data.frame(x))[,-1]
				data.frame(identifier = rep(id, nrow(df_)), df_)
			} else
			{ 
				ldply(crr$ListMetadataFormats, function(x) data.frame(x))[,-1]
			}
		}
	}

	if(!is.null(identifier)) {
		ldply(identifier, function(x) doit(provider, x) )
	} else
		{
			doit(provider=provider)
		}
}