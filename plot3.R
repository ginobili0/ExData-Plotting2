library(ggplot2)

## Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset NEI to only contain Baltimore data
baltimoreNEI <- NEI[NEI$fips == "24510",]

## Plotting
png("plot3.png",bg = "transparent")
plot3 <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill = FALSE)+
        facet_grid(.~type,scales = "free",space = "free") + 
        labs(x = "year", y = "Total PM2.5 Emissions") + 
        labs(title = "PM2.5 Emissions in Baltimore City")
print(plot3)
dev.off()