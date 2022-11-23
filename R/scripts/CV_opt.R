source("scripts/MLE_opt.R")
library(dplyr)
basic.cv_opt <- function(Kfold, x, y) {
  if (Kfold <= 1) {
    stop('Kfold must be at least equal to 2')
  }
  if ((is.matrix(x)) == FALSE) {
    stop('x must be a matrix')
  }
  
  if ((is.vector(y)) == FALSE) {
    stop('y must be a vector')
  }
  
  if (nrow(x) != length(y)) {
    stop('x and y must have the same number of rows')
  }
  
  data <-cbind.data.frame(y, x, fold = sample(1:Kfold, size = nrow(x), replace = TRUE))
  param_vec <- perf_vec <- rep(NA, Kfold)
  max_perf <- 0
  
  list_cv<-lapply(1:Kfold, function(i){
    Xtrain <- as.matrix(filter(data, fold != i)[, -c(1, ncol(data))])
    Xval <- as.matrix(filter(data, fold == i)[, -c(1, ncol(data))])
    Ytrain <- as.vector(filter(data, fold != i)[, 1])
    Yval <- as.vector(filter(data, fold == i)[, 1])
    
    params <- basic.mle(Xtrain, Ytrain)
    predict_vector <- predict.mle(Xval, params)
    
    perf <- sum(((predict_vector == Yval) * 1)) / length(Yval)
    
    param_vec <- params
    perf_vec <- perf
    return(list(param_vec=param_vec,perf_vec=perf_vec))
  })
  
  param_vec<-lapply(list_cv, `[[`, 1)
  perf_vec<-unlist(lapply(list_cv, `[[`, 2))
  best_mle<-param_vec[[match(max(perf_vec),perf_vec)[1]]]
  return(list(best_mle=best_mle,
              params_cv = param_vec,
              perf_cv = perf_vec))
  
}
