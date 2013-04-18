\name{dpla_fields}
\alias{dpla_fields}
\title{Search metadata from the Digital Public Library of America (DPLA).}
\usage{
  dpla_fields(queries = NULL)
}
\arguments{
  \item{queries}{A list of query terms paired with the
  fields you want to search them in.}
}
\value{
  A list for now...
}
\description{
  Search metadata from the Digital Public Library of
  America (DPLA).
}
\examples{
\dontrun{
# Search by specific fields
dpla_fields(c("fruit,title","basket,description"))
}
}

