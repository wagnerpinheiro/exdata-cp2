
makePlot <- function(fun, args=list(), my_dev=png, dev_args=list()){
  #do.call(my_dev, dev_args)
  do.call(fun, args)
  #dev.off()
}