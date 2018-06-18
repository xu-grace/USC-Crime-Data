############################
# Author: Grace Xu
# Last Edited: 4/12/18
# Created: April 6th, 2018

##### READ ME #####
# In order to run this file you must do 2 things.
# 1. Run the dps_functions.R script in it's entirety
# 2. Change the file path to wherever the dps crime logs data is located on your computer.
# After that, just run this script in it's entirety to get your cleaned data. Thanks!
############################

###### File Locations #####
filepath = "C:/Users/acegi/Google Drive/Personal R Projects/USC-Crime-Data/"

library(stringr)
library(pdftools)
library(lubridate)
library(pdftools)

##### Creating Some Functions to Read in the Data #####
# Gets the whole report [getAllReports function]
getAllReports = function(x){
  y = strsplit(as.character(x), "\r\nReported:")
  z = data.frame(matrix(unlist(y), nrow=lengths(y), byrow=T),stringsAsFactors=FALSE)
  return(z)
}

# Turning table into dataframe [turnIntoTable function]
turnIntoTable = function(list){
  theLength = sum(lengths(list))
  df = getAllReports(list[1])
  for(counter in 2:theLength){
    x = getAllReports(list[counter])
    df = rbind(df, x)
  }
  return(df)
}

##### Import Data
df = turnIntoTable(as.list(pdf_text(paste(filepath,"CIS 2017.pdf",sep=""))))

##### List of all Variables and Initializing Columns #####
colnames(df) = "Report"
df$Report_ID = NA
df$Report_Time = NA
df$Location = NA
df$Length = NA
df$Status = NA
df$Incident_Type = NA
df$Description = NA

##### Loop to Fill in Variables #####
for(counter in 1:nrow(df)){
  df[counter, 'Report_ID'] = getReportID(df[counter, 'Report'])
  df[counter, 'Report_Time'] = getReportTime(df[counter, 'Report'])
  df[counter, 'Location'] = getLocation(df[counter, 'Report'])
  df[counter, 'Length'] = getLength(df[counter, 'Report'])
  df[counter, 'Status'] = getStatus(df[counter, 'Report'])
  df[counter, 'Incident_Type'] = getIncidentType(df[counter, 'Report'])
  df[counter, 'Description'] = getDescription(df[counter, 'Report'])
}

##### Alterations #####

# Removing the rows where it's the header, by removing the rows where the Report_Time isn't filled in [381 rows before cut]
df = df[!is.na(df$Report_Time),] #326 rows

# 
df$Incident_Category = sapply(str_extract_all(df$Incident_Type, '\\b[A-Z]+\\b'), paste, collapse=' ')

### This is an assumption, may be untrue. I'm kinda just OCD. GX.
# # Filling in Report ID, IIF the formula is true
# for(x in 1:nrow(df)){
#   if(is.na(df[x,'Report_ID']) == TRUE){
#     # row = df[x,'Report_ID'] #lol this is going to be NA because we're filling in the blanks
#     rowBefore = df[(x-1),'Report_ID']
#     rowAfter = df[(x+1),'Report_ID']
#     difference = rowAfter - rowBefore
#     if(difference == 2 && is.na(difference) == FALSE){
#       df[x,'Report_ID'] = (as.numeric(df[(x-1),'Report_ID']) + 1)
#     }
#   }
# }

# Removing the "Summary: " beginning of the description just for readability
for(x in 1:nrow(df)){
  df[x, 'Description'] = gsub("Summary: ", "", df[x, 'Description'])
}

# Adding a date, derived from Report_Time
df$Date = word(df$Report_Time)

# Removing the original "Report" column since we've gathered all the information
df$Report = NULL

write.csv(df, file = paste(filepath,"dps_crime_logs_2017.csv", sep=""))
