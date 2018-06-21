# USC-Crime-Data
PDF scrape of reports by the USC Department of Public Safety

Files:
-Raw data: CIS 2017.pdf
- Prep scripts: dps_functions.R, dps_crime_logs.R
- Clean data in csv: dps_crime_logs_2017.csv


To scrape the PDF yourself and from the raw data to prepped data:

1. Download the CIS 2017.pdf
2. Run dps_functions.R
3. Run dps_crime_logs.R. Make sure your set your file paths correctly to reference wherever you downlaoded the data.
4. You'll end up with a dataframe in R, and a csv if you choose to run the write to csv line at the bottom.

Known bugs:
- The get descrption function sometimes only takes part of the whole description. I'm probably not string matching the pattern well enough/robustly enough.
