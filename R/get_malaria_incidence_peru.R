## MALARIA INCIDENCE

# The observed monthly malaria incidence in Padre Cocha, Loreto, Peru,
# from the beginning of the year 1996 to the end of the year 1998
#
# Derived from Pizzitutti, F. et al. A validated agent-based model to
# study the spatial and temporal heterogeneities of malaria incidence
# in the rainforest environment. Malar. J. 14, 514 (2015).
# => Figure 6
############################################################################

get_malaria_reference_data <- function()
{

  # Incidence: for each tick and between 2 ticks
  incidence <- c(0.05,0.08,0.144,0.112,0.144,0.06,0.004,0.008,0.008,0.056,
                 0.056,0.168,0.132,0.096,0.132,0.108,0.04,0.064,0.004,
                 0,0.004,0.009,0.024,0.172,0.084,0.108,0.064,0.032,
                 0.02,0.024,0.028,0.032)

  # Figure ticks
  dates_full <- as.Date(c("01/02/1996","11/04/1996","20/06/1996","29/08/1996",
                     "07/11/1996","16/01/1997","27/3/1997","05/06/1997",
                     "14/08/1997","23/10/1997","01/01/1998","12/03/1998",
                     "21/05/1998","30/07/1998","08/10/1998","17/12/1998"),format="%d/%m/%Y")


  # Transform dates into "days"
  dates_days <- as.numeric(dates_full) - as.numeric(dates_full)[1]

  # Get time intervals, in days
  diff(dates_full)
  #=> 70 days, or 10 weeks

  # Create time variable, in days
  days <- c(-35,0,cumsum(rep(35,30)))

  # Create time variable, in dates (starting from the first tick)
  dates <- dates_full[1] + days
  dates_days <- as.numeric(dates) - as.numeric(dates)[1]

  # incidence
  plot(dates,incidence,type='l',lwd=2,col=2,xlab='Time',ylab='Malaria incidence (symptomatic)',main='Padre Cocha (Peru) from Pizzitutti et al (2015)')
  points(dates,incidence)
  # # plot results
  # pdf('malaria_incidence_padre_cocha.pdf')
  # plot(dates,incidence,type='l',lwd=2,col=2,xlab='Time',ylab='Malaria incidence (symptomatic)',main='Padre Cocha (Peru)')
  # dev.off()

  # save data as csv
  out_data <- data.frame(date=dates,day=dates_days,incidence=incidence)
  write.table(out_data,file='malaria_incidence_padre_cocha.csv',row.names=F,sep=',',dec='.')

  return(out_data)
}
