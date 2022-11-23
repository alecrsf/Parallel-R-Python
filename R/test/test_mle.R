source('scripts/MLE_opt.R')
source('scripts/MLE.R')
source('scripts/MLE_par.R')
source('scripts/GenerateData.R')
liste_xy <- rlogit(1000, 10)
#basic mle
basic.mle(liste_xy$X, liste_xy$Y)
#mle opt
basic.mle_opt(liste_xy$X, liste_xy$Y)
#mle parralel
basic.mle_par(liste_xy$X, liste_xy$Y)
