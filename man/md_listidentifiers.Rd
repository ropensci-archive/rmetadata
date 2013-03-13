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
\dontrun{
md_listidentifiers(provider = "dryad", from = "2012-12-15")
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{md_identify}}, \code{\link{md_getrecord}},
  \code{\link{md_listmetadataformats}},
  \code{\link{md_listrecords}}, \code{\link{md_listsets}},
  \code{\link{count_identifiers}}
}

