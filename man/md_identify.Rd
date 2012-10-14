\name{md_identify}
\alias{md_identify}
\title{Identify the OAI-PMH service for each data provider.}
\usage{
  md_identify(provider = NULL, fuzzy = FALSE, ...)
}
\arguments{
  \item{provider}{The metadata provider to identify.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}

  \item{...}{further arguments passed on to agrep (only
  used when fuzzy equals TRUE).}
}
\description{
  Identifies the data sources from the OAI-PMH list, and
  others not on that list, including PMC, DataCite, Hindawi
  Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
md_identify(provider = "datacite")
md_identify(provider = c("datacite","pensoft")) # many providers
md_identify(provider = "arXiv") # arXiv
md_identify(provider = c("harvard", "journal")) # no match for one, two matches for other
md_identify(provider = c("data", "theory", "biology"))
md_identify(provider = "Takasu database") # refine previous for data
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}

