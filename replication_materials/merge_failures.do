// log results
log using "~/Documents/Github/when_police_replication/replication_materials/merge_failure_files/merge_failure_log.log", replace

/* 
File for displaying information on merge failures in the code from Nix et al. 

Writen by Jacob Kang-Brown on Saturday April 6, 2024

This file copies the load commands and neighborhood-identifying-key specific commands
from the replication code. It adds simple commands to reduce the dataset to each neighborhood key 
used in the code for merging, and retains the string neighborhood variables in each file,
renaming them to match the source data files. 


*/ 



// Set Up - indicate source of data

global denver "~/Downloads/replication_materials_data"

// set working directory to save files
global working_merge  "~/Documents/Github/when_police_replication/replication_materials/merge_failure_files"  

cd "$working_merge"


// 1 Load CAD Data, simplify and save

// 1.1 Load
use "$denver/CAD_geocoded_stata_13.dta", clear

encode nbhd_name, gen(neighborhood) // JKB note: was nhoodname in replication do file, indicating possible variance from original data. 
	
drop if neighborhood == . 

// 1.2 Simplify and save
clonevar CAD_nb_key = nbhd_name
keep CAD_nb_key neighborhood 
duplicates drop
sort neighborhood
save CAD_merge.dta, replace

// 2 Load Stop Data, simplify and save

import delimited "$denver/police_pedestrian_stops_and_vehicle_stops.csv", clear

// 2.1 Load stop data 
* generate stop variables for each year for each neighborhood
* first, combine central park (11) and stapelton (62), as these are the same geographic area, it just changed names
* also, change "None" (48) to missing, and recode the neighborhoods > 48 so that the range is 1-78 with no skips
	encode neighborhood_name, gen(neighborhood)
	recode neighborhood (62 = 11)
	recode neighborhood (48 = .)
	replace neighborhood = neighborhood - 1 if neighborhood >=49 & neighborhood <= 61
	replace neighborhood = neighborhood - 2 if neighborhood >= 63 & neighborhood <= 80
	sum neighborhood
	
	drop if neighborhood == . 
// 2.2 	simplify and save

clonevar stop_nb_key = neighborhood_name
replace stop_nb_key = "Central Park or Stapleton" if neighborhood == 11 

keep stop_nb_key neighborhood 
duplicates drop
sort neighborhood
save stop_merge.dta, replace



// 3 Load Crime Data, simplify and save

	import delimited "$denver/crime.csv", clear

// 3.1 Load stop data 
* generate stop variables for each year for each neighborhood
* first, combine central park (11) and stapelton (62), as these are the same geographic area, it just changed names
* also, change "None" (48) to missing, and recode the neighborhoods > 48 so that the range is 1-78 with no skips
	encode neighborhood_id, gen(neighborhood)
	recode neighborhood (61 = 11)
	replace neighborhood = neighborhood - 1 if neighborhood >= 62 & neighborhood <= 80
	
	drop if neighborhood == . // N = 1
// 3.2 	simplify and save
clonevar crime_nb_key = neighborhood_id
replace crime_nb_key = "Central Park or Stapleton" if neighborhood == 11 
keep crime_nb_key neighborhood 
duplicates drop
sort neighborhood
save crime_merge.dta, replace





// 4 Load Arrest Data, simplify and save


// 4.1 Load arrest data 

global arrest "$denver/Arrest_Files"

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
	
	encode Nbhd_Name, gen(neighborhood)
	
	drop if neighborhood == .

cd "$working_merge"


// 4.2 	simplify and save
clonevar arrest_nb_key = Nbhd_Name
keep arrest_nb_key neighborhood 
duplicates drop
sort neighborhood
save arrest_merge.dta, replace


// 5 Load Traffic Accident Data, simplify and save

// 5.1 Load stop data 

	import delimited "$denver/traffic_accidents.csv", clear
	
* Encode and clean the Neighborhood variable
* first, combine central park and stapelton, as these are the same geographic area, it just changed names
* then, renumber neighborhoods so they match the numbers that are used in the Stops data (see "Denver Neighborhood Key.xlsx")
	encode neighborhood_id, gen(neighborhood)
	recode neighborhood (61 = 11) 
	replace neighborhood = neighborhood - 1 if neighborhood >= 62 & neighborhood <= 80
	
	drop if neighborhood == .

	

// 5.2 	simplify and save
clonevar traffic_nb_key = neighborhood_id
replace traffic_nb_key = "Central Park or Stapleton" if neighborhood == 11 
keep traffic_nb_key neighborhood 
duplicates drop
sort neighborhood
save traffic_merge.dta, replace

// 6 Load ACS data

// For replication purpose, made an alternate excel that was identical to source data except for one change:
//  I created a new colum directly to the right of "Neighborhood", named "neighborhood" and given it an ascending code, 1-78. 
//  This is the only way to make the import code in the file work. It expects a numeric variable
//  named neighborhood. It expects that the 5th column with a 60-character-long field name in the first row,
//  "Percent Estimate!!RACE!!Total population!!Two or more races"  will be renamed by Stata to "F" during import. 
//  Further, variable processing code later in the file expects empty values at neighborhood = 40 and  neighborhood = 61 for the 
//  Median house value field. Adding a numeric neighborhood field solves for those varied problems and allows 
//  the replication code to run as-is.  


// 6.1 Load
	import excel "$denver/alt_2014-2018 ACS 5 Year Estimates Denver.xlsx", sheet("NBHD") firstrow clear
	drop if neighborhood == . 

// 6.2 simplify and save
clonevar acs_nb_key = Neighborhood
keep  acs_nb_key  neighborhood 
duplicates drop
sort neighborhood
save  acs_merge.dta, replace

// 7 Load Shapefile
	
//	use r code in "merge_failure_shape.R" for working with the spatial data and saving as "shape_merge.dta"

// 8 Merge files

cd "$working_merge"

use CAD_merge.dta, clear
merge 1:1 neighborhood using stop_merge.dta, gen(_m_stop)
merge 1:1 neighborhood using crime_merge.dta, gen(_m_crime)
merge 1:1 neighborhood using arrest_merge.dta, gen(_m_arrest)
merge 1:1 neighborhood using traffic_merge.dta, gen(_m_traffic)
merge 1:1 neighborhood using acs_merge.dta, gen(_m_acs)
merge 1:1 neighborhood using shape_merge.dta, gen(_m_shape)

// Use neighborhood lables created in the prep file	
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

drop _m*
	
order CAD_nb_key stop_nb_key crime_nb_key arrest_nb_key traffic_nb_key acs_nb_key shape_nb_key neighborhood

// Datasets with failed merges
list crime_nb_key acs_nb_key shape_nb_key neighborhood 

// Datasets with ok merges:
list CAD_nb_key stop_nb_key arrest_nb_key traffic_nb_key neighborhood
	
	
save merge_failure_table.dta, replace
log close
