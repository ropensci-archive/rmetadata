\name{md_listsets}
\alias{md_listsets}
\title{List the OAI-PMH sets for each data provider.}
\usage{
  md_listsets(provider = NULL, fuzzy = FALSE)
}
\arguments{
  \item{provider}{The metadata provider.}

  \item{fuzzy}{Do fuzzy search or not (default FALSE).
  Fuzzy uses agrep.}
}
\description{
  List sets for the data sources from the OAI-PMH list, and
  others not on that list, including PMC, DataCite, Hindawi
  Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
md_listsets(provider = "datacite") # DataCite
md_listsets(provider = "arXiv") # arXiv

# Many providers
md_listsets(provider = c("datacite","pensoft","Aston University Research Archive"))

# Fuzzy search
md_listsets(provider = "biology", fuzzy=TRUE)
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{md_identify}},
  \code{\link{md_listidentifiers}},
  \code{\link{md_listmetadataformats}},
  \code{\link{md_listrecords}}, \code{\link{md_getrecord}},
  \code{\link{count_identifiers}}
}

