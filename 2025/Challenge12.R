library(tidyverse)
library(RSocrata)

congestion <- read.socrata("https://data.ny.gov/api/odata/v4/t6yz-b64h")

congestion2 <- congestion |> 
  group_by(day_of_week,hour_of_day,minute_of_hour,vehicle_class,detection_group,detection_region) |>
  summarise(crz_entries=mean(crz_entries,na.rm=TRUE),
            excluded_roadway_entries=mean(excluded_roadway_entries,na.rm=TRUE))

congestion2 <- congestion2 |> 
  mutate(time=hm(paste(hour_of_day,minute_of_hour)))

congestion2 |> 
  ggplot(aes(x=time,y=crz_entries, color=vehicle_class)) +
  geom_line() +
  facet_grid(day_of_week~detection_group)

congestion3 <- congestion2 |> 
  group_by(day_of_week,time,vehicle_class,detection_region) |> 
  summarise(crz_entries=sum(crz_entries,na.rm=TRUE),
            excluded_roadway_entries=sum(excluded_roadway_entries,na.rm=TRUE)) |> 
  mutate(day_of_week=factor(day_of_week,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")))

congestion3 |> 
  ggplot(aes(x=time,y=crz_entries, color=vehicle_class)) +
  geom_line() +
  facet_grid(day_of_week~detection_region) +
  scale_x_time()

congestion4 <- congestion3 |> 
  mutate(days=case_when(
    day_of_week=="Monday" ~ "Weekday",
    day_of_week=="Tuesday" ~ "Weekday",
    day_of_week=="Wednesday" ~ "Weekday",
    day_of_week=="Thursday" ~ "Weekday",
    day_of_week=="Friday" ~ "Weekday",
    day_of_week=="Saturday" ~ "Weekend",
    day_of_week=="Sunday" ~ "Weekend"
  )) |> 
  group_by(days,time,vehicle_class,detection_region) |> 
  summarise(crz_entries=mean(crz_entries,na.rm=TRUE),
            excluded_roadway_entries=mean(excluded_roadway_entries,na.rm=TRUE))

congestion4hline <- data.frame(days=c("Weekday","Weekend"),
                               time1=hm(c("05:00","09:00")),
                               time=hm(c("21:00","21:00")))

congestion4 |> 
  ggplot(aes(x=time,y=crz_entries, color=vehicle_class)) +
  geom_line() +
  facet_grid(days~detection_region) +
  scale_x_time() +
  theme_minimal() +
  theme(legend.position="bottom") +
  labs(title="Average Congestion Zone Entries by Vehicle Class",
       subtitle="Weekday vs Weekend (gray line denotes when tolls change during the day)",
       x="Time of Day",
       y="Average Congestion Zone Entries",
       color="Vehicle Class") +
  geom_vline(data=congestion4hline,aes(xintercept=time1), linetype="dashed", color="gray") +
  geom_vline(data=congestion4hline,aes(xintercept=time), linetype="dashed", color="gray")
