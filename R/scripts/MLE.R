source("scripts/GenerateData.R")

logistiquelogvrai <- function(x, y, param){
  z <- x%*%param
  sum( y * z - log( 1 + exp(z) ) )
}

logistiquegradient <- function(x, y, param){
  z <- x%*%param
  z <- exp(z) / (1 + exp(z))
  gradient<-rep(NA, ncol(x))
  for (i in 1:ncol(x)){
    gradient[i]<-sum(x[,i] * y - x[,i]* z)
  }
  return(gradient)
}



logistiquehessienne <- function(x, y, param){
  z <- x%*%param
  z <- exp(z) / ( (1 + exp(z))**2 )
  Hmatrix<-matrix(NA,ncol(x),ncol(x))
  for (i in 1:ncol(x)){
    for (j in 1:ncol(x)){
      Hmatrix[i,j]<-sum(-z*x[,i]*x[,j])
    }
  }
  return(Hmatrix)
}


basic.mle<-function(x, y, xi= 0.0001){
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
    param <- param - as.numeric(solve(logistiquehessienne(x, y, param)) %*% logistiquegradient(x, y, param))
    if (sum( (old - param) **2) < xi) break
  }
  return(param)
}

predict.mle<-function(x,param){
  if (ncol(x)!=length(param)){
    stop('x and param must have the same number of column and parameters')
  }
  z <- x%*%param
  z <- exp(z) / (1 + exp(z))
  pred<-z>0.5
  return(pred*1)
}

