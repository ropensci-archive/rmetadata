\name{load_providers}
\alias{load_providers}
\title{Load an updated cache}
\usage{
  load_providers(path = NULL, envir = .GlobalEnv)
}
\arguments{
  \item{path}{location where cache is located. Leaving to
  NULL loads the version in the installed package.}

  \item{envir}{R environment to load data in to.}
}
\value{
  loads the object providers into the working space.
}
\description{
  Load an updated cache
}
\details{
  Loads the data object providers into the global
  workspace.
}
\examples{
\donttest{
# By default the new providers table goes to directory ".", so just load from there
update_providers()
load_providers(path=".")

# Loads the version in the package
load_providers()
}
}
\author{
  Scott Chamberlain \email{myrmecocystus@gmail.com}
}
\seealso{
  \code{\link{update_providers}}
}

