# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

if(0==1){

  hello()


  #install.packages("devtools")
  library("devtools")
  devtools::install_github("lwillem/IBMcourseTutorials")
  library("IBMcourseTutorials")

  # install and load data (print locatie)
  # andere naam gebruiken...
  setup()

  # load data
  #flu_city_daytype <- read.table("tutorial_data/flu_city_daytype.csv",sep=',',header=T)
  # or...
  #data("flu_city_daytype")

  names(flu_city_daytype)

  # use build-in function
  plot_cummulative_incidence(flu_city_daytype)




  all_data <- read.table('./data/flu_city_daytype.csv',sep=',',header=T)
  names(all_data)

  unique(all_data$X.run.number)
  all_data <- all_data[all_data$X.run.number. < 20,]
  all_data <- write.table(all_data,file='./data/flu_city_daytype holidays-dayoutput.csv',sep=',',row.names=F)

  all_data <- save(all_data,file='./data/flu_city_daytype.Rdata')
  flu_city_daytype <- all_data

  plot(all_data$X.step.,all_data$count.people.with..recovered..)

  dev.off()

  load('')
  devtools::use_data(flu_city_daytype,overwrite = T)
  devtools::use_package_doc()
  run_output_processing()

  data('flu_city_daytype',package = 'IBMcourseTutorials')

  flu_city_daytype

}





