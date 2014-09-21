#assigment 2 by Juan Lores.
##3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

library(plyr)
library(ggplot2)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
CityBaltimore <- subset(NEI, fips == "24510")
PM25ByYear <- ddply(CityBaltimore, .(year, type), function(x) sum(x$Emissions))
colnames(PM25ByYear)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=PM25ByYear, color=type, geom="line") +
    ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
    xlab("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()