library(ggplot2)

## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data
vehiclesData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehiclesData, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

## Subset the data to only contain Baltimore data
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]

## Plotting
png("plot5.png", bg = "transparent")
plot <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions)) + 
        geom_bar(stat = "identity", fill = "red", width = 0.50) + 
        theme_bw() + guides(fill = FALSE) + 
        labs(x = "Year", y = "Total Emissions from motor vehicles (10^5)") + 
        labs(title = "Emissions from motor vehicle sources from 1999-2008")
print(plot)
dev.off()