# rm(list=ls())
source('scripts/GenerateData.R')
source('scripts/ModelSelection.R')
source('scripts/ModelSelection_opt.R')
source('scripts/ModelSelection_par.R')

library(profvis)
set.seed(123)
liste_xy<-rlogit(10000,10)

p <- profvis({
  basic.modelselection(liste_xy$X,liste_xy$Y)
  })

htmlwidgets::saveWidget(p,"profiling/prof_ModelSelection.html", selfcontained = T)

p <- profvis({
  basic.modelselection_opt(liste_xy$X,liste_xy$Y)
})

htmlwidgets::saveWidget(p,"profiling/prof_ModelSelection_opt.html", selfcontained = T)

p <- profvis({
  basic.modelselection_par(liste_xy$X,liste_xy$Y)
})

htmlwidgets::saveWidget(p,"profiling/prof_ModelSelection_par.html", selfcontained = T)

