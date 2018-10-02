###############################################################
#
# This file is part of the course material for
# "Individual-based Modelling in Epidemiology"
# by Wim Delva and Lander Willem.
#
###############################################################

#### SET WORK DIRECTORY (ONCE)
## option 1
## open RStudio with this script => sets the work directory automaticaly
## option 2 (WINDOWS)
# setwd("C:\\User\\path\\to\\the\\rcode\\folder") ## WINDOWS
## option 3 (MAC)
# setwd("/Users/path/to/the/rcode/folder")        ## MAC
## option 4
## use the directory of the current file if you use "source"
src_directory <- getSrcDirectory(function(dummy) {dummy})
setwd(ifelse(nchar(src_directory) > 0, src_directory, '.'))

## INSTALL THE FOLLOWING PACKAGES (ONCE)
# install.packages("devtools")
# library("devtools")
# devtools::install_github("lwillem/IBMcourseTutorials")

## CLEAR WORKSPACE (GLOBAL ENVIRONMENT)
rm(list=ls())

## LOAD THE COURSE PACKAGE
library("IBMcourseTutorials")

########################################
## MALARIA MODEL                      ##
########################################
# load tutorial data
load_tutorial_data_malaria()

########################################
## FYI: MALARIA REFERENCE DAT         ##
########################################
malaria_data <- get_malaria_reference_data()


########################################
## FLU MODEL: STOCHASTIC EFFECT       ##
########################################
# LOAD FLU_VACCINE TUTORIAL DATA
sim_bs_data <- malaria_stochastic_tutorial

# ## LOAD YOUR OWN FLU_VACCINE BEHAVIORSPACE DATA
sim_bs_data <- load_behaviorspace_table('/Users/lwillem/Desktop/4_Malaria/malaria_agent_fixed_latent prevalence-table.csv')
dim(sim_bs_data)
sim_data <- sim_bs_data

# plot incidence
plot_malaria_behaviorspace_incidence(sim_data)

########################################
## FLU: COST-EFFECTIVENESS ANALYSIS   ##
########################################
# source: De Boer et al. The cost-effectiveness of trivalent and quadrivalent
# influenza vaccination in communities in South Africa, Vietnam and Australia.
# Vaccine (2018)

cost_dose              <- 53
cost_delivery          <- 25
cost_outpatient        <- 120
#note: we assume no hospital admissions at this point
# vaccine efficacy: 65%

# load behaviorspace data
 sim_bs_data <- flu_city_vaccine_coverage_tutorial

# # load your own data data (only final states)
# sim_bs_data <- load_behaviorspace_table('flu_city_vaccine_coverage_table.csv')

# To be sure: select final output
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
abline(h=0,lty=2)
