\name{md_listmetadataformats}
\alias{md_listmetadataformats}
\title{List available metadata formats from various providers.}
\usage{
  md_listmetadataformats(provider = NULL,
    identifier = NULL, fuzzy = FALSE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{identifier}{The OAI-PMH identifier for the record.
  Optional.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  List metadata formats for the data sources from the
  OAI-PMH list, and others not on that list, including PMC,
  DataCite, Hindawi Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# List metadata formats for a provider
md_listmetadataformats(provider = "dryad")

# List metadata formats for a specific identifier for a provider
md_listmetadataformats(provider = "pensoft", identifier = "10.3897/zookeys.1.10")
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}

