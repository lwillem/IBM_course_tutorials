############################################################################
#
# This file is part of the course material for "Individual-based Modelling
# in Epidemiology: A practical introduction" by Wim Delva and Lander Willem.
#
############################################################################
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

setup_ibm_workbench <- function(){

  ## LOAD DATA
  data('flu_city_daytype',package = 'IBMcourseTutorials')
  data('flu_city_log',package = 'IBMcourseTutorials')

  ## PREPARE TUTORIAL FILES AND CODE
  path_work_dir <- getwd()
  dir_data      <- 'tutorial_data'
  dir_r_code    <- 'tutorial_r_code'

  # check if the output folder exist, and create the folder if not
  if(!dir.exists(dir_data)){
    print(paste0('create folder: ',file.path(path_work_dir,dir_data)))
    dir.create(dir_data)
  }

  if(!dir.exists(dir_r_code)){
    print(paste('create folder:',dir_r_code))
    dir.create(dir_r_code)
  }

  write.table(flu_city_daytype,file='./tutorial_data/flu_city_daytype.csv',sep=',',row.names=F)
  write.table(flu_city_log,file='./tutorial_data/flu_city_log.csv',sep=',',row.names=F)

}


plot_cummulative_incidence <- function(sim_data){

  plot(flu_city_daytype$X.step.,flu_city_daytype$count.people.with..recovered..,
       ylab='cummulative incidence',
       xlab='time (days)',
       col=flu_city_daytype$X.run.number.)

}


plot_weekly_incidence <- function(sim_data){

  num_sim <- length(unique(flu_city_daytype$X.run.number.))
  num_days <- length(unique(flu_city_daytype$X.step.))
  floor(num_days/7) * 7

  plot(c(0,140),c(0,10),col=0,xlab='time (weeks)',ylab='count')
  i <- 1
  for(i in 1:num_sim){
    flag <- flu_city_daytype$X.run.number. == i
    tmp_incidence <- flu_city_daytype$count.people.with..recovered..[flag]
    tmp_incidence <- tmp_incidence - c(0,tmp_incidence[1:(num_days-1)])

    sel_days <- floor(num_days/7) * 7

    mat_incidence <- matrix(tmp_incidence[1:sel_days],nrow=7,byrow = T)
    lines(colSums(mat_incidence),type='l',col=i)
  }

}

prepare_data <- function(){

  flu_city_daytype <- read.table('./data/flu_city_daytype.csv',sep=',',header=T)
  devtools::use_data(flu_city_daytype,overwrite = T)

  flu_city_log <- read.table('./data/flu_city_log.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_log,overwrite = T)

  data('flu_city_daytype',package = 'IBMcourseTutorials')
  data('flu_city_log',package = 'IBMcourseTutorials')

}



