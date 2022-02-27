summarySCC_PM25 <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/Source_Classification_Code.rds")
data <- summarySCC_PM25
data1<- unique(subset(data, fips == '24510'))
my_data <- as.data.frame.table(totalPM2.5)
totalPM2.5 <- with(data, tapply(Emissions, year, sum))
plot(as.numeric(my_data$Var1), as.numeric(my_data$Freq), xlab = 'Date',
     ylab = 'Total PM2.5 Emissions', type = 'l',
     lwd = 3, col = 'black', main = "Total PM2.5 Emissions 1999, 2002, 2005, 2008 in Baltimore City",
     xaxt = 'n')
axis(1, at = my_data$Var1, labels = c('1999', '2002', '2005', '2008'))
dev.copy(png)
dev.off()
