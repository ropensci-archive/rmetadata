\name{dpla_plot}
\alias{dpla_plot}
\title{Search metadata from the Digital Public Library of America (DPLA).}
\usage{
  dpla_plot(input, plottype = "subjectsum")
}
\arguments{
  \item{input}{A data.frame from calling a variety of
  dpla_* functions.}

  \item{plottype}{One of a number of types. These are for
  convenience. You can of course create your own plots with
  more flexibility.}
}
\value{
  A ggplot2 object, a plot that is.
}
\description{
  Search metadata from the Digital Public Library of
  America (DPLA).
}
\examples{
\dontrun{
# Plot results, summarising subjects by number of subjects listed
out <- dpla_basic(q="ecology", fields=c("publisher","subject"), page_size=90)
dpla_plot(input=out)

# By XXX
out <- dpla_basic(q="ecology", fields="date", page_size=90)
dpla_plot(input=out)
}
}

