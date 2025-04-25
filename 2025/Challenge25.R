library(tidyverse)
library(HistData)
library(patchwork)

data("CholeraDeaths1849")

months <- tibble(
  month = c("January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"),
  month_num = ymd("1849-01-15") + months(0:11),
  xmin=ymd("1849-01-01") + months(0:11),
  xmax=ymd("1849-01-01") + months(1:12))

CholeraDeaths1849 |> 
  ggplot() +
  geom_line(aes(x=date, y=deaths,color=cause_of_death)) +
  scale_x_date(date_labels = "%b", date_breaks = "1 month",
               date_minor_breaks = "1 day",
               position="top",
               expand=c(0,0)) +
  theme_minimal() +
  scale_y_continuous(breaks=seq(0, 1100, 100),
                     limits=c(0, 1250),
                     expand=c(0,0)) +
  theme(panel.grid.major=element_line(color="black",
                                      linewidth=.1),
        panel.grid.minor=element_line(color="grey"),
        legend.position="bottom",
        axis.text.x=element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank()) +
  geom_rect(data=months,
            aes(xmin=xmin, xmax=xmax, ymin=1150, ymax=1250),
            fill="white", color="black", alpha=1) +
  geom_text(data=months,
            aes(x=month_num, y=1200, label=month),
            size=3.5, color="black") +
  labs(title="William Farr's Data on Cholera and Diarrhea Deaths",
       subtitle="London, 1849",
       color="Cause of Death",
       caption="Source: HistData")
  
