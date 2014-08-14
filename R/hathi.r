#' hathi_bib
#' 
#' There are two sections: records which holds basic metadata about the set of records which match 
#' the query, and items which lists the complete set of individual HathiTrust items (volumes) 
#' associated with those records.
#' 
#' @section Records:
#' 
#' The records section. The records structure is a hash keyed on the nine-digit record number of 
#' each matched record. It may easily contain multiple records, since duplicates, while not 
#' common, are certainly possible.
#' 
#' For each record:
#' 
#' \itemize{
#'  \item recordURL: The URL to the catalog display record.
#'  \item titles: The list of titles associated with this record, for sanity checking. This list 
#'  includes the standard (MARC field 245) title with and without leading articles, and any 
#'  vernacular (foreign language) titles provided in the record (MARC field 880).
#'  \item isbns, issns, lccns, oclcs, lccns: Each is a (possibly empty) list of identifiers of the 
#'  appropriate type.
#'  \item marc-xml: The full MARC-XML of the record if the URL was of the form /api/volumes/full/...
#'  MARC-XML is not included in brief return values.
#' }
#' 
#' @section Items:
#' 
#' The items structure is an array of hashes describing all the available items associated with 
#' matched records. There may be multiple items because the record(s) in question describe a 
#' serial or multi-volume set, or because identical volumes were digitized at more than one 
#' contributing institution.
#' 
#' For each item:
#' 
#' \itemize{ 
#'  \item orig: The originating institution -- where this particular volume was digitized.
#'  \item fromRecord: The nine-digit record number to which this particular item is attached. It 
#'  will always be one of the records listed in the records section.
#'  \item htid: The HathiTrust volume id.
#'  \item itemURL: The URL to this item in the pageturner interface. This is trivially derived from 
#'  the htid at the moment, but is included here in the event that the handle URLs get more complex 
#'  in the future.
#'  \item rightsCode: The rights code as used in the downloadable files, describing the copyright 
#'  status of the item and what users in various locales are able to do with it.
#'  \item lastUpdate: The date (YYYYMMDD) this item was ingested or last changed (because, e.g., 
#'  the rights determination changed).
#'  \item enumcron: The enumeration/chronology of the item, describing its place in a series. 
#'  These are commonly of the form, "vol. 3, n. 2 1993" or something similar. Used to sort the 
#'  items when present.
#'  \item usRightsString: A textual description of the rights for a US-based user. This is, again, 
#'  trivially derived from the rightsCode, but useful enough to the majority of likely users that 
#'  it is included here. Will be either "Limited (search only)" or "Full View." As noted, a 
#'  reasonably-sophisticated attempt is made to sort items by their enumcron (when present), 
#'  often resulting in the items listed correctly by volume/number. Variation in the way these 
#'  data have been entered at different institutions and at different times makes it impractical 
#'  to guarantee the order will be correct, but it is more often than not correct.
#' }
#' 
#' @references \url{http://www.hathitrust.org/bib_api}
#' @name hathi
NULL
