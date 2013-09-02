\name{dc_search}
\alias{dc_search}
\title{Search Datacite metadata.}
\usage{
  dc_search(q = NULL, fl = NULL, rows = 10, sort = NULL)
}
\arguments{
  \item{q}{Query terms.}

  \item{fl}{A vector of the fields to return in the output.
  The default is all fields. See details for options.}

  \item{rows}{Number of items to return, defaults to 10.
  Max of 100.}

  \item{sort}{Columns to sort by}
}
\value{
  A data.frame of results.
}
\description{
  Search Datacite metadata.
}
\details{
  See here
  \url{http://schema.datacite.org/meta/kernel-2.2/index.html}
  for the Datacite schema. The list of possible fields to
  search and/or return:

  Mandatory fields \itemize{ \item{"doi"} \item{"creator"}
  \item{"publisher"} \item{"publicationYear"}
  \item{"title"} }

  Optional fields \itemize{ \item{"alternateIdentifier"}
  \item{"contributor"} \item{"date"} \item{"description"}
  \item{"format"} \item{"language"}
  \item{"relatedIdentifier"} \item{"resourceType"}
  \item{"resourceTypeGeneral"} \item{"rights"}
  \item{"size"} \item{"subject"} \item{"version"} }

  Other Fields \itemize{ \item{"allocator"} {symbol of the
  DataCite member (e.g. BL = British Library)}
  \item{"datacentre"} {symbol of the datacentre, which
  uploaded the metadata (e.g. BL.ADS = Archeology Data
  Service)} \item{"indexed"} {datestamp of indexing}
  \item{"prefix"} {DOI prefix (e.g. 10.5284)}
  \item{"refQuality"} {reference quality flag (1 or 0)}
  \item{"uploaded"} {datestamp of metadata uploading} }

  The SOLR search parameters: \itemize{ \item{fl} {Fields
  to return in the query} \item{rows} {Number of records to
  return} \item{sort} {Field to sort by, see examples}
  \item{facet} {Facet or not, logical} \item{facet.fields}
  {Fields to facet by} }

  For a tutorial see here
  \url{http://lucene.apache.org/solr/3_6_2/doc-files/tutorial.html}
}
\examples{
\dontrun{
# Basic search, "fruit" in any fields
out <- dc_search(q="wind", rows=2)
dc_data(out) # summary of output
dc_data(input=out, what="brief") # as a data.frame
dc_data(input=out, what="details") # as a list

# Request specific returned fields
out <- dc_search('ecology', 'doi,title')
dc_data(out, "brief")

# Request certain serch terms to not be included (notice fewer records)
out <- dc_search('ecology -birds')
dc_data(out)

# More complicated queries
out <- dc_search('ecology AND (bird or turtle)')
dc_data(out)

# Search for an exact phrase (put quotes around the term)
out <- dc_search('"wind turbine"')
dc_data(out)

# Search within specific field
out <- dc_search('title:ecology')
dc_data(out)

# Search within a range for a numeric field
out <- dc_search('publicationYear:[2000 TO 2005]')
dc_data(out)

# Search for records uploaded in last 5 days
out <- dc_search('uploaded:[NOW-5DAYS TO NOW]')
dc_data(out)

# Return certain number of records
out <- dc_search('ecology', fl='doi,date', rows=12)
dc_data(out, 'brief')

# Sort by a field
out <- dc_search('ecology', fl='doi,date', rows=12)
dc_data(out, 'brief')

# Wildcards: You can use ? for a single character or * for multiple characters,
# e.g. w*d would match wood and wind.
out <- dc_search('subject:w*d', fl='subject')
dc_data(out, 'subject')
}
}
\keyword{datacite}

