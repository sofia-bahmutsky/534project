library(httr)
library(jsonlite)
#' Get real-time weather data in a location of your choice.
#'
#' @param api_key Your API access key, which can be found in your acccount dashboard.
#' @param location pass a single location
#' @param unit this parameter to pass one of the unit identifiers ot the API:m for Metric(	temperature: Celsius); s for Scientific(temperature: Kelvin); f for Fahrenheit
#' @return datframe contain current weather information.
#' @examples
#' weatherstack_current(api_key,"New York","m")
#' weatherstack_current(api_key,"London, United Kingdom","f")

weatherstack_current <- function(api_key,location,units) {
  # setting up the url to access the api
  domain<- "http://api.weatherstack.com/"
  endpoint <- "current"
  params<-list(access_key =api_key,query=location,units=units)
  url <- modify_url(paste(domain,endpoint,sep =""),query = params)
  #post request api
  resp<- POST(url)
  #convert the data to json format
  resp_json <- fromJSON(content(resp, "text"),flatten = TRUE)
  #convert to dataframe
  df <- t(as.data.frame(resp_json))
  return(df)
}
