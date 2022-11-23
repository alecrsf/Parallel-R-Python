#rm(list=ls())

source('scripts/CV_par.R')

basic.modelcomparison_par <- function(x, y, list_model) {
  if ((is.matrix(x)) == FALSE) {
    stop('x must be a matrix')
  }
  
  if ((is.vector(y)) == FALSE) {
    stop('y must be a vector')
  }
  
  if (nrow(x) != length(y)) {
    stop('x and y must have the same number of rows')
  }
  
  if ((length(list_model) == 0)) {
    stop("list of model musn't be empty")
  }
  
  max_perf <- 0
  for (model in list_model) {
    x_model <- as.matrix(x[, model])
    cv_list <- basic.cv_par(5, x_model, y)
    param <- cv_list$best_mle
    pred_perf <- mean(cv_list$perf_cv)
    if (pred_perf > max_perf) {
      best_model <- model
      param_best_model <- param
      max_perf <- pred_perf
    }
  }
  return(list(best_model = best_model, perf_model = max_perf))
}

