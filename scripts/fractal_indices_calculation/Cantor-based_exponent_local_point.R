
# loading precipitation data 

## data from a selected point at coordinates (4.544939°N, 27.136937°E), MPI-ESM1-2-HR CMIP6 model, historical experiment 

R <- readRDS("pr_Historical_MPI-ESM1-2-HR_local_point.rds")


# searching sequences for repeated values

## taking as 1 those precipitation values higher than 1 mm and as 0 the rest.

R.sp <- rle(ifelse(R>1,1,0)) 
dr <- R.sp$lengths[R.sp$values==0]
dr <- dr[!is.na(dr)]


# loading function to obtain the Cantor set

cantor <- function(n, mode="points")
{
  m <- trunc(log10(3^n))+3
  c0 <- seq(0,1,1/3^n)
  ci <- c0
  for(i in 1:n) ci <- ci[round(ci,m) %in% round(c(ci/3, 2/3+ci/3),m)]
  
  serie <- rep(0,length(c0))
  serie[round(c0,m) %in% round(ci,m)] <- 1
  
  if(mode == "points")
    return(ci)
  if(mode == "points.spell")
    return(serie)
  if(mode == "gaps")
    return(c0[!(round(c0,m) %in% round(ci,m))])
  if(mode == "gaps.spell")
    return(1-serie)
}


# Cantor set of reference

n <- 14
z <- cantor(n, mode="points.spell")
z.sp <- rle(z)
dz <- z.sp$lengths[z.sp$values==0]


# computing Cantor-based exponent

dn <- min(c(length(dz),length(dr)))
dz2 <- sort(dz/length(z),decreasing=T)[1:dn] #Cantor
dr2 <- sort(dr/length(R),decreasing=T)[1:dn]

qq <- qqplot(dz2,dr2, plot=F)
qq$x[qq$x == min(qq$x)] <- NA
qq$y[qq$y == min(qq$y)] <- NA

if(length(qq$x) > 1)
{
  if (isTRUE(sum(is.na(qq$y)) == length(qq$y)) | isTRUE(sum(is.na(qq$x)) == length(qq$x))){
    cd  <- NA
  }else{
    lm4 <- lm(log(qq$y) ~ log(qq$x))   
    
    cd <- lm4$coefficients[2] 
  }
}
