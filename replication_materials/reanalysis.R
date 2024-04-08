#######################################################################################

#load packages
library (Matrix); library (lme4); library (performance); library (lmerTest)
library (sjstats); library (stargazer); library (tidyverse); library("Hmisc")
library(car)
library(stargazer)

#get rid of scientific notation
options(scipen = 999)

#open data
setwd ("~/Downloads/replication_materials_data/")

#note: code to create the R dataset from the Stata file and calculate spatial 
#      weights available from the authors
load("data.RData")

data <- load("reanalysis.RDS")

#######################################################################################



#TABLE 1. MAIN TEXT
#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES
#Pedestrian stops
pstop_confounders = lmer (pstop_wgt_avg_3wk_dev ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(pstop_confounders)
BIC(pstop_confounders)
AIC(pstop_confounders)
logLik(pstop_confounders, REML = F)

#Vehicle stops
vstop_confounders = lmer (vstop_wgt_avg_3wk_dev ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(vstop_confounders)
BIC(vstop_confounders)
AIC(vstop_confounders)
logLik(vstop_confounders, REML = F)

#Drug arrests
darrest_confounders = lmer (arrest_drug_wgt_avg_3wk_dev ~ period2 + period3 + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + period2 + period3|neighborhood), 
                            data=data)
summary(darrest_confounders)  
BIC(darrest_confounders)
AIC(darrest_confounders)
logLik(darrest_confounders, REML = F)

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_wgt_avg_3wk_dev ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period2 + period3|neighborhood), 
                              data=data)
summary(disarrest_confounders) 
BIC(disarrest_confounders)
AIC(disarrest_confounders)
logLik(disarrest_confounders, REML = F)




#PANEL 2 - NEGATIVE BINOMIAL - VIOLENCE COUNTS DIRECT EFFECTS###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
violent_periods_conf_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` + 
                                        (1 + period2 + period3|neighborhood), 
                                      data=data, nAGQ = 0)
summary(violent_periods_conf_nb_w)
BIC(violent_periods_conf_nb_w)
AIC(violent_periods_conf_nb_w)
logLik(violent_periods_conf_nb_w, REML = F)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
violent_periods_conf_pstop_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                              pstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_pstop_nb_w)
BIC(violent_periods_conf_pstop_nb_w)
AIC(violent_periods_conf_pstop_nb_w)
logLik(violent_periods_conf_pstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
violent_periods_conf_vstop_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                              vstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_vstop_nb_w)
BIC(violent_periods_conf_vstop_nb_w)
AIC(violent_periods_conf_vstop_nb_w)
logLik(violent_periods_conf_vstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
violent_periods_conf_darrest_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                                arrest_drug_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                (1 + period2 + period3 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_darrest_nb_w)
BIC(violent_periods_conf_darrest_nb_w)
AIC(violent_periods_conf_darrest_nb_w)
logLik(violent_periods_conf_darrest_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
violent_periods_conf_disarrest_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                                  arrest_disorder_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                  (1 + period2 + period3 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_disarrest_nb_w)
BIC(violent_periods_conf_disarrest_nb_w)
AIC(violent_periods_conf_disarrest_nb_w)
logLik(violent_periods_conf_disarrest_nb_w, REML = F)




#PANEL 3 - PROPERTY COUNT MODELS - NEGATIVE BINOMIAL DIRECT EFFECTS###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
property_periods_conf_nb_w = glmer.nb (property ~ period2 + period3 + 
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + period2 + period3|neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)
BIC(property_periods_conf_nb_w)
AIC(property_periods_conf_nb_w)
logLik(property_periods_conf_nb_w, REML = F)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
property_periods_conf_pstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               pstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop_nb_w)
BIC(property_periods_conf_pstop_nb_w)
AIC(property_periods_conf_pstop_nb_w)
logLik(property_periods_conf_pstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
property_periods_conf_vstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               vstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop_nb_w)
BIC(property_periods_conf_vstop_nb_w)
AIC(property_periods_conf_vstop_nb_w)
logLik(property_periods_conf_vstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
property_periods_conf_darrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                 arrest_drug_wgt_avg_3wk_dev +
                                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                                 (1 + period2 + period3 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest_nb_w)
BIC(property_periods_conf_darrest_nb_w)
AIC(property_periods_conf_darrest_nb_w)
logLik(property_periods_conf_darrest_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
property_periods_conf_disarrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                   arrest_disorder_wgt_avg_3wk_dev +
                                                   accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                                   (1 + period2 + period3 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                 data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest_nb_w)
BIC(property_periods_conf_disarrest_nb_w)
AIC(property_periods_conf_disarrest_nb_w)
logLik(property_periods_conf_disarrest_nb_w, REML = F)
#END OF MAIN MODELS############################################################################################################################

## make a short name version of results, and change the class of object to work with table output
s51 <- pstop_confounders
s52 <- vstop_confounders
s53 <- darrest_confounders
s54 <- disarrest_confounders

class(s51) <- "lmerMod"
class(s52) <- "lmerMod"
class(s53) <- "lmerMod"
class(s54) <- "lmerMod"

s61 <- violent_periods_conf_nb_w
s62 <- violent_periods_conf_pstop_nb_w
s63 <- violent_periods_conf_vstop_nb_w
s64 <- violent_periods_conf_darrest_nb_w
s65 <- violent_periods_conf_disarrest_nb_w

class(s61) <- "lmerMod"
class(s62) <- "lmerMod"
class(s63) <- "lmerMod"
class(s64) <- "lmerMod"
class(s65) <- "lmerMod"

s71 <- property_periods_conf_nb_w
s72 <- property_periods_conf_pstop_nb_w
s73 <- property_periods_conf_vstop_nb_w
s74 <- property_periods_conf_darrest_nb_w
s75 <- property_periods_conf_disarrest_nb_w

class(s71) <- "lmerMod"
class(s72) <- "lmerMod"
class(s73) <- "lmerMod"
class(s74) <- "lmerMod"
class(s75) <- "lmerMod"

# Put in github as plain text 
setwd ("~/Documents/Github/when_police_replication/replication_materials/reanalysis_output")
pstop_confounders
vstop_confounders
darrest_confounders
disarrest_confounders

violent_periods_conf_nb_w
violent_periods_conf_pstop_nb_w
violent_periods_conf_vstop_nb_w
violent_periods_conf_darrest_nb_w
violent_periods_conf_disarrest_nb_w

property_periods_conf_nb_w
property_periods_conf_pstop_nb_w
property_periods_conf_vstop_nb_w
property_periods_conf_darrest_nb_w
property_periods_conf_disarrest_nb_w

# pstop_confounders, vstop_confounders, darrest_confounders, disarrest_confounders


# Put in github as plain text 
setwd ("~/Documents/Github/when_police_replication/replication_materials/reanalysis_output")

stargazer(s51, s52, s53, s54,  type="text",
          dep.var.labels=c("Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests"),
          covariate.labels=c("COVID-19 period", "Floyd period", "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          title = "Table TK. Replication of Table S5 without Merge Failure",
          out = "s5_reanalysis_merge_fix.txt")

stargazer(s61, s62, s63, s64, s65,  type="text",
          dep.var.labels=c("Periods only", "Mediator: Pedestrian stops", "Mediator: Vehicle stops", "Mediator: Drug arrests", "Mediator: Disorder arrests"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Replication of Table S6 Violent crime without Merge Failure",
          out = "s6_reanalysis_merge_fix.txt")


stargazer(s71, s72, s73, s74, s75,  type="text",
          dep.var.labels=c("Periods only", "Mediator: Pedestrian stops", "Mediator: Vehicle stops", "Mediator: Drug arrests", "Mediator: Disorder arrests"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Replication of Table S7 - Property crime without Merge Failure",
          out = "s7_reanalysis_merge_fix.txt")


# switch to HTML and save locally to work with as doc
setwd ("~/Downloads/replication_materials_data/")

stargazer(s51, s52, s53, s54,  type="html",
          dep.var.labels=c("Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests"),
          covariate.labels=c("COVID-19 period", "Floyd period", "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          title = "Table TK. Replication of Table S5 without Merge Failure",
          out = "s5_reanalysis_merge_fix.htm")

stargazer(s61, s62, s63, s64, s65,  type="html",
          dep.var.labels=c("Periods only", "Mediator: Pedestrian stops", "Mediator: Vehicle stops", "Mediator: Drug arrests", "Mediator: Disorder arrests"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Replication of Table S6 Violent crime without Merge Failure",
          out = "s6_reanalysis_merge_fix.htm")


stargazer(s71, s72, s73, s74, s75,  type="html",
          dep.var.labels=c("Periods only", "Mediator: Pedestrian stops", "Mediator: Vehicle stops", "Mediator: Drug arrests", "Mediator: Disorder arrests"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Replication of Table S7 - Property crime without Merge Failure",
          out = "s7_reanalysis_merge_fix.htm")



######### Reanalysis with alternate crime outcomes ###########################
######### Reanalysis with alternate mediators ####################################

#Reanalysis TABLE 1. 
#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES - Alternate Mediators 

#Drug only arrests
ar_drug_confounders = lmer (ar_drug_wgt_avg_3wk_dev  ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period2 + period3|neighborhood), 
                              data=data)
summary(ar_drug_confounders)  
BIC(ar_drug_confounders)
AIC(ar_drug_confounders)
logLik(ar_drug_confounders, REML = F)

#Drug and Alcohol with DUI and DUI Drugs arrests
ar_da_dui_confounders = lmer (ar_da_dui_wgt_avg_3wk_dev  ~ period2 + period3 + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + period2 + period3|neighborhood), 
                            data=data)
summary(ar_da_dui_confounders)  
BIC(ar_da_dui_confounders)
AIC(ar_da_dui_confounders)
logLik(ar_da_dui_confounders, REML = F)

#Disorder arrests
ar_dis_confounders = lmer (ar_dis_wgt_avg_3wk_dev ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period2 + period3|neighborhood), 
                              data=data)
summary(ar_dis_confounders) 
BIC(ar_dis_confounders)
AIC(ar_dis_confounders)
logLik(ar_dis_confounders, REML = F)


#Disorder arrests without FTAs included
ar_dis_nofta_confounders = lmer (ar_dis_nofta_wgt_avg_3wk_dev ~ period2 + period3 + 
                             accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                             (1 + period2 + period3|neighborhood), 
                           data=data)
summary(ar_dis_nofta_confounders) 
BIC(ar_dis_nofta_confounders)
AIC(ar_dis_nofta_confounders)
logLik(ar_dis_nofta_confounders, REML = F)


#PANEL 2 - NEGATIVE BINOMIAL - VIOLENCE COUNTS DIRECT EFFECTS###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
cr_vcn_periods_conf_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag + 
                                        (1 + period2 + period3|neighborhood), 
                                      data=data, nAGQ = 0)
summary(cr_vcn_periods_conf_nb_w)
BIC(cr_vcn_periods_conf_nb_w)
AIC(cr_vcn_periods_conf_nb_w)
logLik(cr_vcn_periods_conf_nb_w, REML = F)

###PERIODS + CONFOUNDERS + PSTOPS W/ VC Narrow but full aggravated assault category
cr_vcn_periods_conf_pstop_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                              pstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag +
                                              (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(cr_vcn_periods_conf_pstop_nb_w)
BIC(cr_vcn_periods_conf_pstop_nb_w)
AIC(cr_vcn_periods_conf_pstop_nb_w)
logLik(cr_vcn_periods_conf_pstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
cr_vcn_periods_conf_vstop_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                              vstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag +
                                              (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(cr_vcn_periods_conf_vstop_nb_w)
BIC(cr_vcn_periods_conf_vstop_nb_w)
AIC(cr_vcn_periods_conf_vstop_nb_w)
logLik(cr_vcn_periods_conf_vstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
cr_vcn_periods_conf_ar_da_dui_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                               ar_da_dui_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag +
                                                (1 + period2 + period3 + ar_da_dui_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, family=poisson, nAGQ = 0)
summary(cr_vcn_periods_conf_ar_da_dui_nb_w)
BIC(cr_vcn_periods_conf_ar_da_dui_nb_w)
AIC(cr_vcn_periods_conf_ar_da_dui_nb_w)
logLik(cr_vcn_periods_conf_ar_da_dui_nb_w, REML = F)

###PERIODS + CONFOUNDERS + W/ Narrow Violent Crime, broader disorder
cr_vcn_periods_conf_ar_dis_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                                ar_dis_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag +
                                                  (1 + period2 + period3 + ar_dis_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(cr_vcn_periods_conf_ar_dis_nb_w)
BIC(cr_vcn_periods_conf_ar_dis_nb_w)
AIC(cr_vcn_periods_conf_ar_dis_nb_w)
logLik(cr_vcn_periods_conf_ar_dis_nb_w, REML = F)

###PERIODS + CONFOUNDERS + W/ Narrow Violent Crime, broader disorder no FTA
cr_vcn_periods_conf_ar_dis_nofta_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                              ar_dis_nofta_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcn_lag +
                                              (1 + period2 + period3 + ar_dis_nofta_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(cr_vcn_periods_conf_ar_dis_nofta_nb_w)
BIC(cr_vcn_periods_conf_ar_dis_nofta_nb_w)
AIC(cr_vcn_periods_conf_ar_dis_nofta_nb_w)
logLik(cr_vcn_periods_conf_ar_dis_nofta_nb_w, REML = F)




#PANEL 3 - PROPERTY COUNT MODELS - NEGATIVE BINOMIAL DIRECT EFFECTS###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
property_periods_conf_nb_w = glmer.nb (property ~ period2 + period3 + 
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + period2 + period3|neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)
BIC(property_periods_conf_nb_w)
AIC(property_periods_conf_nb_w)
logLik(property_periods_conf_nb_w, REML = F)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
property_periods_conf_pstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               pstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop_nb_w)
BIC(property_periods_conf_pstop_nb_w)
AIC(property_periods_conf_pstop_nb_w)
logLik(property_periods_conf_pstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
property_periods_conf_vstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               vstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop_nb_w)
BIC(property_periods_conf_vstop_nb_w)
AIC(property_periods_conf_vstop_nb_w)
logLik(property_periods_conf_vstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
property_periods_conf_darrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                 arrest_drug_wgt_avg_3wk_dev +
                                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                                 (1 + period2 + period3 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest_nb_w)
BIC(property_periods_conf_darrest_nb_w)
AIC(property_periods_conf_darrest_nb_w)
logLik(property_periods_conf_darrest_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
property_periods_conf_disarrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                   arrest_disorder_wgt_avg_3wk_dev +
                                                   accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                                   (1 + period2 + period3 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                 data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest_nb_w)
BIC(property_periods_conf_disarrest_nb_w)
AIC(property_periods_conf_disarrest_nb_w)
logLik(property_periods_conf_disarrest_nb_w, REML = F)
#END OF MAIN MODELS############################################################################################################################

## make a short name version of results, and change the class of object to work with table output
vcn_61 <- cr_vcn_periods_conf_nb_w
vcn_62 <- cr_vcn_periods_conf_pstop_nb_w
vcn_63 <- cr_vcn_periods_conf_vstop_nb_w
vcn_64 <- cr_vcn_periods_conf_ar_da_dui_nb_w
vcn_65 <- cr_vcn_periods_conf_ar_dis_nb_w
vcn_66 <- cr_vcn_periods_conf_ar_dis_nofta_nb_w


class(vcn_61) <- "lmerMod"
class(vcn_62) <- "lmerMod"
class(vcn_63) <- "lmerMod"
class(vcn_64) <- "lmerMod"
class(vcn_65) <- "lmerMod"
class(vcn_66) <- "lmerMod"





# Put in github as plain text 
setwd ("~/Documents/Github/when_police_replication/replication_materials/reanalysis_output")

stargazer(vcn_61, vcn_62, vcn_63, vcn_64, vcn_65, vcn_66,  type="text",
          dep.var.labels=c("Periods only", "Pedestrian stops", "Vehicle stops", "Drug/Alc and DUI arrests", "Recoded Disorder arrests", "Recoded Disorder (No FTA)"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug/Alc, & DUI arrests", "Re-Disorder arrests","Re-Disorder arrests no FTA",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Reanalysis of Table S6 using corrected violent crime metric",
          out = "s6_reanalysis_new_vars_vcn.txt")



## make a short name version of results, and change the class of object to work with table output
vcn_61 <- cr_vcn_periods_conf_nb_w
vcn_62 <- cr_vcn_periods_conf_pstop_nb_w
vcn_63 <- cr_vcn_periods_conf_vstop_nb_w
vcn_64 <- cr_vcn_periods_conf_ar_da_dui_nb_w
vcn_65 <- cr_vcn_periods_conf_ar_dis_nb_w
vcn_66 <- cr_vcn_periods_conf_ar_dis_nofta_nb_w


class(vcn_61) <- "lmerMod"
class(vcn_62) <- "lmerMod"
class(vcn_63) <- "lmerMod"
class(vcn_64) <- "lmerMod"
class(vcn_65) <- "lmerMod"
class(vcn_66) <- "lmerMod"





# Put in github as plain text 
setwd ("~/Documents/Github/when_police_replication/replication_materials/reanalysis_output")

stargazer(vcn_61, vcn_62, vcn_63, vcn_64, vcn_65, vcn_66,  type="text",
          dep.var.labels=c("Periods only", "Pedestrian stops", "Vehicle stops", "Drug/Alc and DUI arrests", "Recoded Disorder arrests", "Recoded Disorder (No FTA)"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug/Alc, & DUI arrests", "Re-Disorder arrests","Re-Disorder arrests no FTA",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Reanalysis of Table S6 using corrected violent crime metric",
          out = "s6_reanalysis_new_vars_vcn.txt")


#PANEL 2 - NEGATIVE BINOMIAL - VIOLENCE COUNTS DIRECT EFFECTS###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
cr_vcns_periods_conf_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag + 
                                        (1 + period2 + period3|neighborhood), 
                                      data=data, nAGQ = 0)
summary(cr_vcns_periods_conf_nb_w)
BIC(cr_vcns_periods_conf_nb_w)
AIC(cr_vcns_periods_conf_nb_w)
logLik(cr_vcns_periods_conf_nb_w, REML = F)

###PERIODS + CONFOUNDERS + PSTOPS W/ VC Broad but full aggravated assault category
cr_vcns_periods_conf_pstop_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                              pstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag +
                                              (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(cr_vcns_periods_conf_pstop_nb_w)
BIC(cr_vcns_periods_conf_pstop_nb_w)
AIC(cr_vcns_periods_conf_pstop_nb_w)
logLik(cr_vcns_periods_conf_pstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
cr_vcns_periods_conf_vstop_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                              vstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag +
                                              (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(cr_vcns_periods_conf_vstop_nb_w)
BIC(cr_vcns_periods_conf_vstop_nb_w)
AIC(cr_vcns_periods_conf_vstop_nb_w)
logLik(cr_vcns_periods_conf_vstop_nb_w, REML = F)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
cr_vcns_periods_conf_ar_da_dui_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                                  ar_da_dui_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag +
                                                  (1 + period2 + period3 + ar_da_dui_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(cr_vcns_periods_conf_ar_da_dui_nb_w)
BIC(cr_vcns_periods_conf_ar_da_dui_nb_w)
AIC(cr_vcns_periods_conf_ar_da_dui_nb_w)
logLik(cr_vcns_periods_conf_ar_da_dui_nb_w, REML = F)

###PERIODS + CONFOUNDERS + W/ Broad Violent Crime, broader disorder
cr_vcns_periods_conf_ar_dis_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                               ar_dis_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag +
                                               (1 + period2 + period3 + ar_dis_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(cr_vcns_periods_conf_ar_dis_nb_w)
BIC(cr_vcns_periods_conf_ar_dis_nb_w)
AIC(cr_vcns_periods_conf_ar_dis_nb_w)
logLik(cr_vcns_periods_conf_ar_dis_nb_w, REML = F)

###PERIODS + CONFOUNDERS + W/ Broad Violent Crime, broader disorder no FTA
cr_vcns_periods_conf_ar_dis_nofta_nb_w = glmer.nb (cr_vcn ~ period2 + period3 + 
                                                     ar_dis_nofta_wgt_avg_3wk_dev +
                                                     accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + cr_vcns_lag +
                                                     (1 + period2 + period3 + ar_dis_nofta_wgt_avg_3wk_dev|neighborhood), 
                                                   data=data, family=poisson, nAGQ = 0)
summary(cr_vcns_periods_conf_ar_dis_nofta_nb_w)
BIC(cr_vcns_periods_conf_ar_dis_nofta_nb_w)
AIC(cr_vcns_periods_conf_ar_dis_nofta_nb_w)
logLik(cr_vcns_periods_conf_ar_dis_nofta_nb_w, REML = F)


## make a short name version of results, and change the class of object to work with table output
vcns_61 <- cr_vcns_periods_conf_nb_w
vcns_62 <- cr_vcns_periods_conf_pstop_nb_w
vcns_63 <- cr_vcns_periods_conf_vstop_nb_w
vcns_64 <- cr_vcns_periods_conf_ar_da_dui_nb_w
vcns_65 <- cr_vcns_periods_conf_ar_dis_nb_w
vcns_66 <- cr_vcns_periods_conf_ar_dis_nofta_nb_w


class(vcns_61) <- "lmerMod"
class(vcns_62) <- "lmerMod"
class(vcns_63) <- "lmerMod"
class(vcns_64) <- "lmerMod"
class(vcns_65) <- "lmerMod"
class(vcns_66) <- "lmerMod"


s_vcns_61 <- standardize (vcns_61, unchanged=c("period2","period3"))
s_vcns_62 <- standardize (vcns_62, unchanged=c("period2","period3"))
s_vcns_63 <- standardize (vcns_63, unchanged=c("period2","period3"))
s_vcns_64 <- standardize (vcns_64, unchanged=c("period2","period3"))
s_vcns_65 <- standardize (vcns_65, unchanged=c("period2","period3"))
s_vcns_66 <- standardize (vcns_66, unchanged=c("period2","period3"))


# Put in github as plain text 
setwd ("~/Documents/Github/when_police_replication/replication_materials/reanalysis_output")

stargazer(vcns_61, vcns_62, vcns_63, vcns_64, vcns_65, vcns_66,  type="text",
          dep.var.labels=c("Periods only", "Pedestrian stops", "Vehicle stops", "Drug/Alc and DUI arrests", "Recoded Disorder arrests", "Recoded Disorder (No FTA)"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug/Alc, & DUI arrests", "Re-Disorder arrests","Re-Disorder arrests no FTA",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Reanalysis of Table S6 using broader violent crime metric",
          out = "s6_reanalysis_new_vars_vcn.txt")


stargazer(s_vcns_61, s_vcns_62, s_vcns_63, s_vcns_64, s_vcns_65, s_vcns_66,  type="text",
          dep.var.labels=c("Periods only", "Pedestrian stops", "Vehicle stops", "Drug/Alc and DUI arrests", "Recoded Disorder arrests", "Recoded Disorder (No FTA)"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          covariate.labels=c("COVID-19 period", "Floyd period", 
                             "Pedestrian stops", "Vehicle stops", "Drug/Alc and DUI arrests", "Re-Disorder arrests","Re-Disorder arrests no FTA",
                             "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable", "Spatial lag"),
          title = "Table TK. Reanalysis of Table S6 using broader violent crime metric, standardized coef.",
          out = "s6_reanalysis_new_vars_std_vcn.txt")



