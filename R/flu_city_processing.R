# "FLU CITY" PROCESSING
#
# Author: Lander Willem
# Last update: 14/11/2017
###################################

run_output_processing <- function(output_log_csv)
{

  ## LOAD LOGFILE
  exp_data <- read.table(file=output_log_csv,header=T,sep=' ',row.names=NULL,stringsAsFactors = F)
  dim(exp_data)

  ## INFECTIONS OVER TIME (days)
  plot(table(exp_data$day),type='b',xlab='days',ylab='new infections',main='incidence (per day)')

  ## INFECTIONS OVER TIME (hour of a day)
  plot(table(exp_data$hour),type='b',xlab='hours',ylab='new infections',main='incidence (hour of the day)')
  abline(v=7.5,lty=2)
  abline(v=16.5,lty=2)
  abline(v=20.5,lty=2)

  ## CONTEXT
  barplot(table(exp_data$context),main='context',ylab='count')

  ## GET AGE CLASSES
  range(exp_data$age)
  exp_data$age_class <- cut(exp_data$age,c(0,18,90),right = FALSE)
  exp_data$age_infector_class <- cut(exp_data$age_infector,c(0,18,90),right = FALSE)

  ## INFECTIONS: TOTAL
  print('all infections')
  print(table(exp_data$age_infector_class,exp_data$age_class,dnn=c('age infecter','age infected')))

  ## INFECTIONS: HOUSEHOLD
  print('household & community infections')
  sel <- exp_data$context == 'houses'
  print(table(exp_data$age_infector_class[sel],exp_data$age_class[sel],dnn=c('age infector','age infected')))

  ## INFECTIONS: SCHOOL
  print('infections at school')
  sel <- exp_data$context == 'schools'
  print(table(exp_data$age_infector_class[sel],exp_data$age_class[sel],dnn=c('age infector','age infected')))

  ## INFECTIONS: WORKPLACE
  print('infections at work')
  sel <- exp_data$context == 'workplaces'
  print(table(exp_data$age_infector_class[sel],exp_data$age_class[sel],dnn=c('age infector','age infected')))

  ## SECUNDARY CASES
  barplot(table(table(exp_data$id_infector)),main='secundary cases')

  ## SECUNDARY CASES OVER TIME
  exp_data$sec_cases <- NA
  for(i in 1:dim(exp_data)[1])
  {
    exp_data$sec_cases[i] <- sum(exp_data$id_infector == exp_data$id[i])
  }

  #plot(exp_data$day,exp_data$sec_cases)
  boxplot(exp_data$sec_cases ~ exp_data$day,outline=F,xlab='time',ylab='secundary cases')

  ## (BASIC) REPRODUCTION NUMBER ??

}
