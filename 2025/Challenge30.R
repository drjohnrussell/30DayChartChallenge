library(tigris)
library(RSocrata)
library(tidyverse)
library(viridis)

dogbites <- read.socrata("https://data.cityofnewyork.us/api/odata/v4/rsgh-akpg") |> 
  filter(borough!="Other")

dogbitemap <- dogbites |> 
  group_by(zipcode) |> 
  summarise(total = n())

NYC <- zctas(
  state = "NY",
  cb = TRUE,
  class = "sf",
  year=2000) |> 
  filter(NAME %in% dogbites$zipcode) |> 
  left_join(dogbitemap, by = c("NAME" = "zipcode"))

map1 <- NYC |> 
  ggplot() +
  geom_sf(aes(fill = total), color = "white") +
  xlim(c(-74.3, -73.7)) +
  ylim(c(40.5, 40.9)) +
  theme_minimal() +
  scale_fill_viridis_c(option = "plasma", name = "Dog Bites") +
  labs(title="Dog Bites in NYC by Zipcode",
       subtitle = "2015-2023") +
  theme(legend.position = "bottom")

doglicense <- read.socrata("https://data.cityofnewyork.us/api/odata/v4/nu7n-tubp")

doglicensemap <- doglicense |> 
  group_by(zipcode) |> 
  summarise(totaldogs = n()) |> 
  mutate(zipcode = as.character(zipcode))

NYC2 <- NYC |> 
  left_join(doglicensemap, by = c("NAME" = "zipcode"))

map2 <- NYC2 |> 
  ggplot() +
  geom_sf(aes(fill = totaldogs), color = "white") +
  xlim(c(-74.3, -73.7)) +
  ylim(c(40.5, 40.9)) +
  theme_minimal() +
  scale_fill_viridis_c(option = "turbo", name = "Dog Licenses") +
  labs(title="Dog Ownership in NYC",
       subtitle = "2014-2024") +
  theme(legend.position = "bottom")

library(patchwork)

map2 + map1 +
  plot_annotation(title = "Dogs of NYC",
                  theme = theme(plot.title = element_text(hjust = 0.5)))
