# Extract data

AGG_FUNS <- c("mean", "sum")

# Load ROIs --------------------------------------------------------------------
adm0_sf <- read_sf(file.path(boundaries_dir, "ner_adm_ignn_20230720_ab_shp", 
                             "NER_admbnda_adm0_IGNN_20230720.shp"))
adm1_sf <- read_sf(file.path(boundaries_dir, "ner_adm_ignn_20230720_ab_shp", 
                             "NER_admbnda_adm1_IGNN_20230720.shp"))
adm2_sf <- read_sf(file.path(boundaries_dir, "ner_adm_ignn_20230720_ab_shp", 
                             "NER_admbnda_adm2_IGNN_20230720.shp"))
adm3_sf <- read_sf(file.path(boundaries_dir, "ner_adm_ignn_20230720_ab_shp", 
                             "NER_admbnda_adm3_IGNN_20230720.shp"))

city_df      <- read.csv(file.path(city_dir, "niger_cities.csv"))
city_sf      <- st_as_sf(city_df, coords = c("longitude", "latitude"), crs = 4326)
city_buff_sf <- city_sf %>% st_buffer(dist = 10*1000)

# Extract individual files -----------------------------------------------------

#### Loop through unit
for(unit in c("adm0", "adm1", "adm2", "adm3", "city")){
  
  dir.create(file.path(ntl_dir, "aggregated_individual", unit))
  
  if(unit == "adm0") unit_sf <- adm0_sf
  if(unit == "adm1") unit_sf <- adm1_sf
  if(unit == "adm2") unit_sf <- adm2_sf
  if(unit == "adm3") unit_sf <- adm3_sf
  if(unit == "city") unit_sf <- city_buff_sf
  
  #### Loop through time period
  for(time_period in c("annually", "monthly")){ # "daily"
    
    dir.create(file.path(ntl_dir, "aggregated_individual", unit, time_period))
    
    files_vec <- file.path(ntl_dir, 
                           "individual_rasters",
                           time_period) %>%
      list.files(full.names = T)
    
    #### Loop through dates
    for(file_i in files_vec){
      
      date_i <- file_i %>%
        str_replace_all(".*qflag_t", "") %>%
        str_replace_all(".tif", "")
      
      OUT_DIR <- file.path(ntl_dir, "aggregated_individual", unit, time_period,
                           paste0(date_i, ".Rds"))
      
      #### Extract data
      if(!file.exists(OUT_DIR)){
        
        r <- terra::rast(file_i)
        
        ntl_df <- exact_extract(r, unit_sf, fun = AGG_FUNS)
        names(ntl_df) <- paste0("ntl_", names(ntl_df))
        ntl_df$date <- date_i
        
        unit_df <- unit_sf %>%
          st_drop_geometry()
        unit_df$date <- NULL
        
        ntl_df <- bind_cols(unit_df, ntl_df)
        
        #### Cleanup dates
        if(time_period == "annually"){
          
          ntl_df$date <- ntl_df$date %>% as.numeric()
          
        } else if(time_period == "monthly"){
          
          ntl_df$date <- paste0(ntl_df$date, "-01") %>% 
            str_replace_all("_", "-") %>%
            ymd()
          
        } else if(time_period == "daily"){
          
          ntl_df$date <- ntl_df$date %>% 
            str_replace_all("_", "-") %>%
            ymd()
          
        }
        
        saveRDS(ntl_df, OUT_DIR)
        
      }
    }
  }
}

# Append files -----------------------------------------------------------------
for(unit in c("adm0", "adm1", "adm2", "adm3", "city")){
  for(time_period in c("annually", "monthly", "daily")){ # "daily"
    
    ntl_df <- file.path(ntl_dir, "aggregated_individual", unit, time_period) %>%
      list.files(full.names = T) %>%
      map_df(readRDS)
    
    saveRDS(ntl_df, file.path(ntl_dir, "aggregated_appended", 
                              paste0(unit, "_", time_period, ".Rds")))
    
    write_dta(ntl_df, file.path(ntl_dir, "aggregated_appended", 
                              paste0(unit, "_", time_period, ".dta")))

  }
}

