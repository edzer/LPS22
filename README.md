# The R-spatial package ecosystem and openEO for analysing Earth Observation data

LPS22, session C5.03 Open Source Science, toolboxes and Jupyter technologies in EO

Authors:
E. Pebesma ¹,
M. Mohr ¹,
F. Lahn ²,
P. Zellner ³,
M. Rossi ³,
A. Jacob ³,
P. Griffiths ⁴;
¹ University of Münster
² EFTAS Fernerkundung Technologietransfer GmbH
³ EURAC Research
⁴ ESA - ESRIN

Abstract:

R is a data science language with strong support for spatial data handling and analysis as well as spatial statistics. It has a variety of extension packages for spatial analysis, some of which have been developed and maintained for several decades. Support for data structures like tables, matrices and (labelled) arrays is native; packages sp and raster have supported handling raster images early on. More recently, packages stars and terra have taken over this role, where package stars focuses more on transparent data structures, and multidimensional raster or vector data cubes whereas terra focuses more on high performance and raster stacks; both build against GDAL for I/O and heavy lifting. Both packages also assume that the data is present on the local machine, typically in the form of one or more files. If this is not the case, and data is for instance distributed over cloud storage, the R user needs to move there, and may need to write a loop over the required tiles. R packages rstac and gdalcubes [1,2] help to identify tiles using STAC queries, and building a regular data cube from an image collection. Distributing such tasks over many nodes is possible (with R), but not trivial. An easier and more user-friendly approach to distributed computing capabilities is to use a higher level API for cloud-based processing of Earth Observation data, such as openEO [3]. The recently released R package openeo [4] provides a native R client to interact with the openEO API, using a syntax that is familiar to R users in order to create geospatial and temporal analysis workflows. It also provides a STAC browser, integrated in rstudio, to examine the image collections available from an openEO backend. Results from openEO queries can be downloaded and viewed. It is planned that user-defined functions (UDFs) can be written in R, tested locally, and submitted e.g. as reducers in a call to an openEO backend to be iterated over all the imagery selected, after which results can be viewed or downloaded. Furthermore, the openEO client for R is designed to enable interaction with and processing in the openEO Platform environment. openEO Platform [5] is an operational service developed with ESA funding on top of openEO API. Key aspects of openEO Platform, such as the authentication with OIDC or the execution of processing in three federated backends is also enabled by the R client library.
The usability of the R-Client and R-UDFs have been showcased as a proof of concept within the openEO project. Timeseries break detection has been carried out on forest patches in the amazonas using the bfast method as an UDF running on an openEO backend. Future use cases plan to show applications of custom R-UDFs, which extend the capabilities of native openEO processes, including advanced time series modelling (phenology), temporal and spatial smoothing for downscaling Sentinel 5P data and machine learning for classification tasks.

1. https://doi.org/10.1016/j.spasta.2020.100465
2. https://r-spatial.org/r/2021/04/23/cloud-based-cubes.html
3. https://doi.org/10.3390/rs13061125
4. https://open-eo.github.io/openeo-r-client/
5. https://openeo.cloud/
