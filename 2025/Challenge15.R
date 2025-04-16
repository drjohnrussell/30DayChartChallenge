library(tidyverse)
library(HistData)
library(zoo)

data("Bowley")

Bowley |> 
  mutate(
    `Rolling Average over 3 Years` = rollmean(Value,3,fill=NA,align="center"),
    `Rolling Average over 5 Years` = rollmean(Value,5,fill=NA,align="center"),
    `Rolling Average over 10 Years` = rollmean(Value,10,fill=NA,align="center")) |> 
  pivot_longer(cols = c(`Rolling Average over 3 Years`:`Rolling Average over 10 Years`), 
               names_to = "Type", values_to = "value") |>
  mutate(Type=fct_inorder(Type)) |> 
  ggplot(aes(x = Year, y = value, color = Type)) +
  geom_line(size=1) +
  geom_point(aes(y=Value), color="black",show.legend=FALSE) +
  theme_minimal() +
  labs(
    title = "Bowley's data on British and Irish Trade",
    subtitle="Smoothing by moving averages as done in 1901 textbook",
    x = "Year",
    y = "Total Value of exports (in millions of pounds)",
    color = "Rolling Window") +
  theme(legend.position="bottom")
