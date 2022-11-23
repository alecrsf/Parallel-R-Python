library(parallel)

rlogit <- function (n, m) {
  if (n <= 0 & m < 0) {
    stop('n and m must be strictly positive')
  }
  params <- round(c(-1, rnorm(m)), 3)
  X <- cbind(1, matrix(rnorm(n * m, mean = 0, sd = 1), nrow = n, ncol = m))
  P <- exp(X %*% params) / (1 + exp(X %*% params))
  Y <- as.numeric(1 * (runif(n) < P))
  return(list(X = X, Y = Y, params = params))
}

rlogit_with_param<- function (n, params = c(-1, 0, 1.5, -0.85, 0, 2.3)) {
  if (n <= 0 & length(params) < 0) {
    stop('n and params lenght must be strictly positive')
  }
  m<-length(params)
  X <- cbind(1, matrix(rnorm(n * (m-1), mean = 0, sd = 1), nrow = n, ncol = m-1))
  P <- exp(X %*% params) / (1 + exp(X %*% params))
  Y <- as.numeric(1 * (runif(n) < P))
  return(list(X = X, Y = Y, params = params))
}


rlogit_with_param_parr<- function (vec_obs=c(100,500,1000,2500,5000,7500,10000),params=c(1,0,0.8,0.5,0.2,0,1.5)) {
  list_test<-mclapply(vec_obs, function(n){
    m<-length(params)
    X <- cbind(1, matrix(rnorm(n * (m-1), mean = 0, sd = 1), nrow = n, ncol = m-1))
    P <- exp(X %*% params) / (1 + exp(X %*% params))
    Y <- as.numeric(1 * (runif(n) < P))
    list(X=X,Y=Y)}  , mc.cores = 8)
  
  list_test
}



