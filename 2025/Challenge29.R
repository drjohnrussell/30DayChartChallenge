options(scipen = 999)

library(exoplanets)
library(tidyverse)
library(viridis)
data <- exoplanets("ps")

library(viridis)

largest <- data |> 
  janitor::tabyl(discoverymethod) |> 
  arrange(desc(n)) |> 
  filter(n>100)

data |> 
  filter(discoverymethod %in% largest$discoverymethod) |>
  ggplot(mapping=aes(x=pl_orbper,y=pl_bmassj,color=discoverymethod)) +
  geom_point(size=1) +
  scale_y_log10() +
  scale_x_log10() +
  theme_minimal() +
  stat_ellipse(linewidth=1) +
  theme(legend.position="bottom") +
  labs(
    title = "Exoplanets by Discovery Method",
    subtitle = "Different methods discover different types of planets",
    x = "Orbital Period (days)",
    y = "Mass (Jupiter Masses)",
    color = "Discovery Method",
    caption = "Data from NASA Exoplanet Archive"
  )
