#' Get a record from a OAI-PMH data provider.
#' 
#' Get records for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param identifier The OAI-PMH identifier for the record.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @details To query multiple different identifier's from a single provider, 
#' 		just pass in multiple identifiers like c("identifier1", "identifier2").
#' 		To query identifiers from different providers, just use separate calls to
#' 		md_getrecord.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Single provider, one identifier
#' md_getrecord(provider = "pensoft", identifier = "10.3897/zookeys.1.10")
#' 
#' # Single provider, multiple identifiers
#' md_getrecord(provider = "pensoft", identifier = c("10.3897/zookeys.1.10","10.3897/zookeys.4.57"))
#' }
#' @export
md_getrecord <- function(provider = NULL, identifier = NULL, 
	metadataPrefix = "oai_dc", fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(provider, identifier) {
		args <- compact(list(verb = 'GetRecord', metadataPrefix = metadataPrefix,
											 identifier = identifier))
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
				ldply(crr$GetRecord, function(x) cbind(data.frame(x$header), data.frame(x$metadata)))[,-1]
			}
	}	
	ldply(identifier, function(x) doit(provider, x) )
}