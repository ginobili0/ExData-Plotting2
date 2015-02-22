library(ggplot2)

## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

## Subsetting the data to only contain Baltimore and LAC data
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips == "06037", ]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI, vehiclesLANEI)

## Plotting
png("plot6.png",bg = "transparent")
plot <- ggplot(bothNEI, aes(factor(year), Emissions, fill = city)) +
        geom_bar(aes(fill = year), stat = "identity") +
        facet_grid(scales = "free", space = "free", .~city) +
        guides(fill = FALSE) + theme_bw() +
        labs(x = "Year", y = "Total emissions from motor vehicle sources") + 
        labs(title = "Total emissions from motor vehicles sources in 
             Baltimore and LAC from 1999-2008")
print(plot)
dev.off()
