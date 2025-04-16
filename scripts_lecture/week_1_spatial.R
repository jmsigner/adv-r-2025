
# Exc. 2
set.seed(123)

df1 <- data.frame(
  x = runif(100, 0, 100),
  y = runif(100, 0, 100),
  crown_diameter = runif(100, 1, 15),
  sp = sample(letters[1:4], 100, TRUE)
)


head(df1)

library(sf)
library(dplyr)
# 1. Use df1 and create a geometry column.
df2 <- df1 |> st_as_sf(coords = c("x", "y"))

# 2. Buffer each tree with its canopy radius.
df2 <- df2 |> mutate(ca = st_buffer(geometry, dist = crown_diameter / 2))

# 3. Calculate the crown area of each tree and save it in a new column (hint, you my want to use the function st_area()).
df2 <- df2 |> mutate(area = st_area(ca))

# 4. Find the tree with the largest canopy area.
df2 |> arrange(-area)
df2 |> slice_max(area, n = 1)


# 5. Find the tree with the largest canopy area for each species.
df2 |> group_by(sp) |> 
  slice_max(area, n = 1)


# Exercise 3
#1. Load the Digital Elevation Model (DEM) of Germany saved in
#data/raster/dem_3035.tif.

library(terra)
dem <- rast("data/raster/dem_3035.tif")
plot(dem)

#2. What is the spatial resolution and the CRS of the raster?
res(dem)

#3. Cut the DEM to the state of Lower Saxony (use the data set on German states for this; data/ger/ger_states_3035.shp).

ger <- st_read("data/ger/ger_states_3035.shp")
ls <- filter(ger, state == "Niedersachsen")

dem.ls <- mask(crop(dem, ls), ls)
plot(dem.ls)



# 4. What is the mean elevation of Lower Saxony?
mean(values(dem.ls), na.rm = TRUE)

# 5. Find all pixels in Lower Saxony that have an elevation of 100 m or more. What is the percentage of Lower Saxony with an elevation of 100 m or more? 
plot(dem.ls <= 100)

x <- values(dem.ls)[, 1]
x <- x[!is.na(x)]
sum(x <= 100) / length(x)
mean(x <= 100)