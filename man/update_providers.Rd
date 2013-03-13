\name{update_providers}
\alias{update_providers}
\title{Update the locally stored OAI-PMH data providers table.}
\usage{
  update_providers(path = ".")
}
\arguments{
  \item{path}{Path to put data in.}
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

  This function updates the table for you. Does take a
  while though, so go get a coffee.
}
\examples{
\donttest{
update_providers()
load_providers()
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{load_providers}}
}

