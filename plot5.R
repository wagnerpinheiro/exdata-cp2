library(dplyr)
library(ggplot2)
library(scales)
source("readData.R")

# Q: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# A: Emissions declined at high rates between 1999-2002, and it is in continuous decline.
makePlot5 <- function(){
  
  # get only SCC related to motor vehicle sources
  my_scc = SCC %>% filter(EI.Sector %in% grep("Vehicle", levels(SCC$EI.Sector), value=T))
  
  # summarize using dplyr
  pm25sum <- NEI %>% 
    filter(SCC %in% my_scc$SCC & fips=="24510" & year >= 1999 & year <= 2008) %>% 
    group_by(year) %>% 
    summarize(amount=sum(Emissions))
  
  # plot data
  g <- ggplot(pm25sum, aes(x=year, y=amount)) + 
    geom_area(stat="identity") +
    ggtitle("PM2.5 - Baltimore City motor vehicle Emissions") +
    ylab("pm2.5 amount (tons)") + 
    scale_x_continuous(breaks = seq(1997, 2009, 1))
  
  print(g)
  
  # save plot as png file
  dev.copy(png, filename="plot5.png")
  dev.off()
}