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
#' @param token A token previously provided by the server to resume a request
#'     where it last left off.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_listidentifiers(provider = "datacite", set = "REFQUALITY")
#' md_listidentifiers(provider = "dryad", from = "2012-07-15")
#' md_listidentifiers(provider = c("datacite","pensoft"), from = "2012-07-15") # many providers
#' 
#' # From the Open Archives list
#' md_listidentifiers("arXiv", from='2008-01-15', until = '2008-01-30')
#' }
#' @export
md_listidentifiers <- function(provider = NULL, from = NULL, until = NULL, 
	set = NULL, metadataPrefix = 'oai_dc', token = NULL, fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	args <- compact(list(verb = 'ListIdentifiers', set = set, metadataPrefix = metadataPrefix,
											from = from, until=until, token=token))
	
	doit <- function(x, args) {
		if(fuzzy){ get_ <- providers[ agrep(x, providers[,1], ...), ] } else
			{ get_ <- providers[ grep(x, providers[,1]), ] }
		if(nrow(get_) == 0){
			data.frame(x="no match found")
		} else
			if(nrow(get_) > 1){ 
				data.frame(repo_name = get_[,1])
			} else
				{
					url <- get_[,"base_url"]
					iter <- 0
					token <- "characters" # define a iterator, also used for gettingn the resumptionToken
					nameslist <- list() # define empty list to put joural titles in to
					while(is.character(token) == TRUE) # while token is class "character", keep going
					{
						iter <- iter + 1 
						args2 <- args
						if(token == "characters"){NULL} else {args2$resumptionToken <- token}
						crr <- xmlToList(xmlParse(content(GET(url, query=args2), as="text")))
						names <- as.character(sapply(crr$ListIdentifiers, function(x) x[["identifier"]]))
						nameslist[[iter]] <- names
						if( class( try(crr$ListIdentifiers$resumptionToken$text) ) == "try-error") {
							token <- 1
						} else { token <- crr$ListIdentifiers$resumptionToken$text }
					}
					out <- do.call(c, nameslist) # concatenate
					out[!out == "NULL"] # remove NULLs
				}
	}	
	llply(provider, function(x) doit(x, args) )
}