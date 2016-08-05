# Open Data / Essentia example scripts

This repository contains Essentia scripts that categorize and preprocess open data from a variety of sources. Essentia is a powerful, efficient, and scalable solution for managing vast amounts of data. It is a data management and analysis platform that provides ETL tools, an in-memory map/reduce style database, and file management/accounting. [Learn more about Essentia.] (http://www.auriq.com/)

These scripts provide examples of how Essentia can be used to easily organize and process data from public data sets, and include data from [AWS Public Data Sets](https://aws.amazon.com/public-data-sets/) as well as other sources like [data.gov](https://www.data.gov/).

All of the data in these examples are stored in Amazon S3 buckets. More information about each can be found in the scripts, which are organized by category. You can also read more about these examples on the [AuriQ blog](http://www.auriq.com/blog/category/blog-archive/).

[R](./R) contains R scripts which analyze select samples of open data in RStudio. These scripts use the RESS package, which contains R functions that load Essentia output data into R. [Learn more about Essentia's R Integration package](http://auriq.com/documentation/source/integrations/R/index.html).

[ELK](./ELK) contains Elasticsearch scripts that index select samples of open data for analysis in Kibana. See the "readme.txt" in this directory for details on creating Elasticsearch indexes and visualizing open data in Kibana.
