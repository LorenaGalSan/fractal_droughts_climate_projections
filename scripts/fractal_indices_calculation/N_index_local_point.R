
# loading precipitation data 

## data from a selected point at coordinates (4.544939°N, 27.136937°E), MPI-ESM1-2-HR CMIP6 model, historical experiment 
R <- readRDS("pr_Historical_MPI-ESM1-2-HR_local_point.rds")


# searching sequences for repeated values

## taking as 1 those precipitation values higher than 1 mm and as 0 the rest.

R.sp <- rle(ifelse(R>1,1,0)) 

dr <- R.sp$lengths[R.sp$values==0]

dr <- dr[!is.na(dr)]


# loading "n-index.r" functions (from link https://github.com/robertmonjo/drought)
source("n-index.r") #incluir de alguna forma


# computing n index

result_spell <- spell(dr)

ni <- mean(result_spell$nabs)


