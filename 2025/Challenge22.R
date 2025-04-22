library(tidyverse)
library(HistData)
library(ggrepel)

data("Virginis")
data("Virginis.interp")

Virginis.interp |> 
  ggplot(aes(x=year,y=posangle)) +
  geom_line() +
  geom_point(data=Virginis, aes(x=year,y=posangle), color="red",fill="white",
             shape=21) +
  geom_text_repel(data=Virginis, aes(x=year,y=posangle,label=authority)) +
  theme_minimal() +
  labs(title="Angle of the Twin Stars in Gamma Virginis",
       subtitle="John Herschel's scatter plot",
       x='Year',
       y='Position Angle (degrees)',
       caption="Names are the attribution for the data point, with H being Herschel's father, h being Herschel, and S/Sigma being Fraunhofer"
  )
       