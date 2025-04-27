library(tidyverse)
library(HistData)
library(viridis)
library(patchwork)

data("Fingerprints")

main <- Fingerprints |> 
  filter(!is.na(count)) |> 
  ggplot(aes(x = Loops, y = Whorls)) +
  geom_tile(aes(fill=count),color="black", show.legend=FALSE) +
  theme_minimal() +
  theme(panel.grid=element_blank()) +
  scale_fill_viridis(begin=.2) +
  geom_text(aes(label=count))

Loops <- Fingerprints |> 
  ggplot(aes(x=Loops,y=count)) +
  geom_col() +
  theme_void()

Whorls <- Fingerprints |> 
  ggplot(aes(x=Whorls,y=count)) +
  geom_col() +
  theme_void() +
  coord_flip()

Loops + plot_spacer() + main + Whorls + 
  plot_layout(
    ncol = 2, 
    nrow = 2, 
    widths = c(5, 1),
    heights = c(1, 6)
  ) +
  plot_annotation(
    title = "Waite's data on Patterns in Fingerprints",
    subtitle = "Distribution of loops and whorls in 2000 right hands with marginal histograms",
    caption = "Source: HistData package"
  )
