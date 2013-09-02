\name{count_identifiers}
\alias{count_identifiers}
\title{Count OAI-PMH identifiers for a data provider.}
\usage{
  count_identifiers(provider = NULL,
    metadataPrefix = "oai_dc", fuzzy = FALSE,
    useurl = FALSE, seconds = 3)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{metadataPrefix}{Specifies the metadata format that
  the records will be returned in.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}

  \item{useurl}{Setting to TRUE allows you to just provide
  the metadata provider name, and any matches found the
  function will just use the url to query their OAI-PMH
  API.}

  \item{seconds}{Number of seconds by which to timeout an
  API call to one of the data providers.}
}
\description{
  Count identifiers for the data sources from the OAI-PMH
  list, and others not on that list, including PMC,
  DataCite, Hindawi Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# Select one
count_identifiers("datacite")

# Select a few
ldply(c("datacite","pensoft","arXiv"), count_identifiers)
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{md_identify}},
  \code{\link{md_listidentifiers}},
  \code{\link{md_listmetadataformats}},
  \code{\link{md_listrecords}}, \code{\link{md_listsets}},
  \code{\link{md_getrecord}}
}

