library(parallel)
source("scripts/MLE_opt.R")

logistiquelogvrai <- function(x, y, param) {
  z <- x %*% param
  return(sum(y * z - log(1 + exp(z))))
}
logistiquegradient_par<- function(x, y, param){
  z <- x%*%param
  z <- exp(z) / (1 + exp(z))
  gradient<-rep(NA, ncol(x))
  gradient<-unlist(mclapply(1:ncol(x),function(i) sum(x[,i] * y - x[,i]* z),mc.cores = 8))
  return(gradient)
}

logistiquehessienne_par<- function(x, y, param){
  Hmatrix<-matrix(0,nrow=ncol(x), ncol=ncol(x))
  Hmatrix<-mclapply(1:nrow(x),function(i) as.numeric(x[i,]%*%t(x[i,])*c(exp(param%*%x[i,]))/(1+c(exp(param%*%x[i,])))**2), mc.cores = 8)
  Hmatrix<--matrix(rowSums(do.call(cbind,Hmatrix)),ncol(x),ncol(x))
  return(Hmatrix)
}

basic.mle_par<-function(x, y, xi= 0.0001){
  if ((is.matrix(x))==FALSE){
    stop('x must be a matrix')
  }
  
  if ((is.vector(y))==FALSE){
    stop('y must be a vector')
  }
  
  if (nrow(x)!=length(y)){
    stop('x and y must have the same number of rows')
  }
  param <- rep(0, ncol(x))
  repeat{
    old <- param
    param <- param - as.numeric(solve(logistiquehessienne_par(x, y, param)) %*% logistiquegradient_par(x, y, param))
    if (sum( (old - param) **2) < xi) break
  }
  return(param)
}




