\name{plot_flu_vaccine_behaviorspace_incidence}
\alias{plot_flu_vaccine_behaviorspace_incidence}
\title{Plot Flu Vaccine Tutorial BehaviorSpace Incidence}
\usage{
plot_flu_vaccine_behaviorspace_incidence(simulation_behaviorspace_table)
}
\description{
To plot the prevalence over time, for each run.
}
\examples{

# using tutorial data
load_tutorial_data()
sim_bs_data <- flu_vaccine_bs_tutorial

# use the function
plot_flu_vaccine_behaviorspace_incidence(sim_bs_data)

}
