/* *****************************************************************************
Prep the data for "When police pull back: Neighborhood-level effects of de-policing on violent and property crime" in Criminology
* w/Jessie Huff, Scott Wolfe, David Pyrooz and Scott Mourtgos
* Written 10/29/21 by JN
* Last updated 6/27/23 by JN
* Modified for replication by Jacob Kang-Brown
*******************************************************************************/

* Set a global that points to the data folder
global denver "~/Downloads/replication_materials_data"

* Call up the geocoded CAD data

/* Work around to use in older version of stata involved opening in R with this
 code and then saving as CAD_geocoded_stata_old

library(haven)
CAD_geocoded <- read_dta("~/Downloads/replication_materials_data/CAD_geocoded.dta")
write_dta(
  CAD_geocoded,
  "~/Downloads/replication_materials_data/CAD_geocoded_stata_13.dta",
  version = 13,
  label = attr(data, "label"),
  strl_threshold = 2045,
	)
*/
	use "$denver/CAD_geocoded_stata_13.dta", clear

 
/* Extract from date variable	// already done in file posted online
	gen year = year(date)
	gen month = month(date)
	gen week = week(date)
	gen weekly = wofd(date)
	
	drop if year == 2021 // 1 observation
*/ 		// already done in file posted online

* collapse CAD down to NEIGHBORHOOD WEEK LEVEL (N is 52*5*78 = 20,280) and save a copy that'll be the merged dataset
* Note we didn't actually end up using this data as we could never confidently identify which calls were citizen v. police-initiated
	keep if AgencyType == "Police"
	gen vstop_cad = 1 if Problem == "Vehicle Stop"
	gen pstop_cad = 1 if Problem == "Subject Stop"
	gen self_cad = 1 if Problem == "Self Initiated Action"
	gen shotspotter_cad = 1 if Problem == "Shot Spotter"
	
	encode nbhd_name, gen(neighborhood) // was nhoodname in replication do file
	// this drops 515,831 rows in this table. 
	drop if neighborhood == . // N = 263,899 or 8.2% of CAD entries
	
	gen nh_week = .
	forval num = 2912(1)3171 {
		replace nh_week = `num'+(260*0)  if weekly == `num' & neighborhood == 1
		replace nh_week = `num'+(260*1)  if weekly == `num' & neighborhood == 2
		replace nh_week = `num'+(260*2)  if weekly == `num' & neighborhood == 3
		replace nh_week = `num'+(260*3)  if weekly == `num' & neighborhood == 4
		replace nh_week = `num'+(260*4)  if weekly == `num' & neighborhood == 5
		replace nh_week = `num'+(260*5)  if weekly == `num' & neighborhood == 6
		replace nh_week = `num'+(260*6)  if weekly == `num' & neighborhood == 7
		replace nh_week = `num'+(260*7)  if weekly == `num' & neighborhood == 8
		replace nh_week = `num'+(260*8)  if weekly == `num' & neighborhood == 9
		replace nh_week = `num'+(260*9)  if weekly == `num' & neighborhood == 10
		replace nh_week = `num'+(260*10) if weekly == `num' & neighborhood == 11
		replace nh_week = `num'+(260*11) if weekly == `num' & neighborhood == 12
		replace nh_week = `num'+(260*12) if weekly == `num' & neighborhood == 13
		replace nh_week = `num'+(260*13) if weekly == `num' & neighborhood == 14
		replace nh_week = `num'+(260*14) if weekly == `num' & neighborhood == 15
		replace nh_week = `num'+(260*15) if weekly == `num' & neighborhood == 16
		replace nh_week = `num'+(260*16) if weekly == `num' & neighborhood == 17
		replace nh_week = `num'+(260*17) if weekly == `num' & neighborhood == 18
		replace nh_week = `num'+(260*18) if weekly == `num' & neighborhood == 19
		replace nh_week = `num'+(260*19) if weekly == `num' & neighborhood == 20
		replace nh_week = `num'+(260*20) if weekly == `num' & neighborhood == 21
		replace nh_week = `num'+(260*21) if weekly == `num' & neighborhood == 22
		replace nh_week = `num'+(260*22) if weekly == `num' & neighborhood == 23
		replace nh_week = `num'+(260*23) if weekly == `num' & neighborhood == 24
		replace nh_week = `num'+(260*24) if weekly == `num' & neighborhood == 25
		replace nh_week = `num'+(260*25) if weekly == `num' & neighborhood == 26
		replace nh_week = `num'+(260*26) if weekly == `num' & neighborhood == 27
		replace nh_week = `num'+(260*27) if weekly == `num' & neighborhood == 28
		replace nh_week = `num'+(260*28) if weekly == `num' & neighborhood == 29
		replace nh_week = `num'+(260*29) if weekly == `num' & neighborhood == 30
		replace nh_week = `num'+(260*30) if weekly == `num' & neighborhood == 31
		replace nh_week = `num'+(260*31) if weekly == `num' & neighborhood == 32
		replace nh_week = `num'+(260*32) if weekly == `num' & neighborhood == 33
		replace nh_week = `num'+(260*33) if weekly == `num' & neighborhood == 34
		replace nh_week = `num'+(260*34) if weekly == `num' & neighborhood == 35
		replace nh_week = `num'+(260*35) if weekly == `num' & neighborhood == 36
		replace nh_week = `num'+(260*36) if weekly == `num' & neighborhood == 37
		replace nh_week = `num'+(260*37) if weekly == `num' & neighborhood == 38
		replace nh_week = `num'+(260*38) if weekly == `num' & neighborhood == 39
		replace nh_week = `num'+(260*39) if weekly == `num' & neighborhood == 40
		replace nh_week = `num'+(260*40) if weekly == `num' & neighborhood == 41
		replace nh_week = `num'+(260*41) if weekly == `num' & neighborhood == 42
		replace nh_week = `num'+(260*42) if weekly == `num' & neighborhood == 43
		replace nh_week = `num'+(260*43) if weekly == `num' & neighborhood == 44
		replace nh_week = `num'+(260*44) if weekly == `num' & neighborhood == 45
		replace nh_week = `num'+(260*45) if weekly == `num' & neighborhood == 46
		replace nh_week = `num'+(260*46) if weekly == `num' & neighborhood == 47
		replace nh_week = `num'+(260*47) if weekly == `num' & neighborhood == 48
		replace nh_week = `num'+(260*48) if weekly == `num' & neighborhood == 49
		replace nh_week = `num'+(260*49) if weekly == `num' & neighborhood == 50
		replace nh_week = `num'+(260*50) if weekly == `num' & neighborhood == 51
		replace nh_week = `num'+(260*51) if weekly == `num' & neighborhood == 52
		replace nh_week = `num'+(260*52) if weekly == `num' & neighborhood == 53
		replace nh_week = `num'+(260*53) if weekly == `num' & neighborhood == 54
		replace nh_week = `num'+(260*54) if weekly == `num' & neighborhood == 55
		replace nh_week = `num'+(260*55) if weekly == `num' & neighborhood == 56
		replace nh_week = `num'+(260*56) if weekly == `num' & neighborhood == 57
		replace nh_week = `num'+(260*57) if weekly == `num' & neighborhood == 58
		replace nh_week = `num'+(260*58) if weekly == `num' & neighborhood == 59
		replace nh_week = `num'+(260*59) if weekly == `num' & neighborhood == 60
		replace nh_week = `num'+(260*60) if weekly == `num' & neighborhood == 61
		replace nh_week = `num'+(260*61) if weekly == `num' & neighborhood == 62
		replace nh_week = `num'+(260*62) if weekly == `num' & neighborhood == 63
		replace nh_week = `num'+(260*63) if weekly == `num' & neighborhood == 64
		replace nh_week = `num'+(260*64) if weekly == `num' & neighborhood == 65
		replace nh_week = `num'+(260*65) if weekly == `num' & neighborhood == 66
		replace nh_week = `num'+(260*66) if weekly == `num' & neighborhood == 67
		replace nh_week = `num'+(260*67) if weekly == `num' & neighborhood == 68
		replace nh_week = `num'+(260*68) if weekly == `num' & neighborhood == 69
		replace nh_week = `num'+(260*69) if weekly == `num' & neighborhood == 70
		replace nh_week = `num'+(260*70) if weekly == `num' & neighborhood == 71
		replace nh_week = `num'+(260*71) if weekly == `num' & neighborhood == 72
		replace nh_week = `num'+(260*72) if weekly == `num' & neighborhood == 73
		replace nh_week = `num'+(260*73) if weekly == `num' & neighborhood == 74
		replace nh_week = `num'+(260*74) if weekly == `num' & neighborhood == 75
		replace nh_week = `num'+(260*75) if weekly == `num' & neighborhood == 76
		replace nh_week = `num'+(260*76) if weekly == `num' & neighborhood == 77
		replace nh_week = `num'+(260*77) if weekly == `num' & neighborhood == 78
		}	
		
	beep
	
	collapse (sum) *cad, by(nh_week)
	
	save "$denver/merged_data_for_analysis.dta", replace
	// Intermediate save
	save "$denver/cad_processed.dta", replace
	use "$denver/cad_processed.dta", clear

*********************************************************************************************************	
* Import, clean the traffic/pedestrian stop dataset
	import delimited "$denver/police_pedestrian_stops_and_vehicle_stops.csv", clear
	
	gen pstop_pdi = 1 if problem == "Subject Stop"
	gen vstop_pdi = 1 if problem == "Vehicle Stop"
	
* drop 379,643 incidents from prior to 2016
	gen year = substr(master_incident_number, 5, 2)
	tab year
	replace year = substr(master_incident_number, 6, 2) if year == "-1"
	drop if year == "10" | year == "11" | year == "12" | year == "13" | year == "14" | year == "15"

* try to make sense of this messy date variable
	gen date_str = word(time_phonepickup, 1)
	gen no_date = regexm(date_str, ":") == 1
	gen date = date(date_str, "MDY") if no_date != 1
	gen week = week(date)
	gen weekly = wofd(date)
	format date %td
	
* check dispersion of missing dates, drop anything before 1/1/2016
	tab year no_date, row // approx 11-12% each year
	drop if no_date == 1 // n = 67,698
	display date("1-1-2016", "MDY")
	drop if date < 20454
	drop if year == "21"

* generate stop variables for each year for each neighborhood
* first, combine central park (11) and stapelton (62), as these are the same geographic area, it just changed names
* also, change "None" (48) to missing, and recode the neighborhoods > 48 so that the range is 1-78 with no skips
	encode neighborhood_name, gen(neighborhood)
	recode neighborhood (62 = 11)
	recode neighborhood (48 = .)
	replace neighborhood = neighborhood - 1 if neighborhood >=49 & neighborhood <= 61
	replace neighborhood = neighborhood - 2 if neighborhood >= 63 & neighborhood <= 80
	sum neighborhood
	
	drop if neighborhood == . // N = 10,014 or 2.04% of stops
	
	gen nh_week = .
	forval num = 2912(1)3171 {
		replace nh_week = `num'+(260*0)  if weekly == `num' & neighborhood == 1
		replace nh_week = `num'+(260*1)  if weekly == `num' & neighborhood == 2
		replace nh_week = `num'+(260*2)  if weekly == `num' & neighborhood == 3
		replace nh_week = `num'+(260*3)  if weekly == `num' & neighborhood == 4
		replace nh_week = `num'+(260*4)  if weekly == `num' & neighborhood == 5
		replace nh_week = `num'+(260*5)  if weekly == `num' & neighborhood == 6
		replace nh_week = `num'+(260*6)  if weekly == `num' & neighborhood == 7
		replace nh_week = `num'+(260*7)  if weekly == `num' & neighborhood == 8
		replace nh_week = `num'+(260*8)  if weekly == `num' & neighborhood == 9
		replace nh_week = `num'+(260*9)  if weekly == `num' & neighborhood == 10
		replace nh_week = `num'+(260*10) if weekly == `num' & neighborhood == 11
		replace nh_week = `num'+(260*11) if weekly == `num' & neighborhood == 12
		replace nh_week = `num'+(260*12) if weekly == `num' & neighborhood == 13
		replace nh_week = `num'+(260*13) if weekly == `num' & neighborhood == 14
		replace nh_week = `num'+(260*14) if weekly == `num' & neighborhood == 15
		replace nh_week = `num'+(260*15) if weekly == `num' & neighborhood == 16
		replace nh_week = `num'+(260*16) if weekly == `num' & neighborhood == 17
		replace nh_week = `num'+(260*17) if weekly == `num' & neighborhood == 18
		replace nh_week = `num'+(260*18) if weekly == `num' & neighborhood == 19
		replace nh_week = `num'+(260*19) if weekly == `num' & neighborhood == 20
		replace nh_week = `num'+(260*20) if weekly == `num' & neighborhood == 21
		replace nh_week = `num'+(260*21) if weekly == `num' & neighborhood == 22
		replace nh_week = `num'+(260*22) if weekly == `num' & neighborhood == 23
		replace nh_week = `num'+(260*23) if weekly == `num' & neighborhood == 24
		replace nh_week = `num'+(260*24) if weekly == `num' & neighborhood == 25
		replace nh_week = `num'+(260*25) if weekly == `num' & neighborhood == 26
		replace nh_week = `num'+(260*26) if weekly == `num' & neighborhood == 27
		replace nh_week = `num'+(260*27) if weekly == `num' & neighborhood == 28
		replace nh_week = `num'+(260*28) if weekly == `num' & neighborhood == 29
		replace nh_week = `num'+(260*29) if weekly == `num' & neighborhood == 30
		replace nh_week = `num'+(260*30) if weekly == `num' & neighborhood == 31
		replace nh_week = `num'+(260*31) if weekly == `num' & neighborhood == 32
		replace nh_week = `num'+(260*32) if weekly == `num' & neighborhood == 33
		replace nh_week = `num'+(260*33) if weekly == `num' & neighborhood == 34
		replace nh_week = `num'+(260*34) if weekly == `num' & neighborhood == 35
		replace nh_week = `num'+(260*35) if weekly == `num' & neighborhood == 36
		replace nh_week = `num'+(260*36) if weekly == `num' & neighborhood == 37
		replace nh_week = `num'+(260*37) if weekly == `num' & neighborhood == 38
		replace nh_week = `num'+(260*38) if weekly == `num' & neighborhood == 39
		replace nh_week = `num'+(260*39) if weekly == `num' & neighborhood == 40
		replace nh_week = `num'+(260*40) if weekly == `num' & neighborhood == 41
		replace nh_week = `num'+(260*41) if weekly == `num' & neighborhood == 42
		replace nh_week = `num'+(260*42) if weekly == `num' & neighborhood == 43
		replace nh_week = `num'+(260*43) if weekly == `num' & neighborhood == 44
		replace nh_week = `num'+(260*44) if weekly == `num' & neighborhood == 45
		replace nh_week = `num'+(260*45) if weekly == `num' & neighborhood == 46
		replace nh_week = `num'+(260*46) if weekly == `num' & neighborhood == 47
		replace nh_week = `num'+(260*47) if weekly == `num' & neighborhood == 48
		replace nh_week = `num'+(260*48) if weekly == `num' & neighborhood == 49
		replace nh_week = `num'+(260*49) if weekly == `num' & neighborhood == 50
		replace nh_week = `num'+(260*50) if weekly == `num' & neighborhood == 51
		replace nh_week = `num'+(260*51) if weekly == `num' & neighborhood == 52
		replace nh_week = `num'+(260*52) if weekly == `num' & neighborhood == 53
		replace nh_week = `num'+(260*53) if weekly == `num' & neighborhood == 54
		replace nh_week = `num'+(260*54) if weekly == `num' & neighborhood == 55
		replace nh_week = `num'+(260*55) if weekly == `num' & neighborhood == 56
		replace nh_week = `num'+(260*56) if weekly == `num' & neighborhood == 57
		replace nh_week = `num'+(260*57) if weekly == `num' & neighborhood == 58
		replace nh_week = `num'+(260*58) if weekly == `num' & neighborhood == 59
		replace nh_week = `num'+(260*59) if weekly == `num' & neighborhood == 60
		replace nh_week = `num'+(260*60) if weekly == `num' & neighborhood == 61
		replace nh_week = `num'+(260*61) if weekly == `num' & neighborhood == 62
		replace nh_week = `num'+(260*62) if weekly == `num' & neighborhood == 63
		replace nh_week = `num'+(260*63) if weekly == `num' & neighborhood == 64
		replace nh_week = `num'+(260*64) if weekly == `num' & neighborhood == 65
		replace nh_week = `num'+(260*65) if weekly == `num' & neighborhood == 66
		replace nh_week = `num'+(260*66) if weekly == `num' & neighborhood == 67
		replace nh_week = `num'+(260*67) if weekly == `num' & neighborhood == 68
		replace nh_week = `num'+(260*68) if weekly == `num' & neighborhood == 69
		replace nh_week = `num'+(260*69) if weekly == `num' & neighborhood == 70
		replace nh_week = `num'+(260*70) if weekly == `num' & neighborhood == 71
		replace nh_week = `num'+(260*71) if weekly == `num' & neighborhood == 72
		replace nh_week = `num'+(260*72) if weekly == `num' & neighborhood == 73
		replace nh_week = `num'+(260*73) if weekly == `num' & neighborhood == 74
		replace nh_week = `num'+(260*74) if weekly == `num' & neighborhood == 75
		replace nh_week = `num'+(260*75) if weekly == `num' & neighborhood == 76
		replace nh_week = `num'+(260*76) if weekly == `num' & neighborhood == 77
		replace nh_week = `num'+(260*77) if weekly == `num' & neighborhood == 78
		}	
		
	beep

	collapse (sum) *_pdi, by(nh_week)
		
	merge 1:1 nh_week using "$denver/merged_data_for_analysis.dta"
	
* Some nhweeks show up as missing since there weren't stops in some neighborhoods for some weeks (N=993)
	replace pstop_pdi = 0 if pstop_pdi == .
	replace vstop_pdi = 0 if vstop_pdi == .
		
	save "$denver/merged_data_for_analysis.dta", replace	
	
	// Intermediate save
	save "$denver/merged_data_for_analysis_pre_crime.dta", replace	
	
	

*********************************************************************************************************
* Import, clean and merge the reported crimes dataset
	import delimited "$denver/crime.csv", clear
	
* Create variables for all the offenses we're interested in
	gen crime_murder = 1 if offense_category_id == "murder" & offense_type_id != "homicide-police-by-gun"
	gen crime_rob = 1 if offense_category_id == "robbery"
	gen crime_assault = 1 if offense_category_id == "aggravated-assault"
	gen crime_rape = 1 if offense_type_id == "sex-aslt-rape" | ///
						offense_type_id == "sex-aslt-rape-pot" | ///
						offense_type_id == "sex-aslt-w-object" | ///
						offense_type_id == "sex-aslt-w-object-pot" | ///
						offense_type_id == "sex-asslt-sodomy-man-strng-arm"
	gen crime_VC = 1 if crime_murder == 1 | crime_rob == 1 | crime_assault == 1 | crime_rape == 1
	gen crime_VC_norape = 1 if crime_murder == 1 | crime_rob == 1 | crime_assault == 1
	gen crime_mvt = 1 if offense_category_id == "auto-theft"
	gen crime_cburg = 1 if offense_category_id == "burglary" & regexm(offense_type_id, "bus") == 1
	gen crime_rburg = 1 if offense_category_id == "burglary" & regexm(offense_type_id, "res") == 1
	gen crime_larceny = 1 if offense_category_id == "larceny"
	gen crime_tmv = 1 if offense_category_id == "theft-from-motor-vehicle"
	gen crime_prop = 1 if crime_mvt == 1 | crime_rburg == 1 | crime_cburg == 1 | crime_larceny == 1 | crime_tmv == 1
	gen crime_weapon = 1 if regexm(offense_type_id, "weapon") == 1 & offense_category_id == "all-other-crimes"
	gen police = 1 if regexm(offense_type_id, "police") == 1
	gen crime_assault_cop = 1 if police == 1 & regexm(offense_type_id, "aslt") == 1
	replace crime_assault_cop = 1 if offense_type_id == "assault-police-simple" | offense_type_id == "homicide-police-by-gun"
	gen crime_resist_cop = 1 if police == 1 & offense_type_id == "police-disobey-lawful-order" | ///
											offense_type_id == "police-interference" | ///
											offense_type_id == "police-obstruct-investigation" | ///
											offense_type_id == "police-resisting-arrest"
	gen crime_challenge_cop = 1 if crime_assault_cop == 1 | crime_resist_cop == 1
	
* Clean up the date variable
	gen date_str = word(first_occurrence_date, 1)
	gen date = date(date_str, "MDY")
	format date %td
	sort date
	gen year = year(date)
	gen week = week(date)
	gen month = month(date)
	gen weekly = wofd(date)
	drop if year == 2021

* Encode and clean the Neighborhood variable
* combine Stapleton (61) with Central Park (11), and recode neighborhoods >62 so that range = 1-78
	encode neighborhood_id, gen(neighborhood)
	recode neighborhood (61 = 11)
	replace neighborhood = neighborhood - 1 if neighborhood >= 62 & neighborhood <= 80
	
	drop if neighborhood == . // N = 1
	
	gen nh_week = .
	forval num = 2912(1)3171 {
		replace nh_week = `num'+(260*0)  if weekly == `num' & neighborhood == 1
		replace nh_week = `num'+(260*1)  if weekly == `num' & neighborhood == 2
		replace nh_week = `num'+(260*2)  if weekly == `num' & neighborhood == 3
		replace nh_week = `num'+(260*3)  if weekly == `num' & neighborhood == 4
		replace nh_week = `num'+(260*4)  if weekly == `num' & neighborhood == 5
		replace nh_week = `num'+(260*5)  if weekly == `num' & neighborhood == 6
		replace nh_week = `num'+(260*6)  if weekly == `num' & neighborhood == 7
		replace nh_week = `num'+(260*7)  if weekly == `num' & neighborhood == 8
		replace nh_week = `num'+(260*8)  if weekly == `num' & neighborhood == 9
		replace nh_week = `num'+(260*9)  if weekly == `num' & neighborhood == 10
		replace nh_week = `num'+(260*10) if weekly == `num' & neighborhood == 11
		replace nh_week = `num'+(260*11) if weekly == `num' & neighborhood == 12
		replace nh_week = `num'+(260*12) if weekly == `num' & neighborhood == 13
		replace nh_week = `num'+(260*13) if weekly == `num' & neighborhood == 14
		replace nh_week = `num'+(260*14) if weekly == `num' & neighborhood == 15
		replace nh_week = `num'+(260*15) if weekly == `num' & neighborhood == 16
		replace nh_week = `num'+(260*16) if weekly == `num' & neighborhood == 17
		replace nh_week = `num'+(260*17) if weekly == `num' & neighborhood == 18
		replace nh_week = `num'+(260*18) if weekly == `num' & neighborhood == 19
		replace nh_week = `num'+(260*19) if weekly == `num' & neighborhood == 20
		replace nh_week = `num'+(260*20) if weekly == `num' & neighborhood == 21
		replace nh_week = `num'+(260*21) if weekly == `num' & neighborhood == 22
		replace nh_week = `num'+(260*22) if weekly == `num' & neighborhood == 23
		replace nh_week = `num'+(260*23) if weekly == `num' & neighborhood == 24
		replace nh_week = `num'+(260*24) if weekly == `num' & neighborhood == 25
		replace nh_week = `num'+(260*25) if weekly == `num' & neighborhood == 26
		replace nh_week = `num'+(260*26) if weekly == `num' & neighborhood == 27
		replace nh_week = `num'+(260*27) if weekly == `num' & neighborhood == 28
		replace nh_week = `num'+(260*28) if weekly == `num' & neighborhood == 29
		replace nh_week = `num'+(260*29) if weekly == `num' & neighborhood == 30
		replace nh_week = `num'+(260*30) if weekly == `num' & neighborhood == 31
		replace nh_week = `num'+(260*31) if weekly == `num' & neighborhood == 32
		replace nh_week = `num'+(260*32) if weekly == `num' & neighborhood == 33
		replace nh_week = `num'+(260*33) if weekly == `num' & neighborhood == 34
		replace nh_week = `num'+(260*34) if weekly == `num' & neighborhood == 35
		replace nh_week = `num'+(260*35) if weekly == `num' & neighborhood == 36
		replace nh_week = `num'+(260*36) if weekly == `num' & neighborhood == 37
		replace nh_week = `num'+(260*37) if weekly == `num' & neighborhood == 38
		replace nh_week = `num'+(260*38) if weekly == `num' & neighborhood == 39
		replace nh_week = `num'+(260*39) if weekly == `num' & neighborhood == 40
		replace nh_week = `num'+(260*40) if weekly == `num' & neighborhood == 41
		replace nh_week = `num'+(260*41) if weekly == `num' & neighborhood == 42
		replace nh_week = `num'+(260*42) if weekly == `num' & neighborhood == 43
		replace nh_week = `num'+(260*43) if weekly == `num' & neighborhood == 44
		replace nh_week = `num'+(260*44) if weekly == `num' & neighborhood == 45
		replace nh_week = `num'+(260*45) if weekly == `num' & neighborhood == 46
		replace nh_week = `num'+(260*46) if weekly == `num' & neighborhood == 47
		replace nh_week = `num'+(260*47) if weekly == `num' & neighborhood == 48
		replace nh_week = `num'+(260*48) if weekly == `num' & neighborhood == 49
		replace nh_week = `num'+(260*49) if weekly == `num' & neighborhood == 50
		replace nh_week = `num'+(260*50) if weekly == `num' & neighborhood == 51
		replace nh_week = `num'+(260*51) if weekly == `num' & neighborhood == 52
		replace nh_week = `num'+(260*52) if weekly == `num' & neighborhood == 53
		replace nh_week = `num'+(260*53) if weekly == `num' & neighborhood == 54
		replace nh_week = `num'+(260*54) if weekly == `num' & neighborhood == 55
		replace nh_week = `num'+(260*55) if weekly == `num' & neighborhood == 56
		replace nh_week = `num'+(260*56) if weekly == `num' & neighborhood == 57
		replace nh_week = `num'+(260*57) if weekly == `num' & neighborhood == 58
		replace nh_week = `num'+(260*58) if weekly == `num' & neighborhood == 59
		replace nh_week = `num'+(260*59) if weekly == `num' & neighborhood == 60
		replace nh_week = `num'+(260*60) if weekly == `num' & neighborhood == 61
		replace nh_week = `num'+(260*61) if weekly == `num' & neighborhood == 62
		replace nh_week = `num'+(260*62) if weekly == `num' & neighborhood == 63
		replace nh_week = `num'+(260*63) if weekly == `num' & neighborhood == 64
		replace nh_week = `num'+(260*64) if weekly == `num' & neighborhood == 65
		replace nh_week = `num'+(260*65) if weekly == `num' & neighborhood == 66
		replace nh_week = `num'+(260*66) if weekly == `num' & neighborhood == 67
		replace nh_week = `num'+(260*67) if weekly == `num' & neighborhood == 68
		replace nh_week = `num'+(260*68) if weekly == `num' & neighborhood == 69
		replace nh_week = `num'+(260*69) if weekly == `num' & neighborhood == 70
		replace nh_week = `num'+(260*70) if weekly == `num' & neighborhood == 71
		replace nh_week = `num'+(260*71) if weekly == `num' & neighborhood == 72
		replace nh_week = `num'+(260*72) if weekly == `num' & neighborhood == 73
		replace nh_week = `num'+(260*73) if weekly == `num' & neighborhood == 74
		replace nh_week = `num'+(260*74) if weekly == `num' & neighborhood == 75
		replace nh_week = `num'+(260*75) if weekly == `num' & neighborhood == 76
		replace nh_week = `num'+(260*76) if weekly == `num' & neighborhood == 77
		replace nh_week = `num'+(260*77) if weekly == `num' & neighborhood == 78
		}	
		
	beep
	
	collapse (sum) crime_*, by(nh_week)

	merge 1:1 nh_week using "$denver/merged_data_for_analysis.dta", gen(_merge2)
	
	* Replace missings with zeros (N = 98)
		local crime "crime_murder crime_rob crime_assault crime_rape crime_VC crime_VC_norape crime_mvt crime_cburg crime_rburg crime_larceny crime_tmv crime_prop crime_weapon crime_assault_cop crime_resist_cop crime_challenge_cop"
		foreach i in `crime' {
			replace `i' = 0 if `i' == .
			}
	
	save "$denver/merged_data_for_analysis.dta", replace
	
	// Intermediate save
	save "$denver/merged_data_for_analysis_pre_arrest.dta", replace
	
*********************************************************************************************************
* Import ARREST data, clean, collapse and merge
	global arrest "$denver/Arrest_Files"
	
* There are 5 files, one for each year, 2016-2020. This loop will define the files, generate a temporary "master" file, and import/append each of the data files. 
/*  This loop did not work for me
	cd "$arrest"
	local files: dir "$arrest" files "Arrest*.xlsx"
	di `"`files'"'
	tempfile master // generate temporary save file to store data in
	save `master', replace empty
	foreach x in `files' {
		di "`x'" // display file name
		
		* import each file
			qui: import excel using "`x'", first case(preserve) sheet("Sheet1") clear // import csv file
			qui: gen data_id = subinstr("`x'", ".xlsx", "", .) // generate id variable
		
		* append each file to the master file
			append using `master', force
			save `master', replace
	}
*/
	
//  so I opened the files in excel, saved as a CSV and ran this code
 
clear
	cd "$arrest"
	local files: dir "$arrest" files "Arrest*.csv"
	di `"`files'"'
	tempfile main // generate temporary save file to store data in
	save `main', replace empty
	clear
	foreach x in `files' {
		di "`x'" // display file name
		
		* import each file
			qui: import delimited "`x'",  case(preserve) clear 
			qui: gen data_id = subinstr("`x'", ".xlsx", "", .) // generate id variable
		
		* append each file to the main file
			append using `main', force
			save `main', replace
	}
	
	
	order data_id, first
	
	gen ArrestDate_coded =  daily(ArrestDate, "MDY", 2050)
	drop ArrestDate 
	clonevar ArrestDate = ArrestDate_coded
	
	drop if ArrestDate == . // each file had a bunch of blank rows at the bottom
	
	save "$denver/Arrest_data_merged.dta", replace
	
	use "$denver/Arrest_data_merged.dta", clear
	
	gen year = year(ArrestDate)
	gen month = month(ArrestDate)
	gen weekly = wofd(ArrestDate)
	
* Crime categories, per the "offense_codes" file downloaded from the Open Data Portal
	gen arrest = 1
	
	gen arrest_agg_assault = 1 if UCR == 1310 | UCR == 1311 | UCR == 1312 | UCR == 1314 | UCR == 1315
	gen arrest_simp_assault = 1 if UCR == 1313
	gen arrest_robbery = 1 if UCR == 1202 | UCR == 1205 | UCR == 1208 | UCR == 1210 | UCR == 1211 | UCR == 1212
	gen arrest_murder = 1 if UCR == 902 | UCR == 907 | UCR == 908 | UCR == 910 | UCR == 912
	gen arrest_rape = 1 if UCR == 1102
	
	gen arrest_violent = 1 if arrest_agg_assault == 1 | arrest_simp_assault == 1 | arrest_robbery == 1 | arrest_murder == 1 | arrest_rape == 1		
	gen arrest_drug = 1 if (UCR >= 3501 & UCR <= 3599) | (UCR >= 4101 & UCR <= 4200)
	gen arrest_disorder = 1 if UCR == 1316 | (UCR >= 2901 & UCR <= 2999) | (UCR >= 4001 & UCR <= 4099) | UCR == 5302 | UCR == 5303 | UCR == 5309 | (UCR >= 5312 & UCR <= 5399)
	gen arrest_mvt = 1 if UCR == 2399 | UCR == 2404 | UCR == 2411
	gen arrest_weapon = 1 if UCR == 5202 | UCR == 5203 | UCR == 5212 | UCR == 5213 | UCR == 5299
	gen arrest_flee = 1 if UCR == 5499
	gen arrest_rburg = 1 if UCR == 2202 | UCR == 2204
	gen arrest_cburg = 1 if UCR == 2203 | UCR == 2205
	gen arrest_larceny = 1 if (UCR >= 2301 & UCR <= 2303) | (UCR >= 2307 & UCR <= 2311) | UCR == 2399 | UCR == 2699

* Encode Nbhd_Name
* This will be our neighborhood identifier, and I've confirmed it runs 1-78 and matches the other datasets
* I.E., "None" and "Stapleton" do not appear here.

	encode Nbhd_Name, gen(neighborhood)
	
	drop if neighborhood == . // N = 13,268 or 6.11% of the data
	
	gen nh_week = .
	forval num = 2912(1)3171 {
		replace nh_week = `num'+(260*0)  if weekly == `num' & neighborhood == 1
		replace nh_week = `num'+(260*1)  if weekly == `num' & neighborhood == 2
		replace nh_week = `num'+(260*2)  if weekly == `num' & neighborhood == 3
		replace nh_week = `num'+(260*3)  if weekly == `num' & neighborhood == 4
		replace nh_week = `num'+(260*4)  if weekly == `num' & neighborhood == 5
		replace nh_week = `num'+(260*5)  if weekly == `num' & neighborhood == 6
		replace nh_week = `num'+(260*6)  if weekly == `num' & neighborhood == 7
		replace nh_week = `num'+(260*7)  if weekly == `num' & neighborhood == 8
		replace nh_week = `num'+(260*8)  if weekly == `num' & neighborhood == 9
		replace nh_week = `num'+(260*9)  if weekly == `num' & neighborhood == 10
		replace nh_week = `num'+(260*10) if weekly == `num' & neighborhood == 11
		replace nh_week = `num'+(260*11) if weekly == `num' & neighborhood == 12
		replace nh_week = `num'+(260*12) if weekly == `num' & neighborhood == 13
		replace nh_week = `num'+(260*13) if weekly == `num' & neighborhood == 14
		replace nh_week = `num'+(260*14) if weekly == `num' & neighborhood == 15
		replace nh_week = `num'+(260*15) if weekly == `num' & neighborhood == 16
		replace nh_week = `num'+(260*16) if weekly == `num' & neighborhood == 17
		replace nh_week = `num'+(260*17) if weekly == `num' & neighborhood == 18
		replace nh_week = `num'+(260*18) if weekly == `num' & neighborhood == 19
		replace nh_week = `num'+(260*19) if weekly == `num' & neighborhood == 20
		replace nh_week = `num'+(260*20) if weekly == `num' & neighborhood == 21
		replace nh_week = `num'+(260*21) if weekly == `num' & neighborhood == 22
		replace nh_week = `num'+(260*22) if weekly == `num' & neighborhood == 23
		replace nh_week = `num'+(260*23) if weekly == `num' & neighborhood == 24
		replace nh_week = `num'+(260*24) if weekly == `num' & neighborhood == 25
		replace nh_week = `num'+(260*25) if weekly == `num' & neighborhood == 26
		replace nh_week = `num'+(260*26) if weekly == `num' & neighborhood == 27
		replace nh_week = `num'+(260*27) if weekly == `num' & neighborhood == 28
		replace nh_week = `num'+(260*28) if weekly == `num' & neighborhood == 29
		replace nh_week = `num'+(260*29) if weekly == `num' & neighborhood == 30
		replace nh_week = `num'+(260*30) if weekly == `num' & neighborhood == 31
		replace nh_week = `num'+(260*31) if weekly == `num' & neighborhood == 32
		replace nh_week = `num'+(260*32) if weekly == `num' & neighborhood == 33
		replace nh_week = `num'+(260*33) if weekly == `num' & neighborhood == 34
		replace nh_week = `num'+(260*34) if weekly == `num' & neighborhood == 35
		replace nh_week = `num'+(260*35) if weekly == `num' & neighborhood == 36
		replace nh_week = `num'+(260*36) if weekly == `num' & neighborhood == 37
		replace nh_week = `num'+(260*37) if weekly == `num' & neighborhood == 38
		replace nh_week = `num'+(260*38) if weekly == `num' & neighborhood == 39
		replace nh_week = `num'+(260*39) if weekly == `num' & neighborhood == 40
		replace nh_week = `num'+(260*40) if weekly == `num' & neighborhood == 41
		replace nh_week = `num'+(260*41) if weekly == `num' & neighborhood == 42
		replace nh_week = `num'+(260*42) if weekly == `num' & neighborhood == 43
		replace nh_week = `num'+(260*43) if weekly == `num' & neighborhood == 44
		replace nh_week = `num'+(260*44) if weekly == `num' & neighborhood == 45
		replace nh_week = `num'+(260*45) if weekly == `num' & neighborhood == 46
		replace nh_week = `num'+(260*46) if weekly == `num' & neighborhood == 47
		replace nh_week = `num'+(260*47) if weekly == `num' & neighborhood == 48
		replace nh_week = `num'+(260*48) if weekly == `num' & neighborhood == 49
		replace nh_week = `num'+(260*49) if weekly == `num' & neighborhood == 50
		replace nh_week = `num'+(260*50) if weekly == `num' & neighborhood == 51
		replace nh_week = `num'+(260*51) if weekly == `num' & neighborhood == 52
		replace nh_week = `num'+(260*52) if weekly == `num' & neighborhood == 53
		replace nh_week = `num'+(260*53) if weekly == `num' & neighborhood == 54
		replace nh_week = `num'+(260*54) if weekly == `num' & neighborhood == 55
		replace nh_week = `num'+(260*55) if weekly == `num' & neighborhood == 56
		replace nh_week = `num'+(260*56) if weekly == `num' & neighborhood == 57
		replace nh_week = `num'+(260*57) if weekly == `num' & neighborhood == 58
		replace nh_week = `num'+(260*58) if weekly == `num' & neighborhood == 59
		replace nh_week = `num'+(260*59) if weekly == `num' & neighborhood == 60
		replace nh_week = `num'+(260*60) if weekly == `num' & neighborhood == 61
		replace nh_week = `num'+(260*61) if weekly == `num' & neighborhood == 62
		replace nh_week = `num'+(260*62) if weekly == `num' & neighborhood == 63
		replace nh_week = `num'+(260*63) if weekly == `num' & neighborhood == 64
		replace nh_week = `num'+(260*64) if weekly == `num' & neighborhood == 65
		replace nh_week = `num'+(260*65) if weekly == `num' & neighborhood == 66
		replace nh_week = `num'+(260*66) if weekly == `num' & neighborhood == 67
		replace nh_week = `num'+(260*67) if weekly == `num' & neighborhood == 68
		replace nh_week = `num'+(260*68) if weekly == `num' & neighborhood == 69
		replace nh_week = `num'+(260*69) if weekly == `num' & neighborhood == 70
		replace nh_week = `num'+(260*70) if weekly == `num' & neighborhood == 71
		replace nh_week = `num'+(260*71) if weekly == `num' & neighborhood == 72
		replace nh_week = `num'+(260*72) if weekly == `num' & neighborhood == 73
		replace nh_week = `num'+(260*73) if weekly == `num' & neighborhood == 74
		replace nh_week = `num'+(260*74) if weekly == `num' & neighborhood == 75
		replace nh_week = `num'+(260*75) if weekly == `num' & neighborhood == 76
		replace nh_week = `num'+(260*76) if weekly == `num' & neighborhood == 77
		replace nh_week = `num'+(260*77) if weekly == `num' & neighborhood == 78
		}	
		
	beep
	
	collapse (sum) arrest*, by(nh_week)
	
	merge 1:1 nh_week using "$denver/merged_data_for_analysis.dta", gen(_merge3)
	
* Replace missings with zeros (N = 1483)
	local arrest "arrest arrest_agg_assault arrest_simp_assault arrest_robbery arrest_murder arrest_rape arrest_violent arrest_drug arrest_disorder arrest_mvt arrest_weapon arrest_flee arrest_rburg arrest_cburg arrest_larceny"
	foreach i in `arrest' {
		replace `i' = 0 if `i' == .
		}
	
	save "$denver/merged_data_for_analysis.dta", replace
	
	// Intermediate Save
	save "$denver/merged_data_for_analysis_pre_traffic.dta", replace
	
	
*********************************************************************************************************
* Import traffic accident data, clean, collapse and merge
	import delimited "$denver/traffic_accidents.csv", clear
	
*Clean up the Date Variable
	gen date_str = word(first_occurrence_date, 1)
	gen date_str2 = word(reported_date, 1)
	gen no_date = regexm(date_str, ":") == 1
	gen no_date2 = regexm(date_str2, ":") == 1
	gen date = date(date_str, "MDY") if no_date != 1
	replace date = date(date_str2, "MDY") if date ==. & no_date2 != 1
	format date %td
	gen year = year(date)
	gen month = month(date)
	gen week = week(date)
	gen weekly = wofd(date)
	
* drop missing dates (~10% of total) and years != 2016-20
	drop if date == . // n = 6,286
	display date("1-1-2016", "MDY")
	display date("12-31-2020", "MDY")
	drop if date < 20454
	drop if date > 22280
	
* create dummies for each type of traffic accident specifically, and one generally
	gen accident = 1 if regexm(top_traffic_accident_offense, "POLICE") != 1
	gen accident_dui = 1 if regexm(top_traffic_accident_offense, "DUI") == 1
	gen accident_fatal = 1 if regexm(top_traffic_accident_offense, "FATAL") == 1
	gen accident_hitrun = 1 if regexm(top_traffic_accident_offense, "HIT") == 1
	gen accident_police = 1 if regexm(top_traffic_accident_offense, "POLICE") == 1
	gen accident_sbi = 1 if regexm(top_traffic_accident_offense, "SBI") == 1
	
* Encode and clean the Neighborhood variable
* first, combine central park and stapelton, as these are the same geographic area, it just changed names
* then, renumber neighborhoods so they match the numbers that are used in the Stops data (see "Denver Neighborhood Key.xlsx")
	encode neighborhood_id, gen(neighborhood)
	recode neighborhood (61 = 11) 
	replace neighborhood = neighborhood - 1 if neighborhood >= 62 & neighborhood <= 80
	
	drop if neighborhood == . // N = 4262 or 3.78% of traffic accidents
	
	gen nh_week = .
	forval num = 2912(1)3171 {
		replace nh_week = `num'+(260*0)  if weekly == `num' & neighborhood == 1
		replace nh_week = `num'+(260*1)  if weekly == `num' & neighborhood == 2
		replace nh_week = `num'+(260*2)  if weekly == `num' & neighborhood == 3
		replace nh_week = `num'+(260*3)  if weekly == `num' & neighborhood == 4
		replace nh_week = `num'+(260*4)  if weekly == `num' & neighborhood == 5
		replace nh_week = `num'+(260*5)  if weekly == `num' & neighborhood == 6
		replace nh_week = `num'+(260*6)  if weekly == `num' & neighborhood == 7
		replace nh_week = `num'+(260*7)  if weekly == `num' & neighborhood == 8
		replace nh_week = `num'+(260*8)  if weekly == `num' & neighborhood == 9
		replace nh_week = `num'+(260*9)  if weekly == `num' & neighborhood == 10
		replace nh_week = `num'+(260*10) if weekly == `num' & neighborhood == 11
		replace nh_week = `num'+(260*11) if weekly == `num' & neighborhood == 12
		replace nh_week = `num'+(260*12) if weekly == `num' & neighborhood == 13
		replace nh_week = `num'+(260*13) if weekly == `num' & neighborhood == 14
		replace nh_week = `num'+(260*14) if weekly == `num' & neighborhood == 15
		replace nh_week = `num'+(260*15) if weekly == `num' & neighborhood == 16
		replace nh_week = `num'+(260*16) if weekly == `num' & neighborhood == 17
		replace nh_week = `num'+(260*17) if weekly == `num' & neighborhood == 18
		replace nh_week = `num'+(260*18) if weekly == `num' & neighborhood == 19
		replace nh_week = `num'+(260*19) if weekly == `num' & neighborhood == 20
		replace nh_week = `num'+(260*20) if weekly == `num' & neighborhood == 21
		replace nh_week = `num'+(260*21) if weekly == `num' & neighborhood == 22
		replace nh_week = `num'+(260*22) if weekly == `num' & neighborhood == 23
		replace nh_week = `num'+(260*23) if weekly == `num' & neighborhood == 24
		replace nh_week = `num'+(260*24) if weekly == `num' & neighborhood == 25
		replace nh_week = `num'+(260*25) if weekly == `num' & neighborhood == 26
		replace nh_week = `num'+(260*26) if weekly == `num' & neighborhood == 27
		replace nh_week = `num'+(260*27) if weekly == `num' & neighborhood == 28
		replace nh_week = `num'+(260*28) if weekly == `num' & neighborhood == 29
		replace nh_week = `num'+(260*29) if weekly == `num' & neighborhood == 30
		replace nh_week = `num'+(260*30) if weekly == `num' & neighborhood == 31
		replace nh_week = `num'+(260*31) if weekly == `num' & neighborhood == 32
		replace nh_week = `num'+(260*32) if weekly == `num' & neighborhood == 33
		replace nh_week = `num'+(260*33) if weekly == `num' & neighborhood == 34
		replace nh_week = `num'+(260*34) if weekly == `num' & neighborhood == 35
		replace nh_week = `num'+(260*35) if weekly == `num' & neighborhood == 36
		replace nh_week = `num'+(260*36) if weekly == `num' & neighborhood == 37
		replace nh_week = `num'+(260*37) if weekly == `num' & neighborhood == 38
		replace nh_week = `num'+(260*38) if weekly == `num' & neighborhood == 39
		replace nh_week = `num'+(260*39) if weekly == `num' & neighborhood == 40
		replace nh_week = `num'+(260*40) if weekly == `num' & neighborhood == 41
		replace nh_week = `num'+(260*41) if weekly == `num' & neighborhood == 42
		replace nh_week = `num'+(260*42) if weekly == `num' & neighborhood == 43
		replace nh_week = `num'+(260*43) if weekly == `num' & neighborhood == 44
		replace nh_week = `num'+(260*44) if weekly == `num' & neighborhood == 45
		replace nh_week = `num'+(260*45) if weekly == `num' & neighborhood == 46
		replace nh_week = `num'+(260*46) if weekly == `num' & neighborhood == 47
		replace nh_week = `num'+(260*47) if weekly == `num' & neighborhood == 48
		replace nh_week = `num'+(260*48) if weekly == `num' & neighborhood == 49
		replace nh_week = `num'+(260*49) if weekly == `num' & neighborhood == 50
		replace nh_week = `num'+(260*50) if weekly == `num' & neighborhood == 51
		replace nh_week = `num'+(260*51) if weekly == `num' & neighborhood == 52
		replace nh_week = `num'+(260*52) if weekly == `num' & neighborhood == 53
		replace nh_week = `num'+(260*53) if weekly == `num' & neighborhood == 54
		replace nh_week = `num'+(260*54) if weekly == `num' & neighborhood == 55
		replace nh_week = `num'+(260*55) if weekly == `num' & neighborhood == 56
		replace nh_week = `num'+(260*56) if weekly == `num' & neighborhood == 57
		replace nh_week = `num'+(260*57) if weekly == `num' & neighborhood == 58
		replace nh_week = `num'+(260*58) if weekly == `num' & neighborhood == 59
		replace nh_week = `num'+(260*59) if weekly == `num' & neighborhood == 60
		replace nh_week = `num'+(260*60) if weekly == `num' & neighborhood == 61
		replace nh_week = `num'+(260*61) if weekly == `num' & neighborhood == 62
		replace nh_week = `num'+(260*62) if weekly == `num' & neighborhood == 63
		replace nh_week = `num'+(260*63) if weekly == `num' & neighborhood == 64
		replace nh_week = `num'+(260*64) if weekly == `num' & neighborhood == 65
		replace nh_week = `num'+(260*65) if weekly == `num' & neighborhood == 66
		replace nh_week = `num'+(260*66) if weekly == `num' & neighborhood == 67
		replace nh_week = `num'+(260*67) if weekly == `num' & neighborhood == 68
		replace nh_week = `num'+(260*68) if weekly == `num' & neighborhood == 69
		replace nh_week = `num'+(260*69) if weekly == `num' & neighborhood == 70
		replace nh_week = `num'+(260*70) if weekly == `num' & neighborhood == 71
		replace nh_week = `num'+(260*71) if weekly == `num' & neighborhood == 72
		replace nh_week = `num'+(260*72) if weekly == `num' & neighborhood == 73
		replace nh_week = `num'+(260*73) if weekly == `num' & neighborhood == 74
		replace nh_week = `num'+(260*74) if weekly == `num' & neighborhood == 75
		replace nh_week = `num'+(260*75) if weekly == `num' & neighborhood == 76
		replace nh_week = `num'+(260*76) if weekly == `num' & neighborhood == 77
		replace nh_week = `num'+(260*77) if weekly == `num' & neighborhood == 78
		}	
		
	beep
	
* Collapse down to NEIGHBORHOOD-WEEK LEVEL
	collapse (sum) accident* (mean) neighborhood week weekly month year, by(nh_week)
	replace month = round(month)
	
* Merge & save
	merge 1:1 nh_week using "$denver/merged_data_for_analysis.dta", gen(_merge4)
	
	* Replace missings with zeros (N = 1545)
		local traffic "accident accident_dui accident_fatal accident_hitrun accident_police accident_sbi"
		foreach i in `traffic' {
			replace `i' = 0 if `i' == .
			}
	
	sort nh_week
	order nh_week neighborhood week weekly month year // still need to go back and replace missing values on these variables
	
	save "$denver/merged_data_for_analysis.dta", replace
	
* Vars to fix: neighborhood week weekly month year (JH)

* neighborhood // 1,545 missing, each nhood should repeat 260x
	egen nhood2 = seq(), from(1) to(78) block(260) 
		order nhood2, after(neighborhood)
		assert nhood2 == neighborhood if neighborhood !=.
		assert nhood2 !=.
		tab nhood2 //all=260
		drop neighborhood
		rename nhood2 neighborhood

* week // 1,545 missing, each week should increase by 1, 52x and restart
	egen week2 = seq(), from(1) to(52)
		order week2, after(week)
		assert week2 == week if week !=.
		assert week2 !=.
		tab week2 //all=390 = 78 nhoods *5 years (each week repeats once per year)
		drop week
		rename week2 week
	
* weekly // 1,545 missing, each week should increase by 1 from 2912-3171 by nhood
	egen weekly2 = seq(), from(2912) to(3171)
		order weekly2, after(weekly)
		assert weekly2 == weekly if weekly !=.
		assert weekly2 !=.
		tab weekly2 //all=78 = 78 individual weeks per nhood
		drop weekly
		rename weekly2 weekly
	
* month // 1,545 missing, months should be repeated at different intervals/year
	gen daily = dofw(weekly) // first day of each week in our data
		format daily %td
	gen monthly = mofd(daily)
		format monthly %tm
	* Daily variable flags the first day of each -weekly- observation. Now we want to tag partial weeks. See Nick Cox's helpful paper: <https://journals.sagepub.com/doi/pdf/10.1177/1536867X1201200316>
	* This will produce a variable ranging from 1 to 7, where 7 is a complete week, and anything less is a partial week (i.e., a week that spans 2 months).
	* Thus, values > 3 & < 7 (for observation _n) mean that the majority of the PREVIOUS week (observation _n - 1) falls in the SECOND of the two months. 
		gen length = min(day(daily), 7)
		tab length
		clonevar monthly2 = monthly
		replace monthly2 = monthly + 1 if length[_n+1] >= 4 & length[_n+1] <= 6
		drop monthly
		rename monthly2 monthly
		
		sum monthly // ranges 672 (jan2016) to 731 (dec2020)
		
		gen month2 = .
		forval jan = 672(12)720 {
			replace month2 = 1 if monthly == `jan'
			replace month2 = 2 if monthly == `jan' + 1
			replace month2 = 3 if monthly == `jan' + 2
			replace month2 = 4 if monthly == `jan' + 3
			replace month2 = 5 if monthly == `jan' + 4
			replace month2 = 6 if monthly == `jan' + 5
			replace month2 = 7 if monthly == `jan' + 6
			replace month2 = 8 if monthly == `jan' + 7
			replace month2 = 9 if monthly == `jan' + 8
			replace month2 = 10 if monthly == `jan' + 9
			replace month2 = 11 if monthly == `jan' + 10
			replace month2 = 12 if monthly == `jan' + 11
		}
		
		drop month
		rename month2 month
		
* year // 1,545  missing, each year should repeat 52 times per neighborhood
	egen year2 = seq(), from(2016) to(2020) block(52)
		order year2, after(year)
		assert year2 == year if year !=.
		assert year2 !=.
		tab year2 //all=4,056 = 52 weeks * 78 individual nhoods
		drop year
		rename year2 year
		
	order nh_week neighborhood week weekly month monthly year
		
* Generate neighborhood labels
	label define nh 1 "Athmar Park" 2 "Auraria" 3 "Baker" 4 "Barnum" 5 "Barnum West" 6 "Bear Valley" 7 "Belcaro" ///
		8 "Berkeley" 9 "CBD" 10 "Capitol Hill" 11 "Central Park" 12 "Chaffee Park" 13 "Cheesman Park" ///
		14 "Cherry Creek" 15 "City Park" 16 "City Park West" 17 "Civic Center" 18 "Clayton" 19 "Cole" ///
		20 "College View-South Platte" 21 "Congress Park" 22 "Cory-Merrill" 23 "Country Club" 24 "DIA" ///
		25 "East Colfax" 26 "Elyria Swansea" 27 "Five Points" 28 "Fort Logan" 29 "Gateway-Green Valley Ranch" ///
		30 "Globeville" 31 "Goldsmith" 32 "Hale" 33 "Hampden" 34 "Hampden South" 35 "Harvey Park" 36 "Harvey Park South" ///
		37 "Highland" 38 "Hilltop" 39 "Indian Creek" 40 "Jefferson Park" 41 "Kennedy" 42 "Lincoln Park" ///
		43 "Lowry Field" 44 "Mar Lee" 45 "Marston" 46 "Montbello" 47 "Montclair" 48 "North Capitol Hill" ///
		49 "North Park Hill" 50 "Northeast Park Hill" 51 "Overland" 52 "Platt Park" 53 "Regis" 54 "Rosedale" 55 "Ruby Hill" ///
		56 "Skyland" 57 "Sloan Lake" 58 "South Park Hill" 59 "Southmoor Park" 60 "Speer" 61 "Sun Valley" ///
		62 "Sunnyside" 63 "Union Station" 64 "University" 65 "University Hills" 66 "University Park" ///
		67 "Valverde" 68 "Villa Park" 69 "Virginia Village" 70 "Washington Park" 71 "Washington Park West" ///
		72 "Washington Virginia Vale" 73 "Wellshire" 74 "West Colfax" 75 "West Highland" 76 "Westwood" ///
		77 "Whittier" 78 "Windsor"
	label values neighborhood nh
	tab neighborhood
	
* Make a neighborhood key so we can easily figure out their respective numbers
	decode neighborhood, gen(neighborhood_key)
	tab neighborhood if neighborhood_key == "East Colfax", nolabel // 25
	tab neighborhood if neighborhood_key == "Northeast Park Hill", nolabel // 50
	tab neighborhood if neighborhood_key == "Montbello", nolabel  // 46
	
*** Save was missing -- added a line here:
 	save "$denver/merged_data_for_analysis.dta", replace
	save "$denver/merged_data_for_analysis_pre_aqi.dta", replace

/* Data was missing on precipitation, AQI, and open table reservations that is
 needed for replication. Presumably they would have been added here and used to 
 create tables used to create _merge5, _merge6, _merge7. I've added those data.
 
*/  



global original_data_collection "~/Documents/Github/when_police_replication/original_data_collection"
	
	
	** AQI. 
	** Steps taken to make this file: go here
	** https://aqs.epa.gov/aqsweb/airdata/download_files.html#AQI
	** download the data for Daily AQI
	** DAILY AQI by County_ YYYY
	** download and process here

	clear
	global AQI "$original_data_collection/AQI"
	cd "$AQI"
	local files: dir "$AQI" files "daily_aqi_by*.csv"
	di `"`files'"'
	tempfile main // generate temporary save file to store data in
	save `main', replace empty
	clear
	foreach x in `files' {
		di "`x'" // display file name
		
		* import each file
			qui: import delimited "`x'",  case(lower) clear 
			qui: keep if countyname == "Denver"
			qui: gen data_id = subinstr("`x'", ".csv", "", .) // generate id variable
		
		* append each file to the master file
			append using `main', force
			save `main', replace
	}
	
	gen dd = date(date, "YMD")
	gen year = year(dd)
	gen month = month(dd)
	gen weekly = wofd(dd)
	
	collapse (mean) aqi, by(weekly)
	rename aqi AQI
	save "$denver/aqi.dta", replace
	
 
	** OPEN TABLE **********
	** steps taken to make this file: 
	** 1 navigate to the Open Table website in the Internet Archive
	**  https://web.archive.org/web/20210102090417/https://www.opentable.com/state-of-industry
	** 2 Under "Seated diners from online, phone, and walk-in reservations" click drop down for city
	** 3 click "download dataset", open table data set YoY_Seated_Diner_Data.csv
	** 4 open in plain text editor and manipulate first row to add "2020" year to date,
	*** then transpose, and keep only Denver. 
	
	cd "$original_data_collection"
	
	 import delimited "$original_data_collection/open_table/YoY_Seated_Diner_Data_clean.csv", case(lower) clear
	 keep table_date open_table
	 
	gen dd = date(table_date, "YMD")
	gen weekly = wofd(dd)
	collapse (mean) open_table, by(weekly)
	
	save "$denver/open_table.dta", replace
	
	*** PRECIPITATION / TEMPERATURE
		
	/*
	Downloaded from here: 
		
	https://www.ncei.noaa.gov/cdo-web/review
	https://www.ncei.noaa.gov/cdo-web/search

		
	Dataset	Daily Summaries
	Order Start Date	2016-01-01 00:00
	Order End Date	2020-12-31 23:59
	Output Format	Custom GHCN-Daily CSV
	Data Types	PRCP, SNWD, SNOW, TAVG, TMAX, TMIN
	Custom Flag(s)	Station Name
	Units	Standard
	Stations/Locations	Denver County, CO (Location ID: FIPS:08031)


	*/

	cd "$original_data_collection"
	
	import delimited "$original_data_collection/weather/3645978.csv", clear case(lower)
	keep if name == "DENVER INTERNATIONAL AIRPORT, CO US" 
	
	gen dd = date(date, "YMD")
	/*One wrinkle: Avg Temp is missing for the entire month of Feb 2020 from the dataset. 
	No other stations in Denver have tavg data, only DIA. 
	No stations in nearby Arapahoe County (Aurora).  
	So create a simple estimate using the available data -- including leading and lagging temps 
	for two days. This appears to produce plausible estimates. Given the data is pre-pandemic,
	seems unlikely to have a major impact. */
	
	tsset dd
	reg tavg tmin tmax l.tmin l.tmax  l2.tmin l2.tmax   f.tmin f.tmax  f2.tmin f2.tmax
	predict tavg_model
	replace tavg = tavg_model if tavg ==. 
	
	gen weekly = wofd(dd)
	collapse (mean) prcp snow snwd tavg tmax tmin, by(weekly)
	
	save "$denver/weather.dta", replace
	
// DATASETS
use "$denver/merged_data_for_analysis.dta", clear

merge m:1 weekly using "$denver/aqi.dta", gen(_merge5)

merge m:1 weekly using "$denver/open_table.dta", gen(_merge6)

merge m:1 weekly using "$denver/weather.dta", gen(_merge7)

// Intermediate save
	save "$denver/merged_data_for_analysis.dta", replace
	
	save "$denver/merged_data_for_analysis_pre_acs.dta", replace
	use  "$denver/merged_data_for_analysis_pre_acs.dta", replace
 
	
*********************************************************************************************************	
* Merge in the neighborhood-level 2014-18 ACS 5-year estimates
*preserve
// For replication purpose, made an alternate excel that was identical to source data except for one change:
//  I created a new colum directly to the right of "Neighborhood", named "neighborhood" and given it an ascending code, 1-78. 
//  This is the only way to make the import code in the file work. It expects a numeric variable
//  named neighborhood. It expects that the 5th column with a 60-character-long field name in the first row,
//  "Percent Estimate!!RACE!!Total population!!Two or more races"  will be renamed by Stata to "F" during import. 
//  Further, variable processing code later in the file expects empty values at neighborhood = 40 and  neighborhood = 61 for the 
//  Median house value field. Adding a numeric neighborhood field solves for those varied problems and allows 
//  the replication code to run as-is.  
	import excel "$denver/alt_2014-2018 ACS 5 Year Estimates Denver.xlsx", sheet("NBHD") firstrow clear
	
	* This code did not make sense coming from the source file:
	* there was no field "neighborhood" and there was one for "Neighborhood" 
	* but it was a string. So the import process would produce a string variable, not a numeric variable.
	* drop if neighborhood == . // drop 63 blank rows
	drop if neighborhood == . // drop 63 blank rows

	
	* Clean up these variable names
		rename EstimateRACETotalpopulation total_pop
		rename EstimateTotalhousingunits housing_units
		rename PercentEstimateRACETotalpo pct_one_race
		rename F pct_two_races
		rename Whitealone pct_white
		rename Blackalone pct_black
		rename AmericanIndianorAlaskaNative pct_native
		rename Asianalone pct_asian
		rename NativeHawaiianandOtherPacifi pct_hawaiian
		rename Someotherracealone pct_other
		drop Twoormoreraces // duplicate of column F
		rename Whitealoneorincombinationwi pct_white_combo
		rename BlackorAfricanAmericanalone pct_black_combo
		rename AmericanIndianandAlaskaNativ pct_native_combo
		rename Asianaloneorincombinationwi pct_asian_combo
		rename R pct_hawaiian_combo
		rename Someotherracealoneorincom pct_other_combo
		rename HispanicorLatinoofanyrace pct_hispanic_any
		rename NotHispanicorLatino pct_nonhispanic
		rename Male pct_male
		rename Female pct_female
		rename Under5years pct_under5
		rename to9years pct_5to9
		rename to14years pct_10to14
		rename to19years pct_15to19
		rename to24years pct_20to24
		rename to34years pct_25to34
		rename to44years pct_35to44
		rename to54years pct_45to54
		rename to59years pct_55to59
		rename to64years pct_60to64
		rename to74years pct_65to74
		rename to84years pct_75to84
		rename yearsandover pct_85over
		rename Medianageyears median_age
		rename AL pct_64over
		rename ForeignBorn pct_foreign_born
		rename NotaUSCitizen pct_non_citizen
		rename EstimatePercentPopulation5 pct_5over_nonenglish
		rename SpeakEnglishlessthanverywel pct_english_less_very_well
		rename SpeakSpanish pct_spk_spanish
		rename SpeakOtherIndoEuropeanLangua pct_spk_other_indoeuropean
		rename SpeakAsianandPacificIslandl pct_spk_asian
		rename Speakotherlanguages pct_spk_other
		rename Livingwithadisability pct_disability
		rename Livingwithavisiondisability pct_disability_vision
		rename Livingwithacognitivedisabili pct_disability_cognitive
		rename Livingwithahearingdisability pct_disability_hearing
		rename Livingwithanambulatorydisabi pct_disability_ambulatory
		rename Livingwithaselfcaredisabili pct_disability_selfcare
		rename Livingwithanindependentlivin pct_disability_independent
		rename Percentbelowpovertylevel pct_poverty
		rename MedianHouseholdIncome median_hh_income
		rename MedianGrossRentasPercentof median_gross_rent
		rename MedianHomeValue median_home_value
		rename Owners pct_own
		rename Renters pct_rent
		rename Population25yearsandoverLe pct_25over_less9th
		rename thto12thgradenodiploma pct_9th12th_nodiploma
		rename Highschoolgraduateincludese pct_diploma
		rename Somecollegenodegree pct_some_college
		rename Associatesdegree pct_associates
		rename Bachelorsdegree pct_bachelors
		rename Graduateorprofessionaldegree pct_graduates_degree
		rename Highschoolgraduateorhigher pct_hs_higher
		rename Bachelorsdegreeorhigher pct_bachelors_higher	
		
	* Create a %15-24 variable
		gen pct_15to24 = pct_15to19 + pct_20to24
		
	save "$denver/ACS_5-Year_Estimates.dta", replace
*restore

	use "$denver/merged_data_for_analysis.dta", clear
	merge m:1 neighborhood using "$denver/ACS_5-Year_Estimates.dta", gen(_merge8)	
	
	save "$denver/merged_data_for_analysis.dta", replace
	save "$denver/post_acs_merged_data_for_analysis.dta", replace
	
*********************************************************************************************************
* CREATE THE VARIABLES
	gen study_week = weekly - 3120
	
	clonevar study_weekb = study_week
	replace study_weekb = 0 if year == 2020

	gen study_week2 = study_week^2
	gen study_week3 = study_week^3

	gen twenty20 = 1 if year == 2020
	replace twenty20 = 0 if year != 2020
	
	gen period = .
	replace period = 1 if week <= 10
	replace period = 2 if week >= 11 & week <= 21
	replace period = 3 if week >= 22
	
	gen period1 = 1 if period == 1
	replace period1 = 0 if period != 1 | twenty20 == 0
	
	gen period2 = 1 if period == 2
	replace period2 = 0 if period != 2 | twenty20 == 0
	
	gen period3 = 1 if period == 3
	replace period3 = 0 if period != 3 | twenty20 == 0
	
	gen period2020 = 0
	replace period2020 = 1 if week <= 10 & year == 2020
	replace period2020 = 2 if week >= 11 & week <= 21 & year == 2020
	replace period2020 = 3 if week >= 22 & year == 2020
	tab period2020
	
	* Open Table data begins on 2/18/2020 (Week 7) so we'll impute Weeks 1-6 with the mean of Weeks 7-10.
		sum open_table if week >= 7 & week <= 10 & year == 2020
		replace open_table = -1.642857 if year == 2020 & week <= 6 // 468 changes reflects 6 wks*78 neighborhoods
		
	* Standardize the 52nd week of each year. 
	* For 2017-19, there are 8 days in Week 52 		
		forval num = -105(52)-1 {
			replace pstop_pdi = round((pstop_pdi/8)*7) if study_week == `num'
			replace vstop_pdi = round((vstop_pdi/8)*7) if study_week == `num'
			replace crime_VC_norape = round((crime_VC_norape/8)*7) if study_week == `num'
			replace crime_prop = round((crime_prop/8)*7) if study_week == `num'
			replace arrest_drug = round((arrest_drug/8)*7) if study_week == `num'
			replace arrest_disorder = round((arrest_disorder/8)*7) if study_week == `num'
			replace self_cad = round((self_cad/8)*7) if study_week == `num'
			replace accident = round((accident/8)*7) if study_week == `num'
			replace prcp = round((prcp/8)*7) if study_week == `num'
			replace snow = round((snow/8)*7) if study_week == `num'
			replace snwd = round((snwd/8)*7) if study_week == `num'
			replace tavg = round((tavg/8)*7) if study_week == `num'
			replace tmax = round((tmax/8)*7) if study_week == `num'
			replace tmin = round((tmin/8)*7) if study_week == `num'
			replace AQI = round((AQI/8)*7) if study_week == `num'
		}
	
	* For 2016/2020, there are 9 days in Week 52
		forval num = -157(208)51 {
			replace pstop_pdi = round((pstop_pdi/9)*7) if study_week == `num'
			replace vstop_pdi = round((vstop_pdi/9)*7) if study_week == `num'
			replace crime_VC_norape = round((crime_VC_norape/9)*7) if study_week == `num'
			replace crime_prop = round((crime_prop/9)*7) if study_week == `num'
			replace arrest_drug = round((arrest_drug/9)*7) if study_week == `num'
			replace arrest_disorder = round((arrest_disorder/9)*7) if study_week == `num'
			replace self_cad = round((self_cad/9)*7) if study_week == `num'			
			replace accident = round((accident/9)*7) if study_week == `num'
			replace prcp = round((prcp/9)*7) if study_week == `num'
			replace snow = round((snow/9)*7) if study_week == `num'
			replace snwd = round((snwd/9)*7) if study_week == `num'
			replace tavg = round((tavg/9)*7) if study_week == `num'
			replace tmax = round((tmax/9)*7) if study_week == `num'
			replace tmin = round((tmin/9)*7) if study_week == `num'
			replace AQI = round((AQI/9)*7) if study_week == `num'
			replace open_table = round((open_table/9)*7) if study_week == `num'
		}
	
	* Set neighborhood-week as the time series variable
		tsset nh_week

* Weekly cumulative counts and deviations from prior year
* Violent crime - property crime - stops - self-initiated activites - drug arrests - traffic collisions - weather data

	rename crime_VC_norape violent
	rename crime_prop property
	rename pstop_pdi pstop
	rename vstop_pdi vstop
	rename self_cad self

	local vars "violent property pstop vstop self arrest_drug arrest_disorder accident prcp snow snwd tavg tmax tmin AQI"
	foreach i in `vars' {
		sort neighborhood year week
		bysort neighborhood year: gen `i'_cum = sum(`i')
	}
	
	local vars "violent property pstop vstop self arrest_drug arrest_disorder accident prcp snow snwd tavg tmax tmin AQI"
	foreach i in `vars' {
		sort neighborhood week year
		bysort neighborhood week: gen `i'_dev = `i' - `i'[_n-1]
	}

* Running 3-week averages and deviations from 3-week average in 2019 (only)
	local vars "violent property pstop vstop self arrest_drug arrest_disorder accident prcp snow snwd tavg tmax tmin AQI"
	foreach i in `vars' {
		sort neighborhood year week
		bysort neighborhood: gen `i'_3wk = (`i' + `i'[_n-1] + `i'[_n-2])/3
	}
	
	sort neighborhood year week
	bysort neighborhood: gen open_table_3wk = (open_table + open_table[_n-1] + open_table[_n-2])/3 if year == 2020
	bysort neighborhood: replace open_table_3wk = (open_table + open_table[_n-1])/2 if year == 2020 & week == 2
	bysort neighborhood: replace open_table_3wk = open_table if year == 2020 & week == 1
	
	local vars "violent_3wk property_3wk pstop_3wk vstop_3wk self_3wk arrest_drug_3wk arrest_disorder_3wk accident_3wk prcp_3wk snow_3wk snwd_3wk tavg_3wk tmax_3wk tmin_3wk AQI_3wk"
	foreach i in `vars' {
		sort neighborhood week year
		bysort neighborhood: gen `i'_dev19 = `i' - `i'[_n-1]
	}
	
* Running 3-week averages and deviations from 3-week average of 2016-19 (each year is EQUALLY weighted)
	local vars "violent property pstop vstop self arrest_drug arrest_disorder accident prcp snow snwd tavg tmax tmin AQI"
	foreach i in `vars' {
		sort neighborhood year week	
		bysort neighborhood week: egen `i'_equal = mean(`i') if year < 2020
		replace `i'_equal = `i' if year == 2020
	}
	
	local vars "violent_equal property_equal pstop_equal vstop_equal self_equal arrest_drug_equal arrest_disorder_equal accident_equal prcp_equal snow_equal snwd_equal tavg_equal tmax_equal tmin_equal AQI_equal"
	foreach i in `vars' {
		sort neighborhood year week
		bysort neighborhood: gen `i'_3wk = (`i' + `i'[_n-1] + `i'[_n-2])/3 if year < 2020
	}
	
	* Backfill the 2020 values w/the 3-wk average
		replace violent_equal_3wk = violent_3wk if year == 2020
		replace property_equal_3wk = property_3wk if year == 2020
		replace pstop_equal_3wk = pstop_3wk if year == 2020
		replace vstop_equal_3wk = vstop_3wk if year == 2020
		replace self_equal_3wk = self_3wk if year == 2020
		replace arrest_drug_equal_3wk = arrest_drug_3wk if year == 2020
		replace arrest_disorder_equal_3wk = arrest_disorder_3wk if year == 2020
		replace accident_equal_3wk = accident_3wk if year == 2020
		replace prcp_equal_3wk = prcp_3wk if year == 2020
		replace snow_equal_3wk = snow_3wk if year == 2020
		replace snwd_equal_3wk = snwd_3wk if year == 2020
		replace tavg_equal_3wk = tavg_3wk if year == 2020
		replace tmax_equal_3wk = tmax_3wk if year == 2020
		replace tmin_equal_3wk = tmin_3wk if year == 2020
		replace AQI_equal_3wk = AQI_3wk if year == 2020
	
	local vars "violent_equal_3wk property_equal_3wk pstop_equal_3wk vstop_equal_3wk self_equal_3wk arrest_drug_equal_3wk arrest_disorder_equal_3wk accident_equal_3wk prcp_equal_3wk snow_equal_3wk snwd_equal_3wk tavg_equal_3wk tmax_equal_3wk tmin_equal_3wk AQI_equal_3wk"
	foreach i in `vars' {
		sort neighborhood week year
		bysort neighborhood: gen `i'_dev = `i' - `i'[_n-1]
	}
	
* Running 3-week averages and deviations from 3-week average in 2016-19 (Each year is weighted differently)
	sort neighborhood week year
	gen weight = 1.6 if year == 2019
	replace weight = 1.2 if year == 2018
	replace weight = 0.8 if year == 2017
	replace weight = 0.4 if year == 2016
	
	local vars "violent property pstop vstop self arrest_drug arrest_disorder accident prcp snow snwd tavg tmax tmin AQI"
	foreach i in `vars' {
		sort neighborhood year week	
		egen num_`i' = total(`i' * weight) if year != 2020, by(neighborhood week)
		egen den_`i' = total(weight) if year != 2020, by(neighborhood week)
		gen `i'_wgt_avg = num_`i'/den_`i'
	}
		
	local vars "violent_wgt_avg property_wgt_avg pstop_wgt_avg vstop_wgt_avg self_wgt_avg arrest_drug_wgt_avg arrest_disorder_wgt_avg accident_wgt_avg prcp_wgt_avg snow_wgt_avg snwd_wgt_avg tavg_wgt_avg tmax_wgt_avg tmin_wgt_avg AQI_wgt_avg"
	foreach i in `vars' {
		sort neighborhood year week
		bysort neighborhood: gen `i'_3wk = (`i' + `i'[_n-1] + `i'[_n-2])/3 if year < 2020
	}
	
	* Backfill 2020 w/the 3 wk averages
		replace violent_wgt_avg_3wk = violent_3wk if year == 2020
		replace property_wgt_avg_3wk = property_3wk if year == 2020
		replace pstop_wgt_avg_3wk = pstop_3wk if year == 2020
		replace vstop_wgt_avg_3wk = vstop_3wk if year == 2020
		replace self_wgt_avg_3wk = self_3wk if year == 2020
		replace arrest_drug_wgt_avg_3wk = arrest_drug_3wk if year == 2020
		replace arrest_disorder_wgt_avg_3wk = arrest_disorder_3wk if year == 2020
		replace accident_wgt_avg_3wk = accident_3wk if year == 2020
		replace prcp_wgt_avg_3wk = prcp_3wk if year == 2020
		replace snow_wgt_avg_3wk = snow_3wk if year == 2020
		replace snwd_wgt_avg_3wk = snwd_3wk if year == 2020
		replace tavg_wgt_avg_3wk = tavg_3wk if year == 2020
		replace tmax_wgt_avg_3wk = tmax_3wk if year == 2020
		replace tmin_wgt_avg_3wk = tmin_3wk if year == 2020
		replace AQI_wgt_avg_3wk = AQI_3wk if year == 2020
		
	local vars "violent_wgt_avg_3wk property_wgt_avg_3wk pstop_wgt_avg_3wk vstop_wgt_avg_3wk self_wgt_avg_3wk arrest_drug_wgt_avg_3wk arrest_disorder_wgt_avg_3wk accident_wgt_avg_3wk prcp_wgt_avg_3wk snow_wgt_avg_3wk snwd_wgt_avg_3wk tavg_wgt_avg_3wk tmax_wgt_avg_3wk tmin_wgt_avg_3wk AQI_wgt_avg_3wk"
	foreach i in `vars' {
		sort neighborhood week year
		bysort neighborhood: gen `i'_dev = `i' - `i'[_n-1]
	}
	
* Spot Check
	list year week violent violent_wgt_avg violent_wgt_avg_3wk violent_wgt_avg_3wk_dev if neighborhood == 1 & (week < 3 | week > 50)
	
* EFA for the census variables
* Need to destring median_home_value & reverse code the education and income variables so they're consistent with pct_poverty
* Jefferson Park & Sunnyside have missing values for median_home_value. Replacing them with the mean of surrounding neighborhoods' median_home_value.
* Everything loads together (see kitchen sink). Going to use separate disadvantage and immigration factors.
	replace median_home_value = "" if median_home_value == "-"
	destring median_home_value, replace
	sum median_home_value if neighborhood == 37 | neighborhood == 62 | neighborhood == 57 | neighborhood == 74 // M = 559,121
	sum median_home_value if neighborhood == 74 | neighborhood == 68 | neighborhood == 4 | neighborhood == 67 // M = 260,575
	replace median_home_value = 559121 if neighborhood == 40 // jefferson park
	replace median_home_value = 260575 if neighborhood == 61 // sun valley
	
	gen pct_less_hs = 100 - pct_hs_higher
	gen pct_less_bachelors = 100 - pct_bachelors
	
	egen max_median_home_value = max(median_home_value)
	gen median_home_value_rev = max_median_home_value - median_home_value
	drop max_median_home_value
	
	egen max_median_hh_income = max(median_hh_income)
	gen median_hh_income_rev = max_median_hh_income - median_hh_income
	drop max_median_hh_income
	
	factor pct_poverty pct_less_hs pct_less_bachelors median_home_value_rev median_hh_income_rev pct_english_less_very_well pct_foreign_born pct_non_citizen pct_black pct_hispanic_any, mine(1)
	
	predict kitchen_sink
	
	factor pct_poverty pct_less_hs pct_less_bachelors median_home_value_rev median_hh_income_rev pct_foreign_born pct_non_citizen pct_hispanic_any, mine(1)
	
	factor pct_poverty pct_less_hs pct_less_bachelors median_home_value_rev median_hh_income_rev pct_english_less_very_well pct_foreign_born pct_non_citizen, mine(1)
	
	factor pct_poverty pct_less_hs pct_less_bachelors median_home_value_rev median_hh_income_rev, mine(1)
	
	predict disadvantage
	
	factor pct_english_less_very_well pct_foreign_born pct_non_citizen, mine(1)
	
	predict immigration
	
* Create globals to store mediators and control variables
	global mediators "pstop_wgt_avg_3wk_dev vstop_wgt_avg_3wk_dev arrest_drug_wgt_avg_3wk_dev arrest_disorder_wgt_avg_3wk_dev"
	global controls "disadvantage pct_black pct_hispanic_any immigration total_pop accident prcp tavg AQI open_table"
		

* DESCRIPTIVE STATS: Weighted average, unweighted average, 2019 only
	sum violent property $mediators $controls if year == 2020
	
	sum violent property pstop_equal_3wk_dev vstop_equal_3wk_dev arrest_drug_equal_3wk_dev arrest_disorder_equal_3wk_dev prcp_equal_3wk_dev tavg_equal_3wk_dev AQI_equal_3wk_dev open_table_3wk
	
	sum violent property pstop_3wk_dev19 vstop_3wk_dev19 arrest_drug_3wk_dev19 arrest_disorder_3wk_dev19 prcp_3wk_dev19 tavg_3wk_dev19 AQI_3wk_dev19 open_table_3wk
	
* Look at bivariate correlations among confounders
	pwcorr total_pop pct_15to24 pct_black pct_hispanic_any pct_poverty median_hh_income pct_own pct_bachelors_higher, star(.05)
	
	
* Save and move on to the analysis R script or figure .do file
	save "$denver/merged_data_for_analysis.dta", replace
	use "$denver/merged_data_for_analysis.dta", clear
	
	
	save "$denver/combined_dataset.dta", replace
