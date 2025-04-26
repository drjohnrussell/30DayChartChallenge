library(tidyverse)
library(HistData)

data("Yeast")

means <- Yeast |> 
  group_by(sample) |> 
  summarise(means=weighted.mean(count,freq))

data_spline <- as.data.frame(spline(data$Year, data$`Property Valuation`,n=200)) |> 
  rename(Year=x,`Property Valuation`=y)

Yeast |> 
  ggplot() +
  geom_col(aes(x=count,y=freq,fill=sample)) +
  geom_vline(data=means,aes(xintercept=means,color=sample),linetype="dashed") +
  facet_wrap(~sample,ncol=2) +
  theme_minimal() +
  guides(fill=FALSE,color=FALSE) +
  labs(x="Number of yeast cells seen in the grid square",
       y="Frequency of the count in the grid square",
       title="Student's Yeast Cells")
