\name{md_listidentifiers}
\alias{md_listidentifiers}
\title{List OAI-PMH identifiers for a data provider.}
\usage{
  md_listidentifiers(provider = NULL, from = NULL,
    until = NULL, set = NULL, metadataPrefix = "oai_dc",
    fuzzy = FALSE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{from}{Specifies that records returned must have
  been created/update/deleted on or after this date.}

  \item{until}{Specifies that records returned must have
  been created/update/deleted on or before this date.}

  \item{set}{Optional argument with a setSpec value, which
  specifies set criteria for selective harvesting.}

  \item{metadataPrefix}{Specifies the metadata format that
  the records will be returned in.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  List identifiers for the data sources from the OAI-PMH
  list, and others not on that list, including PMC,
  DataCite, Hindawi Journals, Dryad, and Pensoft Journals.
}
\examples{
\donttest{
md_listidentifiers(provider = "dryad", from = "2012-07-15")

# From the Open Archives list
md_listidentifiers("arXiv", from='2008-01-15', until = '2008-01-30')
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}

