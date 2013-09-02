#' List records of an OAI-PMH from a data provider.
#' 
#' List records for the data sources from the OAI-PMH list, and others not 
#' 		on that list, including PMC, DataCite, Hindawi Journals, Dryad, and 
#' 		Pensoft Journals.
#' 
#' @import XML httr plyr
#' @param provider The metadata provider.
#' @param from Specifies that records returned must have been 
#' 		created/update/deleted on or after this date.
#' @param until Specifies that records returned must have been 
#' 		created/update/deleted on or before this date.
#' @param set Optional argument with a setSpec value, which specifies set 
#' 		criteria for selective harvesting.
#' @param metadataPrefix Specifies the metadata format that the records will be 
#'     returned in. 
#' @param token A token previously provided by the server to resume a request
#'     where it last left off.
#' @param fuzzy Do fuzzy search or not (default FALSE). Fuzzy uses agrep.
#' @seealso \code{\link{md_identify}}, \code{\link{md_listidentifiers}}, 
#' 		\code{\link{md_listmetadataformats}}, \code{\link{md_getrecord}}, 
#' 		\code{\link{md_listsets}}, \code{\link{count_identifiers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Single source
#' md_listrecords(provider = "datacite")
#' 
#' # Fuzzy seaerch, take 3
#' md_listrecords(provider = "biology", fuzzy=TRUE)
#' }
#' @export
md_listrecords <- function(provider = NULL, from = NULL, until = NULL, 
	set = NULL, metadataPrefix = 'oai_dc', token = NULL, fuzzy = FALSE)
{ 
	if(exists(as.character(substitute(providers)))==TRUE){ NULL } else
		{ data(providers); message("loaded providers") }
	
	args <- compact(list(verb = 'ListRecords', set = set, metadataPrefix = metadataPrefix,
											 from = from, until=until, token=token))

	doit <- function(x, args) {
		if(fuzzy){ get_ <- providers[ agrep(x, providers[,1]), ] } else
			{ get_ <- providers[ grep(x, providers[,1]), ] }
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
				
				iter <- 0
				token <- "characters" # define a iterator, also used for gettingn the resumptionToken
				nameslist <- list() # define empty list to put joural titles in to
				while(is.character(token) == TRUE) # while token is class "character", keep going
				{
					iter <- iter + 1 
					args2 <- args
					if(token == "characters"){NULL} else {args2$resumptionToken <- token}
					crr <- xmlToList(xmlParse(content(GET(url, query=args2), as="text")))
					names2 <- llply(crr$ListRecords)
					names2 <- names2[!names(names2) %in% "resumptionToken"]
# 					nameslist[[iter]] <- ldply(names, function(x) cbind(data.frame(x$header), data.frame(x$metadata$dc)))					
# 					tt <- sapply(llply(names, function(x) x$metadata$dc)[[1]], function(x) length(nchar(x)))
					
					shit <- function(x){
						tt = x$metadata$dc
						uu = sapply(tt, function(x) length(nchar(x)))
						tt[uu %in% 0] <- "none"
						xx = tt[names(tt) %in% c('title','creator','publisher','date','type','identifier')]
						yy = xx[-length(xx)]
						singlecre <- paste0(yy[names(yy) %in% "creator"],collapse=";")
						yytemp <- yy[!names(yy) %in% "creator"]
						yytemp$creator <- singlecre
						data.frame(yytemp)
					}
					
					out <- ldply(names2, shit)
					nameslist[[iter]] <- out
# 					nameslist[[iter]] <- ldply(names, function(x) data.frame(x$metadata$dc))
					if( class( try(crr$ListRecords$resumptionToken$text) ) == "try-error") {
						token <- 1
					} else { token <- crr$ListRecords$resumptionToken$text }
				}
				do.call(rbind, nameslist) # concatenate
	}	
	llply(provider, function(x) doit(x, args) )
}