#' Get a record via OAI-PMH from a data provider.
#' 
#' @import OAIHarvester XML rpmc rdatacite rdryad rhindawi rpensoft
#' @param df A data.frame of two columns, named "datasource" and "id". 
#' 		df does not have to be supplied. 
#' @param datasource Datasource, currently one of: "datacite", "pmc", "dryad", 
#' 		"hindawi", or "pensoft".
#' @param id ID for the article/dataset. 
#' @param todf Convert output to a data.frame (logical). 
#' @details The function takes a data.frame as input, or just one set of 
#' 		datasource and id specified in the function call. So the function can be used 
#' 		to do more than one call by supplying a data.frame or by supplying one 
#' 		pair of datasource and id at a time in a lapply type call.
#' @author Scott Chamberlain \link{myrmecocystus@@gmail.com}
#' @examples \dontrun{
#' # Single source
#' md_getrecord(datasource = "pensoft", id = "10.3897/zookeys.1.10")
#' 
#' # Many sources. Submit a data.frame to the function:
#' df <- data.frame(datasource = c('datacite','pmc','pensoft'), id = c(56225, 152494, "10.3897/zookeys.1.10"))
#' md_getrecord(df = df, todf=F) # list output
#' md_getrecord(df = df) # data.frame output
#' }
#' @export
md_getrecord <- function(datasource = NULL, id = NULL, df = NULL, 
	todf = TRUE)
{ 
	if(is.null(df) == TRUE){
		df2 <- data.frame(datasource, id)
	} else
		{ df2 <- df }
	
	getrecord_ <- function(x) {
		datasource2 <- match.arg(as.character(x$datasource), choices = c("datacite","dryad","pmc","hindawi","pensoft"))
		if(datasource2 == "datacite" ){
			rdatacite::getrecord(x$id, TRUE)
		} else
			if(datasource2 == "pmc" ){
				rpmc::getrecord(x$id, TRUE)
			} else
				if(datasource2 == "dryad" ){
					rdryad::getrecord(x$id, TRUE)
				} else
					if(datasource2 == "hindawi" ){
						rhindawi::getrecord(x$id, TRUE)
					} else
						if(datasource2 == "pensoft" ){
							rpensoft::getrecord(x$id, TRUE)
						} else
						stop("Must be one of datacite, pmc, dryad, hindawi, or pensoft")
	}
	if(nrow(df2) > 1){
		tt <- llply(split(df2, row.names(df2)), getrecord_)
	} else
	 { tt <- getrecord_(df2) }
	
	if(todf == TRUE){
		if(nrow(df2) > 1){
			do.call(rbind.fill, llply(tt, function(x) data.frame(xmlToList(x$metadata))))
		} else
		{ data.frame(xmlToList(tt$metadata)) }
	} else
	 { tt }
}