\name{cambridge_search}
\alias{cambridge_search}
\title{Search Cambridge journals metadata.}
\usage{
  cambridge_search(query = NULL, callopts = list())
}
\arguments{
  \item{query}{Query string}

  \item{callopts}{curl options passed on to GET call}
}
\description{
  Search Cambridge journals metadata.
}
\examples{
\dontrun{
# Basic metadata search
out <- cambridge_search(query="history")
out

# Get certain fields
out[,c('creator','pages')]

# Go the web page for an article
browseURL(as.character(out[,c('url')][[1]]))
}
}
\keyword{cambridge}

