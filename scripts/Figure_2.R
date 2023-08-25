# packages 
library(tidyverse)
library(terra)
library(sf)
library(rnaturalearth)
library(fs)
library(classInt)
library(patchwork)

# data 
r <- dir_ls("data_figure_1") %>% map(rast)

limits <- ne_coastline(50, returnclass = "sf")

# proprocessing
rprj <- map(r, project, y = "ESRI:54030") # reproject

# to xyz
df <- map_df(rprj, function(x) as.data.frame(x, xy = TRUE) %>% rename(spell = 3),
             .id = "model")

df <- mutate(df, model = str_remove(model, "Dry_spell_mean_") %>% path_ext_remove())


# clases
br <- classIntervals(df$spell, 10, dataPrecision = 1)

df <- mutate(df, spell_cat = cut(round(spell, 1), round(c(br$brks[-11], 20, 30, 365), 1), include.lowest = TRUE),
             model = fct_relevel(model, "ERA5_r") %>% fct_recode(ERA5 = "ERA5_r"))


# mapping

## main map ERA5 and multimodel mea

df1 <- filter(df, model %in% c("ERA5", "multimodel_CMIP6"))

p1 <- ggplot() +
  geom_raster(data = df1,
              aes(x, y, fill = spell_cat)) +
  geom_sf(data = limits, size = .2, colour = "white") +
  scale_fill_viridis_d(option = "B") +
  scale_colour_viridis_d(option = "B") +
  facet_wrap(model ~ ., nrow = 2) +
  guides(fill = guide_colorsteps(barwidth = 25, barheight = .5, title.vjust = 0)) +
  labs(fill = "Dry spell") +
  coord_sf(crs = "ESRI:54030") +
  theme_void() +
  theme(legend.position = "top",
        plot.margin = margin(10, 10, 10, 10))


# model specific results
df2 <- filter(df, !model %in% c("ERA5", "multimodel_CMIP6"))

p2 <- ggplot() +
  geom_raster(data = df2,
              aes(x, y, fill = spell_cat)) +
  geom_sf(data = limits, size = .2, colour = "white") +
  scale_fill_viridis_d(option = "B") +
  scale_colour_viridis_d(option = "B") +
  facet_wrap(model ~ ., nrow = 5) +
  guides(fill = guide_colorsteps(barwidth = 25, barheight = .5, title.vjust = 0)) +
  labs(fill = "Dry spell") +
  coord_sf(crs = "ESRI:54030") +
  theme_void() +
  theme(legend.position = "bottom",
        plot.margin = margin(10, 10, 10, 10))


p <- (p1 | p2) + plot_layout(guides = 'collect') & 
                 theme(legend.position = "bottom",
                       legend.justification = 0.5)


ggsave("spell_models.png",
       p,
       type = "cairo-png",
       height = 7, 
       width = 10,
       units = "in",
       bg = "white")


