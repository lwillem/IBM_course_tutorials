###############################################################
#
# This file is part of the course material for
# "Individual-based Modelling in Epidemiology"
# by Wim Delva and Lander Willem.
#
###############################################################

# install/load randomForest package
#install.packages('randomForest')
library('randomForest')

get_model_emulator <- function(input_data,output_data,output_tag){

  # set plot panels, based on the number of input variables
  if(ncol(input_data)<=3)      { par(mfrow=c(2,2)) }
  else if(ncol(input_data)<=6) { par(mfrow=c(2,3)) }
  else { par(mfrow=c(3,3)) }

  ## STEP 1: VISUAL INSPECTION
  par(mai=c(0.5,0.8,0.5,0.3))
  for(i in 1:dim(input_data)[2])
  {
    boxplot(output_data ~ input_data[,i],main=names(input_data)[i],ylab=output_tag)
  }

  ## STEP 2: RANDOM FOREST
  experiment_rf <- randomForest(output_data ~ ., data=input_data,
                                prox=TRUE,ntree=1000,importance=TRUE,keep.forest=F)
  print(experiment_rf)
  print(importance(experiment_rf))
  rf_sum <- importance(experiment_rf)[,1]

  # create barplot with results from random forest
  par(mai=c(0.9,1.2,0.5,0.3))
  barplot(abs(rf_sum), las=2,horiz = T,
          main=paste0('random forest for:\n',output_tag),xlab='importance',cex.names=0.7)

}

if(0==1)
{
  #install.packages("devtools")
  library("devtools")
  #devtools::install_github("lwillem/IBMcourseTutorials")
  library("IBMcourseTutorials")

  rm(list=ls())
  # install tutorials data
  load_tutorial_data()

  sim_data <- load_experiment_table('./data/flu_city experiment-table.csv')

  names(sim_data)
}
