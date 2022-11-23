source('scripts/Consistency.R')
source('scripts/Consistency_par.R')
library(ggplot2)
#consistency 
consistency_df<-consistency(vec_obs=c(100,150,250,400,500,800,1000,1500,2500,4000,5000,8000,10000))
ggplot(data=consistency_df, aes(x=vec_obs)) +
  geom_line(aes(y = True_Positive_rate), color = "darkred") +
  geom_line(aes(y = True_Negative_rate), color="steelblue", linetype="twodash")  +
  ylab("Rate")

#consistency parralel data generation
consistency_par_df<-consistency_par(vec_obs=c(100,150,250,400,500,800,1000,1500,2500,4000,5000,8000,10000))
ggplot(data=consistency_par_df, aes(x=vec_obs)) +
  geom_line(aes(y = True_Positive_rate), color = "darkred") +
  geom_line(aes(y = True_Negative_rate), color="steelblue", linetype="twodash")  +
  ylab("Rate")