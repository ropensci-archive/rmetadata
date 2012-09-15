#' Get information on each OAI-PMH data providers. 
#' 
#' Data comes from \link{http://www.openarchives.org/Register/BrowseSites}. Data
#' 		includes oai-identifier (if they have one) and baes URL. The website has
#' 		the name of the data provider too, but not provided in the data pulled 
#' 		down here, but you can grab the name using example below.
#' 
#' @import httr XML 
#' @details This table is scraped from \link{http://www.openarchives.org/Register/BrowseSites}.
#' 		I would get it from \link{http://www.openarchives.org/Register/ListFriends}, 
#' 		but it does not include repository names. 
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' df <- oaipmh_providers()
#' str(df) # wow, that's a lot of OAI-PMH data providers
#' head(df) # take a look
#' oaih_identify(df[1,2]) # Identify the metadata provider
#' 
#' # Visualize the length of the baseURLs for each data provider
#' library(ggplot2)
#' nchars <- data.frame(nchars = sapply(as.character(df$base_url), nchar, USE.NAMES=F))
#' qplot(nchars, data = nchars, geom="histogram")
#' }
#' @export
oaipmh_providers <- function()
{ 
	temp <- content(GET("http://www.openarchives.org/Register/BrowseSites"))
	table <- readHTMLTable("http://www.openarchives.org/Register/BrowseSites")
	table <- table[[2]]
	table <- table[,-c(1,2)] # remove first two columns
	names(table) <- c("repo_name", "base_url", "oai_identifier")
	table
# 	out <- content(GET("http://www.openarchives.org/Register/ListFriends"), as="text")
# 	out2 <- xmlParse(out)
# 	vals <- xpathApply(out2, "//baseURL")
# 	urls <- sapply(vals, xmlValue, USE.NAMES=F)
# 	ids <- sapply(vals, xmlGetAttr, name="id", USE.NAMES=F)
# 	ids <- sapply(ids, function(x) if(is.null(x) == TRUE) {"none"} else{x})
# 	df <- data.frame(oai_identifier = ids, baseURL = urls)
# 	
# 	if(attachnames){
# 		attachname_ <- function(x) {
# 			tt <- try(content(GET(paste(x, "?verb=Identify", sep=""), config = timeout(6))))
# 			if(class(tt)[[1]] == "try-error"){ "no_name_found" } else
# 				{
# 					if( any(grepl("<buffer>", asdf[[1]][[1]])) == TRUE ){ 
# 						"access_forbidden"
# 					} else
# 						{ xmlToList(tt$doc$children[[1]])$Identify$repositoryName }
# 				}
# 		}
# 		df$name <- sapply(df[,2], attachname_)
# 		df
# 	} else
# 		{ df }
}