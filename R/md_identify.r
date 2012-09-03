#' Identify the OAI-PMH service for each dat provider.
#' 
#' @import OAIHarvester rpmc rdatacite rdryad rhindawi
#' @examples \dontrun{
#' md_identify()
#' }
#' @export
md_identify <- function() 
{ 
	out1 <- rpmc::identify()
	out2 <- rdatacite::identify()
	out3 <- rhindawi::identify()
	out4 <- rdryad::identify()$Identify
	outall <- llply(list(out1, out2, out3, out4), function(x) data.frame(t(as.matrix(x))))
	rbind.fill(outall[[1]], outall[[2]], outall[[3]], outall[[4]])
}