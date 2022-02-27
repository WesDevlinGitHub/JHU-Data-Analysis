summarySCC_PM25 <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/Source_Classification_Code.rds")
data <- summarySCC_PM25
library(ggplot2)
library(tidyr)
library(dplyr)

baltimore <- subset(data, data$fips =='24510')

# Continuous variable first then categorical variable
baltimoret <- aggregate(Emissions ~ year + type, baltimore, sum)

ggplot(baltimoret, aes(year, Emissions, col = type)) +
        geom_line() +
        geom_point() +
        ggtitle(expression("Total Baltimore " ~ PM[2.5] ~ "Emissions by Type and Year")) +
        ylab(expression(PM[2.5] ~ "Emissions")) +
        xlab("Year") +
        scale_colour_discrete(name = "Type of sources") +
        theme(legend.title = element_text(face = "bold"))
dev.copy(png)
dev.off()


