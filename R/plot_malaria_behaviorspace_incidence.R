###############################################################
#
# This file is part of the course material for
# "Individual-based Modelling in Epidemiology"
# by Wim Delva and Lander Willem.
#
###############################################################

plot_malaria_behaviorspace_incidence <- function(sim_data, experiment_column){

  require(scales)
  sim_data <- sim_bs_data

  # remove the first year
  range(sim_data$day_of_year)
  flag <- (sim_data$X.step. > max(sim_data$day_of_year)+1)
  sim_data <- sim_data[flag,]
  print('NOTE: remove the first year')

  ## SELECT EXPERIMENT DETAILS
  plot_main      <- gsub('_',' ',experiment_column)
  experiment_opt <- sort(unique(sim_data[,experiment_column] ))

  ## add calender features
  tmp_week_of_year      <- c(rep(0:max_num_weeks,each=7),51)
  sim_data$week_of_year <- tmp_week_of_year[sim_data$day_of_year+1]

  max_num_weeks     <- ceiling(length(unique(sim_data$X.step.))/7)
  tmp_week_total    <- c(rep(0:max_num_weeks,each=7),51)
  sim_data$week_total <- tmp_week_total[sim_data$X.step.]

  experiment_vector <- sim_data[,experiment_column]
  sim_data_week <- aggregate(. ~ X.run.number. + week_total + experiment_vector ,data=sim_data,mean)

  par(mfrow=c(1,2))
  surv_prob_i <- 2; i <- 1;
  for(surv_prob_i in 1:length(surv_prob_opt)){
    flag_surv_prob <- sim_data_week[,experiment_column] == surv_prob_opt[surv_prob_i]
    plot(range(sim_data_week$week_total),range(sim_data_week$count.people.with..is_symptomatic..[flag_surv_prob]),
         ylab='symptomatic prevalence', xlab='time (weeks)', col=0,main=paste(plot_main,surv_prob_opt[surv_prob_i]))
    for(i in unique(sim_data_week$X.run.number.[flag_surv_prob])){
      flag <- sim_data_week$X.run.number. == i
      lines(sim_data_week$week_total[flag],
            sim_data_week$count.people.with..is_symptomatic..[flag],
            lwd=3,
            col=alpha(1,0.2))
    }
  }

  # aggregate per week of the year
  sim_data_season <- aggregate(. ~ X.run.number. + week_of_year + experiment_vector ,data=sim_data,mean)

  surv_prob_i <- 2; i <- 1;
  for(surv_prob_i in 1:length(surv_prob_opt)){
    flag_surv_prob <- sim_data_season[,experiment_column] == surv_prob_opt[surv_prob_i]
    plot(range(sim_data_season$week_of_year),range(sim_data_season$count.people.with..is_symptomatic..[flag_surv_prob]),
         ylab='symptomatic prevalence', xlab='time (week of year)', col=0,main=paste(plot_main,surv_prob_opt[surv_prob_i]))
    for(i in unique(sim_data_season$X.run.number.[flag_surv_prob])){
      flag <- sim_data_season$X.run.number. == i
      lines(sim_data_season$week_of_year[flag],
            sim_data_season$count.people.with..is_symptomatic..[flag],
            lwd=3,
            col=alpha(1,0.2))
    }
  }

  ## IDEM: boxplot
  surv_prob_i <- 2; i <- 1;
  for(surv_prob_i in 1:length(surv_prob_opt)){
    flag_surv_prob <- sim_data_season[,experiment_column] == surv_prob_opt[surv_prob_i]
    boxplot(sim_data_season$count.people.with..is_symptomatic..[flag_surv_prob] ~ sim_data_season$week_of_year[flag_surv_prob],
         ylab='symptomatic prevalence', xlab='time (week of year)',
         main=paste(plot_main,surv_prob_opt[surv_prob_i]),outline=F)
  }

}

plot_malaria_behaviorspace_incidence(sim_bs_data,experiment_column = 'mosquito_daily_survival_prob')
