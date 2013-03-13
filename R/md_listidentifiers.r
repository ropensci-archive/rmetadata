#' List OAI-PMH identifiers for a data provider.
#' 
#' List identifiers for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param from Specifies that records returned must have been 
#' 		created/update/deleted on or after this date.
#' @param until Specifies that records returned must have been 
#' 		created/update/deleted on or before this date.
#' @param set Optional argument with a setSpec value, which specifies set 
#' 		criteria for selective harvesting.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @seealso \code{\link{md_identify}}, \code{\link{md_getrecord}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_listsets}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_listidentifiers(provider = "dryad", from = "2012-12-15")
#' }
#' 
#' @examples \donttest{
#' # Fuzzy search
#' md_listidentifiers(provider = "biology", from='2008-01-15', until = '2008-01-30', fuzzy=TRUE)
#' }
#' @export
md_listidentifiers <- function(provider = NULL, from = NULL, until = NULL, 
	set = NULL, metadataPrefix = 'oai_dc', fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	args <- compact(list(verb = 'ListIdentifiers', set = set, metadataPrefix = metadataPrefix,
											from = from, until=until))
	
# 	x <- provider
	doit <- function(x, args) {
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
		iter <- 0
		token <- "characters" # define a iterator, also used for gettingn the resumptionToken
		nameslist <- list() # define empty list to put joural titles in to
		while(is.character(token) == TRUE) # while token is class "character", keep going
		{
			iter <- iter + 1
			args2 <- args
			if(token == "characters"){NULL} else {args2$resumptionToken <- token}
			crr <- xmlToList(xmlParse(content(GET(url, query=args2), as="text")))
			names <- tryCatch(as.character(sapply(crr$ListIdentifiers, function(x) x[["identifier"]])))
			if(identical(names, character(0))) {nameslist <- names} else {
				nameslist[[iter]] <- names
				if( class( try(crr$ListIdentifiers$resumptionToken$text) ) == "try-error") {
					token <- 1
				} else { token <- crr$ListIdentifiers$resumptionToken$text }
			}
		}
		out <- do.call(c, nameslist) # concatenate
		out[!out == "NULL"] # remove NULLs
	}	
	llply(provider, function(x) doit(x, args) )
}