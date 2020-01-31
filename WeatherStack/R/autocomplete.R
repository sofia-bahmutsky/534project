library(httr)
library(jsonlite)
#' lookup specific locations and their identifying response objects.
#' @param api_key Your API access key, which can be found in your acccount dashboard.
#' @param location pass a single location 
#' @return datframe contain current all the possible location associated with the input location
#' @examples
#' weatherstack_Lookup(api_key,"london")

weatherstack_Lookup <- function(api_key,location) {
  # setting up the url to access the api
  domain<- "http://api.weatherstack.com/"
  endpoint <- "autocomplete"
  params<-list(access_key =api_key,query=location)
  url <- modify_url(paste(domain,endpoint,sep =""),query = params)
  #post request api
  resp<- POST(url)
  #convert the data to json format
  resp_json <- fromJSON(content(resp, "text"),flatten = TRUE)
  #convert to dataframe
  df <- as.data.frame(resp_json)
  return(df)
}
