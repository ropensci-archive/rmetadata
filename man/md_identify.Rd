\name{md_identify}
\alias{md_identify}
\title{Identify the OAI-PMH service for each data provider.}
\usage{
  md_identify(provider = NULL, url = NULL)
}
\description{
  Identifies the data sources: PMC, DataCite, Hindawi
  Journals, Dryad, and Pensoft Journals.
}
\examples{
\dontrun{
# All providers
md_identify()

# Just the providers you want to identify
md_identify(provider = "datacite")
md_identify(provider = "da") # abbreviating the provider works too
md_identify(provider = c("datacite","pensoft")) # many providers

# From the Open Archives list
df <- oaipmh_providers()
md_identify(provider = "openarchive", url = as.character(df[1,2]))
}
}

