
# ============================================================
# master.R
# ------------------------------------------------------------
# Master script to generate and save several globe images 
# as a GIF by iterating over species, months, and rotating
# the globe.
# ============================================================

setwd("/net/meso/work/aschickele/Globe_projection")

# --- 1. Load Configuration and Necessary Packages
# Load the configuration and packages from the previous setup
source("./code/config.R")
source("./code/globe_image.R")

# --- 2. Load Data: Cell x Species x Month x Bootstrap Array (to adapt)
# It should be a CEPHALOPOD output by default
load("/net/meso/work/aschickele/Diversity/output/00_WBF_poster/DIVERSITY.RData")
DATA <- DIVERSITY[[4]] %>% apply(c(1,2,4), mean, na.rm = T)

# --- 3. Build the parameter INDEX (to adapt)
# To be used as input to the globe_image() function
INDEX <- data.frame(ID = str_pad(1:360, 3, pad = "0"),
                    LAT = rep(-10, 360),
                    LON = -179.5:179.5,
                    MONTH = rep(1:12, 10))
INDEX <- INDEX %>% 
  mutate(FILENAME = paste0("proj_", ID, "_", LAT, "_", LON, "_m", MONTH))

# --- 4. Create directory (to adapt)
DIR_NAME <- "plankton_diversity"
if (!dir.exists(paste0("./output/", DIR_NAME))) {
  dir.create(paste0("./output/", DIR_NAME))
}

# --- 5. Create globe images
# According to the index
mclapply(1:nrow(INDEX), function(x){
  globe_image(VALUES = DATA[,4,INDEX$MONTH[x]],
              LON = INDEX$LON[x],
              LAT = INDEX$LAT[x],
              COL = parula_pal(100),
              FILENAME = paste0("./output/", DIR_NAME, "/", INDEX$FILENAME[x], ".jpeg"))
  
}, mc.cores = 10) # end index loop

# --- 6. Create a GIF out of the files
TO_GIF <- list.files(paste0("./output/", DIR_NAME), full.names = T) %>% .[grep(".jpeg", .)] # list files
img_list <- image_read(TO_GIF) # pointer to images
img_gif <- image_animate(img_list, fps = 10, loop = 0) # pointer to gif
image_write(image = img_gif, path = paste0("./output/", DIR_NAME, "/rotation.gif")) # save

# END
