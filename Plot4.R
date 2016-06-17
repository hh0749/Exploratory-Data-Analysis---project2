##Assignment2
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008?

##Read dataset into R 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
EI<-filter(SCC,grepl("Comb",EI.Sector)&grepl("Coal",EI.Sector))
short<-filter(SCC,grepl("Comb",Short.Name)&grepl("Coal",Short.Name))
EI2<-select(EI,EI.Sector,SCC,Short.Name)
short2<-select(short,EI.Sector,SCC,Short.Name)
combined<-rbind(EI2,short2)
unique<-unique(combined$SCC)
final<-filter(NEI,SCC %in% unique)

final2<-ddply(final,.(year,type),function(x) sum(x$Emissions))
colnames(final2)[3] <- "Emissions"

png("plot4.png", width=480, height=480)
qplot(year, Emissions, data=final2,color = type, geom = "line")+
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Emissions by Type & Year from coal combustion-related source"))+ 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
