library(tidyverse)
library(HistData)

data("HalleyLifeTable")

HalleyLifeTable |> 
  ggplot(aes(xmin=number,ymin=age-1,ymax=age-.1,xmax=0)) +
  geom_rect() +
  labs(x="Persons Living Through this Age",
       y="Age",
       title="Halley's Life Table",
       subtitle="Breslau") +
  theme_minimal()
