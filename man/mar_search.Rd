\name{mar_search}
\alias{mar_search}
\title{Search the Microsoft Academic Research API.}
\usage{
  mar_search(FullTextQuery = NULL, AuthorQuery = NULL,
    TitleQuery = NULL, JournalQuery = NULL,
    ConferenceQuery = NULL, ResultObjects = NULL,
    PublicationContent = NULL, AuthorID = NULL,
    StartIdx = 1, EndIdx = 10, YearStart = NULL,
    YearEnd = NULL, return_ = "all",
    key = getOption("MicAcaRes", stop("API key needed for Microsoft Academic Research API")))
}
\arguments{
  \item{FullTextQuery}{Search terms for a full text query
  of the MAS API.}

  \item{AuthorQuery}{Search terms for an author query of
  the MAS API.}

  \item{TitleQuery}{Search terms for a title query of the
  MAS API.}

  \item{JournalQuery}{Search terms for a journal query of
  the MAS API.}

  \item{ConferenceQuery}{Search terms for a conference
  query of the MAS API.}

  \item{ResultObjects}{The object type to be returned, for
  example, Publication, Author, Conference etc.}

  \item{PublicationContent}{When search for publications,
  this parameter is used to specify the properties to be
  returned, for example, Title, Author, Abstract etc.}

  \item{StartIdx}{Record to start at.}

  \item{EndIdx}{Record to end at.}

  \item{OrderBy}{Order results by The sorting method of the
  result, for example, Year and CitationCount.}

  \item{YearStart}{The start year of the publication. Zero
  for no requirement.}

  \item{YearEnd}{The end year of the publication. Zero for
  no requirement.}

  \item{return_}{Content to return: one of all (journal
  info and authors), journal (journal information), or
  authors (author information).}

  \item{key}{API key for the Microsoft Academic Research
  API.}
}
\description{
  Search the Microsoft Academic Research API.
}
\details{
  For more information, see the README for this package.
}
\examples{
\dontrun{
out <- mar_search(FullTextQuery="science", StartIdx=1, EndIdx=2)
lapply(out, function(x) x[["journal"]]) # just journal content
lapply(out, function(x) x[["authors"]]) # just authors content

# Using AuthorID - Return only a certain object, here "Author", and search by AuthorID
mar_search(AuthorID=23552408, ResultObjects="Author")

# Using AuthorQuery - Return only a certain object, here "Author", and search by AuthorID
mar_search(AuthorQuery="Piwowar", ResultObjects="Author")
mar_search(AuthorQuery="Piwowar", ResultObjects="Publication")
}
}

