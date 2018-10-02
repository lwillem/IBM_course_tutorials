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
library('randomForest')

###############################################################
## EXAMPLE 1: linear function

# set sample size, for model inputs
sample_size <- 1000

# setup input variables in a data frame
input_data <- data.frame(x=sample(20,sample_size,replace=T)/10,
                         y=sample(30,sample_size,replace=T)/10,
                         z=NA,                                  # this will be created using u and y
                         u=sample(40,sample_size,replace=T)/10)

# add correlated input variables
input_data$z <- -input_data$u * input_data$y + sample(100,sample_size,replace=T)/10

# create a function and output data: f() = x - 2u + random_effect   (with correlated z with u and x)
output_data <- (input_data$x) - (2*input_data$u) + sample(50,sample_size,replace=T)/10

## STEP 1: VISUAL INSPECTION
par(mfrow=c(2,2))
for(i in 1:4) {plot(output_data ~ input_data[,i],main=names(input_data)[i])}
for(i in 1:4) {boxplot(output_data ~ input_data[,i],main=names(input_data)[i])}

## STEP 2: LINEAR REGRESSION
lin_model <- lm(output_data ~ . ,data=input_data)
print(summary(lin_model))
lr_sum <- summary(lin_model)$coefficients[,1]

## STEP 3: RANDOM FOREST
experiment_rf <- randomForest(output_data ~ ., data=input_data, prox=TRUE,ntree=1000,importance=TRUE,keep.forest=FALSE)
print(experiment_rf)
print(importance(experiment_rf))
rf_sum <- importance(experiment_rf)[,1]

par(mfrow=c(1,2))                                   # set figure as 2 subplots
barplot(c(NA,rf_sum), las=2,horiz = T,
        main='random forest',xlab='importance')     # create barplot with results from random forest
text(1,0.9,'f() = x - 2u + e',pos=4)                # add function info
text(1,0.4,'(correlated z and u)',pos=4)            # add correlation info
barplot(abs(lr_sum)*c(1,apply(input_data,2,median)), las=2, horiz = T,
        main='lin. regression',xlab='abs(coefficient)*median')  # create barplot with results from linear regression

## STEP 4: VARIANCE BASED
r_summary <- vector(length=5)
# all parameters
lin_model    <- lm(output_data ~ x + y + z + u,data=input_data)
r_summary[1] <- summary(lin_model)$r.squared
print(summary(lin_model)$r.squared)

# no "x"
lin_model <- lm(output_data ~ y + z + u, data=input_data)
r_summary[2] <- summary(lin_model)$r.squared
print(summary(lin_model)$r.squared)

# no "y"
lin_model <- lm(output_data ~ x + z + u, data=input_data)
r_summary[3] <- summary(lin_model)$r.squared
print(summary(lin_model)$r.squared)

# no "z"
lin_model <- lm(output_data ~ x + y + u, data=input_data)
r_summary[4] <- summary(lin_model)$r.squared
print(summary(lin_model)$r.squared)

# no "u"
lin_model <- lm(output_data ~ x + y + z ,data=input_data)
r_summary[5] <- summary(lin_model)$r.squared
print(summary(lin_model)$r.squared)

par(mfrow=c(1,1))
barplot(r_summary,hor=T,las=2,names=c('full',"no 'x'","no 'y'","no 'z'", "no 'u'"),xlab='R-squared',main='linear model')
barplot(r_summary[1] - r_summary,hor=T,las=2,names=c('full',"no 'x'","no 'y'","no 'z'", "no 'u'"),xlab='R-squared: difference with full model',main='linear model')


###############################################################@
## EXAMPLE 2: non linear function

# re-use the input data.frame

# create new function and output data: f() = (x)/u + random_effect     (with correlated z and u)
output_data <- (sqrt(input_data$x) + log(input_data$u))/input_data$x + sample(70,sample_size,replace=T)/40

## STEP 1: VISUAL INSPECTION
par(mfrow=c(2,2))
for(i in 1:4) {plot(input_data[,i],output_data,main=names(input_data)[i])}
for(i in 1:4) {boxplot(output_data ~ input_data[,i],main=names(input_data)[i])}

## STEP 2: LINEAR REGRESSION
lin_model <- lm(output_data ~ x + y + z + u,data=input_data)
print(summary(lin_model))
lr_sum <- summary(lin_model)$coefficients[,1]

## STEP 3: RANDOM FOREST
experiment_rf <- randomForest(output_data ~ ., data=input_data, prox=TRUE,ntree=1000,importance=TRUE)
print(experiment_rf)
print(importance(experiment_rf))
rf_sum <- importance(experiment_rf)[,1]

par(mfrow=c(1,2))                                   # set figure as 2 subplots
barplot(c(NA,rf_sum), las=2,horiz = T,
        main='random forest',xlab='importance')     # create barplot with results from random forest
text(1,0.9,'f() = (x + z)/u + e',pos=4)             # add function info
text(1,0.4,'(correlated z and u)',pos=4)            # add correlation info
barplot(abs(lr_sum)*c(1,apply(input_data,2,median)), las=2, horiz = T,
        main='lin. regression',xlab='abs(coefficient)*median')  # create barplot with results from linear regression

###########################
## EXAMPLE 3: USING the IBMcourseTutorials PACKAGE

run_model_sensitivity(input_data,
                      output_data,
                      output_tag = 'non linear function')

#######################################
## EXAMPLE 4: netlogo flu_city model

# A. use tutorial data
data_full <- flu_city_experiment_table_tutorial
input_col_names <- c('seed_infected_probability','transmission_probability','num_days_infected')

# B. use your own data
#data_full <- load_behaviorspace_table(data_file_name='flu_city_model_exploration_table.csv')
#input_col_names <- c('seed_infected_probability','transmission_probability','num_days_infected')

# select final output
flag      <- data_full$X.step. == max(data_full$X.step.)
data_full <- data_full[flag,]

# select input data
input_data <- data_full[,input_col_names]

######################
## TOTAL INCIDENCE

run_model_sensitivity(input_data,
                      data_full$count.people.with..recovered..,
                      output_tag ='total incidence')

######################
## PEAK PREVALENCE

run_model_sensitivity(input_data,
                      data_full$log_peak_prevalence,
                      output_tag ='peak prevalence')

######################
## PEAK DAY

run_model_sensitivity(input_data,
                      data_full$log_peak_day,
                      output_tag ='peak day')

