#' Count OAI-PMH identifiers for a data provider.
#' 
#' Count identifiers for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Select a few
#' count_identifiers(provider = c("datacite","Academic Commons","pensoft","arXiv"))
#' 
#' # Provide a vector
#' out <- count_identifiers(provider = providers[1:40,2], useurl = T)
#' }
#' @export
count_identifiers <- function(provider = NULL, metadataPrefix = 'oai_dc', 
		fuzzy = FALSE, useurl = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	args <- compact(list(verb = 'ListIdentifiers', metadataPrefix = metadataPrefix))
	
	doit <- function(x, args) {
		if(useurl == TRUE){ url <- x } else
		{
			if(fuzzy){ get_ <- providers[ agrep(x, providers[,1], ...), ] } else
				{ get_ <- providers[ grep(x, providers[,1]), ] }
			if(nrow(get_) == 0){ data.frame(x="no match found") } else
				if(nrow(get_) > 1){  data.frame(repo_name = get_[,1]) } else 
					{ url <- get_[,"base_url"] }
		}
			mm <- GET(url)[[4]]$`content-type`
			nn <- strsplit(mm, ";")[[1]][[1]]
			if(nn == "text/html") { "not provided" } else 
				if(nn == "text/xml") {
					tt <- try(xmlToList(xmlParse(content(GET(url, query=args), as="text")))$ListIdentifiers$resumptionToken$.attrs[["completeListSize"]])
					if(class(tt)=="try-error"){ "not provided" } else {
						if(is.null(tt)==TRUE) { "not provided" } else { tt }
					}
			} else { "bad content type" }
	}	
	dd <- sapply(provider, function(x) doit(x, args) , USE.NAMES=F)
	if(useurl){ provider <- providers[providers$base_url %in% provider, 1]} else {provider <- provider}
	data.frame(provider = provider, count = dd)
}