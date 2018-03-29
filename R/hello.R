# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

hello <- function() {
  print("Hello, world!")
  print("bye!")
}


setup <- function(){

  print('aa')
  dir_functions <- '.'
  dir_data <- 'tutorial_data'
  dir_r_code <- 'tutorial_r_code'
  dir_netlogo_code <- 'tutorial_netlogo_code'

  # check if the output folder exist, and create the folder if not
  if(!dir.exists(dir_data)){
    print(paste('create folder:',dir_data))
    dir.create(dir_data)
  }

  if(!dir.exists(dir_r_code)){
    print(paste('create folder:',dir_r_code))
    dir.create(dir_r_code)
  }

  if(!dir.exists(dir_netlogo_code)){
    print(paste('create folder:',dir_netlogo_code))
    dir.create(dir_netlogo_code)
  }

  write.table(flu_city_daytype,file='./tutorial_data/flu_city_daytype.csv',sep=',',row.names=F)

}


plot_cummulative_incidence <- function(sim_data){

  plot(flu_city_daytype$X.step.,flu_city_daytype$count.people.with..recovered..,
       ylab='cummulative incidence',
       xlab='time',
       col=flu_city_daytype$X.run.number.)

}

plot_incidence <- function(sim_data){

  num_sim <- length(unique(flu_city_daytype$X.run.number.))
  num_days <- length(unique(flu_city_daytype$X.step.))
  floor(num_days/7) * 7

  plot(c(0,140),c(0,10),col=0)
  i <- 1
  for(i in 1:num_sim){
    flag <- flu_city_daytype$X.run.number. == i
    tmp_incidence <- flu_city_daytype$count.people.with..recovered..[flag]
    tmp_incidence <- tmp_incidence - c(0,tmp_incidence[1:(num_days-1)])

    sel_days <- floor(num_days/7) * 7

    mat_incidence <- matrix(tmp_incidence[1:sel_days],nrow=7,byrow = T)
    lines(colSums(mat_incidence),type='l',col=i)

  }


  plot(flu_city_daytype$X.step.,flu_city_daytype$count.people.with..recovered..,
       ylab='cummulative incidence',
       xlab='time',
       col=flu_city_daytype$X.run.number.)

}



