###############################################################
#
# This file is part of the course material for
# "Individual-based Modelling in Epidemiology"
# by Wim Delva and Lander Willem.
#
###############################################################

# clear workspalce
rm(list=ls())

#install.packages("devtools")
#library("devtools")
#devtools::install_github("lwillem/IBMcourseTutorials")
library("IBMcourseTutorials")

# load tutorial data
load_tutorial_data()

# use build-in function to plot transmission events
process_flu_city_log(flu_city_log)
process_flu_city_log(flu_city_daytype_log_both)
process_flu_city_log(flu_city_daytype_log_weekdays)
process_flu_city_log(flu_city_daytype_log_weekends)
process_flu_city_log(flu_city_vaccine_log)

# # use your own log data file
# sim_data_log <- load_flu_log_file('./flu_city_vaccine_log.csv')
# process_flu_city_log(sim_data_log)

# FYI
malaria_data <- get_malaria_reference_data()

########################################
## STOCHASTIC EFFECT                  ##
########################################
# LOAD FLU_VACCINE TUTORIAL DATA
sim_bs_data <- flu_stochastic_tutorial

# ## LOAD YOUR OWN FLU_VACCINE BEHAVIORSPACE DATA
# sim_bs_data <- load_behaviorspace_table('./flu_city_vaccine_stochastic_table.csv')

# aggregate per current_day
sim_data <- aggregate(. ~ X.run.number. + current_day ,data=sim_bs_data[,-7],mean)

unique(sim_data[,3:9])

# plot incidence
plot_flu_vaccine_behaviorspace_incidence(sim_data)

########################################
## COST-EFFECTIVENESS ANALYSIS        ##
########################################
# source: De Boer et al. The cost-effectiveness of trivalent and quadrivalent
# influenza vaccination in communities in South Africa, Vietnam and Australia.
# Vaccine (2018)

cost_dose              <- 53
cost_delivery          <- 25
cost_outpatient        <- 120
#note: we assume no hospital admissions
# vaccine efficacy: 65%

# load data (only final states)
sim_bs_data <- load_behaviorspace_table('/Users/lwillem/Desktop/3_Flu/NetLogoOutput/flu_city_vaccine_coverage_table.csv')

# to be sure: select final output
flag         <- sim_bs_data$X.step. == max(sim_bs_data$X.step.)
sim_data     <- sim_bs_data[flag,]

# get total number of infections
total_num_infections <- sim_data$count.people.with..recovered.. + sim_data$count.people.with..infected..

# INCREMENTAL COST
medical_cost             <- total_num_infections * cost_outpatient
program_cost             <- sim_data$initial_people * sim_data$vaccine_coverage * (cost_dose + cost_delivery)
incremental_medical_cost <- medical_cost - median(medical_cost[sim_data$vaccine_coverage == 0])
incremental_cost_total   <- incremental_medical_cost + program_cost

par(mfrow=c(1,2))
boxplot(incremental_cost_total ~ sim_data$vaccine_coverage,
        ylab='incremental cost',
        xlab='vaccine coverage')
abline(h=0,lty=2)

# CASES AVERTED
cases_averted <- median(total_num_infections[sim_data$vaccine_coverage == 0]) - total_num_infections
boxplot(cases_averted ~ sim_data$vaccine_coverage,
        ylab='cases averted',
        xlab='vaccine coverage')
abline(h=0,lty=2)
abline(h=unique(sim_data$vaccine_coverage*sim_data$initial_people*sim_data$vaccine_efficacy),lty=3,col=3)
legend('topleft','population*coverage*efficacy',col=3,lty=3,cex=0.5)

# COST EFFECTIVENESS PLANE
plot(cases_averted,incremental_cost_total,col=factor(sim_data$vaccine_coverage),
     xlab='cases averted',
     ylab='incremental cost')
abline(h=0,lty=2)

# ICER: incremental cost effectivness ratio
program_coverage <- sim_data$vaccine_coverage
program_icer     <- incremental_cost_total/cases_averted
program_icer     <- program_icer[program_coverage>0]
program_coverage <- program_coverage[program_coverage>0]

boxplot(program_icer ~ program_coverage,
     xlab='vaccine coverage',
     ylab='Incremental Cost-Effectiveness Ratio (ICER)',outline=F)

