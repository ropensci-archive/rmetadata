#' Update the locally stored OAI-PMH data providers table. 
#' 
#' Data comes from \url{http://www.openarchives.org/Register/BrowseSites}. 
#' 		Data includes oai-identifier (if they have one) and baes URL. The website has
#' 		the name of the data provider too, but not provided in the data pulled 
#' 		down here, but you can grab the name using example below.
#' 
#' @import httr XML 
#' @details This table is scraped from 
#' 		\url{http://www.openarchives.org/Register/BrowseSites}.
#' 		I would get it from \url{http://www.openarchives.org/Register/ListFriends}, 
#' 		but it does not include repository names. 
#' 		
#' 		This function updates the table for you. Does take a while though, so 
#' 		go get a coffee.
#' @param path Path to put data in.
#' @seealso \code{\link{load_providers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \donttest{
#' update_providers()
#' load_providers()
#' }
#' @export
update_providers <- function(path=".")
{ 
	date <- Sys.Date()
	temp <- content(GET("http://www.openarchives.org/Register/BrowseSites"))
	providers <- readHTMLTable("http://www.openarchives.org/Register/BrowseSites")
	providers <- providers[[2]] # get second table
	providers <- providers[,-c(1,2)] # remove first two columns
	names(providers) <- c("repo_name", "base_url", "oai_identifier")
	save(providers, file=paste(path, "/", date, "-providers.rda", sep=""))
}