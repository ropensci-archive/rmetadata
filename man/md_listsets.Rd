\name{md_listsets}
\alias{md_listsets}
\title{List the OAI-PMH sets for each data provider.}
\usage{
  md_listsets(provider = c("pmc", "datacite", "hindawi", "dryad", "pensoft"))
}
\description{
  List sets for the data sources: PMC, DataCite, Hindawi
  Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# All providers
out <- md_listsets()
head(out); str(out) # details
out[out$datasource == "dryad",] # just dryad

# Select providers
out <- md_listsets(provider = c("hindawi", "dryad"))
head(out)
}
}

