# when_police_replication

Replication and re-analysis repository for J. Nix, Huff, J., Wolfe, S. E., Pyrooz, D. C., and Mourtgos, S. M., "When police pull back: Neighborhood-level effects of de-policing on violent and property crime, a research note," _Criminology_ 2024;1–16. DOI: 10.1111/1745-9125.12363. Additional supporting information can be found in the full text tab for this article in the Wiley Online Library at https://onlinelibrary.wiley.com/doi/full/10.1111/1745-9125.12363.

This repo contains a few folders, primarily code, but also some of the data needed to replicate the papers results. It also contains code to demonstrate that the results are an artifact of a failed merge between the various datasets used in the analysis. For more information on the failed merge, see the [merge failure analysis Stata do file](https://github.com/jkangbrown/when_police_replication/blob/main/replication_materials/merge_failures.do),  or [plain text Stata log](https://github.com/jkangbrown/when_police_replication/blob/main/replication_materials/merge_failure_files/merge_failure_log.log). 

As a github repository, you can see earlier versions of this files stored here, so if you want to see what was added initially, the customization required to replicate results, or the analysis of merge failures you do so [here](https://github.com/jkangbrown/when_police_replication/pulls?q=is%3Apr+is%3Aclosed). 

## Key Results

Plain text versions of key tables that present model results are stored in this repository. Replication results with failed data file merges are stored in this [folder](https://github.com/jkangbrown/when_police_replication/tree/main/replication_materials/replication_output). 

Reanalysis results with corrected merges are stored in this [folder](https://github.com/jkangbrown/when_police_replication/tree/main/replication_materials/reanalysis_output).

### Replication Materials 

Data and replication files taken from https://doi.org/10.17605/OSF.IO/CWFP2.

Email on 2024-03-28 from author J. Nix supplied a link to Harvard Dataverse version that included an additional source datafile, https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/HNFQSP.

### Email Attachments

Email on 2024-03-28 from author J. Huff supplied a R file for spatial data analysis and weight calculation. This email also attached "neighborhoods.shp". See [folder](https://github.com/jkangbrown/when_police_replication/tree/main/email_attachments) for more detail. 


### Additional Data 

The replication [data folder from the authors](https://doi.org/10.17605/OSF.IO/CWFP2) did not include data on weather, air quality, or restaurants. To replicate the analysis, I downloaded this data from their respective sources identified in supplemental material to the research note. The data is stored in this repo, in the [original data collection folder](https://github.com/jkangbrown/when_police_replication/tree/main/original_data_collection). Code to process it is in the [Denver_prep.do](https://github.com/jkangbrown/when_police_replication/blob/45a1ee62ce757ac3a8425a8f9fee2382335a21fc/replication_materials/denver_prep.do#L866-L986) and the [Denver_prep_reanalysis.do](https://github.com/jkangbrown/when_police_replication/blob/45a1ee62ce757ac3a8425a8f9fee2382335a21fc/replication_materials/denver_prep_reanalysis.do#L685) files. If you wanted to verify and download and collect this data manually yourself, one could take the following steps: 

#### AQI

1 Get annual files here for 2016-2020: https://aqs.epa.gov/aqsweb/airdata/download_files.html#AQI

2 Code in repo will process and turn into a single metric for Denver

#### WEATHER

1 Make a request here for daily summary data: https://www.ncei.noaa.gov/cdo-web/search

2 Use the following type of request: 
Dataset Daily Summaries

Order Start Date 2016-01-01 00:00

Order End Date 2020-12-31 23:59

Output Format Custom GHCN-Daily CSV

Data Types PRCP, SNWD, SNOW, TAVG, TMAX, TMIN

Custom Flag(s) Station Name

Units Standard

Stations/Locations Denver County, CO (Location ID: FIPS:08031)


####  OPEN TABLE

1 navigate to the Open Table website archived in January 2021 at the Internet Archive https://web.archive.org/web/20210102090417/https://www.opentable.com/state-of-industry

2 Under "Seated diners from online, phone, and walk-in reservations" click drop down for city

3 click "download dataset", open table data set YoY_Seated_Diner_Data.csv

4 open in plain text editor and manipulate first row to add "2020" year to date, then transpose, and keep only Denver.

#### DENVER NEIGHBORHOODS SHAPE FILE

1 Navigate to Denver's open data website for statistical neighborhoods https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-statistical-neighborhoods

2 download shapefile

## Contact
If you have any questions or need any additional information, please contact Jacob Kang-Brown, jkangbrown@vera.org.  
