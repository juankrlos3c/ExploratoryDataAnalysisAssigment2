#assigment 2 by Juan Lores.
##5:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(plyr)
library(ggplot2)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Assume "Motor Vehicles" only means on road
CityMVBaltimore <- subset(NEI, fips == "24510" & type=="ON-ROAD")

BaltimoreMVPM25ByYear <- ddply(CityMVBaltimore, .(year), function(x) sum(x$Emissions))
colnames(BaltimoreMVPM25ByYear)[2] <- "Emissions"

png("plot5.png")
qplot(year, Emissions, data=BaltimoreMVPM25ByYear, geom="line") +
    ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
    xlab("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()