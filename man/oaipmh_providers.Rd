\name{oaipmh_providers}
\alias{oaipmh_providers}
\title{Get data.frame of OAI-PMH data providers.}
\usage{
  oaipmh_providers()
}
\description{
  Data comes from
  \link{http://www.openarchives.org/Register/BrowseSites}.
  Data includes oai-identifier (if they have one) and baes
  URL.
}
\details{
  There is an old version of the list of providers stored
  in this package. Call X to see it.  However, you should
  update the list if you want the most updated list by
  running X.
}
\examples{
\dontrun{
df <- oaipmh_providers()
str(df) # wow, that's a lot of OAI-PMH data providers
head(df) # take a look
oaih_identify(df[1,2]) # identify the metadata provider
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

