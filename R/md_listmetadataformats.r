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
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # List metadata formats for a provider
#' md_listmetadataformats(provider = "dryad")
#' 
#' # List metadata formats for a provider
#' md_listmetadataformats(provider = "pensoft", identifier = "10.3897/zookeys.1.10")
#' }
#' @export
md_listmetadataformats <- function(provider = NULL, identifier = NULL, fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(provider, identifier) {
		args <- compact(list(verb = 'ListMetadataFormats', identifier = identifier))
		if(fuzzy){ get_ <- providers[ agrep(provider, providers[,1], ...), ] } else
			{ get_ <- providers[ grep(provider, providers[,1]), ] }
		if(nrow(get_) == 0){
			data.frame(x="no match found")
		} else
			if(nrow(get_) > 1){ 
				data.frame(repo_name = get_[,1])
			} else
				{
					url <- get_[,"base_url"]
					crr <- xmlToList(xmlParse(content(GET(url, query=args), as="text")))
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
			doit(provider, NULL)
		}
}