\name{dc_data}
\alias{dc_data}
\title{Get Datacite data.}
\usage{
  dc_data(input = NULL, what = "summary", as = "df")
}
\arguments{
  \item{input}{Output from bison function.}

  \item{what}{One of summary, brielf, all, or list specific
  columns as comma separated character string.}

  \item{as}{As a data.frame (df) or list (list)}
}
\value{
  A message, data.frame or list.
}
\description{
  what=summary prints a message with summary of search,
  what=brief returns all data in a data.frame, what=all
  returns all data, what=<character string of column names>
  returns just those column names
}
\details{
  Get Datacite data from a search using dc_search.
}
\examples{
\dontrun{
# output data
out <- dc_search(q="ecology")
class(out) # check for the correct class (should be "datacite")
dc_data(out) # summary of output
dc_data(input=out, what="brief") # just key columns as a data.frame
dc_data(input=out, what="doi,creator") # pick specific columns to return, as data.frame
dc_data(input=out, what="brief", as='list')
}
}

