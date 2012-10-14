\name{crossref_search}
\alias{crossref_search}
\title{Search the CrossRef Metatdata API.}
\usage{
  crossref_search(query, doi = NULL, page = NULL,
    rows = NULL, sort = NULL, year = NULL,
    url = "http://search.labs.crossref.org/dois")
}
\arguments{
  \item{query}{Query terms.}

  \item{doi}{Search by a single DOI or many DOIs.}

  \item{page}{Page to return from results.}

  \item{rows}{Number of records to return.}

  \item{sort}{Sort either by "score" or "year".}

  \item{year}{Year to search.}

  \item{url}{Base url for the Crossref metadata API.}
}
\description{
  Search the CrossRef Metatdata API.
}
\examples{
\dontrun{
crossref_search(query = c("renear", "palmer"))

# limit to 4 results
crossref_search(query = c("renear", "palmer"), rows = 4)

# get more results than standard
crossref_search(query = c("renear", "palmer"), rows = 40)

# sort results by score
crossref_search(query = c("renear", "palmer"), rows = 10, sort = "score")

# sort results by year
crossref_search(query = c("renear", "palmer"), rows = 10, sort = "year")

# get results for a certain year
crossref_search(query = c("renear", "palmer"), year = 2010)

# search by a single DOI
crossref_search(doi = "10.1890/10-0340.1")

# search for many DOI's
crossref_search(doi = c("10.1890/10-0340.1","10.1016/j.fbr.2012.01.001","10.1111/j.1469-8137.2012.04121.x"))
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}

