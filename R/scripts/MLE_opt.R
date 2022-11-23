
logistiquelogvrai <- function(x, y, param) {
  z <- x %*% param
  return(sum(y * z - log(1 + exp(z))))
}


logistiquegradientopt <- function(x, y, param) {
  z <- x %*% param
  z <- exp(z) / (1 + exp(z))
  return(c(t(x) %*% y - t(x) %*% z))
}
#Hmatrix<-outer( 1:ncol(x), 1:ncol(x),Vectorize(function(i,j) sum(-z * x[, i] * x[, j])))
#outer NOT AS FASTER AS 2 loop
#Hmatrix <-sapply(1:ncol(x), function(i)sapply(1:ncol(x), function(j)sum(-z * x[, i] * x[, j])))
### sapply NOT AS FASTER AS 2loop ###
#MATRIX NOT AS FASTER AS 2 loop
# D<-diag(c(z))
# Hmatrix<--(t(x)%*%D%*%x)

logistiquehessienneopt <- function(x, y, param) {
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


basic.mle_opt <- function(x, y, xi = 0.0001) {
  if ((is.matrix(x)) == FALSE) {
    stop('x must be a matrix')
  }
  
  if ((is.vector(y)) == FALSE) {
    stop('y must be a vector')
  }
  
  if (nrow(x) != length(y)) {
    stop('x and y must have the same number of rows')
  }
  param <- rep(0, ncol(x))
  repeat {
    old <- param
    param <- param - as.numeric(solve(logistiquehessienneopt(x, y, param)) %*% logistiquegradientopt(x, y, param))
    if (sum((old - param) ** 2) < xi)
      break
  }
  return(param)
}


predict.mle <- function(x, param) {
  if (ncol(x) != length(param)) {
    stop('x and param must have the same number of column and parameters')
  }
  z <- x %*% param
  z <- exp(z) / (1 + exp(z))
  pred <- z > 0.5
  return(pred * 1)
}
