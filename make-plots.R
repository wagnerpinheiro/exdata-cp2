
source("loadLib.R")

plots_fun <- c(makePlot1, makePlot2, makePlot3, makePlot4, makePlot5, makePlot6)

if(!exists('NEI')) readData()

lapply(plots_fun, makePlot)

# clean memory
rm(NEI)
rm(SCC)
