#' List the OAI-PMH sets for each data provider.
#' 
#' List sets for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import plyr httr XML
#' @param provider The metadata provider.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @examples \dontrun{
#' md_listsets(provider = "datacite") # DataCite
#' md_listsets(provider = "arXiv") # arXiv
#' md_listsets(provider = c("datacite","pensoft","Aston University Research Archive")) # many providers
#' }
#' @export
md_listsets <- function(provider = NULL, fuzzy = FALSE) 
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
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
	}
	llply(provider, function(x) doit(x, args) )
}