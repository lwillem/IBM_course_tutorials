############################################################################
#
# This file is part of the course material for "Individual-based Modelling
# in Epidemiology" by Wim Delva and Lander Willem.
#
############################################################################

load_flu_log_file <- function(data_file_name){
 sim_data <- read.table(data_file_name,sep=' ',header=T,row.names=NULL,stringsAsFactors = F)
 return(sim_data)
}


