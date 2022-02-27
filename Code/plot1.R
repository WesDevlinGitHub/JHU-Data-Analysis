summarySCC_PM25 <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("~/repos/R_Homework/PM2.5ED/exdata_data_NEI_data/Source_Classification_Code.rds")
data <- summarySCC_PM25
totalPM2.5 <- with(data, tapply(Emissions, year, sum))
my_data <- as.data.frame.table(totalPM2.5)
my_data$Freq <- as.character(my_data$Freq)
plot(as.numeric(my_data$Var1), as.numeric(my_data$Freq)/100, xlab = 'Date',
     ylab = 'Total PM2.5 Emissions/100 units', type = 'l',
     lwd = 3, col = 'red', main = "Total PM2.5 Emission Each Year from 1999 - 2008",
     xaxt = 'n')
axis(1, at = my_data$Var1, labels = c('1999', '2002', '2005', '2008'))
dev.copy(png)
dev.off()
