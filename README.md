# when_police_replication
Replication and re-analysis repository for J. Nix, Huff, J., Wolfe, S. E., Pyrooz, D. C., and Mourtgos, S. M., "When police pull back: Neighborhood-level effects of de-policing on violent and property crime, a research note," _Criminology_ 2024;1–16. DOI: 10.1111/1745-9125.12363. Additional supporting information can be found in the full text tab for this article in the Wiley Online Library at http://onlinelibrary.wiley.com/doi/10.1111/ crim.2024.62.issue-1/issuetoc.

Data and replication files taken from https://doi.org/10.17605/OSF.IO/CWFP2.

Email on 2024-03-28 from author J. Nix supplied a link to Harvard Dataverse version that included an additional source datafile, https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/HNFQSP.

Email on 2024-03-28 from author J. Huff supplied a R file for spatial data analysis and weight calculation. This email also included neighborhoods.shp. 



The replication data folder did not include data on weather, air quality, or restaurants. So I downloaded this data from the respective sources.

AQI
1 Get annual files here: https://aqs.epa.gov/aqsweb/airdata/download_files.html#AQI

WEATHER
https://www.ncei.noaa.gov/cdo-web/search

Dataset Daily Summaries
Order Start Date 2016-01-01 00:00
Order End Date 2020-12-31 23:59
Output Format Custom GHCN-Daily CSV
Data Types PRCP, SNWD, SNOW, TAVG, TMAX, TMIN
Custom Flag(s) Station Name
Units Standard
Stations/Locations Denver County, CO (Location ID: FIPS:08031)

OPEN TABLE
1 navigate to the Open Table website in the Internet Archive https://web.archive.org/web/20210102090417/https://www.opentable.com/state-of-industry
2 Under "Seated diners from online, phone, and walk-in reservations" click drop down for city
3 click "download dataset", open table data set YoY_Seated_Diner_Data.csv
4 open in plain text editor and manipulate first row to add "2020" year to date, then transpose, and keep only Denver.

DENVER NEIGHBORHOODS SHAPE FILE
1 Navigate to Denver's open data website for statistical neighborhoods https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-statistical-neighborhoods
2 download shapefile
