Readme file for: "When police pull back: Neighborhood-level effects of de-policing on violent and property crime" in Criminology
Corresponding author: Justin Nix <jnix@unomaha.edu>
Co-authors: Jessie Huff, Scott E. Wolfe, David C. Pyrooz, Scott M. Mourtgos
Date: 1/26/2024

*** Instructions ***
This repository consists of the code needed to produce the tables and figures in our article "When police pull back: Neighborhood-level effects of de-policing on violent and property crime."

*** Description of code and files ***

- Preprint version 1 was uploaded to Socarxiv on March 3, 2023. It received a reject & resubmit from Criminology on June 10, 2023. 
- Preprint version 2 was uploaded to Socarxiv on September 22, 2023. It was accepted for publication at Criminology on October 2, 2023. 

- denver_prep.do cleans and merges the various datasets needed to reproduce the core estimation dataset in R and the .dofile that generates Figure 1 and Figures S1-S5.
- denver_reproduce_figures.do generates Figure 1 and Figures S1-S5, and the descriptive statistics for Table S14.
- Denver-post.R reproduces all analyses presented in Table 1 and the supplemental appendix.

- fig_s3-s5_data.csv contains the random effects estimates for each neighborhood needed to create Figures S3-S5.
- All other data files are described in greater detail in our supplemental appendix 

*** Computing Environment ***

Stata v.18.0

R version 4.2.2 (2022-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 19045)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.utf8 
[2] LC_CTYPE=English_United States.utf8   
[3] LC_MONETARY=English_United States.utf8
[4] LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] car_3.1-2          carData_3.0-5      Hmisc_5.1-0       
 [4] lubridate_1.9.2    forcats_1.0.0      stringr_1.5.0     
 [7] dplyr_1.1.2        purrr_1.0.1        readr_2.1.4       
[10] tidyr_1.3.0        tibble_3.2.1       ggplot2_3.4.2     
[13] tidyverse_2.0.0    stargazer_5.2.3    sjstats_0.18.2    
[16] lmerTest_3.1-3     performance_0.10.4 lme4_1.1-34       
[19] Matrix_1.6-0      

loaded via a namespace (and not attached):
 [1] splines_4.2.2       modelr_0.1.11       Formula_1.2-5      
 [4] bayestestR_0.13.1   numDeriv_2016.8-1.1 pillar_1.9.0       
 [7] backports_1.4.1     lattice_0.20-45     glue_1.6.2         
[10] digest_0.6.31       checkmate_2.2.0     minqa_1.2.5        
[13] colorspace_2.1-0    sandwich_3.0-2      htmltools_0.5.4    
[16] pkgconfig_2.0.3     broom_1.0.5         xtable_1.8-4       
[19] mvtnorm_1.2-2       scales_1.2.1        tzdb_0.4.0         
[22] timechange_0.2.0    emmeans_1.8.7       htmlTable_2.4.1    
[25] generics_0.1.3      sjlabelled_1.2.0    TH.data_1.1-2      
[28] withr_2.5.0         nnet_7.3-18         cli_3.6.0          
[31] survival_3.4-0      magrittr_2.0.3      evaluate_0.21      
[34] estimability_1.4.1  fansi_1.0.4         nlme_3.1-160       
[37] MASS_7.3-60         foreign_0.8-83      data.table_1.14.8  
[40] tools_4.2.2         hms_1.1.3           lifecycle_1.0.3    
[43] multcomp_1.4-25     munsell_0.5.0       cluster_2.1.4      
[46] compiler_4.2.2      rlang_1.1.1         grid_4.2.2         
[49] nloptr_2.0.3        rstudioapi_0.15.0   htmlwidgets_1.6.2  
[52] rmarkdown_2.23      base64enc_0.1-3     boot_1.3-28        
[55] gtable_0.3.3        codetools_0.2-18    abind_1.4-5        
[58] sjmisc_2.8.9        R6_2.5.1            gridExtra_2.3      
[61] zoo_1.8-12          knitr_1.43          fastmap_1.1.1      
[64] utf8_1.2.3          insight_0.19.7      stringi_1.7.12     
[67] Rcpp_1.0.11         vctrs_0.6.3         rpart_4.1.19       
[70] tidyselect_1.2.0    xfun_0.39           coda_0.19-4 