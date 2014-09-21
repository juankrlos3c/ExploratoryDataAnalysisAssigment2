#assigment 2 by Juan Lores.
##3:
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008?
library(plyr)
library(ggplot2)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# extract all source codes corresponding to coal combustion
CoalCombustionSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal",
                                                  "Fuel Comb - Electric Generation - Coal",
                                                  "Fuel Comb - Industrial Boilers, ICEs - Coal"))

CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
d1 <- setdiff(CoalCombustionSCC, CoalCombustionSCC1)
d2 <- setdiff(CoalCombustionSCC1, CoalCombustionSCC)
d3 <- setdiff(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
d4 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC$SCC)

# Given these differences I believe the best approach is to union the two sets
CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=coalCombustionPM25ByYear, color=type, geom="line") +
    stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
                 color = "black", aes(shape="total"), geom="line") +
    geom_line(aes(size="total", shape = NA)) +
    ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
    xlab("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()