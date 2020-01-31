library(httr)
library(jsonlite)
library(stringr)
#' Get historical time-series results of weather data.
#' 
#' @param api_key Your API access key, which can be found in your acccount dashboard.
#' @param location pass a single location 
#' @param historical_date_start a start date for the current historical time-series request.
#' @param historical_date_end an end date for the current historical time-series request.
#' @return datframe contain time series weather information
#' @examples
#' weatherstack_api(api_key,"New York","2015-01-21","2015-01-25")

weatherstack_api <- function(api_key,location,historical_date_start,historical_date_end) {
  # setting up the url to access the api
  domain<- "http://api.weatherstack.com/"
  endpoint <- "historical"
  params<-list(access_key =api_key,query=location,historical_date_start=historical_date_start,historical_date_end=historical_date_end)
  url <- modify_url(paste(domain,endpoint,sep =""),query = params)
  #post request api
  resp<- POST(url)
  #convert the data to json format
  resp_json <- fromJSON(content(resp, "text"),flatten = TRUE)
  #extract historical data from the json, and make it readable format in dataframe
  count <- as.numeric(str_sub(historical_date_end,-2)) - as.numeric(str_sub(historical_date_start,-2))
  hist <-(resp_json[4])$historical
  new = data.frame()
  for(i in 1:count){
    df <- as.data.frame(hist[[i]])
    new <- rbind(new, df)
  }
  #return readable dataframe
  return(new)
}



 