
vehicledata <- sourcedata %>% filter(str_detect(EI.Sector, 'Mobile - On-Road'))
data1<- unique(subset(data, fips == '24510'))
data2  <- subset(data1, SCC %in% vehicledata$SCC)
bmmvtotal <- aggregate(Emissions ~ year, data2, sum)

ggplot(bmmvtotal, aes(year, y = Emissions, col = 'Motor Vehicles')) +
        geom_line() +
        geom_point() +
        ggtitle(expression("Total Baltimore" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
        ylab(expression(PM[2.5] ~ "Emissions")) +
        xlab("Year") +
        scale_y_continuous(labels = scales::comma) +
        scale_colour_discrete(name = "Type of sources") +
        theme(legend.title = element_text(face = "bold"))
dev.copy(png)
dev.off()