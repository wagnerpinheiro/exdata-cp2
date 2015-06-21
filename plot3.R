library(dplyr)
library(ggplot2)
library(scales)
source("readData.R")

# Q: Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

# A: 'Nonpoint', 'onroad', 'nonroad' type's decreases in emissions from 1999-2008. 
# Only 'point' type emissions have increased in the same period
makePlot3 <- function(){
  
  # summarize using dplyr
  pm25sum <- NEI %>% 
    filter(fips=="24510" & year >= 1999 & year <= 2008) %>% 
    group_by(year, type) %>% 
    summarize(amount=sum(Emissions))
  
  # plot data
  g <- ggplot(pm25sum, aes(x=year, y=amount, fill=type)) + 
    facet_wrap(~type) + 
    geom_bar(stat="identity") +
    ggtitle("PM2.5 Baltimore City Emissions") +
    ylab("pm2.5 amount (tons)") + 
    scale_x_continuous(breaks = seq(1997, 2009, 2))
  
  
  print(g)
  
  # save plot as png file
  dev.copy(png, filename="plot3.png")
  dev.off()
}