library(tidyverse)
library(HistData)
library(waffle)
library(ggh4x)

data("PolioTrials")

PolioTrials |> 
  filter(!str_detect(Group,"NotInoculated|Incomplete")) |> 
  mutate(`Paralytic Polio`=
           (Paralytic/Population)*200000,
         `NonParalytic Polio`=
           (NonParalytic/Population)*200000,
         Experiment=case_when(Experiment=="ObservedControl" ~ "Observed Control",
                              .default="Randomized Control")) |>
  pivot_longer(
    cols=c(`Paralytic Polio`,`NonParalytic Polio`),
    names_to="Type",
    values_to="Cases_per200000") |>
  ggplot(aes(fill=Type,values=Cases_per200000)) +
  geom_waffle(n_rows=10, size=.9,color="white") +
  facet_nested(~Experiment + Group,
               scales="free",
               labeller = label_wrap_gen(width=20)) +
  scale_x_continuous(
    labels = function(x) x * 10, # make this multiplier the same as n_rows
    expand = c(0,0)
  ) +
  scale_fill_manual(values=c("grey66","black")) +
  theme_light() +
  theme(legend.position="bottom",
        axis.text.y=element_blank(),
        panel.grid=element_blank(),
        axis.line=element_blank()) +
  labs(fill="Cases per 200,000",
       title="1954 Polio Trials",
       subtitle="These took place over two clinical trials - an RCT, and a Comparative Trial")
