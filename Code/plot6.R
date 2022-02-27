vehicledata <- sourcedata %>% filter(str_detect(EI.Sector, 'Mobile - On-Road'))
data1<- unique(subset(data, fips == '24510'))
data2  <- subset(data1, SCC %in% vehicledata$SCC)
bmmvtotal <- aggregate(Emissions ~ year, data2, sum)

datala1 <- unique(subset(data, fips == '06037'))
datala2 <- subset(datala1, SCC %in% vehicledata$SCC)
lamvtotal <- aggregate(Emissions ~ year, datala2, sum)

colnames(lamvtotal) <- c('year', 'LA.MV.Emissions')
colnames(bmmvtotal) <- c('year', 'B.MV.Emissions')
blatotal <- merge(bmmvtotal, lamvtotal, by = 'year')

ggplot(blatotal, aes(year, y = as.numeric(B.MV.Emissions), col = 'Baltimore Emissions')) +
        geom_line() +
        geom_point() +
        geom_line(aes(y = as.numeric(LA.MV.Emissions), col = 'LA Emissions')) +
        geom_point(aes(y = as.numeric(LA.MV.Emissions), col = 'LA Emissions')) +
        ggtitle(expression("Baltimore and LA" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
        ylab(expression(PM[2.5] ~ "Emissions")) +
        xlab("Year") +
        scale_y_continuous(labels = scales::comma) +
        scale_colour_discrete(name = "Type of sources") +
        theme(legend.title = element_text(face = "bold"))
dev.copy(png)
dev.off()