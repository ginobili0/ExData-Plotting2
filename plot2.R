## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset NEI to only contain Baltimore data
baltimoreNEI <- NEI[NEI$fips == "24510",]

## Total emissions in the years 1999, 2002, 2005, 2008
totalBaltimoreEmissions <- aggregate(Emissions ~ year, data = baltimoreNEI, sum)

## Plotting
png(filename = "plot2.png")
barplot(totalBaltimoreEmissions$Emissions,
        names.arg = totalBaltimoreEmissions$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions",
        main = "Total PM2.5 emissions from Baltimore")
dev.off()