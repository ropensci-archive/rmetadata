\name{md_getrecord}
\alias{md_getrecord}
\title{Get a record from a OAI-PMH data provider.}
\usage{
  md_getrecord(provider = NULL, identifier = NULL,
    metadataPrefix = "oai_dc", fuzzy = FALSE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{identifier}{The OAI-PMH identifier for the record.}

  \item{metadataPrefix}{Specifies the metadata format that
  the records will be returned in.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  Get records for the data sources from the OAI-PMH list,
  and others not on that list, including PMC, DataCite,
  Hindawi Journals, Dryad, and Pensoft Journals.
}
\details{
  To query multiple different identifier's from a single
  provider, just pass in multiple identifiers like
  c("identifier1", "identifier2").  To query identifiers
  from different providers, just use separate calls to
  md_getrecord.
}
\examples{
\dontrun{
# Single provider, one identifier
md_getrecord(provider = "pensoft", identifier = "10.3897/zookeys.1.10")

# Single provider, multiple identifiers
md_getrecord(provider = "pensoft", identifier = c("10.3897/zookeys.1.10","10.3897/zookeys.4.57"))
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

