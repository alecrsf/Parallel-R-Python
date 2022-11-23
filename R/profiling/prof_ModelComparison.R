# rm(list=ls())
source('scripts/GenerateData.R')
source('scripts/ModelComparison.R')
source('scripts/ModelComparison_opt.R')
source('scripts/ModelComparison_par.R')

library(profvis)
set.seed(123)

liste_xy<-rlogit(10000,5)

p <- profvis({
  basic.modelcomparison(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
})
htmlwidgets::saveWidget(p,"profiling/prof_ModelComparison.html", selfcontained = T)

p <- profvis({
  basic.modelcomparison_opt(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
})
htmlwidgets::saveWidget(p,"profiling/prof_ModelComparison_opt.html", selfcontained = T)


p <- profvis({
  basic.modelcomparison_par(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
})
htmlwidgets::saveWidget(p,"profiling/prof_ModelComparison_par.html", selfcontained = T)