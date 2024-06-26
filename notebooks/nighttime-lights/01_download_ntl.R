# Download Nighttime Lights

## Bearer token
# bearer <- read.csv("/Users/rmarty/Library/CloudStorage/OneDrive-WBG/Webscraping API Keys/bearer_bm.csv") %>%
#   pull(token)
bearer <- read.csv("~/Desktop/bearer_bm.csv") %>%
  pull(token)

## Define ROI
roi_sf <- read_sf(file.path(boundaries_dir, "ner_adm_ignn_20230720_ab_shp",
                            "NER_admbnda_adm0_IGNN_20230720.shp"))

## Download data
annual_r <- bm_raster(roi_sf = roi_sf,
                      product_id = "VNP46A4",
                      date = 2012:2023,
                      bearer = bearer,
                      output_location_type = "file",
                      file_dir = file.path(ntl_dir,
                                           "individual_rasters",
                                           "annually"))

month_r <- bm_raster(roi_sf = roi_sf,
                     product_id = "VNP46A3",
                     date = seq.Date(from = ymd("2012-01-01"), to = Sys.Date(), by = "month"),
                     bearer = bearer,
                     output_location_type = "file",
                     file_dir = file.path(ntl_dir,
                                          "individual_rasters",
                                          "monthly"))

# day_r <- bm_raster(roi_sf = roi_sf,
#                    product_id = "VNP46A2",
#                    date = seq.Date(from = ymd("2023-01-01"), to = Sys.Date(), by = "day"),
#                    bearer = bearer,
#                    output_location_type = "file",
#                    file_dir = file.path(ntl_dir,
#                                         "individual_rasters",
#                                         "daily"))
