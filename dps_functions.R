##### DPS Crime Log Functions #####

##### Making all of the functions ######
# Report ID - "Report #: " - "\r\nOccurred:" #####
getReportID = function(x){
  x = str_match(x, "Report #: (.*?)\r\nOccurred")
  x = as.numeric(x[2])
}

# Report Time - "Reported: " - "Location:"#####
getReportTime = function(x){
  x = str_match(x, "(.*?)Location:")
  x = trimws(x[2], which = "both")
}

# Location - "Location: " - "Report #" #####
getLocation = function(x){
  x = str_match(x, "Location: (.*?)Report #")
  x = str_to_title(trimws(x[2], which = "both"))
}

# Length - "Occurred: " - "Disposition:" #####
getLength = function(x){
  x = str_match(x, "Occurred: (.*?)Disposition:")
  x = trimws(x[2], which = "both")
}

# Status - "Disposition: " - "\r\nIncident:" #####
getStatus = function(x){
  x = str_match(x, "Disposition: (.*?)\r\nIncident:")
  x = trimws(x[2], which = "both")
}

# Incident Type - "Incident: " - "\r\nSummary" #####
getIncidentType = function(x){
  x = str_match(x, "Incident: (.*?)\r\nSummary")
  x = trimws(x[2], which = "both")
}

##### GET DESCRIPTION IS STILL BUGGY, ONLY TAKES FIRST LINE OF DESCRIPTION #####
# Description - "Summary: "
getDescription = function(x){
  x = str_match(x, "Summary: .*")
}
