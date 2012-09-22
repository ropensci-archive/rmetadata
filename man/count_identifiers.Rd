\name{count_identifiers}
\alias{count_identifiers}
\title{Count OAI-PMH identifiers for a data provider.}
\usage{
  count_identifiers(provider = NULL,
    metadataPrefix = "oai_dc", fuzzy = FALSE,
    useurl = FALSE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{metadataPrefix}{Specifies the metadata format that
  the records will be returned in.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  Count identifiers for the data sources from the OAI-PMH
  list, and others not on that list, including PMC,
  DataCite, Hindawi Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# Select a few
count_identifiers(provider = c("datacite","Academic Commons","pensoft","arXiv"))

# Provide a vector
out <- count_identifiers(provider = providers[1:40,2], useurl = T)
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

