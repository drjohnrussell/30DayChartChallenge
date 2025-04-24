library(tidyverse)
library(rgho)

traffic <- search_values("traffic", dimension = "GHO")


result <- get_gho_data(
  code = "RS_246"
)

result2 <- get_gho_data(
  code = "RS_198"
)


numbers <- result |> 
  left_join(result2 |> 
              select(COUNTRY, 
                     total_per100000=NumericValue, NumericValue)) |> 
  mutate(total_per100000 = total_per100000 * (NumericValue/100))

numbers |> 
  mutate(ROADUSERTYPE=str_remove_all(ROADUSERTYPE,"ROADUSERTYPE_RS-DDC-"),
         ROADUSERTYPE=factor(ROADUSERTYPE, 
                             levels=c("4WHEELS","2OR3WHEELS","CYCLISTS","PEDESTRIANS","OTHER"))) |> 
  ggplot(aes(x=fct_rev(ROADUSERTYPE),y=total_per100000,fill=fct_rev(ParentLocation))) +
  geom_col(position="dodge") +
  coord_flip() +
  theme(legend.position = "bottom") +
  guides(fill = guide_legend(reverse = TRUE))
## not good - additive isn't the right stat for this. Let's look for relationship between powered and unpowered

numbers |> 
  mutate(ROADUSERTYPE=str_remove_all(ROADUSERTYPE,"ROADUSERTYPE_RS-DDC-")) |> 
  filter(ROADUSERTYPE!="OTHER") |> 
  mutate(Powered = ifelse(ROADUSERTYPE %in% c("4WHEELS","2OR3WHEELS"),"Powered","Unpowered")) |> 
  group_by(ParentLocation, COUNTRY, Powered) |> 
  summarise(total_per100000=sum(total_per100000)) |>
  pivot_wider(names_from = Powered, values_from = total_per100000) |>
  mutate(label=ifelse(Unpowered>Powered, COUNTRY,NA)) |> 
  ggplot(aes(x=Powered,y=Unpowered)) +
  geom_point(aes(color=ParentLocation)) +
  geom_abline(slope=1, intercept=0, color="red", linetype="dashed") +
#  geom_text(aes(label=label),hjust=0, vjust=0, size=3) +
  annotate("text",x=10,y=20,label="More Unpowered Fatalities", color="red") +
  annotate("text",x=20,y=10,label="More Powered Fatalities", color="red",hjust=0) +
  coord_equal() +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(x="Road Traffic Deaths per 100,000 \n Powered Transportation",
       y="Road Traffic Deaths per 100,000 \n Unpowered Transportation",
       caption="Unpowered Transportation Defined as a Cyclist or Pedestrian",
       title="Relationship between Powered and Unpowered Road Traffic Fatalities",
       color="Region of the World")
