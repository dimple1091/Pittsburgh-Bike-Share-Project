
weather <- read.csv("weather.csv")
holidays <- read.csv("holidays.csv")


set_up_features <- function(df) {
  ### Start Time 
  df$date <- strptime(df$date, format="%Y-%m-%d")
  df$Day <-  as.factor(df$date$mday)
  df$Weekend <- as.factor(df$date$wday)
  df$Month <- as.factor(df$date$mon+1) ## starts from 0
  df$Year <- as.factor(df$date$year + 1900)
  
  df
}

weather <- set_up_features(weather)
weather$Weekend = as.integer(weather$Weekend)
## coded as weekend == 1 others == 0
## Weekends == 1, WorkDays == 0
weather$Weekend= recode(weather$Weekend,"c(1,7)='yes';else='no'")

levels(weather$Types)[levels(weather$Types)=="Fog"] <- "Sunny"
levels(weather$Types)[levels(weather$Types)=="Fog-Rain"] <- "Rain"
levels(weather$Types)[levels(weather$Types)=="Fog-Rain-Snow"] <- "Snow"
levels(weather$Types)[levels(weather$Types)=="Fog-Snow"] <- "Snow"
levels(weather$Types)[levels(weather$Types)=="Rain-Snow"] <- "Snow"
levels(weather$Types)[levels(weather$Types)=="Rain-Thunderstorm"] <- "Rain"

weather$Types <- as.factor(weather$Types)


weather$Holiday <- ifelse((weather$date %in% holidays$date) | (weather$Weekend == 'yes'),1,0)
weather$Holiday <- as.factor(weather$Holiday)
weather_holidays <- weather[-1]

write.csv(weather_holidays, file = "weather_holiday.csv", row.names = FALSE)
