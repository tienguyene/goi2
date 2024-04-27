library(httr)

# Function to fetch data from the API
get_kidb_data <- function(flowref, sdmx_key, start_period, end_period, output_format = "csv") {
  # Constructing the URL
  base_url <- "https://kidb.adb.org/api/v2/sdmx/data/"
  url <- paste0(base_url, flowref, "/", sdmx_key, "?startPeriod=", start_period, "&endPeriod=", end_period, "&output_format=", output_format)
  
  # Making the GET request
  response <- GET(url)
  
  # Checking if request was successful
  if (http_error(response)) {
    stop("HTTP error: ", http_status(response)$message)
  }
  
  # Parsing JSON response
  content(response, "text", encoding = "UTF-8")
}

# Example parameters
flowref <- "IMF"  # Dataset identifier
sdmx_key <- "A.FITB_PA.ALL"  # Indicator key
start_period <- "2014"
end_period <- "2024"

# Getting data in SDMX-JSON format
data <- get_kidb_data(flowref, sdmx_key, start_period, end_period)

# Printing the data
cat(data)


#You can modify the flowref, sdmx_key, start_period, and end_period variables 
#to specify the dataset, indicators, and time range you are interested in. 
#The output_format parameter is optional and defaults to "json", but you can 
# change it to "xml" or "csv" if needed.

# Parse CSV string into a data frame
data_df <- read.csv(text = data)

# View the data frame
View(data_df)
####################################
# Generate the rainbow palette with 21 colors
palette <- rainbow(21)

# Adjust the darkness of the colors
dark_palette <- adjustcolor(palette, alpha.f = 0.7)

# Create the vertical bar chart
# Create the vertical bar chart with automatic color assignment
ggplot(data = data_df, aes(x = factor(TIME_PERIOD), y = OBS_VALUE, fill = REF_AREA)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_discrete() +  # Automatically assigns colors
  labs(x = "Year", y = "Yield on Short-Term Treasury Bills", fill = "Economy") +
  theme_minimal() +
  theme(legend.position = "top")
