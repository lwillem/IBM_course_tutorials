############################################################################
#
# This file is part of the course material for "Individual-based Modelling
# in Epidemiology" by Wim Delva and Lander Willem.
#
############################################################################

load_behaviorspace_table <- function(data_file_name){
 sim_data <- read.table(data_file_name,sep=',',header=T,row.names=NULL,stringsAsFactors = F,skip=6)
 return(sim_data)
}


