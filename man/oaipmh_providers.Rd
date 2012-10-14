\name{oaipmh_providers}
\alias{oaipmh_providers}
\title{Get information on each OAI-PMH data providers.}
\usage{
  oaipmh_providers()
}
\description{
  Data comes from
  \url{http://www.openarchives.org/Register/BrowseSites}.
  Data includes oai-identifier (if they have one) and baes
  URL. The website has the name of the data provider too,
  but not provided in the data pulled down here, but you
  can grab the name using example below.
}
\details{
  This table is scraped from
  \url{http://www.openarchives.org/Register/BrowseSites}.
  I would get it from
  \url{http://www.openarchives.org/Register/ListFriends},
  but it does not include repository names.
}
\examples{
\dontrun{
df <- oaipmh_providers()
str(df) # wow, that's a lot of OAI-PMH data providers
head(df) # take a look
oaih_identify(df[1,2]) # Identify the metadata provider

# Visualize the length of the baseURLs for each data provider
library(ggplot2)
nchars <- data.frame(nchars = sapply(as.character(df$base_url), nchar, USE.NAMES=F))
qplot(nchars, data = nchars, geom="histogram")
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}

