##Assignment2
# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

##Read dataset into R 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
final<-filter(NEI,type=="ON-ROAD", fips == "24510")

final2<-ddply(final,.(year,type),function(x) sum(x$Emissions))
colnames(final2)[3] <- "Emissions"

png("plot5.png", width=480, height=480)
qplot(year, Emissions, data=final2,color = type, geom = "line")+
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Emissions from mortor vehicle sources in Baltimore"))+ 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
