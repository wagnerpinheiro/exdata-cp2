library(dplyr)
library(ggplot2)
library(scales)
source("readData.R")

# Q: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?
# A: There is a long road to L.A. decreased emissions.
makePlot6 <- function(){
  
  # get only SCC related to motor vehicle sources
  my_scc = SCC %>% filter(EI.Sector %in% grep("Vehicle", levels(SCC$EI.Sector), value=T))
  
  # summarize using dplyr
  pm25sum <- NEI %>% 
    filter(SCC %in% my_scc$SCC & fips %in% c("24510", "06037") & year >= 1999 & year <= 2008) %>% 
    group_by(year, fips) %>% 
    summarize(amount=sum(Emissions)) %>%
    mutate(city=ifelse(fips=="24510","Baltimore City, MD", "Los Angeles, CA"))
  
  # plot data
  g <- ggplot(pm25sum, aes(x=year, y=amount, fill=city)) + 
    geom_area(stat="identity") + 
    facet_wrap(~city) +
    ggtitle("PM2.5 - Baltimore vs L.A. motor vehicle Emissions") +
    ylab("pm2.5 amount (tons)") + 
    scale_x_continuous(breaks = seq(1997, 2009, 2))
  
  print(g)
  
  # save plot as png file
  dev.copy(png, filename="plot6.png")
  dev.off()
}