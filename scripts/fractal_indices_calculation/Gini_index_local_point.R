
# loading precipitation data 

## data from a selected point at coordinates (4.544939°N, 27.136937°E), MPI-ESM1-2-HR CMIP6 model, historical experiment 

R <- readRDS("pr_Historical_MPI-ESM1-2-HR_local_point.rds")


# searching sequences for repeated values

## taking as 1 those precipitation values higher than 1 mm and as 0 the rest.

R.sp <- rle(ifelse(R>1,1,0)) 
dr <- R.sp$lengths[R.sp$values==0]
dr <- dr[!is.na(dr)]


# loading SGI. function

SGI. <- function(prc)    
{
  if(class(prc)=="list" | class(prc)=="data.frame")  prc <- prc$dat
  pr <- prc[is.na(prc)==F]
  pr <- sort(pr[pr>0]) 
  nt <- length(pr);
  PR <- pr*0; for(i in 1:nt)PR[i] <- sum(pr[1:i])/sum(pr)
  
  GI  <- 1-2/nt*sum(PR) 
  return(GI)
}


# computing Gini index

gi <- SGI.(dr)

