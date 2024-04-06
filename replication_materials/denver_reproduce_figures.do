/* *****************************************************************************
Reproduce figures in "When police pull back: Neighborhood-level effects of de-policing on violent and property crime" in Criminology
* w/Jessie Huff, Scott Wolfe, David Pyrooz and Scott Mourtgos
* Written 10/29/21 by JN
* Last updated 6/27/23 by JN
*******************************************************************************/

* Set global that points to where the merged data file is
	global denver "~/Downloads/replication_materials_data"
	
* Set global to store the figures
	global figures "~/Downloads/replication_materials_data/figures"
	
* Call up the merged data file
	use "$denver/merged_data_for_analysis.dta", clear
	
	
* Figure 1: Weekly deviations in crime and police discretionary activity at neighborhood level	
	rename arrest_disorder_wgt_avg_3wk_dev disorder_wgt_avg_3wk_dev

	local vars "violent_wgt_avg_3wk_dev property_wgt_avg_3wk_dev pstop_wgt_avg_3wk_dev vstop_wgt_avg_3wk_dev disorder_wgt_avg_3wk_dev arrest_drug_wgt_avg_3wk_dev"
	foreach i in `vars' {
		bysort week: egen `i'_CITY = median(`i') if year == 2020
		bysort week: egen `i'_90 = pctile(`i') if year == 2020, p(90)
		bysort week: egen `i'_10 = pctile(`i') if year == 2020, p(10)
	}
	
	rename violent_wgt_avg_3wk_dev_CITY violent_city_med
	rename property_wgt_avg_3wk_dev_CITY property_city_med
	rename pstop_wgt_avg_3wk_dev_CITY pstop_city_med
	rename vstop_wgt_avg_3wk_dev_CITY vstop_city_med
	rename disorder_wgt_avg_3wk_dev_CITY disorder_city_med
	rename arrest_drug_wgt_avg_3wk_dev_CITY drug_city_med
	
	rename violent_wgt_avg_3wk_dev_90 violent_city_90
	rename property_wgt_avg_3wk_dev_90 property_city_90
	rename pstop_wgt_avg_3wk_dev_90 pstop_city_90
	rename vstop_wgt_avg_3wk_dev_90 vstop_city_90
	rename disorder_wgt_avg_3wk_dev_90 disorder_city_90
	rename arrest_drug_wgt_avg_3wk_dev_90 drug_city_90
	
	rename violent_wgt_avg_3wk_dev_10 violent_city_10
	rename property_wgt_avg_3wk_dev_10 property_city_10
	rename pstop_wgt_avg_3wk_dev_10 pstop_city_10
	rename vstop_wgt_avg_3wk_dev_10 vstop_city_10
	rename disorder_wgt_avg_3wk_dev_10 disorder_city_10
	rename arrest_drug_wgt_avg_3wk_dev_10 drug_city_10
	
	gen zero = 0 // so that the y-line will appear on top of the neighborhood lines in the figure

	sort weekly
	
	twoway line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line pstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line pstop_city_med week if year == 2020, lc(blue) lp(solid) yaxis(2) || ///
	line pstop_city_90 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) || ///
	line pstop_city_10 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) ///
		xtitle("") xscale(range(1(1)52)) xlabel(1(1)52,nolab nogrid notick) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash)) ///
		yscale(range(-60(20)40) axis(1)) ylabel(-60(20)40, labs(3) axis(1)) yscale(range(-15(5)10) axis(2)) ylabel(-15(5)10, labs(3) axis(2)) ///
		ytitle("Neighborhood Deviation", size(3) axis(1)) title("{it:Pedestrian Stops}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(0 2 2 0))  ///
		name(pstop_dev, replace) leg(off) nodraw
	

	twoway line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line vstop_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line vstop_city_med week if year == 2020, lc(blue) lp(solid) yaxis(2) || ///
	line vstop_city_90 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) || ///
	line vstop_city_10 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) ///
		xtitle("") xscale(range(1(3)52)) xlabel(1(1)52,nolab nogrid notick) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash)) ///
		yscale(range(-100(50)100) axis(1)) ylabel(-100(50)100, labs(3) axis(1)) yscale(range(-40(20)40) axis(2)) ylabel(-50(25)50, labs(3) axis(2)) ///
		ytitle("City Deviation - 10/50/90th Percentiles", size(2.75) axis(2)) title("{it:Vehicle Stops}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(-4.4 -4.4 2 0)) ///
		name(vstop_dev, replace) leg(off) nodraw
	

	twoway line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line arrest_drug_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line drug_city_med week if year == 2020, lc(blue) lp(solid) yaxis(2) || ///
	line drug_city_90 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) || ///
	line drug_city_10 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) ///
		xtitle("") xscale(range(1(3)52)) xlabel(1(1)52, nolab nogrid notick) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash))  ///
		yscale(range(-15(5)5) axis(1)) ylabel(-15(5)5, labs(3) axis(1)) yscale(range(-6(2)2) axis(2)) ylabel(-6(2)2, labs(3) axis(2)) ///
		ytitle("Neighborhood Deviation", size(3) axis(1)) title("{it:Drug Arrests}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(0 3.35 2 0))  ///
		name(arrest_drug_dev, replace) leg(off) nodraw
		
		
	twoway line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line disorder_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line disorder_city_med week if year == 2020, lc(blue) lp(solid) yaxis(2) || ///
	line disorder_city_90 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) || ///
	line disorder_city_10 week if year == 2020, lc(blue) lp(shortdash) yaxis(2) ///
		xtitle("") xscale(range(1(3)52)) xlabel(1(1)52, nolab nogrid notick) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash))  ///
		yscale(range(-10(5)10) axis(1)) ylabel(-10(5)10, labs(3) axis(1)) yscale(range(-2(1)2) axis(2)) ylabel(-2(1)2, labs(3) axis(2)) ///
		ytitle("City Deviation - 10/50/90th Percentiles", size(2.75) axis(2)) title("{it:Disorder Arrests}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(0 0 2 0)) ///
		name(disorder_dev, replace) leg(off) nodraw
		
		
twoway line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line violent_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line violent_city_med week if year == 2020, lc(red) lp(solid) yaxis(2) || ///
	line violent_city_90 week if year == 2020, lc(red) lp(shortdash) yaxis(2) || ///
	line violent_city_10 week if year == 2020, lc(red) lp(shortdash) yaxis(2) ///
		xtitle("Week of 2020", size(3)) xscale(range(1(4)52)) xlabel(4(4)52, labs(3) nogrid) xmtick(1(1)52) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash))  ///
		yscale(range(-3(1)4) axis(1)) ylabel(-3(1)4, labs(3) axis(1)) yscale(range(-1.5(.5)2) axis(2)) ylabel(-1.5(.5)2, labs(3) axis(2)) ///
		ytitle("Neighborhood Deviation", size(3) axis(1)) title("{it:Violent Crimes}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(1.2 1.5 0 -2)) ///
		name(violent_dev, replace) leg(off) nodraw
		
		
twoway line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 1, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 2, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 3, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 4, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 5, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 6, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 7, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 8, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 9, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 10, lc(gs14) lp(solid) yaxis(1) || ///	
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 11, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 12, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 13, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 14, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 15, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 16, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 17, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 18, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 19, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 20, lc(gs14) lp(solid) yaxis(1) || ///		
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 21, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 22, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 23, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 24, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 25, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 26, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 27, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 28, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 29, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 30, lc(gs14) lp(solid) yaxis(1) || ///		
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 31, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 32, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 33, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 34, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 35, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 36, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 37, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 38, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 39, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 40, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 41, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 42, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 43, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 44, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 45, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 46, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 47, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 48, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 49, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 50, lc(gs14) lp(solid) yaxis(1) || ///	
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 51, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 52, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 53, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 54, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 55, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 56, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 57, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 58, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 59, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 60, lc(gs14) lp(solid) yaxis(1) || ///	
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 61, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 62, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 63, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 64, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 65, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 66, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 67, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 68, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 69, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 70, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 71, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 72, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 73, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 74, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 75, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 76, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 77, lc(gs14) lp(solid) yaxis(1) || ///
	line property_wgt_avg_3wk_dev week if year == 2020 & neighborhood == 78, lc(gs14) lp(solid) yaxis(1) || ///
	line zero week if year == 2020, lc(black) lp(solid) yaxis(1) || ///
	line property_city_med week if year == 2020, lc(red) lp(solid) yaxis(2) || ///
	line property_city_90 week if year == 2020, lc(red) lp(shortdash) yaxis(2) || ///
	line property_city_10 week if year == 2020, lc(red) lp(shortdash) yaxis(2) ///
		xtitle("Week of 2020", size(3)) xscale(range(1(4)52)) xlabel(4(4)52, labs(3) nogrid) xmtick(1(1)52) ///
		xline(11, lc(gs0) lp(dash)) xline(22, lc(gs0) lp(dash))  ///
		yscale(range(-10(5)25) axis(1)) ylabel(-10(5)25, labs(3) axis(1)) yscale(range(-4(2)10) axis(2)) ylabel(-4(2)10, labs(3) axis(2)) ///
		ytitle("City Deviation - 10/50/90th Percentiles", size(2.75) axis(2)) title("{it:Property Crimes}", size(3)) ///
		plotr(margin(0 0 0 0)) graphr(margin(0 0 0 -2))  ///
		name(property_dev, replace) leg(off) nodraw

	
* Combine into a 3x2 figure
	graph combine pstop_dev vstop_dev arrest_drug_dev disorder_dev violent_dev property_dev, rows(3) ///
	note("*Note: Week 11 = Start of COVID period; Week 22 = Start of FLOYD period", size(1.75) pos(5) margin(0 0 0 2)) name(fig1, replace) nodraw
	
	graph display fig1, ysize(9) xsize(6.5) margins(tiny)
	graph export "$figures\fig1.png", as(png) width(2000) replace
	
/* For text accompanying Figure 1...
	* How many of each of these outcomes occurred in 2020 and the weighted-average prior year? 
	* In each period, what % of the neighborhood-weeks was below 0 for each outcome?  
	* In each period, how many fewer of outcome occurred? 

	preserve
		collapse (sum) pstop_cum vstop_cum arrest_drug_cum arrest_disorder_cum, by(week year)
		
		gen w_pstop_cum16 = pstop_cum * 0.4 if year == 2016
		gen w_pstop_cum17 = pstop_cum * 0.8 if year == 2017
		gen w_pstop_cum18 = pstop_cum * 1.2 if year == 2018
		gen w_pstop_cum19 = pstop_cum * 1.6 if year == 2019
		egen w_pstop_cum_avg = rmean(w_pstop*)
		gen pstop_cum20 = pstop_cum if year == 2020
		
		gen w_vstop_cum16 = vstop_cum * 0.4 if year == 2016
		gen w_vstop_cum17 = vstop_cum * 0.8 if year == 2017
		gen w_vstop_cum18 = vstop_cum * 1.2 if year == 2018
		gen w_vstop_cum19 = vstop_cum * 1.6 if year == 2019
		egen w_vstop_cum_avg = rmean(w_vstop*)
		gen vstop_cum20 = vstop_cum if year == 2020
		
		gen w_arrest_drug_cum16 = arrest_drug_cum * 0.4 if year == 2016
		gen w_arrest_drug_cum17 = arrest_drug_cum * 0.8 if year == 2017
		gen w_arrest_drug_cum18 = arrest_drug_cum * 1.2 if year == 2018
		gen w_arrest_drug_cum19 = arrest_drug_cum * 1.6 if year == 2019
		egen w_arrest_drug_cum_avg = rmean(w_arrest_drug*)
		gen arrest_drug_cum20 = arrest_drug_cum if year == 2020
		
		gen w_arrest_disorder_cum16 = arrest_disorder_cum * 0.4 if year == 2016
		gen w_arrest_disorder_cum17 = arrest_disorder_cum * 0.8 if year == 2017
		gen w_arrest_disorder_cum18 = arrest_disorder_cum * 1.2 if year == 2018
		gen w_arrest_disorder_cum19 = arrest_disorder_cum * 1.6 if year == 2019
		egen w_arrest_disorder_cum_avg = rmean(w_arrest_disorder*)
		gen arrest_disorder_cum20 = arrest_disorder_cum if year == 2020
				
		collapse (mean) w_pstop_cum_avg w_vstop_cum_avg w_arrest_drug_cum_avg w_arrest_disorder_cum_avg (sum) pstop_cum20 vstop_cum20 arrest_drug_cum20 arrest_disorder_cum20, by(week)
		
		list w_pstop_cum_avg pstop_cum20 if week == 10 // Pre-COVID difference
		list w_pstop_cum_avg pstop_cum20 if week == 21 // Subtract total from week 10 for COVID difference
		list w_pstop_cum_avg pstop_cum20 if week == 52 // Subtract total from week 21 for Floyd difference
			// 8202 fewer stops during FLOYD period (8202/78 NHs = 105; 105/31 weeks = 3.39 fewer stops per NH per week)
		
		list w_vstop_cum_avg vstop_cum20 if week == 10 // Pre-COVID difference
		list w_vstop_cum_avg vstop_cum20 if week == 21 // Subtract total from week 10 for COVID difference
		list w_vstop_cum_avg vstop_cum20 if week == 52 // Subtract total from week 21 for Floyd difference
		
		list w_arrest_drug_cum_avg arrest_drug_cum20 if week == 10 // Pre-COVID difference
		list w_arrest_drug_cum_avg arrest_drug_cum20 if week == 21 // Subtract total from week 10 for COVID difference
		list w_arrest_drug_cum_avg arrest_drug_cum20 if week == 52 // Subtract total from week 21 for Floyd difference
		
		list w_arrest_disorder_cum_avg arrest_disorder_cum20 if week == 10 // Pre-COVID difference
		list w_arrest_disorder_cum_avg arrest_disorder_cum20 if week == 21 // Subtract total from week 10 for COVID difference
		list w_arrest_disorder_cum_avg arrest_disorder_cum20 if week == 52 // Subtract total from week 21 for Floyd difference
		
		sum w_arrest_disorder_cum_avg arrest_disorder_cum20 if week == 52
	restore
*/


* APPENDIX FIGURES S1-S2: Neighborhood-level bar charts showing 2020 year-end deviations
	preserve
		collapse (sum) violent_cum property_cum if week == 52, by(neighborhood year)
		
		gen w_violent_cum16 = violent_cum * 0.4 if year == 2016
		gen w_violent_cum17 = violent_cum * 0.8 if year == 2017
		gen w_violent_cum18 = violent_cum * 1.2 if year == 2018
		gen w_violent_cum19 = violent_cum * 1.6 if year == 2019
		egen w_violent_cum_avg = rmean(w_violent*)
		
		gen w_property_cum16 = property_cum * 0.4 if year == 2016
		gen w_property_cum17 = property_cum * 0.8 if year == 2017
		gen w_property_cum18 = property_cum * 1.2 if year == 2018
		gen w_property_cum19 = property_cum * 1.6 if year == 2019
		egen w_property_cum_avg = rmean(w_property*)
		
		gen violent_cum20 = violent_cum if year == 2020
		gen property_cum20 = property_cum if year == 2020

		collapse (mean) w_violent_cum_avg w_property_cum_avg (sum) violent_cum20 property_cum20, by(neighborhood)

		gen nh_vio_dev = violent_cum20 - w_violent_cum_avg
		gen nh_prop_dev = property_cum20 - w_property_cum_avg
		
		/*
		
list if neighborhood ==9, clean

       neighb~d   w_viol~g   w_prop~g   viole~20   prope~20   nh_vio~v   nh_pro~v  
  9.        CBD      148.9      826.2        174       1166   25.10001      339.8  

list if neighborhood == 10, clean 		
		neighborhood   w_viol~g   w_prop~g   viole~20   prope~20   nh_vio~v   nh_pro~v  
 10.   Capitol Hill      140.3      927.2        180        936       39.7   8.799988  


		*/
		
		sum nh_vio_dev, detail
		sum nh_prop_dev, detail

		graph bar nh_vio_dev, over(neighborhood, sort(1) lab(labs(tiny) angle(45)) axis(off)) blabel(group, pos(outside) orientation(vertical) size(2)) ytitle("Deviation", size(small)) yline(4.1, lp(solid) lc(gs12)) text(5 5 "{it:Median = 4.1}", size(2) c(gs12)) plotr(margin(0 0 5 5))  name(figS1, replace)
		graph display figS1, ysize(6.25) xsize(9) margins(tiny)
		graph export "$figures\figS1.png", as(png) width(2000) replace
		
		graph bar nh_prop_dev, over(neighborhood, sort(1) lab(labs(tiny) angle(45)) axis(off)) blabel(group, pos(outside) orientation(vertical) size(2)) ytitle("Deviation", size(small)) yline(69.75, lp(solid) lc(gs12)) text(78 5.1 "{it:Median = 69.75}", size(2) c(gs12)) yscale(range(-150(100)450)) ylabel(-100(100)400) plotr(margin(0 0 7 5)) name(figS2, replace)
		graph display figS2, ysize(6.25) xsize(9) margins(tiny)
		graph export "$figures\figS2.png", as(png) width(2000) replace
	restore

* APPENDIX FIGURES S3-S5
* Neighborhood random efx of pedestrian stops on crime
	* First, import the .csv files SM produced in R, then put neighborhoods into three bins based on those coefficients. 
		preserve
			import delimited "$denver\fig_s3-s5_data.csv", clear
			drop neighborhood			
			rename v1 neighborhood
			xtile randefx_pedvio_bin = violent_ped_total_effect, n(3)
			xtile randefx_vehvio_bin = violent_veh_total_effect, n(3)
			xtile randefx_drugprop_bin = property_drugarrest_total_effect, n(3)
			save "$denver\fig_s3-s5_data.dta", replace
		restore

	* Now merge these bins into the main file.
		merge m:1 neighborhood using "$denver\fig_s3-s5_data.dta", gen(_merge9)

	* Now put descriptive tables together for each bin
		global descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value median_hh_income disadvantage pct_black pct_hispanic_any immigration"
		format pct_poverty pct_hs_higher pct_bachelors median_home_value median_hh_income disadvantage pct_black pct_hispanic_any immigration %4.3f
		format median_home_value median_hh_income total_pop %4.0f
			forv n = 1(1)3 {
				display `"pedestrian-violent bin `n'"'
				sum $descrip if randefx_pedvio_bin == `n', format sep(10)
			}
	
	gen dot1 = violent_ped_total_effect if randefx_pedvio_bin == 1
	gen dot2 = violent_ped_total_effect if randefx_pedvio_bin == 2
	gen dot3 = violent_ped_total_effect if randefx_pedvio_bin == 3
	
* Appendix Figure S3: Ordered dot plot showing random efx of pedestrian stops on violent crime		
	graph dot dot1 dot2 dot3, over(neighborhood_key, sort(violent_ped_total_effect) axis(off)) ytitle("Random Coefficient", size(2.5) margin(0 0 0 0)) yscale(range(-.052(.01).01)) ylabel(-.06(.01).01, grid) blabel(group, pos(outside) orientation(vertical) size(1.9)) leg(off) ndots(0) yline(-.022, lp(solid) lc(gs12)) text(-.021 8 "{it:Fixed Effect = -.022}", size(1.8) c(gs8)) m(1, m(O) msize(vsmall)) m(2, m(O) msize(vsmall)) m(3, m(O) msize(vsmall)) vertical  plotr(margin(0 0 9 9)) name(figS3, replace)
	gr_edit plotregion1.barlabels[73].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[73].DragBy .002 0
	gr_edit plotregion1.barlabels[72].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[72].DragBy .002 0
	gr_edit plotregion1.barlabels[71].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[71].DragBy .002 0
	gr_edit plotregion1.barlabels[70].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[70].DragBy .002 0
	gr_edit plotregion1.barlabels[69].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[69].DragBy .002 0
	gr_edit plotregion1.barlabels[68].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[68].DragBy .002 0
	gr_edit plotregion1.barlabels[67].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[67].DragBy .002 0
	gr_edit plotregion1.barlabels[66].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[66].DragBy .002 0
	gr_edit plotregion1.barlabels[65].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[65].DragBy .002 0
	gr_edit plotregion1.barlabels[64].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[64].DragBy .002 0
	gr_edit plotregion1.barlabels[63].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[63].DragBy .002 0
	gr_edit plotregion1.barlabels[62].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[62].DragBy .002 0
	gr_edit plotregion1.barlabels[61].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[61].DragBy .002 0
	gr_edit plotregion1.barlabels[60].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[60].DragBy .002 0
	gr_edit plotregion1.barlabels[59].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[59].DragBy .002 0
	gr_edit plotregion1.barlabels[58].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[58].DragBy .002 0
	gr_edit plotregion1.barlabels[57].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[57].DragBy .002 0
	gr_edit plotregion1.barlabels[56].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[56].DragBy .002 0
	gr_edit plotregion1.barlabels[55].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[55].DragBy .002 0
	gr_edit plotregion1.barlabels[54].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[54].DragBy .002 0
	gr_edit plotregion1.barlabels[53].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[53].DragBy .002 0
	gr_edit plotregion1.barlabels[52].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[52].DragBy .002 0
	gr_edit plotregion1.barlabels[51].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[51].DragBy .002 0
	gr_edit plotregion1.barlabels[50].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[50].DragBy .002 0
	gr_edit plotregion1.barlabels[49].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[49].DragBy .002 0
	gr_edit plotregion1.barlabels[48].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[48].DragBy .002 0
	gr_edit plotregion1.barlabels[47].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[47].DragBy .002 0
	gr_edit plotregion1.barlabels[46].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[46].DragBy .002 0	
	gr_edit plotregion1.barlabels[45].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[45].DragBy .002 0
	gr_edit plotregion1.barlabels[44].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[44].DragBy .002 0
	gr_edit plotregion1.barlabels[43].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[43].DragBy .002 0
	gr_edit plotregion1.barlabels[42].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[42].DragBy .002 0
	gr_edit plotregion1.barlabels[41].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[41].DragBy .002 0
	gr_edit plotregion1.barlabels[40].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[40].DragBy .002 0
	gr_edit plotregion1.barlabels[39].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[39].DragBy .002 0
	graph display figS3, ysize(6.25) xsize(9) margins(tiny)
	graph export "$figures\figS3.png", as(png) width(2000) replace

* T-tests to see if there are significant structural/compositional differences
	* Pedestrian stops-->violent crime
	
	global descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		
	forval n = 1(1)3 {
		sum $descrip if weekly == 3171 & randefx_pedvio_bin == `n'
	}

	foreach i in $descrip {
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_pedvio_bin == 1 | randefx_pedvio_bin == 3), by(randefx_pedvio_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_pedvio_bin == 1 | randefx_pedvio_bin == 2), by(randefx_pedvio_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_pedvio_bin == 2 | randefx_pedvio_bin == 3), by(randefx_pedvio_bin)
	}
		
	* Summarize violent and property crime in 2020 across the three neighborhood bins for pedestrian stop randefx
		preserve	
			collapse (sum) violent property (mean) randefx_pedvio_bin if year == 2020, by(neighborhood)
			tabstat violent, by(randefx_pedvio_bin) s(mean sd min max)
			tabstat property, by(randefx_pedvio_bin) s(mean sd min max)
			ttest violent if randefx_pedvio_bin != 2, by(randefx_pedvio_bin)
			ttest violent if randefx_pedvio_bin != 3, by(randefx_pedvio_bin)
			ttest violent if randefx_pedvio_bin != 1, by(randefx_pedvio_bin)
			ttest property if randefx_pedvio_bin != 2, by(randefx_pedvio_bin)
			ttest property if randefx_pedvio_bin != 3, by(randefx_pedvio_bin)
			ttest property if randefx_pedvio_bin != 1, by(randefx_pedvio_bin)
			sum
		restore
		
	log close
	
* Appendix Figure S4: Ordered dot plot showing random efx of vehicle stops on violent crime across neighborhoods 
	drop dot1 dot2 dot3
	gen dot1 = violent_veh_total_effect if randefx_vehvio_bin == 1
	gen dot2 = violent_veh_total_effect if randefx_vehvio_bin == 2
	gen dot3 = violent_veh_total_effect if randefx_vehvio_bin == 3

	graph dot dot1 dot2 dot3, over(neighborhood_key, sort(violent_veh_total_effect) axis(off)) ytitle("Random Coefficient", size(2.5) margin(0 0 0 0)) yscale(range(-.005(.001).001)) ylabel(-.005(.001).001, grid) blabel(group, pos(outside) orientation(vertical) size(1.9)) leg(off) ndots(0) yline(-.002, lp(solid) lc(gs12)) text(-.0019 8 "{it:Fixed Effect = -.002}", size(1.8) c(gs8)) m(1, m(O) msize(vsmall)) m(2, m(O) msize(vsmall)) m(3, m(O) msize(vsmall)) vertical  plotr(margin(0 0 9 3)) name(figS4, replace)
	gr_edit plotregion1.barlabels[77].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[77].DragBy .00022 0
	gr_edit plotregion1.barlabels[76].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[76].DragBy .00022 0
	gr_edit plotregion1.barlabels[75].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[75].DragBy .00022 0
	gr_edit plotregion1.barlabels[74].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[74].DragBy .00022 0
	gr_edit plotregion1.barlabels[73].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[73].DragBy .00022 0
	gr_edit plotregion1.barlabels[72].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[72].DragBy .00022 0
	gr_edit plotregion1.barlabels[71].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[71].DragBy .00022 0
	gr_edit plotregion1.barlabels[70].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[70].DragBy .00022 0
	gr_edit plotregion1.barlabels[69].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[69].DragBy .00022 0
	gr_edit plotregion1.barlabels[68].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[68].DragBy .00022 0
	gr_edit plotregion1.barlabels[67].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[67].DragBy .00022 0
	gr_edit plotregion1.barlabels[66].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[66].DragBy .00022 0
	gr_edit plotregion1.barlabels[65].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[65].DragBy .00022 0
	gr_edit plotregion1.barlabels[64].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[64].DragBy .00022 0
	gr_edit plotregion1.barlabels[63].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[63].DragBy .00022 0
	gr_edit plotregion1.barlabels[62].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[62].DragBy .00022 0
	gr_edit plotregion1.barlabels[61].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[61].DragBy .00022 0
	gr_edit plotregion1.barlabels[60].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[60].DragBy .00022 0
	gr_edit plotregion1.barlabels[59].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[59].DragBy .00022 0
	gr_edit plotregion1.barlabels[58].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[58].DragBy .00022 0
	gr_edit plotregion1.barlabels[57].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[57].DragBy .00022 0
	gr_edit plotregion1.barlabels[56].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[56].DragBy .00022 0
	gr_edit plotregion1.barlabels[55].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[55].DragBy .00022 0
	gr_edit plotregion1.barlabels[54].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[54].DragBy .00022 0
	gr_edit plotregion1.barlabels[53].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[53].DragBy .00022 0
	gr_edit plotregion1.barlabels[52].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[52].DragBy .00022 0
	gr_edit plotregion1.barlabels[51].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[51].DragBy .00022 0
	gr_edit plotregion1.barlabels[50].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[50].DragBy .00022 0
	gr_edit plotregion1.barlabels[49].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[49].DragBy .00022 0
	gr_edit plotregion1.barlabels[48].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[48].DragBy .00022 0
	gr_edit plotregion1.barlabels[47].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[47].DragBy .00022 0
	graph display figS4, ysize(6.25) xsize(9) margins(tiny)
	graph export "$figures\figS4.png", as(png) width(2000) replace
	
* T-tests to see if there are significant structural/compositional differences
	* Vehicle stops-->violent crime
	forval n = 1(1)3 {
		sum $descrip if weekly == 3171 & randefx_vehvio_bin == `n'
	}

	foreach i in $descrip {
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_vehvio_bin == 1 | randefx_vehvio_bin == 3), by(randefx_vehvio_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_vehvio_bin == 1 | randefx_vehvio_bin == 2), by(randefx_vehvio_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_vehvio_bin == 2 | randefx_vehvio_bin == 3), by(randefx_vehvio_bin)
	}
		
	* Summarize violent and property crime in 2020 across the three neighborhood bins for pedestrian stop randefx
		preserve	
			collapse (sum) violent property (mean) randefx_vehvio_bin if year == 2020, by(neighborhood)
			tabstat violent, by(randefx_vehvio_bin) s(mean sd min max)
			tabstat property, by(randefx_vehvio_bin) s(mean sd min max)
			ttest violent if randefx_vehvio_bin != 2, by(randefx_vehvio_bin)
			ttest violent if randefx_vehvio_bin != 3, by(randefx_vehvio_bin)
			ttest violent if randefx_vehvio_bin != 1, by(randefx_vehvio_bin)
			ttest property if randefx_vehvio_bin != 2, by(randefx_vehvio_bin)
			ttest property if randefx_vehvio_bin != 3, by(randefx_vehvio_bin)
			ttest property if randefx_vehvio_bin != 1, by(randefx_vehvio_bin)
			sum
		restore


* Appendix Figure S5: Ordered dot plot showing random efx of drug arrests on property crime across neighborhoods 
	drop dot1 dot2 dot3
	gen dot1 = property_drugarrest_total_effect if randefx_drugprop_bin == 1
	gen dot2 = property_drugarrest_total_effect if randefx_drugprop_bin == 2
	gen dot3 = property_drugarrest_total_effect if randefx_drugprop_bin == 3

	graph dot dot1 dot2 dot3, over(neighborhood_key, sort(property_drugarrest_total_effect) axis(off)) ytitle("Random Coefficient", size(2.5) margin(0 0 0 0)) yscale(range(-.10(.05).06)) ylabel(-.10(.05).05, grid) blabel(group, pos(outside) orientation(vertical) size(1.9)) leg(off) ndots(0) yline(-.022, lp(solid) lc(gs12)) text(-.026 8 "{it:Fixed Effect = -.027}", size(1.8) c(gs8)) m(1, m(O) msize(vsmall)) m(2, m(O) msize(vsmall)) m(3, m(O) msize(vsmall)) vertical  plotr(margin(0 0 2 11)) name(figS5, replace)
	gr_edit plotregion1.barlabels[68].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[68].DragBy .006 0
	gr_edit plotregion1.barlabels[67].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[67].DragBy .006 0
	gr_edit plotregion1.barlabels[66].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[66].DragBy .006 0
	gr_edit plotregion1.barlabels[65].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[65].DragBy .006 0
	gr_edit plotregion1.barlabels[64].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[64].DragBy .006 0
	gr_edit plotregion1.barlabels[63].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[63].DragBy .006 0
	gr_edit plotregion1.barlabels[62].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[62].DragBy .006 0
	gr_edit plotregion1.barlabels[61].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[61].DragBy .006 0
	gr_edit plotregion1.barlabels[60].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[60].DragBy .006 0
	gr_edit plotregion1.barlabels[59].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[59].DragBy .006 0
	gr_edit plotregion1.barlabels[58].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[58].DragBy .006 0
	gr_edit plotregion1.barlabels[57].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[57].DragBy .006 0
	gr_edit plotregion1.barlabels[56].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[56].DragBy .006 0
	gr_edit plotregion1.barlabels[55].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[55].DragBy .006 0
	gr_edit plotregion1.barlabels[54].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[54].DragBy .006 0
	gr_edit plotregion1.barlabels[53].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[53].DragBy .006 0
	gr_edit plotregion1.barlabels[52].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[52].DragBy .006 0
	gr_edit plotregion1.barlabels[51].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[51].DragBy .006 0
	gr_edit plotregion1.barlabels[50].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[50].DragBy .006 0
	gr_edit plotregion1.barlabels[49].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[49].DragBy .006 0
	gr_edit plotregion1.barlabels[48].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[48].DragBy .006 0
	gr_edit plotregion1.barlabels[47].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[47].DragBy .006 0
	gr_edit plotregion1.barlabels[46].style.editstyle box_alignment(north) editcopy
	gr_edit plotregion1.barlabels[46].DragBy .006 0
	graph display figS5, ysize(6.25) xsize(9) margins(tiny)
	graph export "$figures\figS5.png", as(png) width(2000) replace
		
	* Run the t-tests for effect of drug arrests on property crime
	forval n = 1(1)3 {
		sum $descrip if weekly == 3171 & randefx_drugprop_bin == `n'
	}

	foreach i in $descrip {
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_drugprop_bin == 1 | randefx_drugprop_bin == 3), by(randefx_drugprop_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_drugprop_bin == 1 | randefx_drugprop_bin == 2), by(randefx_drugprop_bin)
		display `" "'
		display `"`i'"'
		ttest `i' if weekly == 3171 & (randefx_drugprop_bin == 2 | randefx_drugprop_bin == 3), by(randefx_drugprop_bin)
	}
		
	* Summarize violent and property crime in 2020 across the three neighborhood bins for pedestrian stop randefx
		preserve	
			collapse (sum) violent property (mean) randefx_drugprop_bin if year == 2020, by(neighborhood)
			tabstat violent, by(randefx_drugprop_bin) s(mean sd min max)
			tabstat property, by(randefx_drugprop_bin) s(mean sd min max)
			ttest violent if randefx_drugprop_bin != 2, by(randefx_drugprop_bin)
			ttest violent if randefx_drugprop_bin != 3, by(randefx_drugprop_bin)
			ttest violent if randefx_drugprop_bin != 1, by(randefx_drugprop_bin)
			ttest property if randefx_drugprop_bin != 2, by(randefx_drugprop_bin)
			ttest property if randefx_drugprop_bin != 3, by(randefx_drugprop_bin)
			ttest property if randefx_drugprop_bin != 1, by(randefx_drugprop_bin)
			sum
		restore
		
**********************************************************************************************		
* SUPPLEMENTAL ANALYSES		
	* Run the t-tests for effect of pedestrian stops on MVT
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedmvt_coef_bin == 1 | randefx_pedmvt_coef_bin == 3), by(randefx_pedmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedmvt_coef_bin == 1 | randefx_pedmvt_coef_bin == 2), by(randefx_pedmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedmvt_coef_bin == 2 | randefx_pedmvt_coef_bin == 3), by(randefx_pedmvt_coef_bin)
		}
		
	* Run the t-tests for effect of pedestrian stops on agg assaults
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedagg_coef_bin == 1 | randefx_pedagg_coef_bin == 3), by(randefx_pedagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedagg_coef_bin == 1 | randefx_pedagg_coef_bin == 2), by(randefx_pedagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_pedagg_coef_bin == 2 | randefx_pedagg_coef_bin == 3), by(randefx_pedagg_coef_bin)
		}
		
	* Run the t-tests for effect of vehicle stops on MVTs
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehmvt_coef_bin == 1 | randefx_vehmvt_coef_bin == 3), by(randefx_vehmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehmvt_coef_bin == 1 | randefx_vehmvt_coef_bin == 2), by(randefx_vehmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehmvt_coef_bin == 2 | randefx_vehmvt_coef_bin == 3), by(randefx_vehmvt_coef_bin)
		}
		
	* Run the t-tests for effect of vehicle stops on Agg Assaults
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehagg_coef_bin == 1 | randefx_vehagg_coef_bin == 3), by(randefx_vehagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehagg_coef_bin == 1 | randefx_vehagg_coef_bin == 2), by(randefx_vehagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_vehagg_coef_bin == 2 | randefx_vehagg_coef_bin == 3), by(randefx_vehagg_coef_bin)
		}
		
	* Run the t-tests for effect of drug arrests on MVTs
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugmvt_coef_bin == 1 | randefx_drugmvt_coef_bin == 3), by(randefx_drugmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugmvt_coef_bin == 1 | randefx_drugmvt_coef_bin == 2), by(randefx_drugmvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugmvt_coef_bin == 2 | randefx_drugmvt_coef_bin == 3), by(randefx_drugmvt_coef_bin)
		}
		
	* Run the t-tests for effect of drug arrests on Agg Assaults
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugagg_coef_bin == 1 | randefx_drugagg_coef_bin == 3), by(randefx_drugagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugagg_coef_bin == 1 | randefx_drugagg_coef_bin == 2), by(randefx_drugagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_drugagg_coef_bin == 2 | randefx_drugagg_coef_bin == 3), by(randefx_drugagg_coef_bin)
		}
		
	* Run the t-tests for effect of disorder arrests on MVTs
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_dismvt_coef_bin == 1 | randefx_dismvt_coef_bin == 3), by(randefx_dismvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_dismvt_coef_bin == 1 | randefx_dismvt_coef_bin == 2), by(randefx_dismvt_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_dismvt_coef_bin == 2 | randefx_dismvt_coef_bin == 3), by(randefx_dismvt_coef_bin)
		}
		
	* Run the t-tests for effect of disorder arrests on Agg Assaults
		local descrip "total_pop pct_poverty pct_hs_higher pct_bachelors median_home_value_rev median_hh_income_rev disadvantage pct_black pct_hispanic_any immigration"
		foreach i in `descrip' {
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_disagg_coef_bin == 1 | randefx_disagg_coef_bin == 3), by(randefx_disagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_disagg_coef_bin == 1 | randefx_disagg_coef_bin == 2), by(randefx_disagg_coef_bin)
			display `" "'
			display `"`i'"'
			ttest `i' if weekly == 3171 & (randefx_disagg_coef_bin == 2 | randefx_disagg_coef_bin == 3), by(randefx_disagg_coef_bin)
		}
