library(ggplot2)

## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data
combustionData <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalData <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combinedData <- (combustionData & coalData)
combustionSCC <- SCC[combinedData,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

## Plotting
png("plot4.png", bg = "transparent")
plot <- ggplot(combustionNEI, aes(factor(year), Emissions/10^5)) + 
        geom_bar(stat = "identity", fill = "blue", width = 0.50) + 
        theme_bw() + guides(fill = FALSE) + 
        labs(x = "Year", y = "Total PM2.5 Emissions (10^5 Tons)") + 
        labs(title = "Total emissions from coal combustion-related
             sources from 1999-2008 across the US")
print(plot)
dev.off()