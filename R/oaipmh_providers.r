#' Get data.frame of OAI-PMH data providers. 
#' 
#' Data comes from \link{http://www.openarchives.org/Register/BrowseSites}. Data
#' 		includes oai-identifier (if they have one) and baes URL. 
#' 
#' @import httr XML OAIHarvester
#' @details There is an old version of the list of providers stored in 
#' 		this package. Call X to see it.  However, you should update the list
#' 		if you want the most updated list by running X.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' df <- oaipmh_providers()
#' str(df) # wow, that's a lot of OAI-PMH data providers
#' head(df) # take a look
#' oaih_identify(df[1,2]) # identify the metadata provider
#' }
#' @export
oaipmh_providers <- function()
{ 
	out <- content(GET("http://www.openarchives.org/Register/ListFriends"), as="text")
	out2 <- xmlParse(out)
	vals <- xpathApply(out2, "//baseURL")
	urls <- sapply(vals, xmlValue, USE.NAMES=F)
	ids <- sapply(vals, xmlGetAttr, name="id", USE.NAMES=F)
	ids <- sapply(ids, function(x) if(is.null(x) == TRUE) {"none"} else{x})
	data.frame(oai_identifier = ids, baseURL = urls)
}