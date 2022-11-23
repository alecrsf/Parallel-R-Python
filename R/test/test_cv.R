source('scripts/CV_opt.R')
source('scripts/CV.R')
source('scripts/CV_par.R')
source('scripts/GenerateData.R')
liste_xy <- rlogit(1000, 10)
#basic CV
basic.cv(5, liste_xy$X, liste_xy$Y)
#CV opt
basic.cv_opt(5, liste_xy$X, liste_xy$Y)
#parralel CV
basic.cv_par(5, liste_xy$X, liste_xy$Y)
