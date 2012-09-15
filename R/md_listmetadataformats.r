#' List available metadata formats from various providers.
#' 
#' @import OAIHarvester rpmc rdatacite rdryad rhindawi rpensoft
#' @param id ID for the article/dataset. 
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' md_listmetadataformats()
#' }
#' @export
md_listmetadataformats <- function(provider = c("pmc","datacite","hindawi","dryad"), 
	id = NULL)
{ 
	providers <- match.arg(provider, choices=c("pmc","datacite","hindawi","dryad"), several.ok=T)
	foo <- function(x) {
		if(x == "datacite" ){
			tt <- data.frame(dc_listmetadataformats())
			data.frame(id = rep(x,nrow(tt)), tt)
		} else
			if(x == "pmc" ){
				tt <- data.frame(pmc_listmetadataformats())
				data.frame(id = rep(x,nrow(tt)), tt)
			} else
				if(x == "dryad" ){
					y <- t(dr_listmetadataformats())
					row.names(y) <- NULL
					tt <- data.frame(y)
					data.frame(id = rep(x,nrow(tt)), tt)
				} else
					if(x == "hindawi" ){
						tt <- data.frame(hw_listmetadataformats())
						data.frame(id = rep(x,nrow(tt)), tt)
					} else
						stop("Must be one of datacite, pmc, dryad, or hindawi")
	}
	ldply(providers, foo)
}