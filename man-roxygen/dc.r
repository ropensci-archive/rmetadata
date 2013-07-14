#' @import httr plyr
#' @param q Query terms.
#' @param fl A vector of the fields to return in the output. The default 
#'    is all fields. See details for options. 
#' @param rows Number of items to return, defaults to 10. Max of 100.
#' @param sort Columns to sort by
#' @details See here \url{http://schema.datacite.org/meta/kernel-2.2/index.html} 
#' 	  for the Datacite schema. The list of possible fields to search and/or return:
#' 
#' Mandatory fields
#' \itemize{
#'  \item{"doi"}
#'  \item{"creator"}
#'  \item{"publisher"}
#'  \item{"publicationYear"}
#'  \item{"title"}
#' }
#' 
#' Optional fields
#' \itemize{
#'  \item{"alternateIdentifier"}
#'  \item{"contributor"}
#'  \item{"date"}
#'  \item{"description"}
#'  \item{"format"}
#'  \item{"language"}
#'  \item{"relatedIdentifier"}
#'  \item{"resourceType"}
#'  \item{"resourceTypeGeneral"}
#'  \item{"rights"}
#'  \item{"size"}
#'  \item{"subject"}
#'  \item{"version"}
#' }
#' 
#' Other Fields
#' \itemize{
#'  \item{"allocator"} {symbol of the DataCite member (e.g. BL = British Library)}
#'  \item{"datacentre"} {symbol of the datacentre, which uploaded the metadata (e.g. BL.ADS = Archeology Data Service)}
#'  \item{"indexed"} {datestamp of indexing}
#'  \item{"prefix"} {DOI prefix (e.g. 10.5284)}
#'  \item{"refQuality"} {reference quality flag (1 or 0)}
#'  \item{"uploaded"} {datestamp of metadata uploading}
#' }
#' 
#' The SOLR search parameters:
#' \itemize{
#'  \item{fl} {Fields to return in the query}
#'  \item{rows} {Number of records to return}
#'  \item{sort} {Field to sort by, see examples}
#'  \item{facet} {Facet or not, logical}
#'  \item{facet.fields} {Fields to facet by}
#' }
#' 
#' For a tutorial see here \url{http://lucene.apache.org/solr/3_6_2/doc-files/tutorial.html}
#' @return A data.frame of results.