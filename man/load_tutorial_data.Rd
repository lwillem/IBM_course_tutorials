\name{load_tutorial_data}
\alias{load_tutorial_data}
\title{Load IBM course Tutorial Data}
\usage{
load_tutorial_data()
}
\description{
To load the IBM course FLU tutorial data.
}
\examples{

# using tutorial data
load_tutorial_data()
data_full <- flu_city_experiment_table_tutorial
input_col_names <- c('seed_infected_probability','transmission_probability','num_days_infected')

# select input data
input_data <- data_full[,input_col_names]

# select output data
output_data <- data_full$count.people.with..recovered..

run_model_sensitivity(input_data,
                      output_data,
                      output_tag ='total incidence')

}
