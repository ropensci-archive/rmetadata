\name{md_listrecords}
\alias{md_listrecords}
\title{List records of an OAI-PMH from a data provider.}
\usage{
  md_listrecords(provider = NULL, from = NULL,
    until = NULL, set = NULL, metadataPrefix = "oai_dc",
    token = NULL, fuzzy = FALSE)
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

  \item{token}{A token previously provided by the server to
  resume a request where it last left off.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  List records for the data sources from the OAI-PMH list,
  and others not on that list, including PMC, DataCite,
  Hindawi Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# Single source
md_listrecords(provider = "datacite")

# Fuzzy seaerch, take 3
md_listrecords(provider = "biology", fuzzy=TRUE)
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{md_identify}},
  \code{\link{md_listidentifiers}},
  \code{\link{md_listmetadataformats}},
  \code{\link{md_getrecord}}, \code{\link{md_listsets}},
  \code{\link{count_identifiers}}
}

