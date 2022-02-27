sourcedata <- Source_Classification_Code
coaldata <- sourcedata %>% filter(str_detect(EI.Sector, 'Coal'))

eleccoaldata <- coaldata %>% filter(str_detect(EI.Sector, 'Electric Generation'))
idboilercoaldata <- coaldata %>% filter(str_detect(EI.Sector, 'Industrial Boilers'))
commcoaldata <- coaldata %>% filter(str_detect(EI.Sector, 'Comm/Institutional'))

#Total PM2.5 Emissions by Coal Related Electric Generation Sources 
eleccoaldatacomb <- subset(data, SCC %in% eleccoaldata$SCC)
elecyeartotal <- aggregate(Emissions ~ year, eleccoaldatacomb, sum)
colnames(elecyeartotal) <- c('year', 'Electrical.Total.Emissions')

# Total PM2.5 Emissions by Coal Related Industrial Boiler Sources
idboilerdatacomb <- subset(data, SCC %in% idboilercoaldata$SCC)
idboileryeartotal <- aggregate(Emissions ~ year, idboilerdatacomb, sum)
colnames(idboileryeartotal) <- c('year', 'Industrial.Total.Emissions')

# Total PM2.5 Emissions by Coal Related Comm/Institutional Sources
commcoaldatacomb <- subset(data, SCC %in% commcoaldata$SCC)
commyeartotal <- aggregate(Emissions ~ year, commcoaldatacomb, sum)
colnames(commyeartotal) <- c('year', 'Comm.Institutional.Total.Emissions')
# Plot Graph
total1 <- merge(elecyeartotal, idboileryeartotal, by = 'year')
total <- merge(total1, commyeartotal, by = 'year')
p <- ggplot(total, aes(year, y = as.numeric(Electrical.Total.Emissions), col = 'Electrical')) +
        geom_line() +
        geom_point() +
        geom_line(aes(y = as.numeric(Industrial.Total.Emissions), col = 'Industrial')) +
        geom_point(aes(y = as.numeric(Industrial.Total.Emissions), col = 'Industrial')) +
        geom_line(aes(y = as.numeric(Comm.Institutional.Total.Emissions), col = 'Comm/Institutional')) +
        geom_point(aes(y = as.numeric(Comm.Institutional.Total.Emissions), col = 'Comm/Institutional'))+ 
        ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emissions by Production Type and Year")) +
        ylab(expression(PM[2.5] ~ "Emissions")) +
        xlab("Year") +
        scale_y_continuous(labels = scales::comma) +
        scale_colour_discrete(name = "Type of sources") +
        theme(legend.title = element_text(face = "bold"))

dev.copy(png)
dev.off()