library(tidyverse)
library(paleobioDB)
library(rnaturalearth)

Mesosaurus <- pbdb_occurrences(
  taxon_name = "Mesosaurus",
  show="coords")

World <- ne_countries(type="countries")

Mesosaurus |> 
  ggplot() +
  geom_sf(data = World, aes(geometry=geometry)) +
  geom_point(aes(x=lng, y=lat),color="red",shape=8,size=2) +
  theme_minimal() +
  labs(title = "Mesosaurus Occurrences",
       subtitle = "One of the key pieces of evidence for Continental Drift",
       x="",y="")
