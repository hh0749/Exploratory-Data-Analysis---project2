##Assignment2
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == 06037).
# Which city has seen greater changes over time in motor vehicle emissions?

##Read dataset into R 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
final<-filter(NEI,type=="ON-ROAD", fips %in% c("24510","06037"))

final2<-ddply(final,.(year,type,fips),function(x) sum(x$Emissions))
colnames(final2)[4] <- "Emissions"
colnames(final2)[3] <- "County"
final2$County[final2$County == '24510'] <- 'Baltimore'
final2$County[final2$County == '06037'] <- 'California'

png("plot6.png", width=480, height=480)
qplot(year, Emissions, data=final2,color = County, geom = "line")+
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Emissions by Year from mortor vehicle sources in Baltimore vs California"))+ 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
