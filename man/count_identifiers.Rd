\name{count_identifiers}
\alias{count_identifiers}
\title{Count OAI-PMH identifiers for a data provider.}
\usage{
  count_identifiers(provider = NULL,
    metadataPrefix = "oai_dc", fuzzy = FALSE,
    useurl = FALSE, seconds = 3)
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
# Select one
count_identifiers("datacite")

# Select a few
ldply(c("datacite","Academic Commons","pensoft","arXiv"), count_identifiers)

# All of them, takes a while, run on AWS AMI if you can
out <- llply(providers[,2], function(x) count_identifiers(x, useurl = T), .inform=T)
outdf <- ldply(out)
str(outdf)
outdf_ <- outdf[!is.na(as.numeric(as.character(outdf$count))), ]  # just those with counts
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

