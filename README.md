# rmd #


`rmd` accesses article metadata using the OAI-PMH harvester across many sources. 

You do not need an API key. 

Documentation for OAI-PMH in general [here](http://www.openarchives.org/OAI/openarchivesprotocol.html).


`rmd` is part of the rOpenSci project, visit http://ropensci.org to learn more.

## Install `rmd` from GitHub:

```r
install.packages("devtools")
require(devtools)
install_github("rmd", "ropensci")
require(rmd)
```

## Windows binary at the Downloads page
+ [get a windows binary here](https://github.com/ropensci/rmd/downloads)

### You can access all the data sources in the [OAI-PMH list of metadata providers](http://www.openarchives.org/Register/BrowseSites), in addition to some sources not on that list (more will be added later): 

+ [DataCite](http://datacite.org/)
+ [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/)
+ [Hindawi Journals](http://www.hindawi.com/journals/)
+ [Pensoft Journals](http://www.pensoft.net/index.php)
+ CrossRef API's
	+ [General](http://search.labs.crossref.org/help/api)
		+ [Example call: http://search.labs.crossref.org/dois?q=renear+palmer](http://search.labs.crossref.org/dois?q=renear+palmer)
	+ [OpenURL](http://labs.crossref.org/openurl/)
	+ [Metadata search](http://search.labs.crossref.org/help/api)
	+ [ranDOIm](http://random.labs.crossref.org/)