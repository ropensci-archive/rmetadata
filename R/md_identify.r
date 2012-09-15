#' Identify the OAI-PMH service for each data provider.
#' 
#' Identifies the data sources: PMC, DataCite, Hindawi Journals, 
#' 		Dryad, and Pensoft Journals.
#' 
#' @import OAIHarvester rpmc rdatacite rhindawi rdryad rpensoft plyr
#' @examples \dontrun{
#' # All providers
#' md_identify()
#' 
#' # Just the providers you want to identify
#' md_identify(provider = "datacite")
#' md_identify(provider = "da") # abbreviating the provider works too
#' md_identify(provider = c("datacite","pensoft")) # many providers
#' 
#' # From the Open Archives list
#' df <- oaipmh_providers()
#' md_identify(provider = "openarchive", url = as.character(df[1,2]))
#' }
#' @export
md_identify <- function(provider = NULL, url = NULL) 
{ 	
# 	url_pmc <- "http://www.pubmedcentral.gov/oai/oai.cgi"
# 	url_pensoft <- "http://oai.pensoft.eu"
# 	url_dryad <- "http://www.datadryad.org/oai/request"
# 	url_datacite <- "http://oai.datacite.org/oai"
# 	url_hindawi <- "http://www.hindawi.com/oai-pmh/oai.aspx"		
	if(provider_ == "datacite" ){ url <- url_datacite } else
		if(provider_ == "pmc" ){ url <- url_datacite } else
			if(provider_ == "hindawi" ){ url <- url_datacite } else
				if(provider_ == "dryad" ){ url <- url_datacite } else
					if(provider_ == "pensoft" ){ url <- url_datacite } else
						if(provider_ == "openarchive" ){ url <- url } else
							stop("error, something wrong with the provided URL")
	
	provider_ <- match.arg(provider, 
			choices=c("pmc","datacite","hindawi","dryad","pensoft","openarchive"), several.ok=T)
	
	doit <- function(x) {
		args <- compact(list(verb = 'Identify'))
		xmlToList(xmlParse(content(GET(x, query=args), as="text")))$Identify
	}
	
	tt <- llply(url, doit)
	ldply(tt, function(x) data.frame(t(as.matrix(x))))
}