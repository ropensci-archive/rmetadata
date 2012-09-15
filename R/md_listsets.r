#' List the OAI-PMH sets for each data provider.
#' 
#' List sets for the data sources: PMC, DataCite, Hindawi Journals, 
#' 		Dryad, and Pensoft Journals.
#' 
#' @import OAIHarvester rpmc rdatacite rdryad rhindawi XML plyr
#' @examples \dontrun{
#' # All providers
#' out <- md_listsets()
#' head(out); str(out) # details
#' out[out$datasource == "dryad",] # just dryad
#' 
#' # Select providers
#' out <- md_listsets(provider = c("hindawi", "dryad"))
#' head(out)
#' }
#' @export
md_listsets <- function(provider = c("pmc","datacite","hindawi","dryad","pensoft")) 
{ 
	providers <- match.arg(provider, choices=c("pmc","datacite","hindawi","dryad","pensoft"), several.ok=T)
	foo <- function(x) {
		if(x == "datacite" ){
			temp <- dc_listsets()
			temp$datsource <- as.factor(rep("datacite", nrow(temp)))
			temp
		} else
			if(x == "pmc" ){
				temp <- pmc_listsets()
				temp$datsource <- as.factor(rep("pmc", nrow(temp)))
				temp
			} else
				if(x == "dryad" ){
					temp <- dr_listsets()
					temp$datsource <- as.factor(rep("dryad", nrow(temp)))
					temp
				} else
					if(x == "hindawi" ){
						temp <- hw_listsets()
						temp$datsource <- as.factor(rep("hindawi", nrow(temp)))
						temp
					} else
							stop("Must be one of datacite, pmc, dryad, or hindawi")
	}
	ldply(providers, foo)	
}