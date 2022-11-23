source('scripts/ModelComparison_opt.R')
source('scripts/ModelComparison.R')
source('scripts/ModelComparison_par.R')
source('scripts/GenerateData.R')
liste_xy <- rlogit(1000, 5)
set.seed(123)
#basic Comparison
basic.modelcomparison(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
#comparison opt
basic.modelcomparison_opt(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
#parralel comparison
basic.modelcomparison_par(liste_xy$X,liste_xy$Y,list(c(1,2),c(1,3),c(1,4),c(1,5),c(1,2,3),c(1,3,4),c(1,2,4),c(1,2,5),c(1,2,3,4),c(1,2,3,5),c(1,3,4,5),c(1,2,4,5),c(1,2,3,4,5)))
