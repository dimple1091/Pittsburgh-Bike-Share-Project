

weather <- read.csv("./raw_weather.csv",stringsAsFactors = F ,na.strings= c("999", "NA", " ", ""))


weather <- weather[,c(1,3,9,15,18,22)]

weather$Events[is.na(weather$Events)] <- "Sunny"


colnames(weather) <- c('date', 'Mean.Temp','Mena.Humidity','Mean.Visib','Mean.Wind','Types')

weather$date <- as.Date(weather$date)

write.csv(weather, './weather.csv', row.names = FALSE)
