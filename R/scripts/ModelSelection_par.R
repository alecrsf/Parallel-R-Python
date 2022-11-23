#rm(list=ls())

source('scripts/CV_par.R')

basic.modelselection_par <- function(x, y) {
  if ((is.matrix(x)) == FALSE) {
    stop('x must be a matrix')
  }
  
  if ((is.vector(y)) == FALSE) {
    stop('y must be a vector')
  }
  
  if (nrow(x) != length(y)) {
    stop('x and y must have the same number of rows')
  }
  
  i <- 2
  perf_model <- 0
  repeat {
    max_local_perf <- 0
    variables <- i:ncol(x)
    model <- c(1)
    for (var in variables) {
      model <- append(model, var)
      x_model <- x[, model]
      cv_list <- basic.cv_par(5, x_model, y)
      param <- cv_list$best_mle
      pred_perf <- mean(cv_list$perf_cv)
      if (pred_perf > max_local_perf) {
        best_local_model <- model
        max_local_perf <- pred_perf
      }
      else{
        model <- model[-length(model)]
      }
    }
    if (max_local_perf > perf_model) {
      best_model <- best_local_model
      perf_model <- max_local_perf
    }
    i <- i + 1
    if (i > ncol(x)) {
      break
    }
  }
  return(list(best_model = best_model, perf_model = perf_model))
}
