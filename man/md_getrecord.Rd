\name{md_getrecord}
\alias{md_getrecord}
\title{Get a record from a OAI-PMH data provider.}
\usage{
  md_getrecord(provider = NULL, identifier = NULL,
    metadataPrefix = "oai_dc", fuzzy = FALSE, brief = TRUE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{identifier}{The OAI-PMH identifier for the record.}

  \item{metadataPrefix}{Specifies the metadata format that
  the records will be returned in.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}

  \item{brief}{Give brief results (just a subset of
  columns)}
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

# More than one provider found - or just easier than typing in the whole provider name - Choose 15
md_getrecord(provider = "advances", identifier = "oai:ojs.www.academypublisher.com:article/5460", fuzzy=TRUE)
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
  \code{\link{count_identifiers}}
}

