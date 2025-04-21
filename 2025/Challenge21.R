library(tidyverse)
library(paleobioDB)
library(rnaturalearth)

Mesosaurus <- pbdb_occurrences(
  taxon_name = "Mesosaurus",
  show="coords")

World <- ne_countries(type="countries")

World |> 
  ggplot() +
  geom_sf(aes(geometry=geometry), fill="white") +
  geom_point(data=Mesosaurus, aes(x=lng, y=lat), color="red") +
  theme_void()
  coord_sf() +
  labs(title = "Mesosaurus Occurrences",
       x = "Longitude",
       y = "Latitude")

Mesosaurus |> 
  ggplot() +
  geom_sf(data = World, aes(geometry=geometry)) +
  geom_point(aes(x=lng, y=lat),color="red",shape=8,size=2) +
  theme_minimal() +
  labs(title = "Mesosaurus Occurrences",
       subtitle = "One of the key pieces of evidence for Continental Drift",
       x="",y="")
