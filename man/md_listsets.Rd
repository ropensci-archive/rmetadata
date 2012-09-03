\name{md_listsets}
\alias{md_listsets}
\title{List the OAI-PMH sets for each data provider.}
\usage{
  md_listsets()
}
\description{
  List the OAI-PMH sets for each data provider.
}
\examples{
\dontrun{
out <- md_listsets()
head(out); str(out) # details
out[out$datasource == "dryad",] # just dryad
}
}

