#assigment 2 by Juan Lores.
##2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

CityBaltimore <- subset(NEI, fips == "24510")
tPM25ByYear <- tapply(CityBaltimore$Emissions, CityBaltimore$year, sum)

png("Plot2.png")
plot(names(tPM25ByYear), tPM25ByYear, 
     type="l",xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
##end