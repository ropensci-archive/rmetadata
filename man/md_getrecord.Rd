\name{md_getrecord}
\alias{md_getrecord}
\title{Get a record via OAI-PMH from a data provider.}
\usage{
  md_getrecord(datasource = NULL, id = NULL, df = NULL,
    todf = TRUE)
}
\arguments{
  \item{df}{A data.frame of two columns, named "datasource"
  and "id".  df does not have to be supplied.}

  \item{datasource}{Datasource, currently one of:
  "datacite", "pmc", "dryad", "hindawi", or "pensoft".}

  \item{id}{ID for the article/dataset.}

  \item{todf}{Convert output to a data.frame (logical).}
}
\description{
  Get a record via OAI-PMH from a data provider.
}
\details{
  The function takes a data.frame as input, or just one set
  of datasource and id specified in the function call. So
  the function can be used to do more than one call by
  supplying a data.frame or by supplying one pair of
  datasource and id at a time in a lapply type call.
}
\examples{
\dontrun{
# Single source
md_getrecord(datasource = "pensoft", id = "10.3897/zookeys.1.10")

# Many sources. Submit a data.frame to the function:
df <- data.frame(datasource = c('datacite','pmc','pensoft'), id = c(56225, 152494, "10.3897/zookeys.1.10"))
md_getrecord(df = df, todf=F) # list output
md_getrecord(df = df) # data.frame output
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

