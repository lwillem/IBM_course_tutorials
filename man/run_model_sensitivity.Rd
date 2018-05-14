\name{run_model_sensitivity}
\alias{run_model_sensitivity}
\title{Run Model Sensitivity}
\usage{
run_model_sensitivity(input_data,output_data,output_tag)
}
\description{
To run a model sensitiviy analysis using visual inspection and random forest.
}
\examples{

# using tutorial data
load_tutorial_data()
data_full <- flu_city_experiment_table_tutorial

# select input parameters
input_col_names <- c('seed_infected_probability','transmission_probability','num_days_infected')

# select input data
input_data <- data_full[,input_col_names]

# select output data
output_data <- data_full$count.people.with..recovered..

# run function
run_model_sensitivity(input_data,
                      output_data,
                      output_tag ='total incidence')

}
