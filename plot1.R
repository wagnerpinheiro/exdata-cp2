library(dplyr)
source("readData.R")

# Q: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# A: Yes, total emissions decreased
makePlot1 <- function(){
  
  # summarize using dplyr
  pm25sum <- NEI %>% group_by(year) %>% summarize(amount=sum(Emissions))
  
  # plot data
  plot(pm25sum$year, pm25sum$amount, type = 'l', main="PM2.5 - USA Total Emissions by Year", xlab="year", ylab="pm2.5 amount (tons)", col="blue")
  
  # save plot as png file
  dev.copy(png, filename="plot1.png")
  dev.off()
}