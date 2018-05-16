###############################################################
#
# This file is part of the course material for
# "Individual-based Modelling in Epidemiology"
# by Wim Delva and Lander Willem.
#
###############################################################

plot_flu_vaccine_behaviorspace_incidence <- function(sim_data){

  require(scales)

  # aggregate per day
  sim_data <- aggregate(. ~ X.run.number. + current_day ,data=sim_data[,-7],mean)

  par(mfrow=c(1,2))

  plot(range(sim_data$current_day),range(sim_data$count.people.with..infected..),
       ylab='prevalence', xlab='time (days)', col=0)
  for(i in unique(sim_data$X.run.number.)){
    flag <- sim_data$X.run.number. == i
    lines(sim_data$current_day[flag],
          sim_data$count.people.with..infected..[flag],
          lwd=3,
          col=alpha(1,0.2))
  }

  bxplt <- boxplot(sim_data$count.people.with..infected.. ~ sim_data$current_day,
                   outline=F, ylab='prevalence', xlab='time (days)')

  peak_prevalence <- max(bxplt$stats[3,])
  peak_day <- which(bxplt$stats[3,] == peak_prevalence)
  points(peak_day,peak_prevalence,col=2,pch=20,lwd=3)
  print(data.frame(peak_day,peak_prevalence=round(peak_prevalence)))
  legend('topright','epidemic peak',col=2,lwd=4,lty=0,pch=20,bty = "o",cex = 0.6)

}

