#' List the OAI-PMH sets for each data provider.
#' 
#' @import OAIHarvester rpmc rdatacite rdryad rhindawi XML
#' @examples \dontrun{
#' out <- md_listsets()
#' head(out); str(out) # details
#' out[out$datasource == "dryad",] # just dryad
#' }
#' @export
md_listsets <- function() 
{ 
	rpmc_ <- rpmc::listsets()
	rdatacite_ <- rdatacite::listsets()
	rhindawi_ <- rhindawi::listsets()
	rdryad_ <- rdryad::listsets()
	df <- ldply(list(rpmc_, rdatacite_, rhindawi_, rdryad_))
	df$datasource <- 
		as.factor(c(rep("pmc", nrow(rpmc_)), 
			rep("datacite", nrow(rdatacite_)),
			rep("hindawi", nrow(rhindawi_)),
			rep("dryad", nrow(rdryad_))
		))
	df
}