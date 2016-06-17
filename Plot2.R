##Assignment2
# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

##Read dataset into R 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
total24510<-filter(NEI,fips == "24510")

totalPM25ByYear <- tapply(total24510$Emissions, total24510$year, sum)


png("plot2.png", width=480, height=480)
plot(names(totalPM25ByYear), totalPM25ByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year in Baltimore "))
dev.off()
