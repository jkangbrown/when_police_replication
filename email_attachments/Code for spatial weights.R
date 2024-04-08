library(sf); library(spdep); library(tmap)
library(haven)
library(readr)

setwd("~/Documents/GitHub/when_police_replication")

# Add a load command for the Stata data

data <- read_dta("~/Downloads/replication_materials_data/merged_data_for_analysis.dta")

# Point to a complete shape file:  
s = st_read("original_data_collection/statistical_neighborhoods/statistical_neighborhoods.shp")
names(s)
names(data)
data2 = dplyr::select(data,
             neighborhood, week, nh_week, period2, period3, violent, property, crime_assault, crime_mvt)
data2$NBHD_ID = data2$neighborhood
shape = merge(s, data2, by = "NBHD_ID")

#define neighboring polygons - going w/ queen
nb = poly2nb(shape, queen = T)

#get weights
lw = nb2listw(nb, style="W", zero.policy = T)

#Moran's I
moran_v = moran(shape$violent, lw, length(nb), Szero(lw))[1]
moran_v

moran_p = moran(shape$property, lw, length(nb), Szero(lw))[1]
moran_p

moran_a = moran(shape$crime_assault, lw, length(nb), Szero(lw))[1]
moran_a

moran_m = moran(shape$crime_mvt, lw, length(nb), Szero(lw))[1]
moran_m

#Test Moran's I
moran_v_test = moran.test(shape$violent, lw, alternative = "greater")
moran_v_test

moran_p_test = moran.test(shape$property, lw, alternative = "greater")
moran_p_test

moran_a_test = moran.test(shape$crime_assault, lw, alternative = "greater")
moran_a_test

moran_m_test = moran.test(shape$crime_mvt, lw, alternative = "greater")
moran_m_test

#create lagged measures by nhood - https://rpubs.com/erikaaldisa/spatialweights
violent_lag = lag.listw(lw, shape$violent)
lag.list.v = list(shape$NBHD_ID, lag.listw(lw, shape$violent))
lag.res.v = as.data.frame(lag.list.v)
colnames(lag.res.v) = c("NBHD_ID", "lag violent (queen)")
head(lag.res.v)
data = cbind(data, lag.res.v)

property_lag = lag.listw(lw, shape$property)
lag.list.p = list(shape$NBHD_ID, lag.listw(lw, shape$property))
lag.res.p = as.data.frame(lag.list.p)
colnames(lag.res.p) = c("NBHD_ID", "lag property (queen)")
head(lag.res.p)
data = cbind(data, lag.res.p)

assault_lag = lag.listw(lw, shape$crime_assault)
lag.list.a = list(shape$NBHD_ID, lag.listw(lw, shape$crime_assault))
lag.res.a = as.data.frame(lag.list.a)
colnames(lag.res.a) = c("NBHD_ID", "lag assault (queen)")
head(lag.res.a)
data = cbind(data, lag.res.a)

mvt_lag = lag.listw(lw, shape$crime_mvt)
lag.list.m = list(shape$NBHD_ID, lag.listw(lw, shape$crime_mvt))
lag.res.m = as.data.frame(lag.list.m)
colnames(lag.res.m) = c("NBHD_ID", "lag mvt (queen)")
head(lag.res.m)
data = cbind(data, lag.res.m)

save(data, file="~/Downloads/replication_materials_data/replication_data_resubmit.RData")

write_rds(data, file="~/Downloads/replication_materials_data/replication_with_merge_failure.RDS")
