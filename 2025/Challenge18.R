library(tidyverse)
library(sf)
library(HistData)
library(Guerry)
library(patchwork)

data("gfrance")

data2 <- st_as_sf(gfrance)

data2 |> 
  ggplot() +
  geom_sf(aes(geometry=geometry,fill=Instruction)) +
  geom_sf_text(aes(label=Instruction,color=(Instruction<37)),size=2) +
  scale_fill_gradient2(low = "white", high = 'black') +
  scale_color_manual(values=c("white","black"))
