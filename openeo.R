library(openeo)
con = openeo::connect("https://openeo.cloud")
login()
# list_collections()
collection = "SENTINEL2_L2A"
coll_meta = describe_collection(collection)
library(sf)
bbox = st_bbox(c(xmin = 7, xmax = 7.01, ymin = 52, ymax = 52.01), crs = 'EPSG:4326')
bbox = list(west = bbox[[1]],
            east = bbox[[3]],
            south = bbox[[2]],
            north = bbox[[4]])
bands = c("B04", "B08")
time_range = list("2018-01-01", "2019-01-01")
p = openeo::processes()
ndvi = function(data, context) {
  red = data[1]
  nir = data[2]
  (nir-red)/(nir+red)
}
data = p$load_collection(id = collection, 
                         spatial_extent = bbox,
                         temporal_extent = time_range, 
                         bands = bands) 
calc_ndvi = p$reduce_dimension(data = data,
                               dimension = "bands",
                               reducer = ndvi)
intervals = list(c('2018-01-02', '2018-02-01'),
                 c('2018-02-01', '2018-03-01'),
                 c('2018-03-01', '2018-04-01'),
                 c('2018-04-01', '2018-05-01'),
                 c('2018-05-01', '2018-06-01'), 
                 c('2018-06-01', '2018-07-01'), 
                 c('2018-07-01', '2018-08-01'),
                 c('2018-08-01', '2018-09-01'),
                 c('2018-09-01', '2018-10-01'), 
                 c('2018-10-01', '2018-11-01'),
                 c('2018-11-01', '2018-12-01'), 
                 c('2018-12-01', '2018-12-30'))
# and labels
labels = lapply(intervals, function(x){x[[1]]}) %>% unlist() # create labels from list

# add the process node
temp_period = p$aggregate_temporal(data = calc_ndvi,
                                   intervals = intervals,
                                   reducer = function(data, context){p$median(data)},
                                   labels = labels,
                                   dimension = "t")
result = p$save_result(data = temp_period, format="NetCDF")
# synchronous:
#compute_result(result, format = "NetCDF", output_file = "ndvi.nc", con = con)

# asynchronous:
job = create_job(graph = result,
                 title = "ndvi.nc",
                 description = "ndvi.nc",
                 format = "netCDF")

start_job(job = job$id) # use the id of the job (job$id) to start the job
job_list = list_jobs() # here you can see your jobs and their status

#result_obj = list_results(job = job$id)
#result_obj

status(job) # wait until it sais finished, then:

dwnld = download_results(job = job$id, 
                         folder = "./") # adjust path here

r = read_stars("openEO.nc")
plot(r)
