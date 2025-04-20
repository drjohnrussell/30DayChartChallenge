library(tidyverse)
library(HistData)

data("Wheat")
data("Wheat.monarchs")

monarchs <- Wheat.monarchs |> 
  mutate(alternating=rep(c(0,-1), length.out = nrow(Wheat.monarchs)),
         alternating=alternating+commonwealth)

Wheat |> 
  filter(Year!=1821) |> 
  mutate(xmin=Year,
         xmax=Year+5,
         ymax=Wheat,
         ymin=case_when(between(Year,1565,1595) ~ 30,
                        between(Year,1600,1760) ~ 20,
                        .default=30)) |> 
  ggplot() +
  geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), 
            fill="darkslategrey", color="black", linewidth=.1) +
  scale_y_continuous(limits=c(0,100),
                     breaks = seq(0,100,by=10),
                     minor_breaks=waiver(),
                     sec.axis = dup_axis(name="Price of the Quarter of Wheat in Shillings"),
                     expand=c(0,0)) +
  scale_x_continuous(limits=c(1565,1830),
                     breaks=c(1565,seq(1600,1800,by=50)),
                     minor_breaks = seq(1565,1830,by=5),
                     expand=c(0,0)) +
  geom_smooth(aes(x=Year,y=Wages), color="red",size=1) +
  geom_smooth(aes(x=Year,y=Wages), color="black", size=.5) +
  geom_rect(data=monarchs,
            aes(xmin=start,
                xmax=end,
                ymin=97+alternating,
                ymax=98+alternating,
                fill=as.factor(commonwealth)),
            color="black",
            show.legend=FALSE) +
  geom_text(data=monarchs,
            aes(x=(start+end)/2,
                y=95+alternating,
                label=name),size=2.5) +
  scale_fill_manual(values=c("black","white")) +
  geom_vline(xintercept=1565) +
  theme_minimal() +
  labs(y="",
       x="5 Years Each Division",
       title="Chart showing Price of the Quarter of Wheat and Wages of Labour by the Week",
       subtitle="William Playfair's Time-Series Chart") +
  annotate("text", x=1610, y=9, label= "Wages of a Good Mechanic", hjust=0) +
  theme(panel.grid.major=element_line(color="black",linewidth=.5))
