#' Get a record from a OAI-PMH data provider.
#' 
#' Get records for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param identifier The OAI-PMH identifier for the record.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @param brief Give brief results (just a subset of columns)
#' @details To query multiple different identifier's from a single provider, 
#' 		just pass in multiple identifiers like c("identifier1", "identifier2").
#' 		To query identifiers from different providers, just use separate calls to
#' 		md_getrecord.
#' @seealso \code{\link{md_identify}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_listrecords}}, 
#' 		\code{\link{md_listsets}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Single provider, one identifier
#' md_getrecord(provider = "pensoft", identifier = "10.3897/zookeys.1.10")
#' 
#' # Single provider, multiple identifiers
#' md_getrecord(provider = "pensoft", identifier = c("10.3897/zookeys.1.10","10.3897/zookeys.4.57"))
#' 
#' # More than one provider found - or just easier than typing in the whole provider name - Choose 15
#' md_getrecord(provider = "advances", identifier = "oai:ojs.www.academypublisher.com:article/5460", fuzzy=TRUE)
#' }
#' @export
md_getrecord <- function(provider = NULL, identifier = NULL, 
	metadataPrefix = "oai_dc", fuzzy = FALSE, brief = TRUE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	doit <- function(provider, identifier) {
		args <- compact(list(verb = 'GetRecord', metadataPrefix = metadataPrefix,
											 identifier = identifier))
		if(fuzzy){ get_ <- providers[ agrep(provider, providers[,1]), ] } else
			{ get_ <- providers[ grep(provider, providers[,1]), ] }
		if(nrow(get_) == 0){
			stop("\nNo match found!\n")
		} else
			if(nrow(get_) > 1){ 		
				# user prompt
					# sort alphabetically
					get_df <- get_[order(get_$repo_name), ]
					rownames(get_df) <- 1:nrow(get_df)
					
					# prompt
					cat("\n\n")
					print(data.frame(get_df$repo_name))
					cat("\nMore than one match found for provider '", provider, "'!\n
          Enter row number of provider (other inputs will return 'NA'):\n") # prompt
					take <- scan(n = 1, quiet = TRUE, what = 'raw')
      		
					# Get base url to use
					if(length(take) == 0)
						stop(paste("\nYou need to type in a number from 1 to ",nrow(get_df),'\n',sep=''))
					if(take %in% seq_len(nrow(get_df))){
						take <- as.numeric(take)
						cat("Input accepted, took provider '", as.character(get_df$repo_name[take]), "'.\n")
						url <-  get_df$base_url[take]
					} else { stop("\nNo match found!\n") }
      
			} else
				{ url <- get_[,"base_url"] }
		
		crr <- xmlToList(xmlParse(content(GET(url, query=args), as="text")))
		temp <- crr$GetRecord$record$metadata$dc
		temp[sapply(temp, is.null)] <- "none"
		temp <- temp[!names(temp) %in% '.attrs']
		temp2 <- data.frame(temp)			
		if(brief){ temp2[names(temp2) %in% c('title','creator','date','type')] } else
			{ temp2 }
	}	
	ldply(identifier, function(x) doit(provider, x) )
}