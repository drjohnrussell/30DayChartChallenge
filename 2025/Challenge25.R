library(tidyverse)
library(HistData)
library(patchwork)

data("CholeraDeaths1849")

CholeraDeaths1849 |> 
  ggplot(aes(x=date, y=deaths)) +
  geom_line(aes(color=cause_of_death)) +
  scale_x_date(date_labels = "%b", date_breaks = "1 month",
               date_minor_breaks = "1 day",
               position="top")+
  theme_minimal() +
  theme(panel.grid.major=element_line(color="black",
                                      linewidth=.1),
        panel.grid.minor=element_line(color="grey"))
