library(sf); library(spdep); library(tmap)
library(haven)
library(tidyverse)
#open data
setwd("~/Documents/GitHub/when_police_replication")

# Add a load command for the Stata data

data <- read_dta("~/Downloads/replication_materials_data/merged_data_for_reanalysis.dta")

# this file doesn't have a shx. 

s = st_read("email_attachments/neighborhoods.shp") 

# Using the one fromDenver website https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-statistical-neighborhoods 

s = st_read("original_data_collection/statistical_neighborhoods/statistical_neighborhoods.shp")

s$neighborhood_key = str_replace(s$NBHD_NAME, " - ", "-")

shp_nb <- distinct_at(s, vars(NBHD_ID, NBHD_NAME, neighborhood_key))
data_nb <- distinct_at(data, vars(neighborhood, neighborhood_key))
shape_test = merge(shp_nb, data_nb, by.x = "neighborhood_key" , by.y = "neighborhood_key")




# this does not work
# shape_test = merge(shp_nb, data_nb, by.x = "NBHD_ID" , by.y = "neighborhood")
# this does 

#


data2 = dplyr::select(data,
                      neighborhood, neighborhood_key, 
                      week, nh_week, period2, period3, 
                      violent, property, crime_assault, crime_mvt,
                      cr_agg, cr_sim, cr_vca, cr_vcns, cr_vcn, cr_prop_alt
)
shape = merge(s, data2, by = "neighborhood_key")

names(shape)


#define neighboring polygons - going w/ queen
nb = poly2nb(shape, queen = T)

#get weights
lw = nb2listw(nb, style="W", zero.policy = T)

# save out
saveRDS(nb,file ="nb.RDS")

nb <- read_rds( file = "nb.RDS")


#Moran's I
moran_v = moran(shape$violent, lw, length(nb), Szero(lw))[1]
moran_v

moran_p = moran(shape$property, lw, length(nb), Szero(lw))[1]
moran_p

moran_a = moran(shape$crime_assault, lw, length(nb), Szero(lw))[1]
moran_a

moran_m = moran(shape$crime_mvt, lw, length(nb), Szero(lw))[1]
moran_m

moran_cr_agg = moran(shape$cr_agg, lw, length(nb), Szero(lw))[1]
moran_cr_agg

moran_cr_sim = moran(shape$cr_sim, lw, length(nb), Szero(lw))[1]
moran_cr_sim

moran_cr_vca = moran(shape$cr_vca, lw, length(nb), Szero(lw))[1]
moran_cr_vca

moran_cr_vcns = moran(shape$cr_vcns, lw, length(nb), Szero(lw))[1]
moran_cr_vcns

moran_cr_vcn = moran(shape$cr_vcn, lw, length(nb), Szero(lw))[1]
moran_cr_vcn

moran_cr_prop_alt = moran(shape$cr_prop_alt, lw, length(nb), Szero(lw))[1]
moran_cr_prop_alt

#Test Moran's I
moran_v_test = moran.test(shape$violent, lw, alternative = "greater")
moran_v_test

moran_p_test = moran.test(shape$property, lw, alternative = "greater")
moran_p_test

moran_a_test = moran.test(shape$crime_assault, lw, alternative = "greater")
moran_a_test

moran_m_test = moran.test(shape$crime_mvt, lw, alternative = "greater")
moran_m_test

moran_cr_agg_test = moran.test(shape$cr_agg, lw, alternative = "greater") 
moran_cr_sim_test = moran.test(shape$cr_sim, lw, alternative = "greater") 
moran_cr_vca_test = moran.test(shape$cr_vca, lw, alternative = "greater") 
moran_cr_vcns_test = moran.test(shape$cr_vcns, lw, alternative = "greater") 
moran_cr_vcn_test = moran.test(shape$cr_vcn, lw, alternative = "greater") 
moran_cr_prop_alt_test = moran.test(shape$cr_prop_alt, lw, alternative = "greater") 

moran_cr_agg_test
moran_cr_sim_test
moran_cr_vca_test
moran_cr_vcns_test
moran_cr_vcn_test
moran_cr_prop_alt_test


#create lagged measures by nhood - https://rpubs.com/erikaaldisa/spatialweights
violent_lag = lag.listw(lw, shape$violent)
lag.list.v = list(shape$neighborhood, lag.listw(lw, shape$violent))
lag.res.v = as.data.frame(lag.list.v)
colnames(lag.res.v) = c("neighborhood", "lag violent (queen)")
head(lag.res.v)
data = cbind(data, lag.res.v)

property_lag = lag.listw(lw, shape$property)
lag.list.p = list(shape$neighborhood, lag.listw(lw, shape$property))
lag.res.p = as.data.frame(lag.list.p)
colnames(lag.res.p) = c("neighborhood", "lag property (queen)")
head(lag.res.p)
data = cbind(data, lag.res.p)

assault_lag = lag.listw(lw, shape$crime_assault)
lag.list.a = list(shape$neighborhood, lag.listw(lw, shape$crime_assault))
lag.res.a = as.data.frame(lag.list.a)
colnames(lag.res.a) = c("neighborhood", "lag assault (queen)")
head(lag.res.a)
data = cbind(data, lag.res.a)

mvt_lag = lag.listw(lw, shape$crime_mvt)
lag.list.m = list(shape$neighborhood, lag.listw(lw, shape$crime_mvt))
lag.res.m = as.data.frame(lag.list.m)
colnames(lag.res.m) = c("neighborhood", "lag mvt (queen)")
head(lag.res.m)
data = cbind(data, lag.res.m)


cr_agg_lag = lag.listw(lw, shape$cr_agg)
lag.list.cr_agg = list(shape$neighborhood, lag.listw(lw, shape$cr_agg))
lag.res.cr_agg = as.data.frame(lag.list.cr_agg)
colnames(lag.res.cr_agg) = c("neighborhood", "lag cr_agg (queen)")
head(lag.res.cr_agg)
data = cbind(data, lag.res.cr_agg)

cr_sim_lag = lag.listw(lw, shape$cr_sim)
lag.list.cr_sim = list(shape$neighborhood, lag.listw(lw, shape$cr_sim))
lag.res.cr_sim = as.data.frame(lag.list.cr_sim)
colnames(lag.res.cr_sim) = c("neighborhood", "lag cr_sim (queen)")
head(lag.res.cr_sim)
data = cbind(data, lag.res.cr_sim)

cr_vca_lag = lag.listw(lw, shape$cr_vca)
lag.list.cr_vca = list(shape$neighborhood, lag.listw(lw, shape$cr_vca))
lag.res.cr_vca = as.data.frame(lag.list.cr_vca)
colnames(lag.res.cr_vca) = c("neighborhood", "lag cr_vca (queen)")
head(lag.res.cr_vca)
data = cbind(data, lag.res.cr_vca)

cr_vcns_lag = lag.listw(lw, shape$cr_vcns)
lag.list.cr_vcns = list(shape$neighborhood, lag.listw(lw, shape$cr_vcns))
lag.res.cr_vcns = as.data.frame(lag.list.cr_vcns)
colnames(lag.res.cr_vcns) = c("neighborhood", "lag cr_vcns (queen)")
head(lag.res.cr_vcns)
data = cbind(data, lag.res.cr_vcns)

cr_vcn_lag = lag.listw(lw, shape$cr_vcn)
lag.list.cr_vcn = list(shape$neighborhood, lag.listw(lw, shape$cr_vcn))
lag.res.cr_vcn = as.data.frame(lag.list.cr_vcn)
colnames(lag.res.cr_vcn) = c("neighborhood", "lag cr_vcn (queen)")
head(lag.res.cr_vcn)
data = cbind(data, lag.res.cr_vcn)

cr_prop_alt_lag = lag.listw(lw, shape$cr_prop_alt)
lag.list.cr_prop_alt = list(shape$neighborhood, lag.listw(lw, shape$cr_prop_alt))
lag.res.cr_prop_alt = as.data.frame(lag.list.cr_prop_alt)
colnames(lag.res.cr_prop_alt) = c("neighborhood", "lag cr_prop_alt (queen)")
head(lag.res.cr_prop_alt)
data = cbind(data, lag.res.cr_prop_alt)



save(data, file="data_reanalysis.RData")

saveRDS(data,file ="~/Downloads/replication_materials_data/reanalysis_new_data.RDS")

test <- readRDS(file = "~/Downloads/replication_materials_data/reanalysis_new_data.RDS")
