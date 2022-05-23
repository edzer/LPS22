library(gdalcubes)
L8.files = list.files("/home/edzer/data/L8_cropped", pattern = ".tif",
					  recursive = TRUE, full.names = TRUE)
L8.col = create_image_collection(L8.files, format = "L8_SR", out_file = "L8.db")
extent(L8.col, srs="EPSG:4326")
v.overview.500m = cube_view(srs="EPSG:3857", extent=L8.col, dx = 500, dy = 500,
							dt = "P1Y", resampling="average", aggregation="median")
v.overview.500m
L8.cube.overview = raster_cube(L8.col, v.overview.500m)

L8.cube.overview.rgb = select_bands(L8.cube.overview, c("B02", "B03", "B04"))

write_ncdf(L8.cube.overview.rgb, "L8.nc")

