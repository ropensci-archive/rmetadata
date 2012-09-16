# rmetadata #


`rmetadata` accesses article metadata using the OAI-PMH harvester across many sources. 

You do not need an API key. 

Documentation for OAI-PMH in general [here](http://www.openarchives.org/OAI/openarchivesprotocol.html).


`rmetadata` is part of the rOpenSci project, visit http://ropensci.org to learn more.

## Install `rmetadata` from GitHub:

```R 
install.packages("devtools")
require(devtools)
install_github("rmetadata", "ropensci")
require(rmetadata)
```

## You can access all the data sources in the [OAI-PMH list of metadata providers](http://www.openarchives.org/Register/BrowseSites), in addition to some sources not on that list (more will be added later): 

+ [DataCite](http://datacite.org/)
+ [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/)
+ [Hindawi Journals](http://www.hindawi.com/journals/)
+ [Pensoft Journals](http://www.pensoft.net/index.php)