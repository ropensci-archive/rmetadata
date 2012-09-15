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
#' @examples \dontrun{
#' md_identify(provider = "datacite")
#' md_identify(provider = c("datacite","pensoft")) # many providers
#' md_identify(provider = "arXiv") # arXiv
#' md_identify(provider = c("harvard", "journal")) # no match for one, two matches for other
#' md_identify(provider = c("data", "theory", "biology"))
#' md_identify(provider = "Takasu database") # refine previous for data
#' }
#' @export
md_identify <- function(provider = NULL, fuzzy = FALSE, ...) 
{
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(x) {
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
					args <- list(verb = "Identify")
					xmlToList(xmlParse(content(GET(url, query=args), as="text")))$Identify
				}
	}
	
	tt <- llply(provider, doit)
	if(class(tt[[1]])=="data.frame"){ 
		names(tt) <- provider
		tt
	} else 
		{ ldply(tt, function(x) data.frame(t(as.matrix(x)))) }	
}