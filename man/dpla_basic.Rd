\name{dpla_basic}
\alias{dpla_basic}
\title{Search metadata from the Digital Public Library of America (DPLA).}
\usage{
  dpla_basic(q = NULL, verbose = FALSE, fields = NULL,
    limit = 10, page = NULL, sort_by = NULL,
    date.before = NULL, date.after = NULL)
}
\arguments{
  \item{q}{Query terms.}

  \item{verbose}{If TRUE, the console talks to you :/}

  \item{limit}{Number of items to return, defaults to 10.
  Max of 100.}

  \item{page}{Page number to return, defaults to NULL.}

  \item{sort_by}{The default sort order is ascending. Most,
  but not all fields can be sorted on. Attempts to sort on
  an un-sortable field will return the standard error
  structure with a HTTP 400 status code.}

  \item{fields}{A vector of the fields to return in the
  output. The default is all fields. See details for
  options.}

  \item{verbose}{If TRUE, fun little messages print to
  console to inform you of things.}
}
\value{
  A data.frame of results.
}
\description{
  Search metadata from the Digital Public Library of
  America (DPLA).
}
\details{
  Options for the fields argument are: \itemize{ \item
  sourceResource.title The title of the object \item
  sourceResource.decription The description of the object
  \item sourceResource.subject The subjects of the object
  \item sourceResource.creator The creator of the object
  \item sourceResource.type The type of the object \item
  sourceResource.publisher The publisher of the object
  \item sourceResource.format The format of the object
  \item sourceResource.rights The rights for the object
  \item sourceResource.contributor The contributor of the
  object \item sourceResource.spatial The spatial of the
  object \item isPartOf The isPartOf thing, not sure what
  this is \item provider The provider of the object \item
  id The item id }
}
\examples{
\dontrun{
# Basic search, "fruit" in any fields
dpla_basic(q="fruit")

# Some verbosity
dpla_basic(q="fruit", verbose=TRUE, limit=2)

# Return certain fields
dpla_basic(q="fruit", verbose=TRUE, fields=c("publisher","format"))
dpla_basic(q="fruit", fields="subject")

# Max is 100 per call, but the function handles larger numbers by looping
dpla_basic(q="fruit", fields="id", limit=200)
dpla_basic(q="fruit", fields=c("id","provider"), limit=200)
dpla_basic(q="fruit", fields=c("id","provider"), limit=200)
out <- dpla_basic(q="science", fields=c("id","subject"), limit=400)

# Search by date
dpla_basic(q="science", date.before=1900, limit=200)
}
}

