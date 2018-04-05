############################################################################
#
# This file is part of the course material for "Individual-based Modelling
# in Epidemiology: A practical introduction" by Wim Delva and Lander Willem.
#
############################################################################
# "FLU CITY" PROCESSING
#
###################################

# DEBUG CODE
if(0==1){
  rm(list=ls())
  flu_city_log2 <- read.table('./data/output_log.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  flu_city_log2 <- read.table('./Netlogo/3_Flu/output_log.csv',sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
  run_flu_city_processing(flu_city_log2)
  # devtools::use_data(flu_city_log,overwrite = T)

  #setup_ibm_workbench()
  sim_data_log <- flu_city_log2

}

run_flu_city_processing <- function(sim_data_log)
{

  # set plot panels
  par(mfrow=c(2,3))

  ## INFECTIONS OVER TIME (days)
  plot(table(sim_data_log$day),type='b',xlab='days',ylab='new infections',main='incidence (per day)')

  ## INFECTIONS OVER TIME (hour of a day)
  plot(table(sim_data_log$hour),type='b',xlab='time of day (hour)',ylab='new infections',main='incidence (time of day)')
  abline(v=7.5,lty=2)
  abline(v=16.5,lty=2)
  abline(v=20.5,lty=2)

  ## GET AGE CLASSES
  range(sim_data_log$age)
  age_class_threshold <- c(0,18,65,90)
  sim_data_log$age_class <- cut(sim_data_log$age,age_class_threshold,right = FALSE)
  sim_data_log$age_infector_class <- cut(sim_data_log$age_infector,age_class_threshold,right = FALSE)

  ## CONTEXT
  barplot(table(sim_data_log$context),main='context',xlab='frequency',las=2,horiz = T)

  ## INFECTIONS: TOTAL
  print(table(sim_data_log$age_infector_class,sim_data_log$age_class,dnn=c('age infecter','age infected \t\t -- all infections --')))

  ## INFECTIONS: HOUSEHOLD
  sel <- sim_data_log$context == 'household'
  print(table(sim_data_log$age_infector_class[sel],sim_data_log$age_class[sel],dnn=c('age infector','age infected \t\t -- infections at home --')))

  ## INFECTIONS: SCHOOL
  sel <- sim_data_log$context == 'school'
  print(table(sim_data_log$age_infector_class[sel],sim_data_log$age_class[sel],dnn=c('age infector','age infected \t\t -- infections at school--')))

  ## INFECTIONS: WORKPLACE
  sel <- sim_data_log$context == 'workplace'
  print(table(sim_data_log$age_infector_class[sel],sim_data_log$age_class[sel],dnn=c('age infector','age infected \t\t -- infections at work --')))

  ## SECUNDARY CASES
  barplot(table(table(sim_data_log$id_infector)),main='secundary cases',xlab='secundary cases',ylab='count')

  ## SECUNDARY CASES OVER TIME
  sim_data_log$sec_cases <- NA
  for(i in 1:dim(sim_data_log)[1])
  {
    sim_data_log$sec_cases[i] <- sum(sim_data_log$id_infector == sim_data_log$id[i])
  }
  boxplot(sim_data_log$sec_cases ~ sim_data_log$day,outline=F,xlab='days',ylab='secundary cases',main='secundary cases')

  # set plot panels back to default
  par(mfrow=c(1,1))

}
