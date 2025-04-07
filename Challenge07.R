library(tidyverse)
library(magrittr)
library(rvest)
library(ggbeeswarm)
library(ggrepel)

Presidents <- read_html("https://en.m.wikipedia.org/wiki/List_of_presidents_of_the_United_States_by_time_in_office#Presidents_by_time_in_office") |> 
  html_element('table.wikitable.sortable') |> 
  html_table()

Presidents2 <- Presidents |> 
  mutate(`Lengthin days` = parse_number(`Lengthin days`),
         name=case_when(`Lengthin days` %in% c(1461,2922,2865,2840,2728,
                                               1460,1430,1419) ~ "",
                        .default=President),
         color=case_when(name!="" ~ "outlier",
                         .default="normal"))

Presidents2 |> 
  ggplot(aes(x=`Lengthin days`,y="")) +
  geom_beeswarm(aes(color=color),show.legend=FALSE) +
  geom_text_repel(aes(label=name),position=position_beeswarm(),angle=45,size=2.3) +
  scale_y_discrete(limits=c(""),expand=expansion(mult=c(0.07,0.07))) +
  scale_x_continuous(expand=expansion(mult=c(0.05,0.05))) +
  theme_minimal() +
  scale_color_manual(values=c("gray","red")) +
  labs(y="",
       x="Length (days)",
       title="Length of US Presidents' Terms in Office",
       subtitle="Outliers labeled")

Presidents2 |> 
  ggplot(aes(x=`Lengthin days`)) +
  geom_boxplot() +
  theme_minimal() +
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  labs(y="",
       x="Length (days)",
       title="Length of US Presidents' Terms in Office")
