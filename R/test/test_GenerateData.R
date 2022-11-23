source('scripts/GenerateData.R')
#automatic data generation
rlogit(100,5)
#with manual selection of params
rlogit_with_param(100,params=c(1,0,0.8,0.5,0.2,0,1.5))

#parralel generate data
rlogit_with_param_parr(vec_obs=c(100,500,1000),params=c(1,0,0.8,0.5,0.2,0,1.5))