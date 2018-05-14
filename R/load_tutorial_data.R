############################################################################
#
# This file is part of the course material for "Individual-based Modelling
# in Epidemiology" by Wim Delva and Lander Willem.
#
############################################################################

load_tutorial_data <- function(){

  # LOAD TUTORIAL DATA
  data('flu_city_log',                  package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_both',     package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_weekdays', package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_weekends', package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_holiday',  package = 'IBMcourseTutorials')
  data('flu_city_experiment_table_tutorial',  package = 'IBMcourseTutorials')
}


# plot_cummulative_incidence <- function(sim_data){
#
#   plot(sim_data$X.step.,sim_data$count.people.with..recovered..,
#        ylab='cummulative incidence',
#        xlab='time (days)',
#        col=sim_data$X.run.number.)
# }
#
# plot_weekly_incidence <- function(sim_data){
#
#   num_sim <- length(unique(sim_data$X.run.number.))
#   num_days <- length(unique(sim_data$X.step.))
#
#   plot(c(0,140),c(0,10),col=0,xlab='time (weeks)',ylab='count')
#   i <- 1
#   for(i in 1:num_sim){
#     flag <- sim_data$X.run.number. == i
#     tmp_incidence <- sim_data$count.people.with..recovered..[flag]
#     tmp_incidence <- tmp_incidence - c(0,tmp_incidence[1:(num_days-1)])
#
#     sel_days <- floor(num_days/7) * 7
#
#     mat_incidence <- matrix(tmp_incidence[1:sel_days],nrow=7,byrow = T)
#     lines(colSums(mat_incidence),type='l',col=i)
#   }
# }

prepare_data <- function(){

  flu_city_daytype <- read.table('./data/flu_city_daytype.csv',sep=',',header=T)
  devtools::use_data(flu_city_daytype,overwrite = T)

  flu_city_log <- read.table('./data/flu_city_log.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_log,overwrite = T)

  flu_city_daytype_log_both     <- read.table('./data/flu_city_daytype_log_both.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_daytype_log_both,overwrite = T)

  flu_city_daytype_log_weekdays <- read.table('./data/flu_city_daytype_log_weekday.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_daytype_log_weekdays,overwrite = T)

  flu_city_daytype_log_weekends <- read.table('./data/flu_city_daytype_log_weekend.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_daytype_log_weekends,overwrite = T)

  flu_city_daytype_log_holiday <- read.table('./data/flu_city_daytype_log_holiday.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  devtools::use_data(flu_city_daytype_log_holiday,overwrite = T)

  flu_city_experiment_table_tutorial <- load_experiment_table('./data/flu_city_experiment_table_tutorial.csv')
  devtools::use_data(flu_city_experiment_table_tutorial,overwrite = T)

  data('flu_city_log',                      package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_both',         package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_weekdays',     package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_weekends',     package = 'IBMcourseTutorials')
  data('flu_city_daytype_log_holiday',      package = 'IBMcourseTutorials')
  data('flu_city_experiment_table_tutorial',package = 'IBMcourseTutorials')
}



