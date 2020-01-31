# installing required packages
#install.packages(c("httr", "jsonlite", "lubridate"))
library(httr)
library(jsonlite)
library(lubridate)

# the wrapper function
weatherstack_historical <- function(key2, location, date, unit){
  
  # set up for the request of the url and path from website
  domain <- "http://api.weatherstack.com/"
  api_function <- "historical"

  # checking unit input
  if (unit == 'Fahrenheit'){
    units = 'f'
  }else{
    units = 'm'
  }
  
  #parameters required for the API function
  params <- list(access_key = key2, query = location, historical_date = date, units = unit)
  
  #url combine with path and parameters
  url <- modify_url(paste(domain, api_function, sep = ""), query = params)
  
  #encoding data as json
  resp <- POST(url, encode = 'json')
  
  # manipulating json to display as dataframe
  resp_json <- fromJSON(content(resp, "text"),flatten = TRUE)
  df <- as.data.frame(resp_json)
  return(df)
}