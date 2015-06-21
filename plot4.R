library(dplyr)
library(ggplot2)
library(scales)
source("readData.R")

# Q: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# A: Emissions from coal combustion drecreased at low rates over time.
makePlot4 <- function(){
  
  # get only SCC related to coal combustion
  my_scc = SCC %>% filter(EI.Sector %in% grep("Comb(.*)Coal", levels(SCC$EI.Sector), value=T))
  
  # summarize using dplyr
  pm25sum <- NEI %>% 
    filter(SCC %in% my_scc$SCC & year >= 1999 & year <= 2008) %>% 
    group_by(year) %>% 
    summarize(amount=sum(Emissions))
  
  # plot data
  g <- ggplot(pm25sum, aes(x=year, y=amount)) + 
    geom_area(stat="identity") +
    ggtitle("PM2.5 - USA Coal combustion-related Emissions") +
    ylab("pm2.5 amount (tons)") + 
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x))) +
    scale_x_continuous(breaks = seq(1997, 2009, 1))
  
  print(g)
  
  # save plot as png file
  dev.copy(png, filename="plot4.png")
  dev.off()
}