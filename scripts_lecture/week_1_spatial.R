
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

