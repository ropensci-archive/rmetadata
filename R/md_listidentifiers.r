#' List OAI-PMH identifiers for a data provider.
#' 
#' @import OAIHarvester XML rpmc rdatacite rdryad rhindawi rpensoft plyr
#' @param from Specifies that records returned must have been 
#' 		created/update/deleted on or after this date.
#' @param until Specifies that records returned must have been 
#' 		created/update/deleted on or before this date.
#' @param set Optional argument with a setSpec value, which specifies set 
#' 		criteria for selective harvesting.
#' @param prefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param token A token previously provided by the server to resume a request
#'     where it last left off.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_listidentifiers(provider = "datacite", set = "REFQUALITY")
#' md_listidentifiers(provider = "dryad")
#' 
#' # From the Open Archives list
#' providers <- oaipmh_providers() # get from the web
#' data(providers) # or load from local machine
#' md_listidentifiers(provider = "openarchive", url = as.character(providers[1,2]), from='2008-01-15', until = '2008-03-15')
#' }
#' @export
md_listidentifiers <- function(from = NULL, until = NULL, set = NULL, 
		metadataPrefix = 'oai_dc', token = NULL, url = NULL, provider = NULL)
{ 
	args <- compact(list(verb = 'ListIdentifiers', set = set, metadataPrefix = metadataPrefix,
											from = from, until=until, token=token))
	provider_ <- match.arg(provider, 
		choices=c("pmc","datacite","hindawi","dryad","pensoft","openarchive"), several.ok=T)
	doit <- function(url, args) {
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
	
	url_pmc <- "http://www.pubmedcentral.gov/oai/oai.cgi"
	url_pensoft <- "http://oai.pensoft.eu"
	url_dryad <- "http://www.datadryad.org/oai/request"
	url_datacite <- "http://oai.datacite.org/oai"
	url_hindawi <- "http://www.hindawi.com/oai-pmh/oai.aspx"	

# 	if(is.null(url)) stop("Need to specify a URL")
	
	if(provider_ == "datacite" ){ url <- url_datacite } else
		if(provider_ == "pmc" ){ url <- url_datacite } else
			if(provider_ == "hindawi" ){ url <- url_datacite } else
				if(provider_ == "dryad" ){ url <- url_datacite } else
					if(provider_ == "pensoft" ){ url <- url_datacite } else
						if(provider_ == "openarchive" ){ url <- url } else
							stop("error, something wrong with the provided URL")
							
	doit(url, args)
}