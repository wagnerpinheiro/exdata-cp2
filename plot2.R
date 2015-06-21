library(dplyr)
source("readData.R")

# Q: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot
# answering this question.

# A: Yes, emissions from PM2.5 decreased in the Baltimore City, Maryland.
makePlot2 <- function(){
  
  # summarize using dplyr
  pm25sum <- NEI %>% 
    filter(fips=="24510" & year >= 1999 & year <= 2008) %>% 
    group_by(year) %>% 
    summarize(amount=sum(Emissions))
  
  # plot data
  plot(pm25sum$year, pm25sum$amount, type = 'l', main="PM2.5 - Baltimore City Emissions by Year", xlab="year", ylab="pm2.5 amount (tons)", col="blue")
  
  # save plot as png file
  dev.copy(png, filename="plot2.png")
  dev.off()
}