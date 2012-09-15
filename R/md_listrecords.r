#' List records of an OAI-PMH from a data provider.
#' 
#' List records for the data sources from the OAI-PMH list, and others not 
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
#' # Single source
#' md_listrecords(provider = "datacite")
#' }
#' @export
md_listrecords <- function(provider = NULL, from = NULL, until = NULL, 
	set = NULL, metadataPrefix = 'oai_dc', token = NULL, fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	args <- compact(list(verb = 'ListRecords', set = set, metadataPrefix = metadataPrefix,
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
					names <- llply(crr$ListRecords)
					nameslist[[iter]] <- ldply(names, function(x) cbind(data.frame(x$header), data.frame(x$metadata$dc)))
					if( class( try(crr$ListRecords$resumptionToken$text) ) == "try-error") {
						token <- 1
					} else { token <- crr$ListRecords$resumptionToken$text }
				}
				do.call(rbind, nameslist) # concatenate
			}
	}	
	llply(provider, function(x) doit(x, args) )
}