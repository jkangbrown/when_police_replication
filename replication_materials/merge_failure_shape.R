
library(sf); 
library(spdep) 
library(tidyverse)
library(haven)
setwd("~/Documents/GitHub/when_police_replication")

# Point to a complete shape file:  
s = st_read("original_data_collection/statistical_neighborhoods/statistical_neighborhoods.shp")

# recode the string name to simplify
s$shape_nb_key = str_replace(s$NBHD_NAME, " - ", "-")
# rename the numeric identifier to neighborhood
s$neighborhood = s$NBHD_ID

# simplify file
shape_merge <- distinct_at(s, vars(neighborhood, shape_nb_key))

write_dta(
  shape_merge,
  "replication_materials/merge_failure_files/shape_merge.dta",
  version = 13,
)
