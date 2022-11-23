# rm(list=ls())

source("scripts/GenerateData.R")

library(profvis)
p <- profvis({
  rlogit(10000, 5)
})
htmlwidgets::saveWidget(p, file = "profiling/prof_GenerateData.html", selfcontained = T)
