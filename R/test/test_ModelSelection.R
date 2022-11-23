source('scripts/ModelSelection_opt.R')
source('scripts/ModelSelection.R')
source('scripts/ModelSelection_par.R')
source('scripts/GenerateData.R')
liste_xy <- rlogit(1000, 5)
set.seed(123)
#basic Selection
basic.modelselection(liste_xy$X,liste_xy$Y)
#Selection opt
basic.modelselection_opt(liste_xy$X,liste_xy$Y)
#parralel Selection
basic.modelselection_par(liste_xy$X,liste_xy$Y)
