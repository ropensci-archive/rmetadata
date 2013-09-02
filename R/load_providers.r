#' Load an updated cache
#' 
#' @param path location where cache is located. Leaving to NULL loads the version
#' 		in the installed package.
#' @param envir R environment to load data in to.
#' @details Loads the data object providers into the global workspace. 
#' @return loads the object providers into the working space. 
#' @seealso \code{\link{update_providers}}
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @examples \donttest{
#' # By default the new providers table goes to directory ".", so just load from there
#' update_providers() 
#' load_providers(path=".")
#' 
#' # Loads the version in the package
#' load_providers()
#' }
#' @export
load_providers <- function(path=NULL, envir=.GlobalEnv)
{
  if(is.null(path))
  	file <- system.file("data", "providers.rda", package="rmd")
  else {
  	# load the most recent file from the cache
  	files <- list.files(path)
  	copies <- grep("providers.rda", files)
  	most_recent <- files[copies[length(copies)]]
  	file=paste(path, "/", most_recent, sep="")
  }
#   load(file, envir = rmdCache)
  load(file,envir=envir)
#   providers.data <- get("providers", envir = rmdCache)
#   providers.data
}