##Assignment2
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999-2008 for Baltimore City? Which have seen increases in
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
# answer this question.

##Read dataset into R 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
total24510<-filter(NEI,fips == "24510")
type124510<-ddply(total24510,.(year,type),function(x) sum(x$Emissions))
colnames(type124510)[3] <- "Emissions"

png("plot3.png", width=480, height=480)
qplot(year, Emissions, data=type124510,color = type, geom = "line")+
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Emissions by Type & Year in Baltimore"))+ 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
