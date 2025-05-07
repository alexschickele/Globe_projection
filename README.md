# 🌍 Rotating Globe Projections in R

**Description:**\

A lightweight and modular set of R functions for generating rotating globe projections from spatial data. This repository enables you to visualize geospatial matrices (e.g., species distributions, climate data) on an orthographic globe, and compile a series of frames into a smooth `.gif` animation.

## 📦 Repository Structure

This repository includes the following components:

### `1) config.R`

Handles package installation and loading. It ensures all dependencies are installed before running the other scripts.

### `2) globe_image.R`

Core function that takes a `longitude × latitude` matrix and projects it onto a globe centered at a specified geographic coordinate (latitude, longitude). It renders the globe as a `.jpeg` image.

### `3) master.R`

Driver script that:

-   Loads a spatial dataset (e.g., a 3D array: cell × species × time).

-   Allows the user to define parameters such as species, month, and globe center coordinates.

-   Iteratively generates a series of globe images.

-   Combines them into a rotating `.gif` animation.

## ⚠️ Known Issues

While the code runs successfully and produces a usable `.gif`, some globe frames may fail to render properly at certain latitude/longitude combinations due to projection issues. This results in a few missing frames in the final animation. The visual impact is minor, but the issue is noted for future improvement.

## ✅ Requirements

-   R (\>= 4.0)

-   Suggested packages: `terra`, `sf`, `rnaturalearth`, `mapproj`, `magick`, etc.\
    See `config.R` for full details.
