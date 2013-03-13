\name{short_doi}
\alias{short_doi}
\title{Get a random set of DOI's through CrossRef.}
\usage{
  short_doi(doi = NULL, justshort = TRUE)
}
\arguments{
  \item{doi}{A long-form DOI.}

  \item{justshort}{If TRUE, return just the short DOI. If
  false, the short DOI, the submitted long-form DOI, and
  whether the short DOI is new.}
}
\value{
  Either the short DOI or the submitted DOI, the short DOI,
  and whether it is a new short DOI or not.
}
\description{
  Get a random set of DOI's through CrossRef.
}
\details{
  See here \url{http://shortdoi.org/} for more information.
}
\examples{
\dontrun{
# Geta a short DOI, just the short DOI returned
short_doi(doi = "10.1371/journal.pone.0042793")
short_doi(doi = "10.1890/10-0340.1")

# Geta a short DOI, all data returned
short_doi(doi = "10.1371/journal.pone.0042793", justshort=FALSE)
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{crossref_search}},
  \code{\link{crossref_citation}},
  \code{\link{crossref_search_free}}
}

