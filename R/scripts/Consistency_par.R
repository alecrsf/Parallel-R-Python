source('scripts/ModelSelection_par.R')
source('scripts/GenerateData.R')
library(ggplot2)

consistency_par<-function(vec_obs=c(100,150,250,400,500,800,1000,1500,2500,4000,5000,8000,10000)){
  params<-c(1,0,0.8,0.5,0.2,0,1.5,-0.5,2,0)
  list_xy<-rlogit_with_param_parr(vec_obs,params)
  params_negatif<-which(params %in% c(0))
  params_positive<-which(params != c(0))
  listX<-lapply(list_xy, `[[`, 1)
  listY<-lapply(list_xy, `[[`, 2)
  res<-t(mcmapply(function(i,j) {
    best_model<-basic.modelselection_par(i,j)$best_model
    best_model=best_model},listX,listY))

  True_Positive<-function(list_vec,params_positive){
    vec_percentage<-c()
    for (vec in list_vec){
      Num_T_P<-sum(table(vec[vec %in% params_positive]))
      percentage<-Num_T_P/length(params_positive)
      vec_percentage<-c(vec_percentage,percentage)
    }
    return(vec_percentage)
  }

  True_Negative<-function(list_vec,params,params_negatif){
    vec_percentage<-c()
    seq_params<-1:length(params)
    for (vec in list_vec){
      vec_neg<-setdiff(seq_params,vec)
      Num_T_F<-sum(table(vec_neg[vec_neg %in% params_negatif]))
      percentage<-Num_T_F/length(params_negatif)
      vec_percentage<-c(vec_percentage,percentage)
    }
    return(vec_percentage)
  }
  True_Positive_rate<-True_Positive(res,params_positive)
  True_Negative_rate<-True_Negative(res,params,params_negatif)
  return(data.frame(list(True_Positive_rate=True_Positive_rate,True_Negative_rate=True_Negative_rate,vec_obs=vec_obs)))
}




 