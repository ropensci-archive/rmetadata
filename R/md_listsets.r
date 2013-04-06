#' List the OAI-PMH sets for each data provider.
#' 
#' List sets for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import plyr httr XML
#' @param provider The metadata provider.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @seealso \code{\link{md_identify}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_getrecord}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_listsets(provider = "datacite") # DataCite
#' md_listsets(provider = "arXiv") # arXiv
#' 
#' # Many providers
#' md_listsets(provider = c("datacite","pensoft","Aston University Research Archive"))
#' 
#' # Fuzzy search
#' md_listsets(provider = "biology", fuzzy=TRUE)
#' }
#' @export
md_listsets <- function(provider = NULL, fuzzy = FALSE) 
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
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
					
		args <- list(verb = "ListSets")
		iter <- 0
		token <- "characters" # define a iterator, also used for gettingn the resumptionToken
		nameslist <- list() # define empty list to put joural titles in to
		while(is.character(token) == TRUE) # while token is class "character", keep going
		{
			iter <- iter + 1 
			args2 <- args
			if(token == "characters"){NULL} else {args2$resumptionToken <- token}
			crr <- xmlToList(xmlParse(content(GET(url, query=args2), as="text")))
			out <- ldply(crr$ListSets, function(x) c(setName=x[["setName"]], setSpec=x[["setSpec"]]))[,-1]
			nameslist[[iter]] <- out
			if( class( try(crr$ListSets$resumptionToken$text) ) == "try-error") {
				token <- 1
			} else { token <- crr$ListIdentifiers$resumptionToken$text }
		}
		do.call(rbind, nameslist) # concatenate
	}
	llply(provider, function(x) doit(x, args) )
}