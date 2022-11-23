# rm(list=ls())
source("scripts/GenerateData.R")
source('scripts/CV.R')
source("scripts/CV_opt.R")
source("scripts/CV_par.R")

library(profvis)
liste_xy <- rlogit(10000, 30)
p <- profvis({
  basic.cv(5, liste_xy$X, liste_xy$Y)
})
htmlwidgets::saveWidget(p, "profiling/prof_CV.html", selfcontained = T)

p <- profvis({
  basic.cv_opt(5, liste_xy$X, liste_xy$Y)
})
htmlwidgets::saveWidget(p, file = "profiling/prof_CV_opt.html", selfcontained = T)

p <- profvis({
  basic.cv_par(5, liste_xy$X, liste_xy$Y)
})
htmlwidgets::saveWidget(p, file = "profiling/prof_CV_par.html", selfcontained = T)