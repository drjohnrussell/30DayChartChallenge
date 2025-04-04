library(HistData)
library(tidyverse)
library(RColorBrewer)
library(ggExtra)

data("MacdonellDF")

p <- MacdonellDF |> 
  ggplot(aes(x=height,y=finger)) +
  geom_point(position="jitter",alpha=.6) +
  geom_density2d(alpha=1,show.legend=FALSE,bins=9) +
  theme_minimal() +
  scale_fill_brewer(palette="Purples") +
  labs(title="MacDonnell's Data on Height and Finger Length of Criminals",
       x="Height (feet)",
       y="Finger Length (inches)")

ggMarginal(p, type="histogram")
