## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Total emissions in the years 1999, 2002, 2005, 2008
totalEmissions <- aggregate(Emissions ~ year, data = NEI, sum)

## Plotting
png(filename = "plot1.png")
barplot((totalEmissions$Emissions)/10^6,
        names.arg = totalEmissions$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (10^6)",
        main = "Total PM2.5 Emissions From All US Sources")
dev.off()