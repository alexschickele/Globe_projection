#' Create an Orthographic Projection Image of Global Data
#'
#' This function generates and saves a globe view (orthographic projection)
#' of gridded global data, overlaying land as a black mask for visual clarity.
#'
#' @param VALUES   A numeric vector of raster values in 1° resolution (n = 64800).
#' @param LON      Longitude at the center of the globe (e.g., 0 to 360 or -180 to 180).
#' @param LAT      Latitude at the center of the globe (e.g., -90 to 90).
#' @param COL      A color palette (vector of 100 colors) to represent VALUES.
#' @param FILENAME File path (with extension, e.g., ".jpeg") to save the image output.
#'
#' @return Saves a JPEG image of the orthographic projection.

globe_image <- function(VALUES, LON, LAT, COL, FILENAME) {
  
  message("Step 1: Creating base raster and interpolating values...")
  r0 <- rast(ncols = 360, nrows = 180, extent = c(-180, 180, -90, 90))  # 1-degree grid
  values(r0) <- VALUES
  r0[is.na(r0)] <- 0  # Fill NA (land) to avoid interpolation edge artifacts
  r_interp <- resample(r0, rast(ncols = 3600, nrows = 1800, extent = ext(r0)), method = "cubicspline")
  
  message("Step 2: Downloading and processing land polygons...")
  land_sf <- rnaturalearth::ne_download(scale = "medium", type = "land", category = "physical", returnclass = "sf")
  land_raster <- rasterize(vect(land_sf), r_interp, field = 1)
  land_raster <- resample(land_raster, r_interp, method = "bilinear")
  land_mask <- classify(land_raster, matrix(c(-Inf, 0, NA), ncol = 3, byrow = TRUE))
  
  message("Step 3: Converting rasters to data frames...")
  df_model <- as.data.frame(r_interp, xy = TRUE, na.rm = TRUE)
  colnames(df_model) <- c("lon", "lat", "value")
  df_land <- as.data.frame(land_mask, xy = TRUE, na.rm = TRUE)
  colnames(df_land) <- c("lon", "lat", "elev")
  
  message("Step 4: Projecting to orthographic view...")
  model_proj <- mapproject(df_model$lon, df_model$lat, projection = "orthographic",
                           orientation = c(LAT, LON, 0))
  land_proj <- mapproject(df_land$lon, df_land$lat, projection = "orthographic",
                          orientation = c(LAT, LON, 0))
  
  keep_model <- !is.na(model_proj$x) & !is.na(model_proj$y)
  keep_land <- !is.na(land_proj$x) & !is.na(land_proj$y)
  
  message(paste("Step 5: Plotting and saving image to", FILENAME, "..."))
  jpeg(FILENAME, width = 1000, height = 1000, quality = 100)
  par(mar = rep(0, 4))
  
  plot(NA, xlim = c(-1, 1), ylim = c(-1, 1), asp = 1,
       axes = FALSE, xlab = "", ylab = "",
       main = "Orthographic Projection of Global Data",
       sub = paste("Centered at Lat:", LAT, "Lon:", LON))
  
  model_colors <- COL[cut(df_model$value[keep_model], breaks = 100)]
  points(model_proj$x[keep_model], model_proj$y[keep_model], col = model_colors, pch = ".", cex = 1.2)
  points(land_proj$x[keep_land], land_proj$y[keep_land], col = "black", pch = ".", cex = 1.2)
  symbols(0, 0, circles = 1, inches = FALSE, add = TRUE, lwd = 2)
  dev.off()
  
  message("Done.\n")
}
