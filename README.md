# Will the world experience more fractal droughts?
Lorena Galiano, Robert Monjo, Dominic Royé, Javier Martin-Vide


## Abstract

Meteorological droughts will become the principal factor driving compound hot-dry events and analysis thereof is therefore fundamental with regard to understanding future climate patterns. The average citizen knows little of geometry, but it plays an essential role in the characteristics of the droughts, by means of "fractional lengths". A fractality measure based upon the Cantor set reveals consensual changes in the behavior of droughts worldwide. Most regions will undergo a slight increase in fractality (up to +10% on average), particularly associated with an acceleration of the hydrological cycle. Simultaneously, the polar regions might benefit from more regular precipitation patterns. In general terms, the earth’s climate will be more fractal in these patterns, which likely means that the consequences will be more catastrophic for the human population.


## Mapping drought simulation by climate models

```{r, echo=FALSE}
setwd("scripts")
source("Figure_1.R")
```

As result, our first figure appears:

![Figure_1](https://user-images.githubusercontent.com/110187434/190433141-bf478a10-cc15-4ca7-8047-fcde23479f81.PNG)


## Calculating fractal indices on selected grid point

To indicate how the fractal indices has been calculated, the precipitation time series corresponding to a grid point with coordinates (4.544939°N, 27.136937°E) for the MPI-ESM1-2-HR CMIP6 model under the historical experiment is selected.

### n-index

```{r, echo=FALSE}
setwd("scripts/fractal_indices_calculation")
source("N_index_local_point.R")
```

### Cantor-based exponent

```{r, echo=FALSE}
setwd("scripts/fractal_indices_calculation")
source("Cantor-based_exponent_local_point.R")
```

### Gini index

```{r, echo=FALSE}
setwd("scripts/fractal_indices_calculation")
source("Gini_index_local_point.R")
```


## How to cite

Code Availability: Galiano,L; Monjo, R; Royé, D; Martin-Vide, J. (2022). Fractal drougth climate projections. [doi: 10.5281/zenodo.7043297](https://doi.org/10.5281/zenodo.7043297)

