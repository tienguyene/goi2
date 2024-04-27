# Install and load the necessary package
if (!requireNamespace("XML", quietly = TRUE)) {
  install.packages("XML")
}
library(XML)

# Save the URL of the XML file in a variable
xml.url <- "https://kidb.adb.org/api/v2/sdmx/metadata/codelist?mode=view"

# Try to fetch the XML content
xml_content <- tryCatch(
  {
    readLines(xml.url)
  },
  error = function(e) {
    message("Error fetching XML content:", e$message)
    NULL
  }
)

# Check if XML content is fetched successfully
if (!is.null(xml_content)) {
  # Print out the first few lines of XML content
  cat("First few lines of XML content:\n")
  cat(head(xml_content), sep = "\n")
  
  # Parse XML content
  xmlfile <- tryCatch(
    {
      xmlTreeParse(xml_content, asText = TRUE)
    },
    error = function(e) {
      message("Error parsing XML content:", e$message)
      NULL
    }
  )
  
  # Check if XML is parsed successfully
  if (!is.null(xmlfile)) {
    # Print out class of parsed XML object
    cat("\nClass of parsed XML object:", class(xmlfile), "\n")
    
    # Access the top node
    xmltop <- xmlRoot(xmlfile)
    
    # Print out the XML code of the first subnodes
    cat("\nXML code of the first subnodes:\n")
    print(xmltop)[1:2]
  }
}
#-----------------------------------
# Check the structure of plantcat
str(plantcat)

# If plantcat is a named list, convert it to a data frame
plantcat_df <- data.frame(t(plantcat), row.names = NULL)

# View the structure of plantcat_df
str(plantcat_df)


# Now, try to view the first few rows and columns
View(plantcat_df)


# Now, try to view the first few rows and columns
head(plantcat_df)





