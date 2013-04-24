\name{dpla_plot}
\alias{dpla_plot}
\title{Search metadata from the Digital Public Library of America (DPLA).}
\usage{
  dpla_plot(input)
}
\arguments{
  \item{input}{XXXX}
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
# Plot results from basic search
out <- dpla_basic(q="science", returnfields=c("format","publisher"), page_size=30)
dpla_plot(input=out)
}
}

