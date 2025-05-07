# ============================================================
# globe_config.R
# ------------------------------------------------------------
# Configuration script for globe_image()
# Loads required libraries, sets options, and defines palettes
# ============================================================

# --- 1. Load Required Packages
# --- 2.1. General use
if(!require("devtools")){install.packages("devtools")}
if(!require("abind")){install.packages("abind")}

# --- 2.2. Tidy environment-related
if(!require("tidyverse")){install.packages("tidyverse")}
if(!require("parallel")){install.packages("parallel")}

# --- 2.4. Spatial data and object
if(!require("terra")){install.packages("terra")}
if(!require("sf")){install.packages("sf")}
if(!require("rnaturalearth")){install.packages("rnaturalearth")}
if(!require("maps")){install.packages("maps")}
if(!require("mapproj")){install.packages("mapproj")}

# --- 2.6. Others
if(!require("RColorBrewer")){install.packages("RColorBrewer")}
if(!require("scales")){install.packages("scales")}
if(!require("magick")){install.packages("magick")}

# --- 3. Define Default Color Palette(s)
mako_pal <- function(n = 100) {
  tmp <- c("black", "#0A0A32", "#142C50", "#1F4D70", "#2A6D8F", "#368DAE", "#46ABBB", "#64C5BC", "#8DD6B8", "#B7E5Bd", "white")
  pal <- colorRampPalette(tmp)(n)
  
  return(pal)
} # END

parula_pal <- function(n){
  tmp <- c("#000000", "#005DAB", "#0083C7", "#00A8DE", "#05C8D6", "#5CE6BF", "#B6FF9E", "#FDE724", "#FFB400")
  pal <- colorRampPalette(tmp)(n)
  
  return(pal)
} # END 


rocket_pal <- function(n){
  tmp <- c("black", "#03051AFF","#2A1636FF","#551E4FFF","#841E5AFF","#B41658FF","#DD2C45FF","#F06043FF","#F5936AFF","#F6C09EFF","#FAEBDDFF","white")
  pal <- colorRampPalette(tmp)(n)
} # END 


viridis_pal <- function(n){
  tmp <- c("#440154FF","#414487FF","#2A788EFF","#22A884FF","#7AD151FF","#FDE725FF")
  pal <- colorRampPalette(tmp)(n)
  
  return(pal)
} # END 

inferno_pal <- function(n){
  tmp <- c("#000004ff","#1b0b40ff","#480e64ff","#761b6bff","#a32d5fff","#cc4546ff","#ea6827ff","#f99913ff","#f9cd3aff","#fcffa4ff")
  pal <- colorRampPalette(tmp)(n)
  
  return(pal)
} # END 

# --- End of Configuration Script ---
