\name{md_listidentifiers}
\alias{md_listidentifiers}
\title{List OAI-PMH identifiers for a data provider.}
\usage{
  md_listidentifiers(from = NULL, until = NULL, set = NULL,
    metadataPrefix = "oai_dc", token = NULL, url = NULL,
    provider = NULL)
}
\arguments{
  \item{from}{Specifies that records returned must have
  been created/update/deleted on or after this date.}

  \item{until}{Specifies that records returned must have
  been created/update/deleted on or before this date.}

  \item{set}{Optional argument with a setSpec value, which
  specifies set criteria for selective harvesting.}

  \item{prefix}{Specifies the metadata format that the
  records will be returned in.}

  \item{token}{A token previously provided by the server to
  resume a request where it last left off.}
}
\description{
  List OAI-PMH identifiers for a data provider.
}
\examples{
\dontrun{
md_listidentifiers(provider = "datacite", set = "REFQUALITY")
md_listidentifiers(provider = "dryad")

# From the Open Archives list
providers <- oaipmh_providers() # get from the web
data(providers) # or load from local machine
md_listidentifiers(provider = "openarchive", url = as.character(providers[1,2]), from='2008-01-15', until = '2008-03-15')
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

