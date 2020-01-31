rm(list= ls())
ls()

key <- '9377f1f5ddbbb9561d84a2d8a97a063d'
key2 <- 'ba435151893f4b833c9b27ca6f28044f'
# installing required packages
#install.packages(c("httr", "jsonlite", "lubridate"))
library(httr)
library(jsonlite)
library(lubridate)

weather_api <- function(key2, location, date, unit){
  domain <- "http://api.weatherstack.com/"
  api_function <- "historical"

  if (unit == 'Fahrenheit'){
    units = 'f'
  }else{
    units = 'm'
  }

  params <- list(access_key = key2, query = location, historical_date = date, units = unit)
  url <- modify_url(paste(domain, api_function, sep = ""), query = params)
  resp <- POST(url, encode = 'json')

  resp_json <- fromJSON(content(resp, "text"),flatten = TRUE)
  df <- as.data.frame(resp_json)
  return(df)
}

history <- weather_api(key2, "New York", '2015-01-21', "m")
View(t(history))

typeof(history)
