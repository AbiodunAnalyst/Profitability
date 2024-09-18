library(data.table)
library(dplyr)
library(tidyverse)
library(sparklyr)
library(data.table)
library(readxl)
library(lubridate)

merge_csv_files <- function(mypath) {
  # Get the list of file names
  filenames <- list.files(path = mypath, full.names = TRUE)
  
  # Function to handle reading of files
  read_file <- function(file) {
    if (grepl("\\.zip$", file)) {
      # If the file is a zip, list the contents
      zip_contents <- unzip(file, list = TRUE)
      if (nrow(zip_contents) > 1) {
        stop("Compressed files containing more than 1 file are currently not supported.")
      }
      # Extract the single file and read it
      temp_file <- unzip(file, files = zip_contents$Name[1], exdir = tempdir())
      if (grepl("\\.csv$", temp_file)) {
        data <- fread(temp_file)
      } else if (grepl("\\.xlsx?$", temp_file)) {
        data <- as.data.table(read_excel(temp_file))
      } else {
        stop("Unsupported file type in zip.")
      }
    } else if (grepl("\\.csv$", file)) {
      # If the file is a CSV, read it directly
      data <- fread(file)
    } else if (grepl("\\.xlsx?$", file)) {
      # If the file is an Excel file, read it directly
      data <- as.data.table(read_excel(file))
    } else {
      stop("Unsupported file type.")
    }
    return(data)
  }
  
  # Apply the read_file function to each file
  data_list <- lapply(filenames, read_file)
  
  # Combine all data tables into one
  merged_data <- rbindlist(data_list, fill = TRUE)
  
  return(merged_data)
}

# Specify the directory containing CSV and Excel files

directory_path <- "C:/Users/DELL LATITUDE 7370/OneDrive/Documents/ENFORCA/AMAZON PROJECT/Amazon_data"

# Call the merge_csv_files function to merge files from the directory

am_df <- merge_csv_files(directory_path)

View(am_df)


######################### Check for duplicate #################################

# Find duplicate rows
duplicates <-am_df %>%
  filter(duplicated(.) | duplicated(., fromLast = TRUE))
#View(duplicates)

# Remove all duplicate rows
am_df <- am_df %>%
  distinct()  # Keep only unique rows


# Select required row
am_df <- am_df %>%
  select("Date", "Status", "Fulfilment", "Sales Channel", "ship-service-level", "Category", "Size", 
         "ASIN", "Courier Status", "Qty", "Amount", "ship-city", "ship-state", "B2B", "SKU") 

#names(am_df)

# Number of rows 

nrow(am_df)  ## 128975 ---- number of rows in the data


########################## Check for missing value ##############################

na_counts_for_all_var <- am_df %>%
  summarize(across(everything(), list(na_count = ~sum(as.numeric(is.na(.)))))) %>% 
  show()


########################### Quality Check ###################################

am_df <- am_df %>%
  mutate(
    Status = ifelse(Status == "Shipped - Delivered to Buyer", "Shipped", Status),
    Amount = ifelse(Qty == 0, 0, Amount),
    `Courier Status`= ifelse(Qty == 0, "Cancelled", `Courier Status`),
    `Courier Status`= ifelse(Qty == 1, "Shipped", `Courier Status`)
  )


# Renaming varaibles
am_df <- am_df %>%
  rename(
    Sales_Channel = `Sales Channel`, 
    Courier_Status = `Courier Status`,
  )

# format date
am_df <- am_df %>% 
  mutate(Date = as.Date(Date, format = "%m-%d-%y"))

View(am_df)

glimpse(am_df)


############### Connection to Posgresql ######################################

install.packages("RPostgres")

library(odbc)
library(RODBC)
library(DBI)
library(RPostgres)



# Connection to the database
con <- dbConnect(RPostgres::Postgres(), 
                 dbname = "Ecommerce",
                 host = "localhost",
                 port = 5432,
                 user = "postgres",
                 password = "marvel")  # Password should be enclosed in quotes

# Write to the database, overwriting existing table
dbWriteTable(con, "am_df", am_df, overwrite = TRUE)



# Write to the database, appending data to existing table
#dbWriteTable(con, "am_df", am_df, append = TRUE)


# Write to the database with a different table name
#dbWriteTable(con, "New_Crime_df", Crime_df)


dbDisconnect(con)










