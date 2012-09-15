\name{md_listmetadataformats}
\alias{md_listmetadataformats}
\title{List available metadata formats from various providers.}
\usage{
  md_listmetadataformats(provider = c("pmc", "datacite", "hindawi", "dryad"),
    id = NULL)
}
\arguments{
  \item{id}{ID for the article/dataset.}
}
\description{
  List available metadata formats from various providers.
}
\examples{
\dontrun{
md_listmetadataformats()
}
}
\author{
  Scott Chamberlain \link{myrmecocystus@gmail.com}
}

