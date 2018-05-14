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
library("devtools")
#devtools::install_github("lwillem/IBMcourseTutorials")
library("IBMcourseTutorials")

# load tutorial data
load_tutorial_data()

# use build-in function to plot transmission events
process_flu_city_log(flu_city_log)
process_flu_city_log(flu_city_daytype_log_both)
process_flu_city_log(flu_city_daytype_log_weekdays)
process_flu_city_log(flu_city_daytype_log_weekends)
process_flu_city_log(flu_city_daytype_log_holiday)

# FYI
malaria_data <- ?get_malaria_incidence_peru()







