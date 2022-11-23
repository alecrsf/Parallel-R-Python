source("scripts/GenerateData.R")
source("scripts/MLE_par.R")
source("scripts/MLE_opt.R")

library(profvis)

liste_xy <- rlogit(100, 5)

p<-profvis({
  logistiquegradient_par(liste_xy$X,liste_xy$Y,liste_xy$params)
  logistiquegradientopt(liste_xy$X,liste_xy$Y,liste_xy$params)
})
htmlwidgets::saveWidget(p, "profiling/prof_gradient_par.html", selfcontained = T)


p<-profvis({
  logistiquehessienne_par(liste_xy$X,liste_xy$Y,liste_xy$params)
  logistiquehessienneopt(liste_xy$X,liste_xy$Y,liste_xy$params)
  
})
htmlwidgets::saveWidget(p, "profiling/prof_hessian_par.html", selfcontained = T)

p<-profvis({
  basic.mle_par(liste_xy$X,liste_xy$Y)
  basic.mle_opt(liste_xy$X,liste_xy$Y)
  
})
htmlwidgets::saveWidget(p, "profiling/prof_MLE_par.html", selfcontained = T)


