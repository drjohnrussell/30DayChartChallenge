options(scipen = 999)

library(exoplanets)
library(tidyverse)
data <- exoplanets("ps")


orb.lm <- lm(log10(pl_orbper) ~ log10(pl_orbsmax), data)
summary(orb.lm) #notice coefficient is nearly 3/2

planetary <- read_csv("2025/data/Planetary-Data.csv")

data |> 
  ggplot(mapping=aes(x=pl_orbsmax,y=pl_orbper)) +
  geom_point(size=.2) +
  geom_point(data=planetary,mapping=aes(x=`Seperation (AU)`,y=`Orbital Period (days)`),color="red") +
  scale_y_log10() +
  scale_x_log10() +
  geom_abline(slope=coef(orb.lm)[["log10(pl_orbsmax)"]],
              intercept=coef(orb.lm)[["(Intercept)"]]) +
  labs(x="Separation (AU)",
       y="Orbital Period (days)",
       title="Relationship between Orbital Period and Separation",
       subtitle="Solar System in Red") +
  theme_light() +
  annotate("text",x=1000,y=10,label=paste0("m=",round(coef(orb.lm)[["log10(pl_orbsmax)"]],3)),color="blue")
