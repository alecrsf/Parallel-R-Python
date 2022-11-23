source("scripts/GenerateData.R")
source("scripts/MLE.R")
library(dplyr)

basic.cv <- function(Kfold, x, y) {
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
  data <-
    mutate(as.data.frame(cbind(y, x)),
           fold = sample(1:Kfold, size = nrow(x), replace = TRUE))
  param_vec <- c()
  perf_vec <- c()
  max_perf <- 0
  for (i in 1:Kfold) {
    Xtrain <- as.matrix(filter(data, fold != i)[, -c(1, ncol(data))])
    Xval <- as.matrix(filter(data, fold == i)[, -c(1, ncol(data))])
    Ytrain <- as.vector(filter(data, fold != i)[, 1])
    Yval <- as.vector(filter(data, fold == i)[, 1])
    params <- basic.mle(Xtrain, Ytrain)
    predict_vector <- predict.mle(Xval, params)
    perf <- sum(((predict_vector == Yval) * 1)) / length(Yval)
    param_vec <- append(param_vec, list(params))
    perf_vec <- append(perf_vec, perf)
    if (perf > max_perf) {
      best_mle <- params
      max_perf <- perf
    }
  }
  return(list(
    best_mle = round(best_mle,2),
    params_cv = param_vec %>% lapply(round, 2),
    perf_cv = round(perf_vec,2),
    accuracy = mean(perf_vec) %>% round(2))
  )
}

