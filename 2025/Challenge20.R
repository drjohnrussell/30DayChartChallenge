library(tidyverse)
library(HistData)

data(Prostitutes)

Prostitutes |> 
  ggplot(aes(x=date, y=count)) +
  geom_point() +
  geom_smooth(method = "loess", span = 0.05) +
  theme_minimal() +
  labs(x="Time (1812-1854)",
       y="Number of Prostitutes on the Registers, Paris",
       title="Parent-Duchalt's Data on Prostitutes in Paris",
       subtitle="Loess curve added for smoother trend")
