library(tidyverse)
library(HistData)

data("Wheat")
data("Wheat.monarchs")

monarchs <- Wheat.monarchs |> 
  mutate(alternating=rep(c(0,-1), length.out = nrow(Wheat.monarchs)),
         alternating=alternating+commonwealth)

alphaness <- tibble(xmin=rep(1565,100),
                    xmax=rep(1830,100),
                    ymin=seq(0,31.99,by=.32),
                    ymax=seq(1,32.99,by=.32),
                    alpha=seq(.99,0,by=-.01))

Wheat |> 
  filter(Year!=1821) |> 
  ggplot() +
  geom_rect(aes(xmin=Year,
                xmax=Year+5,
                ymin=0,
               ymax=Wheat), 
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
  geom_rect(data=alphaness,
            aes(xmin=xmin,
                xmax=xmax,
                ymin=ymin,
                ymax=ymax,
                alpha=alpha), 
            fill="white", linewidth=0, show.legend=FALSE) +
  geom_line(aes(x=Year,y=Wages), color="red",size=1) +
  geom_line(aes(x=Year,y=Wages), color="black", size=.5) +
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
  geom_ribbon(aes(x=Year,ymin = 0,ymax = Wages),
              alpha = 0.3,fill = 'lightblue') +
  theme_minimal() +
  labs(y="",
       x="5 Years Each Division",
       title="Chart showing Price of the Quarter of Wheat and Wages of Labour by the Week",
       subtitle="William Playfair's Time-Series Chart") +
  annotate("text", x=1610, y=9, label= "Wages of a Good Mechanic", hjust=0) +
  theme(panel.grid.major=element_line(color="black",linewidth=.5))
