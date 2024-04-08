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
# load("data.RData")

data <- read_rds(file="~/Downloads/replication_materials_data/replication_with_merge_failure.RDS")

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

# Produce output tables demonstrating the published results rely on failed matches

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
setwd ("~/Documents/Github/when_police_replication/replication_materials/replication_output")
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
setwd ("~/Documents/Github/when_police_replication/replication_materials/replication_output")


stargazer(s51, s52, s53, s54,  type="text",
          dep.var.labels=c("Pedestrian stops", "Vehicle stops", "Drug arrests", "Disorder arrests"),
          covariate.labels=c("COVID-19 period", "Floyd period", "Motor vehicle accidents", 
                             "Total population", "Disadvantage", "% Black", "% Hispanic", "Immigration", 
                             "Precipitation", "Temperature", "AQI", "OpenTable"),
          initial.zero = FALSE, 
          star.cutoffs = c(0.05, 0.01, 0.001),
          model.numbers = FALSE,
          title = "Table TK. Replication of Table S5 with Merge Failure",
          out = "s5_replication_merge_fail.txt")

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
          title = "Table TK. Replication of Table S6 Violent crime with Merge Failure",
          out = "s6_replication_merge_fail.txt")


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
          title = "Table TK. Replication of Table S7 - Property crime with Merge Failure",
          out = "s7_replication_merge_fail.txt")


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
          title = "Table TK. Replication of Table S5 with Merge Failure",
          out = "s5_replication_merge_fail.htm")

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
          out = "s6_replication_merge_fail.htm")


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
          title = "Table TK. Replication of Table S7 - Property crime with Merge Failure",
          out = "s7_replication_merge_fail.htm")





#SUPPLEMENTAL TABLES############################################################################################################################
#NOTE: some objects have the same name and will write over main table results.


#TABLE S4. The relationship between policing and crime in Denver neighborhoods in 2020 (Neighborhoods only).###########################################################################################
#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES

#Pedestrian stops
pstop_confounders = lmer (pstop_wgt_avg_3wk_dev ~  
                            (1 |neighborhood), 
                          data=data)
summary(pstop_confounders)
logLik(pstop_confounders, REML = F)
performance::icc(pstop_confounders)

#Vehicle stops
vstop_confounders = lmer (vstop_wgt_avg_3wk_dev ~ 
                            (1 |neighborhood), 
                          data=data)
summary(vstop_confounders)
logLik(vstop_confounders, REML = F)
performance::icc(vstop_confounders)

#Drug arrests
darrest_confounders = lmer (arrest_drug_wgt_avg_3wk_dev ~ 
                              (1 |neighborhood), 
                            data=data)
summary(darrest_confounders)  
logLik(darrest_confounders, REML = F)
performance::icc(darrest_confounders)

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_wgt_avg_3wk_dev ~ 
                                (1 |neighborhood), 
                              data=data)
summary(disarrest_confounders) 
logLik(disarrest_confounders, REML = F)
performance::icc(disarrest_confounders)


#PANEL 2 - VIOLENCE COUNT MODELS - NEGATIVE BINOMIAL DIRECT EFFECTS
violent_periods_conf_nb_w = glmer.nb (violent ~ 
                                        (1 |neighborhood), 
                                      data=data, nAGQ = 0)
summary(violent_periods_conf_nb_w)
performance::icc(violent_periods_conf_nb_w)

#PANEL 3 - PROPERTY COUNT MODELS - NEGATIVE BINOMIAL DIRECT EFFECTS
property_periods_conf_nb_w = glmer.nb (property ~ 
                                         (1 |neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)
performance::icc(property_periods_conf_nb_w)
#################################################################################################################################################




#Table S8. Mixed effects negative binomial regression models of motor vehicle theft counts in Denver neighborhoods in 2020.###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
crime_mvt_periods_conf_nb_w = glmer.nb (crime_mvt ~ period2 + period3 + 
                                          accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag mvt (queen)` +
                                          (1 + period2 + period3|neighborhood), 
                                        data=data, nAGQ = 0)
summary(crime_mvt_periods_conf_nb_w)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
crime_mvt_periods_conf_pstop_nb_w = glmer.nb (crime_mvt ~ period2 + period3 + 
                                                pstop_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag mvt (queen)` +
                                                (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, nAGQ = 0)
summary(crime_mvt_periods_conf_pstop_nb_w)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
crime_mvt_periods_conf_vstop_nb_w = glmer.nb (crime_mvt ~ period2 + period3 + 
                                                vstop_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag mvt (queen)` +
                                                (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, nAGQ = 0)
summary(crime_mvt_periods_conf_vstop_nb_w)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
crime_mvt_periods_conf_darrest_nb_w = glmer.nb (crime_mvt ~ period2 + period3 + 
                                                  arrest_drug_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag mvt (queen)` +
                                                  (1 + period2 + period3 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, nAGQ = 0)
summary(crime_mvt_periods_conf_darrest_nb_w)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
crime_mvt_periods_conf_disarrest_nb_w = glmer.nb (crime_mvt ~ period2 + period3 + 
                                                    arrest_disorder_wgt_avg_3wk_dev +
                                                    accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag mvt (queen)` +
                                                    (1 + period2 + period3 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                  data=data, nAGQ = 0)
summary(crime_mvt_periods_conf_disarrest_nb_w)
#################################################################################################################################################





#Table S9. Mixed effects negative binomial regression models of aggravated assault counts in Denver neighborhoods in 2020.###########################################################################################

###PERIODS + CONFROUNDERS W/ VCS
crime_assault_periods_conf_nb_w = glmer.nb (crime_assault ~ period2 + period3 + 
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag assault (queen)` +
                                              (1 + period2 + period3|neighborhood), 
                                            data=data, nAGQ = 0)
summary(crime_assault_periods_conf_nb_w)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
crime_assault_periods_conf_pstop_nb_w = glmer.nb (crime_assault ~ period2 + period3 + 
                                                    pstop_wgt_avg_3wk_dev +
                                                    accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag assault (queen)` +
                                                    (1 + period2 + period3 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                                  data=data, nAGQ = 0)
summary(crime_assault_periods_conf_pstop_nb_w)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
crime_assault_periods_conf_vstop_nb_w = glmer.nb (crime_assault ~ period2 + period3 + 
                                                    vstop_wgt_avg_3wk_dev +
                                                    accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag assault (queen)` +
                                                    (1 + period2 + period3 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                                  data=data, nAGQ = 0)
summary(crime_assault_periods_conf_vstop_nb_w)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
crime_assault_periods_conf_darrest_nb_w = glmer.nb (crime_assault ~ period2 + period3 + 
                                                      arrest_drug_wgt_avg_3wk_dev +
                                                      accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag assault (queen)` +
                                                      (1 + period2 + period3 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                                    data=data, nAGQ = 0)
summary(crime_assault_periods_conf_darrest_nb_w)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
crime_assault_periods_conf_disarrestt_nb_w = glmer.nb (crime_assault ~ period2 + period3 + 
                                                         arrest_disorder_wgt_avg_3wk_dev +
                                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag assault (queen)` +
                                                         (1 + period2 + period3 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                       data=data, nAGQ = 0)
summary(crime_assault_periods_conf_disarrestt_nb_w)
#################################################################################################################################################









#Table S10. Models from Table 1 re-estimated with equally weighted comparison years.###########################################################################################	

#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES
#Pedestrian stops
pstop_confounders = lmer (pstop_equal_3wk_dev ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(pstop_confounders)
BIC(pstop_confounders)

#Vehicle stops
vstop_confounders = lmer (vstop_equal_3wk_dev ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(vstop_confounders)
BIC(vstop_confounders)

#Drug arrests
darrest_confounders = lmer (arrest_drug_equal_3wk_dev ~ period2 + period3 + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + period2 + period3|neighborhood), 
                            data=data)
summary(darrest_confounders)  
BIC(darrest_confounders)

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_equal_3wk_dev ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period2 + period3|neighborhood), 
                              data=data)
summary(disarrest_confounders) 
BIC(disarrest_confounders)

#PANEL 2 - NEGATIVE BINOMIAL - VIOLENCE COUNTS 

###PERIODS + CONFROUNDERS W/ VCS
violent_periods_conf_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` + 
                                        (1 + period2 + period3|neighborhood), 
                                      data=data, nAGQ = 0)
summary(violent_periods_conf_nb_w)


###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
violent_periods_conf_pstop_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                              pstop_equal_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period2 + period3 + pstop_equal_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_pstop_nb_w)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
violent_periods_conf_vstop_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                              vstop_equal_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period2 + period3 + vstop_equal_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_vstop_nb_w)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
violent_periods_conf_darrest_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                                arrest_drug_equal_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                (1 + period2 + period3 + arrest_drug_equal_3wk_dev|neighborhood), 
                                              data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_darrest_nb_w)


###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS

violent_periods_conf_disarrest_nb_w = glmer.nb (violent ~ period2 + period3 + 
                                                  arrest_disorder_equal_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                  (1 + period2 + period3 + arrest_disorder_equal_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_disarrest_nb_w)


#PANEL 3 - PROPERTY COUNT MODELS - NEGATIVE BINOMIAL

###PERIODS + CONFROUNDERS W/ VCS
property_periods_conf_nb_w = glmer.nb (property ~ period2 + period3 + 
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + period2 + period3|neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
property_periods_conf_pstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               pstop_equal_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + pstop_equal_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop_nb_w)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
property_periods_conf_vstop_nb_w = glmer.nb (property ~ period2 + period3 + 
                                               vstop_equal_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period2 + period3 + vstop_equal_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop_nb_w)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
property_periods_conf_darrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                 arrest_drug_equal_3wk_dev +
                                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                                 (1 + period2 + period3 + arrest_drug_equal_3wk_dev|neighborhood), 
                                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest_nb_w)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
property_periods_conf_disarrest_nb_w = glmer.nb (property ~ period2 + period3 + 
                                                   arrest_disorder_equal_3wk_dev +
                                                   accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                                   (1 + period2 + period3 + arrest_disorder_equal_3wk_dev|neighborhood), 
                                                 data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest_nb_w)
######################################################################################################################################################################################







# Table S11. Models from Table 1 re-estimated with 2019 as the only comparison year.###########################################################################################

#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES
#Pedestrian stops
pstop_confounders = lmer (pstop_3wk_dev19 ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(pstop_confounders)

#Vehicle stops
vstop_confounders = lmer (vstop_3wk_dev19 ~ period2 + period3 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period2 + period3|neighborhood), 
                          data=data)
summary(vstop_confounders)

#Drug arrests
darrest_confounders = lmer (arrest_drug_3wk_dev19 ~ period2 + period3 + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + period2 + period3|neighborhood), 
                            data=data)
summary(darrest_confounders)  

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_3wk_dev19 ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period2 + period3|neighborhood), 
                              data=data)
summary(disarrest_confounders) 

#PANEL 2 - VIOLENCE COUNT MODELS - NEGATIVE BINOMIAL

###PERIODS + CONFROUNDERS W/ VCS
violent_periods_conf = glmer (violent ~ period2 + period3 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                (1 + period2 + period3|neighborhood), 
                              data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
violent_periods_conf_pstop = glmer (violent ~ period2 + period3 + 
                                      pstop_3wk_dev19 +
                                      accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                      (1 + period2 + period3 + pstop_3wk_dev19|neighborhood), 
                                    data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_pstop)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
violent_periods_conf_vstop = glmer (violent ~ period2 + period3 + 
                                      vstop_3wk_dev19 +
                                      accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                      (1 + period2 + period3 + vstop_3wk_dev19|neighborhood), 
                                    data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_vstop)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
violent_periods_conf_darrest = glmer (violent ~ period2 + period3 + 
                                        arrest_drug_3wk_dev19 +
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                        (1 + period2 + period3 + arrest_drug_3wk_dev19|neighborhood), 
                                      data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_darrest)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
violent_periods_conf_disarrest = glmer (violent ~ period2 + period3 + 
                                          arrest_disorder_3wk_dev19 +
                                          accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                          (1 + period2 + period3 + arrest_disorder_3wk_dev19|neighborhood), 
                                        data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_disarrest)


#PANEL 3 - PROPERTY COUNT MODELS - NEGATIVE BINOMIAL

###PERIODS + CONFROUNDERS W/ VCS
property_periods_conf = glmer (property ~ period2 + period3 + 
                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                 (1 + period2 + period3|neighborhood), 
                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf)

###PERIODS + CONFOUNDERS + PSTOPS W/ VCS
property_periods_conf_pstop = glmer (property ~ period2 + period3 + 
                                       pstop_3wk_dev19 +
                                       accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                       (1 + period2 + period3 + pstop_3wk_dev19|neighborhood), 
                                     data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop)

###PERIODS + CONFOUNDERS + VSTOPS W/ VCS
property_periods_conf_vstop = glmer (property ~ period2 + period3 + 
                                       vstop_3wk_dev19 +
                                       accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                       (1 + period2 + period3 + vstop_3wk_dev19|neighborhood), 
                                     data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop)

###PERIODS + CONFOUNDERS + DARRESTS W/ VCS
property_periods_conf_darrest = glmer (property ~ period2 + period3 + 
                                         arrest_drug_3wk_dev19 +
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + period2 + period3 + arrest_drug_3wk_dev19|neighborhood), 
                                       data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest)

###PERIODS + CONFOUNDERS + DISARRESTS W/ VCS
property_periods_conf_disarrest = glmer (property ~ period2 + period3 + 
                                           arrest_disorder_3wk_dev19 +
                                           accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                           (1 + period2 + period3 + arrest_disorder_3wk_dev19|neighborhood), 
                                         data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest)
######################################################################################################################################################################################




#Table S12. “Total Effect” of COVID and Floyd (weeks 1-10 = 0; weeks 11-52 = 1).	
#TOTAL EFFECTS MODEL W/ COVID AND FLOYD PERIOD COMBINED
  data$period4=data$period1==0

#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES###########################################################################################
#Pedestrian stops
pstop_confounders = lmer (pstop_wgt_avg_3wk_dev ~ period4 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period4|neighborhood), 
                          data=data)
summary(pstop_confounders)
BIC(pstop_confounders)
AIC(pstop_confounders)
logLik(pstop_confounders, REML = F)

#Vehicle stops
vstop_confounders = lmer (vstop_wgt_avg_3wk_dev ~ period4 + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + period4|neighborhood), 
                          data=data)
summary(vstop_confounders)
BIC(vstop_confounders)
AIC(vstop_confounders)
logLik(vstop_confounders, REML = F)

#Drug arrests
darrest_confounders = lmer (arrest_drug_wgt_avg_3wk_dev ~ period4 + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + period4|neighborhood), 
                            data=data)
summary(darrest_confounders)  
BIC(darrest_confounders)
AIC(darrest_confounders)
logLik(darrest_confounders, REML = F)

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_wgt_avg_3wk_dev ~ period4 + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + period4|neighborhood), 
                              data=data)
summary(disarrest_confounders) 
BIC(disarrest_confounders)
AIC(disarrest_confounders)
logLik(disarrest_confounders, REML = F)

#PANEL 2 - VIOLENCE COUNTS - NEGATIVE BINOMIAL
violent_periods_conf_nb_w = glmer.nb (violent ~ period4 + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` + 
                                        (1 + period4|neighborhood), 
                                      data=data, nAGQ = 0)
summary(violent_periods_conf_nb_w)

violent_periods_conf_pstop_nb_w = glmer.nb (violent ~ period4 + 
                                              pstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period4 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_pstop_nb_w)

violent_periods_conf_vstop_nb_w = glmer.nb (violent ~ period4 + 
                                              vstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + period4 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_vstop_nb_w)

violent_periods_conf_darrest_nb_w = glmer.nb (violent ~ period4 + 
                                                arrest_drug_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                (1 + period4 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_darrest_nb_w)

violent_periods_conf_disarrest_nb_w = glmer.nb (violent ~ period4 + 
                                                  arrest_disorder_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                  (1 + period4 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_disarrest_nb_w)


#PANEL 3 - PROPERTY COUNTS - NEGATIVE BINOMIAL 

###PERIODS + CONFROUNDERS W/ VCS
property_periods_conf_nb_w = glmer.nb (property ~ period4 + 
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + period4|neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)

property_periods_conf_pstop_nb_w = glmer.nb (property ~ period4 + 
                                               pstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period4 + pstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop_nb_w)

property_periods_conf_vstop_nb_w = glmer.nb (property ~ period4 + 
                                               vstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + period4 + vstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop_nb_w)

property_periods_conf_darrest_nb_w = glmer.nb (property ~ period4 + 
                                                 arrest_drug_wgt_avg_3wk_dev +
                                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                                 (1 + period4 + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest_nb_w)

property_periods_conf_disarrest_nb_w = glmer.nb (property ~ period4 + 
                                                   arrest_disorder_wgt_avg_3wk_dev +
                                                   accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                                   (1 + period4 + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                 data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest_nb_w)
################################################################################################################################################




# Table S13. COVID as reference period (weeks 1-10 dropped; weeks 11-21 = 0; weeks 22-52 = 1; N = 78, N*T = 3,276).	
#MODELS USING COVID ONLY AS PERIOD 0 AND FLOYD AS PERIOD 1
data$periodrr = NA
data$periodrr = ifelse(data$period2==1, 0, data$periodrr)
data$periodrr = ifelse(data$period3==1, 1, data$periodrr)

#PANEL 1 - OLS - MEDIATOR DEVIATIONS AS OUTCOMES###########################################################################################
#Pedestrian stops
pstop_confounders = lmer (pstop_wgt_avg_3wk_dev ~ periodrr + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + periodrr|neighborhood), 
                          data=data)
summary(pstop_confounders)
BIC(pstop_confounders)
AIC(pstop_confounders)
logLik(pstop_confounders, REML = F)

#Vehicle stops
vstop_confounders = lmer (vstop_wgt_avg_3wk_dev ~ periodrr + 
                            accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                            (1 + periodrr|neighborhood), 
                          data=data)
summary(vstop_confounders)
BIC(vstop_confounders)
AIC(vstop_confounders)
logLik(vstop_confounders, REML = F)

#Drug arrests
darrest_confounders = lmer (arrest_drug_wgt_avg_3wk_dev ~ periodrr + 
                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                              (1 + periodrr|neighborhood), 
                            data=data)
summary(darrest_confounders)  
BIC(darrest_confounders)
AIC(darrest_confounders)
logLik(darrest_confounders, REML = F)

#Disorder arrests
disarrest_confounders = lmer (arrest_disorder_wgt_avg_3wk_dev ~ periodrr + 
                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + 
                                (1 + periodrr|neighborhood), 
                              data=data)
summary(disarrest_confounders) 
BIC(disarrest_confounders)
AIC(disarrest_confounders)
logLik(disarrest_confounders, REML = F)

#PANEL 2 - VIOLENCE COUNTS - NEGATIVE BINOMIAL
violent_periods_conf_nb_w = glmer.nb (violent ~ periodrr + 
                                        accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` + 
                                        (1 + periodrr|neighborhood), 
                                      data=data, nAGQ = 0)
summary(violent_periods_conf_nb_w)

violent_periods_conf_pstop_nb_w = glmer.nb (violent ~ periodrr + 
                                              pstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + periodrr + pstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_pstop_nb_w)

violent_periods_conf_vstop_nb_w = glmer.nb (violent ~ periodrr + 
                                              vstop_wgt_avg_3wk_dev +
                                              accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                              (1 + periodrr + vstop_wgt_avg_3wk_dev|neighborhood), 
                                            data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_vstop_nb_w)

violent_periods_conf_darrest_nb_w = glmer.nb (violent ~ periodrr + 
                                                arrest_drug_wgt_avg_3wk_dev +
                                                accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                (1 + periodrr + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                              data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_darrest_nb_w)

violent_periods_conf_disarrest_nb_w = glmer.nb (violent ~ periodrr + 
                                                  arrest_disorder_wgt_avg_3wk_dev +
                                                  accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag violent (queen)` +
                                                  (1 + periodrr + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                data=data, family=poisson, nAGQ = 0)
summary(violent_periods_conf_disarrest_nb_w)

#PANEL 3 - PROPERTY COUNTS - NEGATIVE BINOMIAL 
property_periods_conf_nb_w = glmer.nb (property ~ periodrr + 
                                         accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                         (1 + periodrr|neighborhood), 
                                       data=data, nAGQ = 0)
summary(property_periods_conf_nb_w)

property_periods_conf_pstop_nb_w = glmer.nb (property ~ periodrr + 
                                               pstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + periodrr + pstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_pstop_nb_w)

property_periods_conf_vstop_nb_w = glmer.nb (property ~ periodrr + 
                                               vstop_wgt_avg_3wk_dev +
                                               accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                               (1 + periodrr + vstop_wgt_avg_3wk_dev|neighborhood), 
                                             data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_vstop_nb_w)

property_periods_conf_darrest_nb_w = glmer.nb (property ~ periodrr + 
                                                 arrest_drug_wgt_avg_3wk_dev +
                                                 accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` +
                                                 (1 + periodrr + arrest_drug_wgt_avg_3wk_dev|neighborhood), 
                                               data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_darrest_nb_w)

property_periods_conf_disarrest_nb_w = glmer.nb (property ~ periodrr + 
                                                   arrest_disorder_wgt_avg_3wk_dev +
                                                   accident + total_pop + disadvantage + pct_black + pct_hispanic_any + immigration + prcp + tavg + AQI + open_table + `lag property (queen)` + 
                                                   (1 + periodrr + arrest_disorder_wgt_avg_3wk_dev|neighborhood), 
                                                 data=data, family=poisson, nAGQ = 0)
summary(property_periods_conf_disarrest_nb_w)

#END OF SUPPLEMENTAL TABLES######################################################################################################################
