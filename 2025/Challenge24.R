library(tidyverse)
library(rgho)


traffic <- search_values("traffic", dimension = "GHO")


result <- get_gho_data(
  code = "RS_246"
)

