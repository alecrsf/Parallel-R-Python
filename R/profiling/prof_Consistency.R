source("scripts/Consistency.R")
source("scripts/Consistency_par.R")

library(profvis)

p<-profvis({
  consistency(vec_obs=c(100,150,250,500,1500,2500,5000,10000))
})
htmlwidgets::saveWidget(p, "profiling/prof_consistency.html", selfcontained = T)

p<-profvis({
  consistency_par(vec_obs=c(100,150,250,500,1500,2500,5000,10000))
})
htmlwidgets::saveWidget(p, "profiling/prof_consistency_par.html", selfcontained = T)


