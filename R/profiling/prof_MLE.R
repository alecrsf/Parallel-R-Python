# rm(list=ls())

source('scripts/MLE.R')
source("scripts/MLE_opt.R")

library(profvis)
liste_xy <- rlogit(10000, 10)
p <- profvis({
  param <- basic.mle(liste_xy$X, liste_xy$Y)
  glm(liste_xy$Y ~ liste_xy$X + 0, family = 'binomial')
  prediction <- predict.mle(liste_xy$X, param)
  
})
htmlwidgets::saveWidget(p, "profiling/prof_MLE.html", selfcontained = T)

p <- profvis({
  param <- basic.mle_opt(liste_xy$X, liste_xy$Y)
  glm(liste_xy$Y ~ liste_xy$X + 0, family = 'binomial')
  prediction <- predict.mle(liste_xy$X, param)
  
})
htmlwidgets::saveWidget(p, "profiling/prof_MLE_opt.html", selfcontained = T)
